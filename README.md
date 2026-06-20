```
<p align="center">
  <img src="https://img.shields.io/badge/XHTTP-Panel-0f172a?style=for-the-badge&labelColor=0f172a&color=22c55e" alt="XHTTP Panel" />
</p>

<h1 align="center">XHTTP Panel</h1>

<p align="center">
  <strong>A panel for deploying, managing, and monitoring VLESS+XHTTP relays on 6 cloud platforms</strong>
</p>

<p align="center">
  <a href="https://t.me/Hub7c"><img src="https://img.shields.io/badge/Telegram-topnet__cloud-26A5E4?style=for-the-badge&logo=telegram&logoColor=white" alt="Telegram" /></a>
  <a href="https://youtube.com/@Hubdarkweb"><img src="https://img.shields.io/badge/YouTube-topnet__cloud-FF0000?style=for-the-badge&logo=youtube&logoColor=white" alt="YouTube" /></a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Next.js-15-black?logo=nextdotjs" alt="Next.js" />
  <img src="https://img.shields.io/badge/Express-4-000?logo=express" alt="Express" />
  <img src="https://img.shields.io/badge/TypeScript-5.7-3178c6?logo=typescript&logoColor=white" alt="TypeScript" />
  <img src="https://img.shields.io/badge/SQLite-3-003B57?logo=sqlite&logoColor=white" alt="SQLite" />
  <img src="https://img.shields.io/badge/Tailwind-3.4-06B6D4?logo=tailwindcss&logoColor=white" alt="Tailwind" />
  <img src="https://img.shields.io/badge/shadcn/ui-latest-000?logo=shadcnui" alt="shadcn/ui" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Vercel-supported-000?logo=vercel" alt="Vercel" />
  <img src="https://img.shields.io/badge/Netlify-supported-00C7B7?logo=netlify&logoColor=white" alt="Netlify" />
  <img src="https://img.shields.io/badge/Azure-supported-0078D4?logo=microsoftazure&logoColor=white" alt="Azure" />
  <img src="https://img.shields.io/badge/Fastly-supported-FF282D?logo=fastly&logoColor=white" alt="Fastly" />
  <img src="https://img.shields.io/badge/Deno-supported-000?logo=deno" alt="Deno" />
  <img src="https://img.shields.io/badge/Railway-supported-7C3AED?logo=railway&logoColor=white" alt="Railway" />
</p>

---

## Quick Install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Hubdarkweb/XHTTP-Panel/main/install.sh)
```

That's it. The rest is automatic.

**Requirements:** Ubuntu 20.04+ server · Domain · Root access

---

## Panel Management (`xhttp-info`)

After installation, the `xhttp-info` command on the server provides these options:

```bash
xhttp-info
```

```
  [1] Reset admin password     ← Forgot password
  [2] Change web path          ← Change panel path
  [3] Update panel             ← Update to the latest version
  [q] Quit
```

### Update Panel:
```bash
xhttp-info update
```
Tokens, configs, and deployments remain untouched after the update.

### Reset Password:
```bash
xhttp-info reset-password
```

### Change Panel Path:
```bash
xhttp-info set-path
```

---

## What is this?

XHTTP Panel is a **self-hosted web dashboard** that replaces manual CLI work for deploying and managing VLESS+XHTTP relay servers. Instead of SSHing and running commands, you get a clean UI with one-click deployment, live progress, and full management.

---

## Features

---

### 1. Dashboard

The command center of the panel. When you log in, this is the first page you see.

- **3 statistic cards at the top:**
  - Total number of deployments
  - Number of active deployments (active)
  - Number of failed Health Checks
- **Recent deployments table** — with columns for platform, project name, URL, status, and creation date
- Colored badge for each status: green (active), gray (deploying), red (failed)
- Dedicated icon for each platform with tooltip

---

### 2. Token Management

A beautifully designed card page for storing and managing access information for each platform.

- **Dedicated gradient cards** — each platform has its own color and icon (Vercel, Netlify, Azure, Deno, Railway, Fastly)
- **AES-256-GCM encryption** — tokens are never stored in plain text. The encryption key is automatically generated and specific to that installation.
- **Masked display** — tokens are shown as `****xxxx`, not fully visible
- **One-click validity test** — make sure your token is still valid before deploying. Test result (Valid/Invalid) is shown on the same card.
- **Dynamic form** — when you select a platform, the specific fields for that platform are displayed:
  - Vercel / Netlify: one field (API Token)
  - Azure: 4 fields (App ID, Password, Tenant ID, Subscription ID)
  - Deno: 2 fields (API Token, Org Name)
  - Railway / Fastly: one field (API Token)
- **Multiple tokens per platform** — for example 3 different Fastly accounts
- **Delete with confirmation** — confirmation dialog before deletion

---

### 3. Deployment

The heart of the panel. A sleek 3-step wizard that deploys VLESS+XHTTP relays on 6 cloud platforms.

#### Step 1 — Platform Selection
- 6 cards with dedicated icons, colors, and glow effects
- The selected card is highlighted with a glowing border

#### Step 2 — Deployment Information
- **Token** — select from saved tokens (dropdown filtered by platform)
- **Project Name** — project name (lowercase letters, numbers, and hyphens only)
- **Target Domain** — server domain (e.g. `your-domain.com`) or IP
- **Relay Path / Public Path** — relay path (default `/api`)
- **Platform-specific settings:**
  - **Fastly:** Choose custom domain (`xxx.edgecompute.app`) or random
  - **Azure:** Resource Group, SKU (F1/B1/B2/S1), Region, Port, Max Inflight, Upload/Download limit
  - **Railway:** Region (6 regions with country flags), Max Inflight, Upstream Timeout

#### Step 3 — Confirmation and Deploy
- Summary of all settings before execution
- Deploy button with spinner

#### Live Progress (SSE)
- **Modal dialog** with numbered steps
- Each step has three states: ⏳ Pending (empty circle), 🔄 Running (spinner), ✅ Completed (green check), ❌ Error (red cross)
- **Server-Sent Events stream** — build and deployment steps update in real time
- When deployment is complete: Service URL + VLESS config link + Copy button
- **Server-side progress** — deployment continues even if the browser is closed

#### Supported Platforms

| Platform | Runtime | Deployment Method | Special Feature |
|---------|---------|------------|-----------|
| **Vercel** | Node.js (Serverless) | Vercel API | Fluid Compute, Fast Pipe mode |
| **Netlify** | Node.js (Functions) | Netlify CLI | Domain fronting |
| **Azure** | Node.js (App Service) | Azure REST API | SKU and Region selection, Resource Group management |
| **Fastly** | WebAssembly (Compute@Edge) | Fastly CLI | 100+ Global Edge POPs, Custom domain |
| **Deno** | TypeScript (Deno Deploy) | deployctl | Fast Edge runtime |
| **Railway** | Node.js (Container) | Railway CLI | Region selection, Docker container |

#### Operations on Existing Deployments
- **Redeploy** — redeploy with one click (new code is pushed)
- **Delete** — complete deletion (remote service + database record + Resource Group in Azure)
- **Health Check** — health test with status code and response time in milliseconds

---

### 4. Configs and Connections

Central page for viewing and managing all connection links. It has three tabs:

#### Connection Tab (Connection Links)
- **Direct server link** — VLESS config directly from VPS without relay
- **Link for each deployment** — VLESS config through each relay (Vercel, Fastly, ...)
- Each link includes:
  - **One-click copy** — Copy button + "Copied!" notification
  - **QR Code** — open/close with animation, ready for mobile scanning
  - **Check Relay** — live relay test with status code and latency display (e.g. `✓ 200 (142ms)`)
  - **Quick delete** — Delete button with confirmation dialog directly from this page
  - **Platform badge** — shows platform name next to each link
- Displays total number of links as a badge on the tab
- Refresh button to reload

#### Status Tab (Server Status)
- **Xray Service** — Is the service active? (Green/Red badge)
- **Uptime** — How long the service has been running
- **Domain** — Current server domain
- **SSL Expiry** — SSL certificate expiry date
- **Restart Xray** — Restart button with confirmation dialog

#### Config Tab (Xray Config)
- Full display of the server Xray `config.json` file
- JSON format with syntax highlighting
- Scrollbar for large files

---

### 5. Initial Setup (4-Phase Wizard)

A page for automatic checking and installation to ensure the server is ready. Each phase has a separate card with status indicator (Complete/Pending).

#### Phase 1 — Operating System
- Check OS type (Ubuntu, Debian, ...)
- Root access
- Node.js installation + version
- npm installation
- git installation
- curl installation

#### Phase 2 — Tools and CLIs
- Check + **automatic install button** for each tool:
  - Xray-core (+ version display)
  - acme.sh (SSL issuance)
  - Vercel CLI
  - Netlify CLI
  - Azure CLI
  - Deno / deployctl
  - Railway CLI
  - Fastly CLI
- **Uninstall button** — with confirmation dialog
- Installed tools show green check + version, not installed show red cross + Install button

#### Phase 3 — SSL and Domain
- Current domain
- Certificate file path
- Certificate file existence
- SSL expiry date
- Certificate validity (Valid/Invalid)
- **Issue new certificate** — domain field + Issue Certificate button

#### Phase 4 — Xray Status
- Is Xray service running?
- Service uptime
- Does config file exist?

**Progress bar at the top of the page:** `2/4 Phases Complete` with number of completed phases displayed

---

### 6. Server Resources (Resources)

Real-time monitoring of server resources with live charts.

- **CPU** — usage percentage + live Sparkline chart (60 points)
- **RAM** — used / total (e.g. `1.2 GB / 3.8 GB`) + percentage + colored progress bar
- **Network** — download (↓) and upload (↑) speed in real time in bytes/sec
- **Disk** — used / total + percentage + progress bar
- **Uptime** — server uptime duration
- Colored progress bars: blue (normal), orange (warning > 70%), red (critical > 85%)
- Automatic update every few seconds

---

### 7. Settings

- **Language change** — switch between English and Persian (with ToggleGroup)
- **Change admin password** — 3-field form:
  - Current password
  - New password (minimum 6 characters)
  - Repeat new password (must match)
- Light / Dark theme (button in Header)

---

### 8. Management CLI (`xhttp-info`)

Command line tool when you SSH into the server and don't want to open the browser.

```
╔══════════════════════════════════════════════╗
║          XHTTP Panel — Management            ║
╠══════════════════════════════════════════════╣
║  URL:       http://your-domain.com/a3f9c1d2e4 ║
║  Path:      /a3f9c1d2e4                       ║
║  Local:     http://localhost:3000/a3f9c1d2e4  ║
╚══════════════════════════════════════════════╝

  [1] Reset admin password
  [2] Change web path
  [q] Quit
```

- `xhttp-info` — interactive menu with ANSI colors
- `xhttp-info info` — only display panel address and path
- `xhttp-info reset-password` — reset admin password (minimum 6 characters)
- `xhttp-info set-path` — change hidden web path (4 to 32 characters, only `a-z 0-9 _ -`)
- Communication with the panel through local API (`127.0.0.1:3000`) — works only from the server itself
- After changing path you need to run `pm2 restart xhttp-panel`

---

### 9. Security

| Layer | How it works |
|------|--------------|
| **Panel Access** | Random 10-character URL path (e.g. `/a3f9c1d2e4`). When you open this path, an `httpOnly` cookie with 7-day lifetime is set. Without the cookie, every HTML request gets 404 — meaning anyone who doesn't have the URL won't even know the panel exists. |
| **Authentication** | JWT access token (15 minutes lifetime) + refresh token (7 days lifetime). Password is hashed with bcrypt (10 rounds). |
| **Token Encryption** | Every API token is encrypted with AES-256-GCM. The 32-byte random key is automatically generated and stored in `.encryption-key` file with permission `600`. Each installation has its own key. |
| **CLI Protection** | `/api/v1/local/*` endpoints only respond from `127.0.0.1` and `::1`. Not accessible from outside the server. |
| **Static Files** | JS, CSS, fonts, and favicon are served without restriction. But no HTML file is delivered without a valid cookie. |
| **Form Protection** | Zod validation on both client and server side. Inputs are sanitized. |

---

## Architecture

```
                         +------------------+
                         |   Browser (UI)   |
                         +--------+---------+
                                  |
                          Nginx (80 / 2053 SSL)
                                  |
                    +-------------+-------------+
                    |                           |
              Secret Path Gate            Xray (443)
              /{random_path}              VLESS+XHTTP+TLS
                    |
           +--------+--------+
           |  Express API    |    Port 3000 (localhost)
           |  (Node.js)      |
           +--------+--------+
                    |
        +-----------+-----------+
        |           |           |
     SQLite     Services     SSE Streams
     (panel.db)  (deploy)    (progress)
                    |
    +------+--------+--------+------+------+
    |      |        |        |      |      |
  Vercel Netlify  Azure   Fastly  Deno  Railway
```

### Security Model

| Layer | Mechanism |
|------|---------|
| **Panel Access** | Random path (`/{web_path}`) sets an `httpOnly` cookie — without cookie = 404 |
| **API Authentication** | JWT access + refresh token with bcrypt hashing |
| **Token Storage** | AES-256-GCM encryption with installation-specific key |
| **CLI Access** | `localOnly` middleware — only responds from `127.0.0.1` |
| **Static Files** | JS/CSS public, **all HTML** requires a valid cookie |

---

## Technologies

### Backend

| Section | Technology |
|-----|----------|
| Runtime | Node.js 20+ |
| Framework | Express 4 |
| Language | TypeScript 5.7 |
| Database | SQLite (better-sqlite3) |
| Authentication | JWT + bcrypt |
| Encryption | AES-256-GCM (node:crypto) |
| QR Code | qrcode |

### Frontend

| Section | Technology |
|-----|----------|
| Framework | Next.js 15 (Static Export) |
| Styling | Tailwind CSS 3.4 |
| Components | shadcn/ui (50+ components) |
| Forms | React Hook Form + Zod |
| Multilingual | EN / FA |
| Icons | Lucide React |
| Notifications | Sonner |

---

## Manual Installation (Optional)

If the automatic installation above doesn't work:

### First Login

```bash
# Get panel address
xhttp-info info

# Output:
# URL:   http://your-domain.com/a3f9c1d2e4
# Path:  /a3f9c1d2e4
# Local: http://localhost:3000/a3f9c1d2e4
```

1. Open the panel address in your browser
2. Login with default credentials: `admin` / `admin`
3. **Immediately change the password** from the settings section

---

## Nginx Config

```nginx
# HTTP — Panel
server {
    listen 80 default_server;
    server_name _;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}

# HTTPS — Panel (Optional, Recommended)
server {
    listen 2053 ssl default_server;
    server_name _;

    ssl_certificate     /path/to/fullchain.cer;
    ssl_certificate_key /path/to/private.key;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

> Port 443 is used directly by Xray for VLESS+XHTTP+TLS.

---

## Environment Variables

| Variable | Default | Description |
|--------|---------|-------|
| `PORT` | `3000` | Server port |
| `JWT_SECRET` | Auto generated | Access token signing key |
| `JWT_REFRESH_SECRET` | Auto generated | Refresh token signing key |
| `ENCRYPTION_KEY_PATH` | `./data/.encryption-key` | AES-256 key path |
| `DB_PATH` | `./data/panel.db` | SQLite database path |
| `INSTALLER_ENV_PATH` | `/etc/xhttp-installer/info.env` | Installation status file |
| `XRAY_CONFIG_PATH` | `/usr/local/etc/xray/config.json` | Xray config path |

---

## API Reference

### Authentication
| Method | Path | Description |
|-----|------|-------|
| `POST` | `/api/v1/auth/login` | Login (returns JWT) |
| `POST` | `/api/v1/auth/refresh` | Refresh access token |

### Dashboard
| Method | Path | Description |
|-----|------|-------|
| `GET` | `/api/v1/dashboard/stats` | Deployment statistics |
| `GET` | `/api/v1/dashboard/recent-deploys` | Recent deployments |

### Tokens
| Method | Path | Description |
|-----|------|-------|
| `GET` | `/api/v1/tokens` | List of tokens |
| `POST` | `/api/v1/tokens` | Add encrypted token |
| `DELETE` | `/api/v1/tokens/:id` | Delete token |
| `POST` | `/api/v1/tokens/:id/test` | Test token validity |

### Deploy
| Method | Path | Description |
|-----|------|-------|
| `GET` | `/api/v1/deploy` | List of deployments |
| `POST` | `/api/v1/deploy/:platform` | Create deployment |
| `POST` | `/api/v1/deploy/:id/redeploy` | Redeploy |
| `DELETE` | `/api/v1/deploy/:id` | Delete deployment |
| `GET` | `/api/v1/deploy/:id/health` | Health check |
| `GET` | `/api/v1/deploy/:id/stream` | Progress stream (SSE) |

### Configs
| Method | Path | Description |
|-----|------|-------|
| `GET` | `/api/v1/configs/links` | All config links |
| `GET` | `/api/v1/configs/server-status` | Xray + SSL status |

### Local (localhost only)
| Method | Path | Description |
|-----|------|-------|
| `GET` | `/api/v1/local/info` | Panel address and path |
| `POST` | `/api/v1/local/reset-password` | Reset admin password |
| `POST` | `/api/v1/local/set-web-path` | Change hidden path |

---

## License

GPL-3.0
```

Copy everything above and replace the content of your `README.md` file with it. Then run:

```bash
git add README.md
git commit -m "Translate README.md to English"
git push origin main
```
