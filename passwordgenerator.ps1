# Function to generate a random password
function Generate-Password {
    param (
        [int]$length
    )

    # Define the character sets
    $lowercase = 'abcdefghijklmnopqrstuvwxyz'
    $uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    $numbers = '0123456789'
    $specialCharacters = '!@#$%^&*()-_=+[]{}|;:,.<>?'

    # Combine all character sets
    $allCharacters = $lowercase + $uppercase + $numbers + $specialCharacters

    # Create a random password
    $password = -join ((0..($length - 1)) | ForEach-Object { $allCharacters[(Get-Random -Maximum $allCharacters.Length)] })
    return $password
}

# Main script
do {
    do {
        # Prompt user for password length
        $userInput = Read-Host "Enter the desired password length (between 6 and 20)"

        # Check if the input is a number
        if ($userInput -match '^\d+$') {
            $passwordLength = [int]$userInput
            
            # Validate the length
            if ($passwordLength -lt 6) {
                Write-Host "Minimum password length is 6." -ForegroundColor Red
            } elseif ($passwordLength -gt 20) {
                Write-Host "Maximum password length is 20." -ForegroundColor Red
            } else {
                # Generate and display the password
                $password = Generate-Password -length $passwordLength
                Write-Host "Your generated password is: $password" -ForegroundColor Green
                break
            }
        } else {
            Write-Host "Please use numbers between 6 and 20 and refrain from using letters." -ForegroundColor Red
        }
    } while ($true)

    # Ask if the user wants to generate another password
    $response = Read-Host "Would you like to generate another password? (Y/N)"
    
    if ($response -notmatch '^[Yy]$') {
        Write-Host "Exiting the script. Have a great day!" -ForegroundColor Cyan
        break
    }
} while ($true)

# Keep the window open
Write-Host "Press Enter to exit..."
[void][System.Console]::ReadLine()