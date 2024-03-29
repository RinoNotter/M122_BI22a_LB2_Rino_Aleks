<#
.SYNOPSIS
    PowerShell script to create a confirmation dialog with "Yes" and "No" buttons.

.DESCRIPTION
    This script generates a Windows Forms confirmation dialog with "Yes" and "No" buttons.
    It is typically used to confirm an action before proceeding. The script includes event
    handlers for both "Yes" and "No" buttons.

.NOTES
    File Name      : ConfirmationDialog.ps1
    Author         : Rino Notter
    Prerequisite   : PowerShell

#>

# Generated Form Function
function GenerateForm {
	# Import the Assemblies
	[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
	[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null

	# Generated Form Objects
	$frm_Confirmation = New-Object System.Windows.Forms.Form
	$btn_Ja = New-Object System.Windows.Forms.Button
	$btn_Nein = New-Object System.Windows.Forms.Button
	$txb_Sicher = New-Object System.Windows.Forms.TextBox
	$InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState

	# Generated Event Script Blocks
	$btn_Onclick_Nein = {
		$frm_Confirmation.Close()
	}

	$btn_Onclick_Ja = {
		# Using the global var to assign value to a local var for use in the "kill" function
		$Global:selectedProcess = $lbx_Processes.SelectedItem
		
		<#
		funtion that checks if the value of $selectedProcess does NOT equal $null,
		if yes it force kills the process and refreshes the process list else it displays
		an error in the comandline. After the if-else loop it closes the form and opens
		the processstopped form for the confirmation of a succeful kill
		#>
		if ($selectedProcess -ne $null) {
			Stop-Process -Name $selectedProcess -Force
			Refresh-ProcessesListBox
		}
		else {
			Write-Host "Error"
		}
		$frm_Confirmation.Close()
		.\ProcessStopped_V0.1.ps1
	}

	$OnLoadForm_StateCorrection = {
		# Correct the initial state of the form to prevent the .Net maximized form issue
		$frm_Confirmation.WindowState = $InitialFormWindowState
	}

	# Generated Form Code
	$System_Drawing_Size = New-Object System.Drawing.Size
	$System_Drawing_Size.Height = 97
	$System_Drawing_Size.Width = 226
	$frm_Confirmation.ClientSize = $System_Drawing_Size
	$frm_Confirmation.DataBindings.DefaultDataSourceUpdateMode = 0
	$frm_Confirmation.Name = "frm_Confirmation"

	$btn_Ja.DataBindings.DefaultDataSourceUpdateMode = 0
	$System_Drawing_Point = New-Object System.Drawing.Point
	$System_Drawing_Point.X = 58
	$System_Drawing_Point.Y = 62
	$btn_Ja.Location = $System_Drawing_Point
	$btn_Ja.Name = "btn_Ja"
	$System_Drawing_Size = New-Object System.Drawing.Size
	$System_Drawing_Size.Height = 23
	$System_Drawing_Size.Width = 75
	$btn_Ja.Size = $System_Drawing_Size
	$btn_Ja.TabIndex = 2
	$btn_Ja.Text = "Ja"
	$btn_Ja.UseVisualStyleBackColor = $True
	$btn_Ja.add_Click($btn_Onclick_Ja)

	$frm_Confirmation.Controls.Add($btn_Ja)

	$btn_Nein.DataBindings.DefaultDataSourceUpdateMode = 0
	$System_Drawing_Point = New-Object System.Drawing.Point
	$System_Drawing_Point.X = 139
	$System_Drawing_Point.Y = 62
	$btn_Nein.Location = $System_Drawing_Point
	$btn_Nein.Name = "btn_Nein"
	$System_Drawing_Size = New-Object System.Drawing.Size
	$System_Drawing_Size.Height = 23
	$System_Drawing_Size.Width = 75
	$btn_Nein.Size = $System_Drawing_Size
	$btn_Nein.TabIndex = 1
	$btn_Nein.Text = "Nein"
	$btn_Nein.UseVisualStyleBackColor = $True
	$btn_Nein.add_Click($btn_Onclick_Nein)

	$frm_Confirmation.Controls.Add($btn_Nein)

	$txb_Sicher.DataBindings.DefaultDataSourceUpdateMode = 0
	$System_Drawing_Point = New-Object System.Drawing.Point
	$System_Drawing_Point.X = 12
	$System_Drawing_Point.Y = 12
	$txb_Sicher.Location = $System_Drawing_Point
	$txb_Sicher.Name = "txb_Sicher"
	$System_Drawing_Size = New-Object System.Drawing.Size
	$System_Drawing_Size.Height = 20
	$System_Drawing_Size.Width = 202
	$txb_Sicher.Size = $System_Drawing_Size
	$txb_Sicher.TabIndex = 0
	$txb_Sicher.Text = "Sind Sie sicher?"

	$frm_Confirmation.Controls.Add($txb_Sicher)

	# Save the initial state of the form
	$InitialFormWindowState = $frm_Confirmation.WindowState

	# Init the OnLoad event to correct the initial state of the form
	$frm_Confirmation.add_Load($OnLoadForm_StateCorrection)

	# Show the Form
	$frm_Confirmation.ShowDialog() | Out-Null
}

# Call the Function
GenerateForm
