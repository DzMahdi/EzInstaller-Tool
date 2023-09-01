# Define a function to install Google Chrome
function Install-GoogleChrome {
    Write-Host "Installing Google Chrome..."
    Write-Host "Inside Install-GoogleChrome function."

    # Define URLs for software download
    $chromeUrl = "https://dl.google.com/chrome/install/latest/Chrome_installer.exe"

    # Define installation paths
    $installDir = "C:\Program Files\Google\Chrome"

    # Download Google Chrome installer
    $chromeInstallerPath = "$env:TEMP\chrome_installer.exe"
    Invoke-WebRequest -Uri $chromeUrl -OutFile $chromeInstallerPath

    # Install Google Chrome silently
    Start-Process -FilePath $chromeInstallerPath -ArgumentList "/silent /install" -Wait

    # Clean up the downloaded installer
    Remove-Item $chromeInstallerPath

    Write-Host "Google Chrome has been installed."
    Write-Host "Returning from Install-GoogleChrome function."

    return "Google Chrome"
}

# Define a function to install Microsoft Teams
function Install-MicrosoftTeams {
    Write-Host "Inside Install-MicrosoftTeams function."
    Write-Host "Installing Microsoft Teams..."

    # Define URLs for software download
    $teamsUrl = "https://go.microsoft.com/fwlink/?linkid=2187327&Lmsrc=groupChatMarketingPageWeb&Cmpid=directDownloadWin64&clcid=0x409&culture=en-us&country=us"

    # Define installation paths
    $installDir = "C:\Program Files\Microsoft Teams"

    # Download Microsoft Teams installer
    $teamsInstallerPath = "$env:TEMP\teams_installer.exe"
    Invoke-WebRequest -Uri $teamsUrl -OutFile $teamsInstallerPath

    # Install Microsoft Teams silently
    Start-Process -FilePath $teamsInstallerPath -ArgumentList "--silent" -Wait

    # Clean up the downloaded installer
    Remove-Item $teamsInstallerPath

    # Create a shortcut for Microsoft Teams on the desktop
    $desktopPath = [Environment]::GetFolderPath("Desktop")
    $wshShell = New-Object -ComObject WScript.Shell

    # Define the relative path from the user's profile directory
    $relativePath = "AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Microsoft Teams (work or school).lnk"
    $fullPath = Join-Path $env:USERPROFILE $relativePath

    $shortcut = $wshShell.CreateShortcut("$desktopPath\Microsoft Teams.lnk")
    $shortcut.TargetPath = $fullPath
    $shortcut.Save()

    # Rename the shortcut to "Microsoft Teams"
    $shortcutFile = Join-Path $desktopPath "Microsoft Teams.lnk"
    $newShortcutFile = Join-Path $desktopPath "Microsoft Teams.lnk"
    Rename-Item -Path $shortcutFile -NewName $newShortcutFile

    Write-Host "Microsoft Teams has been installed."
    Write-Host "Returning from Install-MicrosoftTeams function."

    return "Microsoft Teams"
}

# Define a function to install TeamViewer
function Install-TeamViewer {
    Write-Host "Inside Install-TeamViewer function."
    Write-Host "Installing TeamViewer..."

    # Define URL for software download
    $teamViewerUrl = "https://download.teamviewer.com/download/TeamViewer_Setup_x64.exe?utm_source=google&utm_medium=cpc&utm_campaign=ca%7Cb%7Cpr%7C22%7Cjul%7Ctv-core-download-sn%7Cfree%7Ct0%7C0&utm_content=Download&utm_term=teamviewer+full+version"

    # Download TeamViewer installer
    $teamViewerInstallerPath = "$env:TEMP\teamviewer_installer.exe"
    Invoke-WebRequest -Uri $teamViewerUrl -OutFile $teamViewerInstallerPath

    # Check if Microsoft Edge WebView2 Runtime is already installed using the registry
    $webView2Installed = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\EdgeUpdate\Clients\{2CD8A007-E189-409D-A2C8-9AF4EF3C72AA}*" -ErrorAction SilentlyContinue

    # Install TeamViewer silently
    if ($webView2Installed) {
        # WebView2 is already installed, so install TeamViewer without the /NoWebView switch
        Start-Process -FilePath $teamViewerInstallerPath -ArgumentList "/S" -Wait
    } else {
        # WebView2 is not installed, so install TeamViewer with the /NoWebView switch
        Start-Process -FilePath $teamViewerInstallerPath -ArgumentList "/S /NoWebView" -Wait
    }

    # Clean up the downloaded installer
    Remove-Item $teamViewerInstallerPath

    Write-Host "TeamViewer has been installed."
    Write-Host "Returning from Install-TeamViewer function."

    return "TeamViewer"
}


# Define a function to install Java 8
function Install-Java8 {
    Write-Host "Inside Install-Java8 function."
    Write-Host "Installing Java 8..."

    # Construct the path to the Java installation script using $PSScriptRoot
    $javaInstallScriptPath = Join-Path $PSScriptRoot "JavaInstall.ps1"

    # Call the standalone Java installation script
    & $javaInstallScriptPath

    Write-Host "Java 8 installation process started."
    Write-Host "Returning from Install-Java8 function."

    return "Java 8"
}


# Define a function to install Adobe Reader
function Install-AdobeReader {
    Write-Host "Inside Install-AdobeReader function."
    Write-Host "Installing Adobe Reader..."

    # Define URL for software download
    $adobeReaderUrl = "https://ardownload2.adobe.com/pub/adobe/acrobat/win/AcrobatDC/2300320284/AcroRdrDCx642300320284_MUI.exe"

    # Download Adobe Reader installer
    $adobeReaderInstallerPath = "$env:TEMP\AcroRdrDCx64.exe"
    Invoke-WebRequest -Uri $adobeReaderUrl -OutFile $adobeReaderInstallerPath

    # Install Adobe Reader silently
    Start-Process -FilePath $adobeReaderInstallerPath -ArgumentList "/sAll" -Wait

    # Clean up the downloaded installer
    Remove-Item $adobeReaderInstallerPath

    Write-Host "Adobe Reader has been installed."
    Write-Host "Returning from Install-AdobeReader function."

    return "Adobe Reader"
}


# Load the Windows Forms assembly
Add-Type -AssemblyName System.Windows.Forms

# Create a form
$form = New-Object Windows.Forms.Form
$form.Text = "EzInstaller Tool"
$form.Size = New-Object Drawing.Size(400, 200)  # Adjusted width to accommodate Adobe Reader checkbox
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen

# Create checkboxes for Google Chrome, Microsoft Teams, Java 8, and Adobe Reader
$checkBoxChrome = New-Object Windows.Forms.CheckBox
$checkBoxChrome.Text = "Google Chrome"
$checkBoxChrome.Location = New-Object Drawing.Point(20, 20)

$checkBoxTeams = New-Object Windows.Forms.CheckBox
$checkBoxTeams.Text = "Microsoft Teams"
$checkBoxTeams.Location = New-Object Drawing.Point(20, 50)

$checkBoxJava = New-Object Windows.Forms.CheckBox
$checkBoxJava.Text = "Java 8"
$checkBoxJava.Location = New-Object Drawing.Point(20, 80)

$checkBoxAdobe = New-Object Windows.Forms.CheckBox
$checkBoxAdobe.Text = "Adobe Reader"
$checkBoxAdobe.Location = New-Object Drawing.Point(150, 20)

$form.Controls.AddRange(@($checkBoxChrome, $checkBoxTeams, $checkBoxJava, $checkBoxAdobe))

# Create an "Install" button
$installButton = New-Object Windows.Forms.Button
$installButton.Text = "Install"
$installButton.Location = New-Object Drawing.Point(20, 110)
$form.Controls.Add($installButton)

# Array to store installed apps
$global:installedApps = @()

# Event handler for the Install button
$installButton.Add_Click({
    Write-Host "Install button clicked."
    if ($checkBoxChrome.Checked) {
        Install-GoogleChrome
        $global:installedApps += "Google Chrome"
    }

    if ($checkBoxTeams.Checked) {
        Install-MicrosoftTeams
        $global:installedApps += "Microsoft Teams"
    }

    if ($checkBoxJava.Checked) {
        Install-Java8
        $global:installedApps += "Java 8"
    }

    if ($checkBoxAdobe.Checked) {
        Install-AdobeReader
        $global:installedApps += "Adobe Reader"
    }

    # Close the form only after processing all installations
    if ($checkBoxChrome.Checked -or $checkBoxTeams.Checked -or $checkBoxJava.Checked -or $checkBoxAdobe.Checked) {
        $form.Close()
    }
})

# Create a "Cancel" button
$cancelButton = New-Object Windows.Forms.Button
$cancelButton.Text = "Cancel"
$cancelButton.Location = New-Object Drawing.Point(120, 110)
$form.Controls.Add($cancelButton)

# Event handler for the Cancel button
$cancelButton.Add_Click({
    $form.Close()
})

# Show the form
$result = $form.ShowDialog()

Write-Host "About to display message box for $($installedApps.Count) apps."

# Check if any app was installed and display a MessageBox
if ($global:installedApps.Count -gt 0) {
    [System.Windows.Forms.MessageBox]::Show("Installation of $($installedApps -join ', ') is complete.", "Installation Complete", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
}
