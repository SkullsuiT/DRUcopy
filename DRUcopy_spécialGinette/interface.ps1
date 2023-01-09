    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

# Declare variables for the form, buttons, and text box
    $Form = New-Object System.Windows.Forms.Form
    $OKButton = New-Object System.Windows.Forms.Button
    $CancelButton = New-Object System.Windows.Forms.Button
    $TextBox = New-Object System.Windows.Forms.TextBox

# Set size and location variables
    $OKButtonLocation = New-Object System.Drawing.Size(75,120)
    $OKButtonSize = New-Object System.Drawing.Size(75,23)
    $CancelButtonLocation = New-Object System.Drawing.Size(150,120)
    $CancelButtonSize = New-Object System.Drawing.Size(75,23)
    $TextBoxLocation = New-Object System.Drawing.Size(10,10)
    $TextBoxSize = New-Object System.Drawing.Size(200,20)


    function Set-FormTitleText
    {
        param(
            [System.Windows.Forms.Form]$Form,
            [string]$Text
        )
    
        $Form.Text = $Text
    
        # Calculate the size of the text
        $textSize = $Form.CreateGraphics().MeasureString($Text, $Form.Font)
    
        # Calculate the x coordinate for the text
        $x = ($Form.Width - $textSize.Width) / 2
    
        # Get the handle for the form
        $handle = $Form.Handle
    
        # Send a message to the form to update the title bar text
        [System.Windows.Forms.NativeMethods]::SetWindowText($handle, $Text)
    
        # Send a message to the form to update the position of the title bar text
        [System.Windows.Forms.NativeMethods]::SendMessage($handle, &H0085, $x, 0)
    }
    
    $Form = New-Object System.Windows.Forms.Form
        
    Set-FormTitleText -Form $Form -Text "My Form"
    

# Set form properties
# Increase the size of the form
    $Form.Size = New-Object System.Drawing.Size(400,200)
# Set the AutoSize property to true
    $Form.AutoSize = $true
# Set the maximum size of the form
    $Form.MaximumSize = New-Object System.Drawing.Size(900,200)

    $Form.ControlBox = $true



    

    



# Set button properties
    $OKButton.Location = $OKButtonLocation
    $OKButton.Size = $OKButtonSize
    $OKButton.Text = "OK"
    $CancelButton.Location = $CancelButtonLocation
    $CancelButton.Size = $CancelButtonSize
    $CancelButton.Text = "Annuler"

# Set text box properties
    $TextBox.Location = $TextBoxLocation
    $TextBox.Size = $TextBoxSize

# Add buttons and text box to form
    $Form.Controls.Add($OKButton)
    $Form.Controls.Add($CancelButton)
    $Form.Controls.Add($TextBox)

# Handle button click events
    $OKButton.Add_Click({
        Switch ($this.Text) {
            "OK" {
                # Perform OK button actions
                $Form.Close()
            };
            "Annuler" {
                # Perform Cancel button actions
                $Form.Close()
            }
        }
    })

# Show the form
    $Form.ShowDialog()
