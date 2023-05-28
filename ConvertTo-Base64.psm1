function ConvertTo-Base64 {
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
    $Str = $In.Trim() # ensure we get a clean string without whitespaces (probably unnecessary)
    Write-Verbose "ConvertTo-Base64:`nThis is the string that's being converted (between dash lines):`n-----------`n$Str`n-----------"
    $EncodedStr = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($Str)) # do the conversion
    return $EncodedStr # return encoded string
}

