function ConvertFrom-Base64 {
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
        [object]$In,

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
    
    if ($Browse) { # if -Browse switch is specified, browse to decoded string if it is a valid url
        if ($DecodedString -match "(http[s]?)(:\/\/)([^\s]+)") { # match using regex to ensure the output is at the very least in the format of 'http(s)://text'
            
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

