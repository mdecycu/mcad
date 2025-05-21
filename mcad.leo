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
<v t="leo.20250521212548.1"><vh>README</vh>
<v t="leo.20250521214249.1"><vh>sqlitebrowser</vh></v>
</v>
<v t="leo.20250521205157.1"><vh>https test</vh></v>
<v t="leo.20250521205246.1"><vh>nginx.conf</vh></v>
<v t="leo.20250520073928.1"><vh>importer</vh></v>
<v t="leo.20250520074018.1"><vh>@clean flaskapp.py</vh></v>
<v t="leo.20250521213635.1"><vh>@clean app.py</vh></v>
<v t="leo.20250521212840.1"><vh>@edit schema.sql</vh></v>
<v t="leo.20250521213009.1"><vh>@path templates</vh>
<v t="leo.20250521213018.1"><vh>@edit index.html</vh></v>
<v t="leo.20250521213315.1"><vh>@edit add.html</vh></v>
<v t="leo.20250521213337.1"><vh>@edit update.html</vh></v>
<v t="leo.20250521213417.1"><vh>@edit query.html</vh></v>
</v>
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
    user_email = str(user_info.get("mail") or user_info.get("userPrincipalName", ""))
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
</t>
<t tx="leo.20250521205157.1">if __name__ == '__main__':
    context = (r'C:\Certbot\live\your_server_domain\cert.pem', r'C:\Certbot\live\your_server_domain\privkey.pem')
    app.run(debug=True, host='your_server_domain', port=443, ssl_context=context)</t>
<t tx="leo.20250521205246.1">nginx.conf 的 server 設定
# for mcad waitress 8080 轉進 https 443
    server {
    listen       443 ssl;
    server_name  35.mde.nfu.edu.tw;

    ssl_certificate      C:/Certbot/live/35.mde.nfu.edu.tw/fullchain.pem;
    ssl_certificate_key  C:/Certbot/live/35.mde.nfu.edu.tw/privkey.pem;

    ssl_session_cache    shared:SSL:1m;
    ssl_session_timeout  5m;

    ssl_ciphers  HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers  on;

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   html;
    }
}</t>
<t tx="leo.20250521212548.1">執行 flaskapp.py 所需模組

pip install flask sqlite3 waitress</t>
<t tx="leo.20250521213009.1"></t>
<t tx="leo.20250521213635.1">from flask import Flask, request, redirect, url_for, render_template
import sqlite3
  
app = Flask(__name__)
  
DATABASE = 'database.db'
  
def get_db():
    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    return conn
  
def init_db():
    with app.app_context():
        db = get_db()
        with open('schema.sql', 'r') as f:
            db.executescript(f.read())
        db.commit()
  
@app.route('/')
def index():
    return render_template('index.html')
  
@app.route('/add', methods=['GET', 'POST'])
def add_user():
    if request.method == 'POST':
        student_id = request.form['student_id']
        github_account = request.form['github_account']
        notes = request.form.get('notes', '')
  
        db = get_db()
        db.execute('INSERT INTO users (student_id, github_account, notes) VALUES (?, ?, ?)',
                   (student_id, github_account, notes))
        db.commit()
        return redirect(url_for('index'))
  
    return render_template('add.html')
  
@app.route('/update/&lt;int:user_id&gt;', methods=['GET', 'POST'])
def update_user(user_id):
    db = get_db()
    if request.method == 'POST':
        student_id = request.form['student_id']
        github_account = request.form['github_account']
        notes = request.form.get('notes', '')
  
        db.execute('UPDATE users SET student_id = ?, github_account = ?, notes = ? WHERE id = ?',
                   (student_id, github_account, notes, user_id))
        db.commit()
        return redirect(url_for('index'))
  
    user = db.execute('SELECT * FROM users WHERE id = ?', (user_id,)).fetchone()
    return render_template('update.html', user=user)
  
@app.route('/delete/&lt;int:user_id&gt;')
def delete_user(user_id):
    db = get_db()
    db.execute('DELETE FROM users WHERE id = ?', (user_id,))
    db.commit()
    return redirect(url_for('index'))
  
@app.route('/query')
def query_users():
    db = get_db()
    users = db.execute('SELECT * FROM users').fetchall()
    return render_template('query.html', users=users)
  
if __name__ == '__main__':
    init_db()
    app.run(debug=True)</t>
<t tx="leo.20250521214249.1">https://github.com/sqlitebrowser/sqlitebrowser/releases/tag/v3.13.1</t>
</tnodes>
</leo_file>
