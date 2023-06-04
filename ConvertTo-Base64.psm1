function ConvertTo-Base64 {

<#
.SYNOPSIS
    Converts a UTF-8 string to be base-64 encoded

.DESCRIPTION
    This funtion takes string input and attempts to convert it from UTF-8 to Base64
    
.PARAMETER In
    The UTF-8 string to convert

.EXAMPLE
     PS> ConvertTo-Base64 "https://github.com/rado-boy/Convert-Base64"
    aHR0cHM6Ly9naXRodWIuY29tL3JhZG8tYm95L0NvbnZlcnQtQmFzZTY0

.INPUTS
    String

.OUTPUTS
    String

.NOTES
    Author: https://github.com/rado-boy
#>

    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory=$True,
            HelpMessage="Text string to encode",
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true
            )
        ]
        [ValidateNotNullOrEmpty()]
        [string]$In
    )
    $Str = $In.Trim() # added this to ensure there isn't a newline at end of output if you pipe from Out-String
    Write-Verbose "ConvertTo-Base64:`nThis is the string that's being converted (between dash lines):`n-----------`n$Str`n-----------"
    $EncodedStr = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($Str)) # do the conversion
    return $EncodedStr # return encoded string
}

