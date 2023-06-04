function ConvertFrom-Base64 {

<#
.SYNOPSIS
    Converts a Base64-encoded string to UTF-8

.DESCRIPTION
    This funtion takes string input and attempts to convert it from Base64 to UTF-8
    then spit out the converted string. If a string is not Base64, you'll get an error.
    Additionally, a switch parameter is included to grab a URL & open it 
    which is described below

.PARAMETER In
    The Base64 string to convert

.PARAMETER Browse
    Switch paramter - if you expect the decoded string to be a URL, you can use this
    to quickly open the link in your default web browser.  Before opening, the decoded
    string will first be validated to ensure it is a correctly-formatted URL.
    My regex logic is simple, so it really only checks to ensure you have "http(s)",
    the ":\\", and then something after it; so this script considers "https://test" to
    be a valid link for example - good enough for me. Then, the user will be displayed
    the validated URL string and a security lecture prompt where you have to choose yes
    to browse to it.

.EXAMPLE
     PS> ConvertFrom-Base64 "aHR0cHM6Ly9naXRodWIuY29tL3JhZG8tYm95L0NvbnZlcnQtQmFzZTY0" -Browse
    (note: this is the decoded string https://github.com/rado-boy/Convert-Base64)

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
            HelpMessage="Base64 String to decode",
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true
            )
        ]
        [ValidateNotNullOrEmpty()]
        [string]$In,

        [Parameter(
            Mandatory=$False,
            HelpMessage="If decoded string is a link, open it in browser - Note: Not recommended"
            )
        ]
        [switch]$Browse
    )

    $Str = $In.Trim() # added this to ensure there isn't a newline at end of output if you pipe from Out-String
    Write-Verbose "ConvertFrom-Base64:`nThis is the string that's being converted (between dash lines):`n-----------`n$Str`n-----------"
    $DecodedString = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($Str)) # do the conversion
    
    if ($Browse) { # if -Browse switch is specified & output is a 'valid' URL, browse to it
        if ($DecodedString -match "(http[s]?)(:\/\/)([^\s]+)") { # match using regex to ensure the output is in the minimum format of 'http(s)://text'
            
            # display link and ask user if they want to open it
            $msg = `
                'WARNING: Please exercise extreme caution and only open links from trusted sources' + "`n" +`
                'The creator of this script is not liable for any damage if you enter "Y" below' +` "`n" + "`n" +`
                'Do you want to open this URL?' + "`n" +`
            $DecodedString
            $options = 
                '&Yes', 
                '&No'
            $default = 1  # 0=Yes, 1=No

            $response = $Host.UI.PromptForChoice($null, $msg, $options, $default)
            if ($response -eq 0) { # if response is yes, launch URL in default browser
                Start-Process $DecodedString
            } # if user said no, not necessary to return decoded string
            
        } else {
            # throw an error if regex does not find the URL to be valid
            Write-Error "`"-Browse`" parameter specified but converted string does not appear to be a URL (or my regex is broken again :( )"
            $Browse = $False # this line ensures decoded string is returned at end of function if regex match failed
        }
    }
    
    # return decoded string if $Browse = $False
    if (!($Browse)) {return $DecodedString}

}

