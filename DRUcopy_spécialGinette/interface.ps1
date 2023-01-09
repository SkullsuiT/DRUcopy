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

# Set form properties
    $Form.Text = "Ma première interface utilisateur en PowerShell"
# Increase the size of the form
    $Form.Size = New-Object System.Drawing.Size(400,200)
# Adjust the font size of the form's text
    $Form.Font = New-Object System.Drawing.Font("Arial", 11)
# Set the AutoSize property to true
    $Form.AutoSize = $true
# Set the maximum size of the form
    $Form.MaximumSize = New-Object System.Drawing.Size(900,200)

    $Form.ControlBox = $true

# Override the WndProc method
$Form.Add_WndProc({
    param($m)

    # Check for the WM_NCPAINT message
    if ($m.Msg -eq 0x85) {
        # Get the size of the text
        $textSize = $Form.CreateGraphics().MeasureString($Form.Text, $Form.Font)

        # Calculate the x and y coordinates for the text
        $x = ($Form.Width - $textSize.Width) / 2
        $y = 0

        # Draw the text on the form
        $Form.CreateGraphics().DrawString($Form.Text, $Form.Font, [System.Drawing.Brushes]::Black, $x, $y)
    }

    # Call the base method
    $Form.WndProc($m)
})

    



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
