<#
.SYNOPSIS
    PowerShell script to create a simple process manager GUI using Windows Forms.

.DESCRIPTION
    This script generates a Windows Forms application with buttons to refresh the list of processes,
    kill a selected process, and quit the application. The script also includes an event to handle
    form load, refreshing the process list.

.NOTES
    File Name      : ProcessManager.ps1
    Author         : Rino Notter
    Prerequisite   : PowerShell

#>

# Generated Form Function
function GenerateForm {
  # Import the Assemblies
  [reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
  [reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null

  # Generated Form Objects
  $frm_Processmanager = New-Object System.Windows.Forms.Form
  $btn_Quit = New-Object System.Windows.Forms.Button
  $btn_Refresh = New-Object System.Windows.Forms.Button
  $btn_Kill = New-Object System.Windows.Forms.Button
  $lbx_Processes = New-Object System.Windows.Forms.ListBox
  $lbl_Processes = New-Object System.Windows.Forms.Label
  $InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState

  #Global Var:
  $Global:selectedProcess = $null
  $Global:lbx_Processes = $null

  # Custom function to refresh the processes in the ListBox
  function Refresh-ProcessesListBox {
    $processNames = Get-Process | ForEach-Object {
      $_.ProcessName
    }

    $lbx_Processes.Items.Clear()
    $lbx_Processes.Items.AddRange($processNames)
  }

  # Generated Event Script Blocks
  # Save the selected item from the lbx into a global var for later use, opening the next script
  $btn_Onclick_Kill = {
    $Global:selectedProcess = $lbx_Processes.SelectedItem
    .\Confirmation_V0.3.ps1 
  }

  # Add the custom function "refresh-processesListBox" to the onclick action for the refresh button
  $btn_Onclick_Refresh = {
    Refresh-ProcessesListBox
  }

  # Closing the form
  $btn_Onclick_Quit = {
    $frm_Processmanager.Close()
  }

  # Generated Form Code
  $frm_Processmanager.ClientSize = New-Object System.Drawing.Size(397, 321)

  $btn_Quit.Location = New-Object System.Drawing.Point(318, 278)
  $btn_Quit.Size = New-Object System.Drawing.Size(67, 31)
  $btn_Quit.TabIndex = 4
  $btn_Quit.Text = "Quit"
  $btn_Quit.UseVisualStyleBackColor = $True
  $btn_Quit.add_Click($btn_Onclick_Quit)

  $frm_Processmanager.Controls.Add($btn_Quit)

  $btn_Refresh.Location = New-Object System.Drawing.Point(288, 74)
  $btn_Refresh.Size = New-Object System.Drawing.Size(97, 39)
  $btn_Refresh.TabIndex = 3
  $btn_Refresh.Text = "Refresh"
  $btn_Refresh.UseVisualStyleBackColor = $True
  $btn_Refresh.add_Click($btn_Onclick_Refresh)

  $frm_Processmanager.Controls.Add($btn_Refresh)

  $btn_Kill.Location = New-Object System.Drawing.Point(288, 29)
  $btn_Kill.Size = New-Object System.Drawing.Size(97, 39)
  $btn_Kill.TabIndex = 2
  $btn_Kill.Text = "Kill"
  $btn_Kill.UseVisualStyleBackColor = $True
  $btn_Kill.add_Click($btn_Onclick_Kill)

  $frm_Processmanager.Controls.Add($btn_Kill)

  $lbx_Processes.FormattingEnabled = $True
  $lbx_Processes.Location = New-Object System.Drawing.Point(12, 29)
  $lbx_Processes.MultiColumn = $True
  $lbx_Processes.Size = New-Object System.Drawing.Size(234, 225)
  $lbx_Processes.TabIndex = 1

  $frm_Processmanager.Controls.Add($lbx_Processes)

  $lbl_Processes.Location = New-Object System.Drawing.Point(12, 9)
  $lbl_Processes.Size = New-Object System.Drawing.Size(120, 17)
  $lbl_Processes.TabIndex = 0
  $lbl_Processes.Text = "Prozessverwalter"

  $frm_Processmanager.Controls.Add($lbl_Processes)

  # Save the initial state of the form
  $InitialFormWindowState = $frm_Processmanager.WindowState

  # Init the OnLoad event to correct the initial state of the form
  $frm_Processmanager.add_Load({
      $frm_Processmanager.WindowState = $InitialFormWindowState
      Refresh-ProcessesListBox
    })

  # Show the Form
  $frm_Processmanager.ShowDialog() | Out-Null
}

# Call the Function
GenerateForm
