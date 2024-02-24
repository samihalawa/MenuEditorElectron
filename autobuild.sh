#!/bin/bash

function setupEnvironment() {
  echo "Setting up MelindaAI Editor environment..."
  # Ensure the assets directory exists
  mkdir -p MelindaAI/src/assets
  
  # Copy the icon to the project directory, ensure the source path is correct
  cp /users/samihalawa/documents/2024_CHATGPT_MASTER/MELINDA_AI/melindaaiicon.png MelindaAI/src/assets/melindaaiicon.png
}

function updatePackageJSON() {
  echo "Updating package.json with necessary build configurations..."
  jq '.build.appId = "com.melindai.editor" |
      .build.mac.category = "public.app-category.productivity" |
      .build.mac.icon = "src/assets/melindaaiicon.png" |
      .build.mac.target = ["mas"] |
      .build.mac.entitlements = "entitlements.mas.plist" |
      .build.mac.entitlementsInherit = "entitlements.mas.inherit.plist" |
      .build.mac.hardenedRuntime = true |
      .build.mac.gatekeeperAssess = false |
      .build.mac.extendInfo = {
        "NSCameraUsageDescription": "This app requires camera access to record videos.",
        "NSMicrophoneUsageDescription": "This app requires microphone access to record audio."
      } |
      .build.mas.type = "distribution"' MelindaAI/package.json > MelindaAI/package.json.tmp && mv MelindaAI/package.json.tmp MelindaAI/package.json
}

function createEntitlements() {
  echo "Creating entitlements files for sandboxing and security..."
  cat > MelindaAI/entitlements.mas.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <!-- Add your entitlements here -->
</dict>
</plist>
EOF

  cat > MelindaAI/entitlements.mas.inherit.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <!-- Add your inherit entitlements here -->
</dict>
</plist>
EOF
}

function enhancements3() {
  echo "Applying enhancements for menu bar interaction and window management..."
  cat >> MelindaAI/src/scripts/main.js << 'EOF'

const { app, BrowserWindow, Tray, screen, ipcMain } = require('electron');
let mainWindow, trayWindow = null;
let tray = null;

app.on('ready', () => {
  mainWindow = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      nodeIntegration: true,
      contextIsolation: false,
      enableRemoteModule: true,
    }
  });
  
  mainWindow.loadURL(`file://${__dirname}/index.html`);
  
  // Tray setup
  tray = new Tray('src/assets/melindaaiicon.png');
  tray.setToolTip('MelindaAI Editor');
  tray.on('click', toggleTrayWindow);
  
  ipcMain.on('toggle-editor', (event, editor) => {
    mainWindow.webContents.send('editor-changed', editor);
  });

  ipcMain.on('open-main-window', () => {
    if (mainWindow) {
      mainWindow.show();
    } else {
      createWindow();
    }
  });
});

function createTrayWindow() {
  let { width, height } = screen.getPrimaryDisplay().workAreaSize;
  
  trayWindow = new BrowserWindow({
    width: 300,
    height: 500,
    show: false,
    frame: false,
    fullscreenable: false,
    resizable: false,
    transparent: true,
    webPreferences: {
      nodeIntegration: true,
      contextIsolation: false,
      enableRemoteModule: true,
    }
  });

  trayWindow.loadURL(`file://${__dirname}/index.html`);

  trayWindow.on('blur', () => {
    trayWindow.hide();
  });

  let trayBounds = tray.getBounds();
  let x = Math.round(trayBounds.x + (trayBounds.width / 2) - (trayWindow.getBounds().width / 2));
  let y = Math.round(trayBounds.y + trayBounds.height + 3);

  trayWindow.setPosition(x, y, false);
}

function toggleTrayWindow() {
  if (trayWindow && trayWindow.isVisible()) {
    trayWindow.hide();
  } else {
    createTrayWindow();
    trayWindow.show();
  }
}
EOF
}

function enhancements4() {
  echo "Configuring build and sign processes for Mac App Store distribution..."
  # Note: Actual build, sign, and package commands are to be executed manually due to requirement for Developer ID and manual checks
}

setupEnvironment
updatePackageJSON
createEntitlements
enhancements3
enhancements4

echo "Setup and enhancements applied. Please manually build, sign, and package the app as per the macOS and Mac App Store requirements."



#!/bin/bash

function setupEnvironment() {
  echo "Setting up MelindaAI Editor environment..."
  # Ensure the assets directory exists
  mkdir -p MelindaAI/src/assets
  
  # Copy the icon to the project directory, ensure the source path is correct
  cp /users/samihalawa/documents/2024_CHATGPT_MASTER/MELINDA_AI/melindaaiicon.png MelindaAI/src/assets/melindaaiicon.png
}

function updatePackageJSON() {
  echo "Updating package.json with necessary build configurations..."
  jq '.build.appId = "com.melindai.editor" |
      .build.mac.category = "public.app-category.productivity" |
      .build.mac.icon = "src/assets/melindaaiicon.png" |
      .build.mac.target = ["mas"] |
      .build.mac.entitlements = "entitlements.mas.plist" |
      .build.mac.entitlementsInherit = "entitlements.mas.inherit.plist" |
      .build.mac.hardenedRuntime = true |
      .build.mac.gatekeeperAssess = false |
      .build.mac.extendInfo = {
        "NSCameraUsageDescription": "This app requires camera access to record videos.",
        "NSMicrophoneUsageDescription": "This app requires microphone access to record audio."
      } |
      .build.mas.type = "distribution"' MelindaAI/package.json > MelindaAI/package.json.tmp && mv MelindaAI/package.json.tmp MelindaAI/package.json
}

function createEntitlements() {
  echo "Creating entitlements files for sandboxing and security..."
  cat > MelindaAI/entitlements.mas.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <!-- Add your entitlements here -->
</dict>
</plist>
EOF

  cat > MelindaAI/entitlements.mas.inherit.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <!-- Add your inherit entitlements here -->
</dict>
</plist>
EOF
}

function enhancements3() {
  echo "Applying enhancements for menu bar interaction and window management..."
  cat >> MelindaAI/src/scripts/main.js << 'EOF'

const { app, BrowserWindow, Tray, screen, ipcMain } = require('electron');
let mainWindow, trayWindow = null;
let tray = null;

app.on('ready', () => {
  mainWindow = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      nodeIntegration: true,
      contextIsolation: false,
      enableRemoteModule: true,
    }
  });
  
  mainWindow.loadURL(`file://${__dirname}/index.html`);
  
  // Tray setup
  tray = new Tray('src/assets/melindaaiicon.png');
  tray.setToolTip('MelindaAI Editor');
  tray.on('click', toggleTrayWindow);
  
  ipcMain.on('toggle-editor', (event, editor) => {
    mainWindow.webContents.send('editor-changed', editor);
  });

  ipcMain.on('open-main-window', () => {
    if (mainWindow) {
      mainWindow.show();
    } else {
      createWindow();
    }
  });
});

function createTrayWindow() {
  let { width, height } = screen.getPrimaryDisplay().workAreaSize;
  
  trayWindow = new BrowserWindow({
    width: 300,
    height: 500,
    show: false,
    frame: false,
    fullscreenable: false,
    resizable: false,
    transparent: true,
    webPreferences: {
      nodeIntegration: true,
      contextIsolation: false,
      enableRemoteModule: true,
    }
  });

  trayWindow.loadURL(`file://${__dirname}/index.html`);

  trayWindow.on('blur', () => {
    trayWindow.hide();
  });

  let trayBounds = tray.getBounds();
  let x = Math.round(trayBounds.x + (trayBounds.width / 2) - (trayWindow.getBounds().width / 2));
  let y = Math.round(trayBounds.y + trayBounds.height + 3);

  trayWindow.setPosition(x, y, false);
}

function toggleTrayWindow() {
  if (trayWindow && trayWindow.isVisible()) {
    trayWindow.hide();
  } else {
    createTrayWindow();
    trayWindow.show();
  }
}
EOF
}

function enhancements4() {
  echo "Configuring build and sign processes for Mac App Store distribution..."
  # Note: Actual build, sign, and package commands are to be executed manually due to requirement for Developer ID and manual checks
}

setupEnvironment
updatePackageJSON
createEntitlements
enhancements3
enhancements4

echo "Setup and enhancements applied. Please manually build, sign, and package the app as per the macOS and Mac App Store requirements."
