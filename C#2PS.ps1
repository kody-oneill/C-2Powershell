################################################################################ 
#
#  Name    : C:\Users\kody.oneill\OneDrive - Proto Labs, Inc\Powershell\ConvertToPS\ConvertTool\Form1.ps1  
#  Version : 0.1
#  Author  :
#  Date    : 12/14/2021
#
 #  Generated with ConvertForm module version 2.0.0
#  PowerShell version 5.1.18362.1171
#
#  Invocation Line   : Convert-Form -Path $Source -Destination $Destination -Encoding UTF8 -force
#  Source            : C:\Users\kody.oneill\source\repos\PowerShellConversionForm\PowerShellConversionForm\Form1.Designer.cs
################################################################################

function Get-ScriptDirectory
{ #Return the directory name of this script
  $Invocation = (Get-Variable MyInvocation -Scope 1).Value
  Split-Path $Invocation.MyCommand.Path
}

$ScriptPath = Get-ScriptDirectory

# Loading external assemblies
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Form1 = New-Object System.Windows.Forms.Form

$SourceFileButton = New-Object System.Windows.Forms.Button
$SourceTextBox = New-Object System.Windows.Forms.TextBox
$DestinationTextBox = New-Object System.Windows.Forms.TextBox
$DestinationButton = New-Object System.Windows.Forms.Button
$SubmitButton = New-Object System.Windows.Forms.Button
#
# SourceFileButton
#
$SourceFileButton.Location = New-Object System.Drawing.Point(322, 23)
$SourceFileButton.Name = "SourceFileButton"
$SourceFileButton.Size = New-Object System.Drawing.Size(75, 23)
$SourceFileButton.TabIndex = 0
$SourceFileButton.Text = "Source File"
$SourceFileButton.UseVisualStyleBackColor = $true




#
# SourceTextBox
#
$SourceTextBox.Location = New-Object System.Drawing.Point(12, 26)
$SourceTextBox.Name = "SourceTextBox"
$SourceTextBox.Size = New-Object System.Drawing.Size(304, 20)
$SourceTextBox.TabIndex = 1
#
# DestinationTextBox
#
$DestinationTextBox.Location = New-Object System.Drawing.Point(12, 52)
$DestinationTextBox.Name = "DestinationTextBox"
$DestinationTextBox.Size = New-Object System.Drawing.Size(304, 20)
$DestinationTextBox.TabIndex = 2
#
# DestinationButton
#
$DestinationButton.Location = New-Object System.Drawing.Point(322, 52)
$DestinationButton.Name = "DestinationButton"
$DestinationButton.Size = New-Object System.Drawing.Size(75, 23)
$DestinationButton.TabIndex = 3
$DestinationButton.Text = "Destination"
$DestinationButton.UseVisualStyleBackColor = $true




#
# SubmitButton
#
$SubmitButton.Location = New-Object System.Drawing.Point(13, 96)
$SubmitButton.Name = "SubmitButton"
$SubmitButton.Size = New-Object System.Drawing.Size(384, 42)
$SubmitButton.TabIndex = 4
$SubmitButton.Text = "Convert"
$SubmitButton.UseVisualStyleBackColor = $true

$SourceFileButton.Add_Click( { 
	$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath('Desktop') }
	$FileBrowser.ShowDialog()
	$SourceTextBox.Text = $FileBrowser.FileName
 } )

 $DestinationButton.Add_Click( { 

	$FileBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
	$FileBrowser.ShowDialog()
	$DestinationTextBox.Text = $FileBrowser.SelectedPath
} )

$SubmitButton.Add_Click( { 

	if([string]::IsNullOrEmpty($DestinationTextBox.Text)){
		[void][System.Windows.Forms.MessageBox]::Show("Destination Not Chosen")
	}else {
		if([string]::IsNullOrEmpty($SourceTextBox.Text)){
			[void][System.Windows.Forms.MessageBox]::Show("Source Not Chosen")
		}else {
			if($SourceTextBox.Text.Contains(".Designer.cs")){
				Convert-Form -Path $SourceTextBox.Text -Destination $DestinationTextBox.Text -Encoding UTF8 -force
				$SourceTextBox.Clear()
				$DestinationTextBox.Clear()
			}else {
				[void][System.Windows.Forms.MessageBox]::Show("Source file must be .Designer.cs file extension")
			}
		}
	}

	
 } )

#
# Form1
#
$Form1.ClientSize = New-Object System.Drawing.Size(415, 156)
$Form1.Controls.Add($SubmitButton)
$Form1.Controls.Add($DestinationButton)
$Form1.Controls.Add($DestinationTextBox)
$Form1.Controls.Add($SourceTextBox)
$Form1.Controls.Add($SourceFileButton)
$Form1.Name = "Form1"
$Form1.Text = "C# to PowerShell Conversion Form"

function OnFormClosing_Form1{ 
	# $this parameter is equal to the sender (object)
	# $_ is equal to the parameter e (eventarg)

	# The CloseReason property indicates a reason for the closure :
	#   if (($_).CloseReason -eq [System.Windows.Forms.CloseReason]::UserClosing)

	#Sets the value indicating that the event should be canceled.
	($_).Cancel= $False
}

$Form1.Add_FormClosing( { OnFormClosing_Form1} )

$Form1.Add_Shown({$Form1.Activate()})
$ModalResult=$Form1.ShowDialog()
# Release the Form
$Form1.Dispose()
