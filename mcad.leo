<?xml version="1.0" encoding="utf-8"?>
<!-- Created by Leo: https://leo-editor.github.io/leo-editor/leo_toc.html -->
<leo_file xmlns:leo="https://leo-editor.github.io/leo-editor/namespaces/leo-python-editor/1.1" >
<leo_header file_format="2"/>
<globals/>
<preferences/>
<find_panel_settings/>
<vnodes>
<v t="leo.20250520073858.1"><vh>@settings</vh>
<v t="leo.20250520073858.2"><vh>@data qt-gui-plugin-style-sheet</vh></v>
<v t="leo.20250520073858.3"><vh>@string initial_split_orientation = horizontal</vh></v>
</v>
<v t="leo.20250520073746.2"><vh>MCad project</vh></v>
<v t="leo.20250520073928.1"><vh>importer</vh></v>
<v t="leo.20250520074041.1"><vh>@path ./../</vh>
<v t="leo.20250520074112.1"><vh>@clean config.py</vh></v>
</v>
<v t="leo.20250520074018.1"><vh>@clean flaskapp.py</vh></v>
</vnodes>
<tnodes>
<t tx="leo.20250520073746.2">修課學員經由 @nfu.edu.tw 網域, 可利用"學號@nfu.edu.tw"經由 https://login.microsoftonline.com/ 登入 MS 365.

登入後, 使用者可以利用"應用程式註冊"建立應用程式.

所註冊的延伸應用程式則可以利用 Microsoft Online 主機所提供的 OAuth2 API 程式庫, 取得登入者的 profile.

經由上列步驟取得登入者的 profile 後, 延伸應用程式可設法讀取課程學員的作業倉儲與網站連結.

應用程式註冊: https://portal.azure.com/#view/Microsoft_AAD_RegisteredApps/ApplicationsListBlade</t>
<t tx="leo.20250520073858.1"></t>
<t tx="leo.20250520073858.2">QTreeWidget {
    /* These apply to the selected item, but not to editing items.*/
    background-color: #ffffec; /* Leo's traditional tree color */
    selection-color: black; /* was white */
    selection-background-color: lightgrey;
    /* font-family: SansSerif; */
    /*font-family: DejaVu Sans Mono;*/
    font-family:YaHei Mono;
    /* 標題字型大小設定 */
    font-size: 20px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal, italic,oblique */
 }

/* Headline edit widgets */
QTreeWidget QLineEdit {
    background-color: cornsilk;
    selection-color: white;
    selection-background-color: blue;
    /*font-family: DejaVu Sans Mono;*/    
    font-family:YaHei Mono;
    /* 沒有特別對應字型大小 */
    font-size: 20px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal, italic,oblique */
}

/* The log panes */
QTextEdit {
    background-color: #f2fdff;
    selection-color: red;
    selection-background-color: blue;
    /* font-family: Courier New; */
    font-family:YaHei Mono;
    /* log font 大小 */
    font-size: 20px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal, italic,oblique */
}

/* The body pane */
QTextEdit#richTextEdit {
    background-color: #fdf5f5; /* A kind of pink. */
    selection-color: white;
    selection-background-color: red;
    /*font-family: DejaVu Sans Mono;*/
    /* font-family: Courier New; */
    font-family:YaHei Mono;
    /* 內文字型大小 */
    font-size: 20px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal,italic,oblique */
}

QLabel {
    font-family:YaHei Mono;'CherryPy', 'pytz', 'mako', 'beautifulsoup4', 'pymysql', 'peewee'
    /* 下方的 Minibuffer 標題字型大小 */
    font-size: 20px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal,italic,oblique */
}

/* Editor labels */
QLineEdit#editorLabel {
    background-color: #ffffec;
    font-family:YaHei Mono;
    /* 沒有直接對應字型大小 */
    font-size: 20px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal,italic,oblique */
    border: 2px;
    margin: 2px;
}</t>
<t tx="leo.20250520073858.3">horizontal: body pane to the left
vertical: body pane on the botton

this settings is not working on 6.8.3 any more
use Window - Toggle-Split-Direction</t>
<t tx="leo.20250520073928.1">@language python
# ctrl + b 執行
c.recursiveImport(
    dir_ = './rb/',
    kind = '@clean',        # or '@file' or '@auto'
    safe_at_file = False,   # True: generate @@clean nodes.
    theTypes = ['.py']        # Same as ['.py']
)</t>
<t tx="leo.20250520074018.1">from flask import Flask, redirect, request, session, url_for
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
 
    在應用程式註冊的左側欄選單選擇「憑證與秘密」（Certificates &amp; secrets）。
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
                f'&amp;response_type=code'
                f'&amp;redirect_uri={REDIRECT_URI}'
                f'&amp;response_mode=query'
                f'&amp;scope={SCOPE}')
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
    return (f'Hello, {user_id} &lt;br&gt;'
            f'&lt;script type="text/javascript"&gt;'
            f'  window.location = "https://login.microsoftonline.com/common/oauth2/v2.0/logout";'
            f'&lt;/script&gt;')
  
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
    app.run(debug=True, host='your_server_domain', port=443, ssl_context=context)</t>
<t tx="leo.20250520074041.1"></t>
<t tx="leo.20250520074112.1">CLIENT_ID = 'your_CLIENT_ID'
CLIENT_SECRET = 'your_CLIENT_SECRET'
TENANT_ID = 'your_TENANT_ID'
REDIRECT_URI = 'https://your_server/callback'</t>
</tnodes>
</leo_file>
