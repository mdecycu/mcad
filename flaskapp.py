from flask import Flask, redirect, request, session, url_for
import requests
import json
  
app = Flask(__name__)
app.secret_key = 'your_secret_key'  # 用於 Flask session 的秘密金鑰
  
# 替換成你的 Azure AD 應用程式資訊
'''
取得 CLIENT_ID（應用程式 (用戶端) 識別碼）
 
    進入你的應用程式註冊細節頁面。
    在「概觀」分頁中，找到「應用程式 (用戶端) 識別碼」（Application (client) ID）。
    複製這個 GUID 字串，填入 CLIENT_ID = '這個字串'
 
建立 CLIENT_SECRET（用戶端密碼）
 
    在應用程式註冊的左側欄選單選擇「憑證與秘密」（Certificates & secrets）。
    點選「新增用戶端密碼」（New client secret）。
    填寫描述與存續期限，按下「新增」。
    建立後會出現一個「值」(Value)，這才是 CLIENT_SECRET，只會顯示一次，請立即複製起來，填入 CLIENT_SECRET = '這個值'
 
取得 TENANT_ID（目錄 (租用戶) 識別碼）
 
    同樣在「概觀」分頁中，找到「目錄 (租用戶) 識別碼」（Directory (tenant) ID）。
    複製這個 GUID 字串，填入 TENANT_ID = '這個字串'
'''
CLIENT_ID = 'your_CLIENT_ID'
CLIENT_SECRET = 'your_CLIENT_SECRET'
TENANT_ID = 'your_TENANT_ID'
AUTHORITY = f'https://login.microsoftonline.com/{TENANT_ID}'
REDIRECT_URI = 'https://35.cycu.org/callback'
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
    user_email = str(user_info["mail"])
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
    return session["user_id"]
      
  
# 登出功能
@app.route('/logout')
def logout():
    # 清除 session 中的訪問令牌
    session.pop('access_token', None)
    # 重定向到 MS Online 登出 URL
    return redirect('https://login.microsoftonline.com/common/oauth2/v2.0/logout')
  
if __name__ == '__main__':
    context = (r'C:\Certbot\live\your_server_domain\cert.pem', r'C:\Certbot\live\your_server_domain\privkey.pem')
    app.run(debug=True, host='your_server_domain', port=443, ssl_context=context)
