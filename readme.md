# Convert-Base64 Powershell Cmdlets #

## ConvertTo-Base64 ##

Give it a UTF8-encoded string and it will output the base64-encoded version.  Accepts string input and outputs a string

*Example:*

```PowerShell
PS> Import-Module .\ConvertTo-Base64.psm1
PS> ConvertTo-Base64 "https://github.com/rado-boy/Convert-Base64"
aHR0cHM6Ly9naXRodWIuY29tL3JhZG8tYm95L0NvbnZlcnQtQmFzZTY0
```

## ConvertFrom-Base64 ##

Give it a base64 string and it will output the UTF8-encoded version.  Accepts string input and outputs a string

*Example:*

```PowerShell
PS> Import-Module .\ConvertFrom-Base64.psm1
PS> ConvertFrom-Base64 "aHR0cHM6Ly9naXRodWIuY29tL3JhZG8tYm95L0NvbnZlcnQtQmFzZTY0"
https://github.com/rado-boy/Convert-Base64
```

### -Browse Usage ###

Use this parameter to check the decoded string for a URL and open it in your default browser if it appears valid (displays the URL for the user first along with a security warning)

*Example:*

```PowerShell
PS> Import-Module .\ConvertFrom-Base64.psm1
PS> ConvertFrom-Base64 "aHR0cHM6Ly9naXRodWIuY29tL3JhZG8tYm95L0NvbnZlcnQtQmFzZTY0" -Browse
WARNING: Please exercise extreme caution and only open links from trusted sources
The creator of this script is not liable for any damage if you enter "Y" below

Do you want to open this URL?
https://github.com/rado-boy/Convert-Base64
[Y] Yes  [N] No  [?] Help (default is "N"): y
```

* Result: Link is opened in default browser