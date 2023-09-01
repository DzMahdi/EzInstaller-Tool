# Define a function to install Google Chrome
function Install-GoogleChrome {
    Write-Host "Installing Google Chrome..."
    #Write-Host "Inside Install-GoogleChrome function."

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
    #Write-Host "Returning from Install-GoogleChrome function."

    return "Google Chrome"
}

# Define a function to install Microsoft Teams
function Install-MicrosoftTeams {
  #  Write-Host "Inside Install-MicrosoftTeams function."
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
   # Write-Host "Returning from Install-MicrosoftTeams function."

    return "Microsoft Teams"
}

# Define a function to install TeamViewer
function Install-TeamViewer {
   # Write-Host "Inside Install-TeamViewer function."
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
   # Write-Host "Returning from Install-TeamViewer function."

    return "TeamViewer"
}

# Define a function to install Adobe Reader
function Install-AdobeReader {
  #  Write-Host "Inside Install-AdobeReader function."
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
   # Write-Host "Returning from Install-AdobeReader function."

    return "Adobe Reader"
}

# Define a function to install Java
function Install-Java {
    Write-Host "Installing Java..."

    # Define URL for software download
    $javaUrl = "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=248771_8c876547113c4e4aab3c868e9e0ec572"

    # Download Java installer
    $javaInstallerPath = Join-Path $env:USERPROFILE "Downloads\java_installer.exe"
    Invoke-WebRequest -Uri $javaUrl -OutFile $javaInstallerPath

    # Install Java silently
    Start-Process -FilePath $javaInstallerPath -ArgumentList "/s" -Wait

    # Clean up the downloaded installer
    Remove-Item $javaInstallerPath

    Write-Host "Java has been installed."
    return "Java"
}


# Define a function to install FortiClient VPN
function Install-FortiClientVPN {
  #  Write-Host "Inside Install-FortiClientVPN function."
    Write-Host "Installing FortiClient VPN..."

    # Define URL for software download
    $fortiClientVPNUrl = "https://links.fortinet.com/forticlient/win/vpnagent"

    # Define the user's Downloads directory
    $downloadsDir = "$env:USERPROFILE\Downloads"

    # Download FortiClient VPN installer
    $fortiClientVPNInstallerPath = "$downloadsDir\FortiClientVPNOnlineInstaller.exe"
    Invoke-WebRequest -Uri $fortiClientVPNUrl -OutFile $fortiClientVPNInstallerPath

    # Install FortiClient VPN silently using the online installer
    Start-Process -FilePath $fortiClientVPNInstallerPath -ArgumentList "/quiet /norestart" -Wait

    # Clean up the downloaded online installer
    Remove-Item $fortiClientVPNInstallerPath

    Write-Host "FortiClient VPN has been installed."
   # Write-Host "Returning from Install-FortiClientVPN function."

    return "FortiClient VPN"
}

# Define a function to install 7-Zip
function Install-7Zip {
 #  Write-Host "Inside Install-7Zip function."
    Write-Host "Installing 7-Zip..."

    # Define URL for software download
    $sevenZipUrl = "https://www.7-zip.org/a/7z2301-x64.exe"

    # Download 7-Zip installer
    $sevenZipInstallerPath = "$env:TEMP\7zip_installer.exe"
    Invoke-WebRequest -Uri $sevenZipUrl -OutFile $sevenZipInstallerPath

    # Install 7-Zip silently
    Start-Process -FilePath $sevenZipInstallerPath -ArgumentList "/S" -Wait

    # Clean up the downloaded installer
    Remove-Item $sevenZipInstallerPath

    Write-Host "7-Zip has been installed."
  # Write-Host "Returning from Install-7Zip function."

    return "7-Zip"
}

# Define a function to install Notepad++
function Install-NotepadPlusPlus {
  #  Write-Host "Inside Install-NotepadPlusPlus function."
    Write-Host "Installing Notepad++..."

    # Define URL for software download
    $notepadPlusPlusUrl = "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.5.6/npp.8.5.6.Installer.x64.exe"

    # Download Notepad++ installer
    $notepadPlusPlusInstallerPath = "$env:TEMP\npp_installer.exe"
    Invoke-WebRequest -Uri $notepadPlusPlusUrl -OutFile $notepadPlusPlusInstallerPath

    # Install Notepad++ silently
    Start-Process -FilePath $notepadPlusPlusInstallerPath -ArgumentList "/S" -Wait

    # Clean up the downloaded installer
    Remove-Item $notepadPlusPlusInstallerPath

    Write-Host "Notepad++ has been installed."
   # Write-Host "Returning from Install-NotepadPlusPlus function."

    return "Notepad++"
}



# Load the Windows Forms assembly
Add-Type -AssemblyName System.Windows.Forms

# Create a form
$form = New-Object Windows.Forms.Form
$form.Text = "EzInstaller Tool"
$form.Size = New-Object Drawing.Size(400, 300)
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen


# Create checkboxes for Google Chrome, Microsoft Teams, Java, Adobe Reader, TeamViewer, and FortiClient VPN
$checkBoxChrome = New-Object Windows.Forms.CheckBox
$checkBoxChrome.Text = "Google Chrome"
$checkBoxChrome.Location = New-Object Drawing.Point(20, 20)

$checkBoxTeams = New-Object Windows.Forms.CheckBox
$checkBoxTeams.Text = "Microsoft Teams"
$checkBoxTeams.Location = New-Object Drawing.Point(20, 50)

$checkBoxJava = New-Object Windows.Forms.CheckBox
$checkBoxJava.Text = "Java"
$checkBoxJava.Location = New-Object Drawing.Point(20, 80)

$checkBoxAdobe = New-Object Windows.Forms.CheckBox
$checkBoxAdobe.Text = "Adobe Reader"
$checkBoxAdobe.Location = New-Object Drawing.Point(150, 20)

$checkBoxTeamViewer = New-Object Windows.Forms.CheckBox
$checkBoxTeamViewer.Text = "TeamViewer"
$checkBoxTeamViewer.Location = New-Object Drawing.Point(150, 50)

$checkBoxFortiClientVPN = New-Object Windows.Forms.CheckBox
$checkBoxFortiClientVPN.Text = "FortiClient VPN"
$checkBoxFortiClientVPN.Location = New-Object Drawing.Point(150, 80)

$checkBox7Zip = New-Object Windows.Forms.CheckBox
$checkBox7Zip.Text = "7-Zip"
$checkBox7Zip.Location = New-Object Drawing.Point(280, 20)

$checkBoxNotepadPlusPlus = New-Object Windows.Forms.CheckBox
$checkBoxNotepadPlusPlus.Text = "Notepad++"
$checkBoxNotepadPlusPlus.Location = New-Object Drawing.Point(280, 50)


$form.Controls.AddRange(@($checkBoxChrome, $checkBoxTeams, $checkBoxAdobe, $checkBoxTeamViewer, $checkBoxFortiClientVPN, $checkBox7Zip, $checkBoxNotepadPlusPlus))


Add-Type -AssemblyName PresentationFramework

$result = [System.Windows.MessageBox]::Show("Do you want to install Java 8 ? You can download it from https://www.java.com/en/download/", "EzInstaller Tool", [System.Windows.MessageBoxButton]::YesNo)

if ($result -eq "Yes") {
    Install-Java
}

# Create an "Install" button
$installButton = New-Object Windows.Forms.Button
$installButton.Text = "Install"
$installButton.Location = New-Object Drawing.Point(20, 110)
$form.Controls.Add($installButton)

# Array to store installed apps
$global:installedApps = @()

$checkBoxJava.Enabled = $false
$checkBoxJava.Checked = $false

# Event handler for the Install button
$installButton.Add_Click({
    $errors = @()

    if ($checkBoxChrome.Checked) {
        try {
            Install-GoogleChrome
            $global:installedApps += "Google Chrome"
        } catch {
            $errors += "Error installing Google Chrome: $($_.Exception.Message)"
        }
    }

    if ($checkBoxTeams.Checked) {
        try {
            Install-MicrosoftTeams
            $global:installedApps += "Microsoft Teams"
        } catch {
            $errors += "Error installing Microsoft Teams: $($_.Exception.Message)"
        }
    }
    
    if ($checkBoxTeamViewer.Checked) {
        try {
            Install-TeamViewer
            $global:installedApps += "TeamViewer"
        } catch {
            $errors += "Error installing TeamViewer: $($_.Exception.Message)"
        }
    }

    if ($checkBoxJava.Checked) {
        try {
			
			#Install-Java
            #$global:installedApps += "Java"
        } catch {
            $errors += "Error installing Java: $($_.Exception.Message)"
        }
    }

    if ($checkBoxAdobe.Checked) {
        try {
            Install-AdobeReader
            $global:installedApps += "Adobe Reader"
        } catch {
            $errors += "Error installing Adobe Reader: $($_.Exception.Message)"
        }
    }
	
	if ($checkBoxFortiClientVPN.Checked) {
        try {
            Install-FortiClientVPN
            $global:installedApps += "FortiClient VPN"
        } catch {
            $errors += "Error installing FortiClient VPN: $($_.Exception.Message)"
        }
		
	}	
		if ($checkBox7Zip.Checked) {
        try {
            Install-7Zip
            $global:installedApps += "7-Zip"
        } catch {
            $errors += "Error installing 7-Zip: $($_.Exception.Message)"
        }
    }
	
	    if ($checkBoxNotepadPlusPlus.Checked) {
        try {
            Install-NotepadPlusPlus
            $global:installedApps += "Notepad++"
        } catch {
            $errors += "Error installing Notepad++: $($_.Exception.Message)"
        }
    }

    # Display errors if any
    if ($errors.Count -gt 0) {
        $errorMessage = $errors -join "`n"
        [System.Windows.Forms.MessageBox]::Show($errorMessage, "Installation Errors", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }

    # Close the form only after processing all installations
    $form.Close()
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

# Create a label for the disclaimer
$disclaimerLabel = New-Object System.Windows.Forms.Label
$disclaimerLabel.Location = New-Object System.Drawing.Point(10,240) 
$disclaimerLabel.Size = New-Object System.Drawing.Size(370,60)
$disclaimerLabel.Text = @"
Copyright © 2023 Amkak Marketing. All rights reserved.
"@
$form.Controls.Add($disclaimerLabel)

# Show the form
$result = $form.ShowDialog()

# Check if any app was installed and display a MessageBox
if ($global:installedApps.Count -gt 0) {
    [System.Windows.Forms.MessageBox]::Show("Installation of $($global:installedApps -join ', ') is complete.", "Installation Complete", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
}


<#
Copyright © 2023 AmkakMarketing All rights reserved.

No part of this software may be reproduced, distributed, or transmitted in any form or by any means, including photocopying, recording, or other electronic or mechanical methods, without the prior written permission of the copyright holder, except in the case of brief quotations embodied in critical reviews and certain other noncommercial uses permitted by copyright law. Unauthorized reproduction or distribution of this software, or any portion of it, may result in severe civil and criminal penalties, and will be prosecuted to the maximum extent possible under the law.

For permission requests, write to the copyright holder, addressed “Attention: Permissions Coordinator,” at the email address provided.

DISCLAIMER: THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#>
