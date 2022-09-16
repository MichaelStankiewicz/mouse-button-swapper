<#
    .SYNOPSIS
    Swaps the primary mouse button on the system to match the desired hand.

    .DESCRIPTION
    This script will generate a WinForm asking the user to select the hand with which they intend to use the mouse.
    Based on the selection, it will activate the respective primary mouse button.

    .EXAMPLE
    .\Set-PrimaryMouseButton.ps1
#>

[CmdletBinding()]
param()

function Swap_MouseButton{
    [CmdletBinding()]
    param(
        [ValidateSet('Left', 'Right')]
        [Parameter(Mandatory=$true)]
        [String] $MouseButtonOrientation
    )

    # Load the proper method from the required unamanged DLL.
    # This is required to call the necessary mouse button activation functionality.
    Add-Type -Name NativeMethods -NameSpace Win32 -MemberDefintition `
@'
    [DllImport("user32.dll")]
    public static extern Int32 SwapMouseButton(Int32 bSwap);
'@

    # Based on the orientation provided, set the mouse button accordingly.
    switch ($MouseButtonOrientation){
        'Left'  { [Win32.NativeMethods]::SwapMouseButton(0) }
        'Right' { [Win32.NativeMethods]::SwapMouseButton(1) }
    }
}

function Generate_WinForm{
    [CmdletBinding()]
    param()

    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $form = New-Object System.Windows.Forms.Form
    $form.Text = 'Mouse Button Swapper'
    $form.Size = New-Object System.Drawing.Size(308,200)
    $form.StartPosition = 'CenterScreen'
    $form.FormBorderStyle = [System.WIndows.Forms.FormBorderStyle]::FixedSingle
    $form.MaximizeBox = $false
    $form.MinimizeBox = $false
    $icon = [System.Drawing.Icon]::New('.\images\mouse.ico')
    $form.Icon = $icon

    $leftButton = New-Object System.Windows.Forms.Button
    $leftButton.Location = New-Object System.Drawing.Point(10,65)
    $leftButton.Size = New-Object System.Drawing.Size(134,50)
    $leftButton.Text = 'Left'
    $leftButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $form.AcceptButton = $leftButton
    $form.Controls.Add($leftButton)

    $rightButton = New-Object System.Windows.Forms.Button
    $rightButton.Location = New-Object System.Drawing.Point(145,65)
    $rightButton.Size = New-Object System.Drawing.Size(134,50)
    $rightButton.Text = 'Right'
    $rightButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $form.CancelButton = $rightButton
    $form.Controls.Add($rightButton)

    $label = New-Object System.Windows.Forms.Label
    $label.Location = New-Object System.Drawing.Point(10,20)
    $label.Size = New-Object System.Drawing.Size(280,20)
    $label.Text = 'Which hand would you like to use the mouse with?'
    $form.Controls.Add($label)

    $form.Topmost = $true

    $result = $form.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK)
    {
        Swap_MouseButton -MouseButtonOrientation 'Right'
    } else {
        Swap_MouseButton -MouseButtonOrientation 'Left'
    }
}

#region main

Generate_WinForm

#endregion main