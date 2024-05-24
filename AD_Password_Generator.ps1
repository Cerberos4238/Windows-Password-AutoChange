$userID = Read-Host "Enter the account name for which the password has to be change "
$Userexists = (Get-Localuser).Name -contains $userID

if ($Userexists) {
    function Generate-RandomPassword{
        [CmdletBinding()]
        param (
          [int]$Length = 8
        )
      $chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()-_=+[]{};:,.<>/?\|`~"
      $random = New-Object System.Random
      $password = ""
      for ($i = 0; $i -lt $Length; $i++) {
        $index = $random.Next(0, $chars.Length)
        $password += $chars[$index]
      }
      return $password
    }
    
$password = Generate-RandomPassword
$SecurePassword = ConvertTo-SecureString $password -AsPlainText -Force

Set-ADAccountPassword -Identity $userID -Reset -NewPassword $SecurePassword
Write-Host "`nThe new password for $userID is $Password" -ForegroundColor Green

} else {
        Write-Host "`nUser doesn't exists`n" -ForegroundColor Red
        Start-Sleep -Seconds 1
        exit
}