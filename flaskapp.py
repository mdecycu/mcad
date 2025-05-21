from flask import Flask, redirect, request, session, url_for
import requests
import json
import sys
import os

# 導入上一個目錄中的 config.py
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
import config

app = Flask(__name__)
app.secret_key = 'your_secret_key'  # 用於 Flask session 的秘密金鑰

# 從 config.py 讀取 Azure AD 應用程式資訊
CLIENT_ID = config.CLIENT_ID
CLIENT_SECRET = config.CLIENT_SECRET
TENANT_ID = config.TENANT_ID
REDIRECT_URI = config.REDIRECT_URI

AUTHORITY = f'https://login.microsoftonline.com/{TENANT_ID}'
SCOPE = 'User.Read'

# 用於登錄和取得授權碼
@app.route('/')
def index():
    auth_url = (f'{AUTHORITY}/oauth2/v2.0/authorize'
                f'?client_id={CLIENT_ID}'
                f'&response_type=code'
                f'&redirect_uri={REDIRECT_URI}'
                f'&response_mode=query'
                f'&scope={SCOPE}')
    return redirect(auth_url)

# 處理回調和交換授權碼
@app.route('/callback')
def callback():
    code = request.args.get('code')
    token_url = f'{AUTHORITY}/oauth2/v2.0/token'
    token_data = {
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': REDIRECT_URI,
        'client_id': CLIENT_ID,
        'client_secret': CLIENT_SECRET,
        'scope': SCOPE
    }
    token_r = requests.post(token_url, data=token_data)
    token_r.raise_for_status()
    tokens = token_r.json()
    session['access_token'] = tokens['access_token']
    return redirect(url_for('profile'))

# 使用訪問令牌呼叫 Microsoft Graph API 來獲取用戶資料
@app.route('/profile')
def profile():
    access_token = session.get('access_token')
    if not access_token:
        return redirect(url_for('index'))

    headers = {
        'Authorization': f'Bearer {access_token}',
        'Content-Type': 'application/json'
    }
    graph_url = 'https://graph.microsoft.com/v1.0/me'
    graph_r = requests.get(graph_url, headers=headers)
    graph_r.raise_for_status()
    user_info = graph_r.json()
    user_email = str(user_info.get("mail") or user_info.get("userPrincipalName", ""))
    user_id = user_email.split("@")[0]
    session["user_id"] = user_id
    # 登出 MS Online 並重定向回首頁
    # 返回 HTML 及 JavaScript 以進行自動登出
    return (f'Hello, {user_id} <br>'
            f'<script type="text/javascript">'
            f'  window.location = "https://login.microsoftonline.com/common/oauth2/v2.0/logout";'
            f'</script>')

@app.route('/userid')
def userid():
    return session.get("user_id", "")

# 登出功能
@app.route('/logout')
def logout():
    # 清除 session 中的訪問令牌
    session.pop('access_token', None)
    # 重定向到 MS Online 登出 URL
    return redirect('https://login.microsoftonline.com/common/oauth2/v2.0/logout')


# 以下採 waitress http 執行, 並設法與 nginx 結合為 https
if __name__ == '__main__':
    from waitress import serve
    serve(app, host='127.0.0.1', port=8080)
