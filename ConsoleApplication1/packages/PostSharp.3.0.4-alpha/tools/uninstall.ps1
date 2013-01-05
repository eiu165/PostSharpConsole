﻿param($installPath, $toolsPath, $package, $project)

$targetsFile = [System.IO.Path]::Combine($toolsPath, 'PostSharp.targets')

# Need to load MSBuild assembly if it's not loaded yet.
Add-Type -AssemblyName 'Microsoft.Build, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'

# Grab the loaded MSBuild project for the project
$msbuild = [Microsoft.Build.Evaluation.ProjectCollection]::GlobalProjectCollection.GetLoadedProjects($project.FullName) | Select-Object -First 1

# Remove the property DontImportPostSharp
$msbuild.Xml.Properties | Where-Object {$_.Name.ToLowerInvariant() -eq "dontimportpostsharp" } | Foreach { 
	$_.Parent.RemoveChild( $_ ) 
	"Removed property DontImportPostSharp"
}

# Remove imports to PostSharp.targets
$msbuild.Xml.Imports | Where-Object {$_.Project.ToLowerInvariant().EndsWith("postsharp.targets") } | Foreach { 
	$_.Parent.RemoveChild( $_ ) 
	[string]::Format( "Removed import of '{0}'" , $_.Project )
}
# SIG # Begin signature block
# MIIekwYJKoZIhvcNAQcCoIIehDCCHoACAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUyM3II4aF2FAk5B8jBlUy7ZO4
# KtagghmDMIIEhTCCA22gAwIBAgIDAjpkMA0GCSqGSIb3DQEBBQUAMEIxCzAJBgNV
# BAYTAlVTMRYwFAYDVQQKEw1HZW9UcnVzdCBJbmMuMRswGQYDVQQDExJHZW9UcnVz
# dCBHbG9iYWwgQ0EwHhcNMTIxMDE4MTQzODM1WhcNMjIwNTIwMTQzODM1WjBeMQsw
# CQYDVQQGEwJVUzEdMBsGA1UEChMUU3ltYW50ZWMgQ29ycG9yYXRpb24xMDAuBgNV
# BAMTJ1N5bWFudGVjIFRpbWUgU3RhbXBpbmcgU2VydmljZXMgQ0EgLSBHMjCCASIw
# DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALGss0lUS5ccEgrYJXmRIlcqb9y4
# JsRDc2vCvy5QWvsUwnaOQwElQ7Sh4kX06Ld7w3TMIte0lAAC903tv7S3RCRrzV9F
# O9FEzkMScxeCi2m0K8uZHqxyGyZNcR+xMd37UWECU6aq9UksBXhFpS+JzueZ5/6M
# 4lc/PcaS3Er4ezPkeQr78HWIQZz/xQNRmarXbJ+TaYdlKYOFwmAUxMjJOxTawIHw
# Hw103pIiq8r3+3R8J+b3Sht/p8OeLa6K6qbmqicWfWH3mHERvOJQoUvlXfrlDqcs
# n6plINPYlujIfKVOSET/GeJEB5IL12iEgF1qeGRFzWBGflTBE3zFefHJwXECAwEA
# AaOCAWYwggFiMB8GA1UdIwQYMBaAFMB6mGiNifurBWQMEX2qfWW4ysxOMB0GA1Ud
# DgQWBBRfmvVuXMzMdJrU3X3vP9vsTIAu3TASBgNVHRMBAf8ECDAGAQH/AgEAMA4G
# A1UdDwEB/wQEAwIBBjA6BgNVHR8EMzAxMC+gLaArhilodHRwOi8vY3JsLmdlb3Ry
# dXN0LmNvbS9jcmxzL2d0Z2xvYmFsLmNybDA0BggrBgEFBQcBAQQoMCYwJAYIKwYB
# BQUHMAGGGGh0dHA6Ly9vY3NwLmdlb3RydXN0LmNvbTBLBgNVHSAERDBCMEAGCSsG
# AQQB8CIBBzAzMDEGCCsGAQUFBwIBFiVodHRwOi8vd3d3Lmdlb3RydXN0LmNvbS9y
# ZXNvdXJjZXMvY3BzMCgGA1UdEQQhMB+kHTAbMRkwFwYDVQQDExBUaW1lU3RhbXAt
# MjA0OC0xMBMGA1UdJQQMMAoGCCsGAQUFBwMIMA0GCSqGSIb3DQEBBQUAA4IBAQCq
# Pj8DQS81E3+MPxJcEM/uZ1V5VmAPAVIPI4d6QShH5dNmcrsCz8kMJClBwtoumeAj
# ke+xM0c8wgg6BpVzohsOvD+34lnxab7w0+EYj3Mt6KOcIUBA8806twGN3E2UtHoQ
# BVB/G2HFghWK5CxN7TQR61tqiVnH3vcshMCzvTqY4UUoiiGVgD/JB5fw/0LBHkKE
# 57LH4KJqmdTx1Mb+V8C5Ouf2J3ANqeB7ShOVwsm5q2kH2U3MZkdCSnSnp22zpzXo
# fkuqzr28k599xkCl/KofqNXR8H5/0uNMVv1AZPBHTFEEMOrqlC8kyukIxXhboWLJ
# HUiHlxn6TaV47ewEeQ42MIIEozCCA4ugAwIBAgIQfh/fcpno0kWhXQuo5bFZujAN
# BgkqhkiG9w0BAQUFADBeMQswCQYDVQQGEwJVUzEdMBsGA1UEChMUU3ltYW50ZWMg
# Q29ycG9yYXRpb24xMDAuBgNVBAMTJ1N5bWFudGVjIFRpbWUgU3RhbXBpbmcgU2Vy
# dmljZXMgQ0EgLSBHMjAeFw0xMjEwMTgwMDAwMDBaFw0yMjA1MTkyMzU5NTlaMGIx
# CzAJBgNVBAYTAlVTMR0wGwYDVQQKExRTeW1hbnRlYyBDb3Jwb3JhdGlvbjE0MDIG
# A1UEAxMrU3ltYW50ZWMgVGltZSBTdGFtcGluZyBTZXJ2aWNlcyBTaWduZXIgLSBH
# NDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKJjCzlEuLsjp0RJuw7/
# ofBhClOTsJjbrSwPSsVu/4Y8U1UPFc4EPyv9qZaW2b5heQtbyUyGduXgQ0sile7C
# K0PBn9hotI5AT+6FOLkRxSPyZFjwFTJvTlehroikAtcqHs1L4d1j1ReJMluwXpla
# qJ0oUA4X7pbbYTtFUR3PElYLkkf8q672Zj1HrHBy55LnX80QucSDZJQZvSWA4ejS
# IqXQugJ6oXeTW2XD7hd0vEGGKtwITIySjJEtnndEH2jWqHR32w5bMotWizO92WPI
# SZ06xcXqMwvS8aMb9Iu+2bNXizveBKd6IrIkri7HcMW+ToMmCPsLvalPmQjhEChy
# qs0CAwEAAaOCAVcwggFTMAwGA1UdEwEB/wQCMAAwFgYDVR0lAQH/BAwwCgYIKwYB
# BQUHAwgwDgYDVR0PAQH/BAQDAgeAMHMGCCsGAQUFBwEBBGcwZTAqBggrBgEFBQcw
# AYYeaHR0cDovL3RzLW9jc3Aud3Muc3ltYW50ZWMuY29tMDcGCCsGAQUFBzAChito
# dHRwOi8vdHMtYWlhLndzLnN5bWFudGVjLmNvbS90c3MtY2EtZzIuY2VyMDwGA1Ud
# HwQ1MDMwMaAvoC2GK2h0dHA6Ly90cy1jcmwud3Muc3ltYW50ZWMuY29tL3Rzcy1j
# YS1nMi5jcmwwKAYDVR0RBCEwH6QdMBsxGTAXBgNVBAMTEFRpbWVTdGFtcC0yMDQ4
# LTIwHQYDVR0OBBYEFEbGaaMOShQe1UzaUmMXP142vA3mMB8GA1UdIwQYMBaAFF+a
# 9W5czMx0mtTdfe8/2+xMgC7dMA0GCSqGSIb3DQEBBQUAA4IBAQBjADKNFx8o3AR5
# yScZhLg2aKd1GRiyT0msXWErhjLQDU26tXxettI36O1biCzSKWG+H1ApSiL5F4a9
# hyFb0TxNv2TAui6bphCh8cSEU7CNWPKOrxIZdx+t976+gS2Ogn5w+DmWM2VZqE9/
# iyLJGH5eZOK5MG0GtLcRjGa6LCZEuYrcsYeRtdy/FKHcg6NgryleZoorDe2d0DkF
# ubhvHrm6ccxo3rJ5OgPWiOEdKbM05yHYow8rchpCtZ5F+t+nK53X8s0dyFYSL42d
# Tc4yySZhZNCaeOUvEmpKRAIk2FeFMn/NWYxrczMApV6rw/AiwMsIw+D3uLgEFOxK
# 7zn5z8olMIIE0zCCA7ugAwIBAgIQGNrRniZ96LtKIVjNzGs7SjANBgkqhkiG9w0B
# AQUFADCByjELMAkGA1UEBhMCVVMxFzAVBgNVBAoTDlZlcmlTaWduLCBJbmMuMR8w
# HQYDVQQLExZWZXJpU2lnbiBUcnVzdCBOZXR3b3JrMTowOAYDVQQLEzEoYykgMjAw
# NiBWZXJpU2lnbiwgSW5jLiAtIEZvciBhdXRob3JpemVkIHVzZSBvbmx5MUUwQwYD
# VQQDEzxWZXJpU2lnbiBDbGFzcyAzIFB1YmxpYyBQcmltYXJ5IENlcnRpZmljYXRp
# b24gQXV0aG9yaXR5IC0gRzUwHhcNMDYxMTA4MDAwMDAwWhcNMzYwNzE2MjM1OTU5
# WjCByjELMAkGA1UEBhMCVVMxFzAVBgNVBAoTDlZlcmlTaWduLCBJbmMuMR8wHQYD
# VQQLExZWZXJpU2lnbiBUcnVzdCBOZXR3b3JrMTowOAYDVQQLEzEoYykgMjAwNiBW
# ZXJpU2lnbiwgSW5jLiAtIEZvciBhdXRob3JpemVkIHVzZSBvbmx5MUUwQwYDVQQD
# EzxWZXJpU2lnbiBDbGFzcyAzIFB1YmxpYyBQcmltYXJ5IENlcnRpZmljYXRpb24g
# QXV0aG9yaXR5IC0gRzUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCv
# JAgIKXo1nmAMqudLO07cfLw8RRy7K+D+KQL5VwijZIUVJ/XxrcgxiV0i6CqqpkKz
# j/i5Vbext0uz/o9+B1fs70PbZmIVYc9gDaTY3vjgw2IIPVQT60nKWVSFJuUrjxuf
# 6/WhkcIzSdhDY2pSS9KP6HBRTdGJaXvHcPaz3BJ023tdS1bTlr8Vd6Gw9KIl8q8c
# kmcY5fQGBO+QueQA5N06tRn/Arr0PO7gi+s3i+z016zy9vA9r911kTMZHRxAy3Qk
# GSGT2RT+rCpSx4/VBEnkjWNHiDxpg8v+R70rfk/Fla4OndTRQ8Bnc+MUCH7lP59z
# uDMKz10/NIeWiu5T6CUVAgMBAAGjgbIwga8wDwYDVR0TAQH/BAUwAwEB/zAOBgNV
# HQ8BAf8EBAMCAQYwbQYIKwYBBQUHAQwEYTBfoV2gWzBZMFcwVRYJaW1hZ2UvZ2lm
# MCEwHzAHBgUrDgMCGgQUj+XTGoasjY5rw8+AatRIGCx7GS4wJRYjaHR0cDovL2xv
# Z28udmVyaXNpZ24uY29tL3ZzbG9nby5naWYwHQYDVR0OBBYEFH/TZafC3ey78DAJ
# 80M5+gKvMzEzMA0GCSqGSIb3DQEBBQUAA4IBAQCTJEowX2LP2BqYLz3q3JktvXf2
# pXkiOOzEp6B4Eq1iDkVwZMXnl2YtmAl+X6/WzChl8gGqCBpH3vn5fJJaCGkgDdk+
# bW48DW7Y5gaRQBi5+MHt39tBquCWIMnNZBU4gcmU7qKEKQsTb47bDN0lAtukixlE
# 0kF6BWlKWE9gyn6CagsCqiUXObXbf+eEZSqVir2G3l6BFoMtEMze/aiCKm0oHw0L
# xOXnGiYZ4fQRbxC1lfznQgUy286dUV4otp6F01vvpX1FQHKOtw5rDgb7MzVIcbid
# J4vEZV8NhnacRHr2lVz2XTIIM6RUthg/aFzyQkqFOFSDX9HoLPKsEdao7WNqMIIF
# ajCCBFKgAwIBAgIQDLZ6+7O4pymGCOAOlM81PjANBgkqhkiG9w0BAQUFADCBtDEL
# MAkGA1UEBhMCVVMxFzAVBgNVBAoTDlZlcmlTaWduLCBJbmMuMR8wHQYDVQQLExZW
# ZXJpU2lnbiBUcnVzdCBOZXR3b3JrMTswOQYDVQQLEzJUZXJtcyBvZiB1c2UgYXQg
# aHR0cHM6Ly93d3cudmVyaXNpZ24uY29tL3JwYSAoYykxMDEuMCwGA1UEAxMlVmVy
# aVNpZ24gQ2xhc3MgMyBDb2RlIFNpZ25pbmcgMjAxMCBDQTAeFw0xMTA2MjQwMDAw
# MDBaFw0xNDA3MDMyMzU5NTlaMIGtMQswCQYDVQQGEwJDWjEPMA0GA1UECBMGUHJh
# Z3VlMQ8wDQYDVQQHEwZQcmFndWUxHTAbBgNVBAoUFFNoYXJwQ3JhZnRlcnMgcy5y
# Lm8uMT4wPAYDVQQLEzVEaWdpdGFsIElEIENsYXNzIDMgLSBNaWNyb3NvZnQgU29m
# dHdhcmUgVmFsaWRhdGlvbiB2MjEdMBsGA1UEAxQUU2hhcnBDcmFmdGVycyBzLnIu
# by4wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCtAOpIYgUUs43HJF6P
# JVW2P03GRyvy0+RsJIOxMsogYrx5yEbLlTWsxLvJGvWZlRzR/vFdL05UbvYq06GV
# ZDltE6lXNCicQ2vTpt9ieWmrkNFVgSNdxCOEc8e8fl+pWb+ucOzddW3R40sDnVWa
# jSMAB+mLxYFGtY/DDimCk3D1G+z6+rJUUar1jSWks3ObCg6Nrt87aDOjIvGTi075
# SItlgLvQDia2yS5yEv0j24C/gN7NTLfxqrlbN76HGhy4N/+gKJeFypiP2BXDgEg+
# 9m/WX6VU4IXetap0PSF8LYxwgwJDByMZ8pP4VH1zdlvuRBbdALxje4/gGPMFvMqC
# TOaPAgMBAAGjggF7MIIBdzAJBgNVHRMEAjAAMA4GA1UdDwEB/wQEAwIHgDBABgNV
# HR8EOTA3MDWgM6Axhi9odHRwOi8vY3NjMy0yMDEwLWNybC52ZXJpc2lnbi5jb20v
# Q1NDMy0yMDEwLmNybDBEBgNVHSAEPTA7MDkGC2CGSAGG+EUBBxcDMCowKAYIKwYB
# BQUHAgEWHGh0dHBzOi8vd3d3LnZlcmlzaWduLmNvbS9ycGEwEwYDVR0lBAwwCgYI
# KwYBBQUHAwMwcQYIKwYBBQUHAQEEZTBjMCQGCCsGAQUFBzABhhhodHRwOi8vb2Nz
# cC52ZXJpc2lnbi5jb20wOwYIKwYBBQUHMAKGL2h0dHA6Ly9jc2MzLTIwMTAtYWlh
# LnZlcmlzaWduLmNvbS9DU0MzLTIwMTAuY2VyMB8GA1UdIwQYMBaAFM+Zqep7JvRL
# yY6P1/AFJu/j0qedMBEGCWCGSAGG+EIBAQQEAwIEEDAWBgorBgEEAYI3AgEbBAgw
# BgEBAAEB/zANBgkqhkiG9w0BAQUFAAOCAQEAcuiguQ1/8KOeaaYrcdof3/FMVpjb
# B77wK4UCkM0n2LUGEPH7nldxWGgv/b5HdQK3d+QNwLE9VKS7nmeDVVwOJbainlzO
# RenvoT1nuZ3Oc5A6/Fhay6o7D413PR4h6aEJvsmfS53P8JAPnh76y6fg5peVyVjr
# 28x3/b1i80ohGqiNpogOsszXEmZgC82p3q9Y9wI2jFPDpq9FL7CKScKCVQxVqKTc
# wiRu6LycIWowctZrYR0v5daTqFmtg/xn3x5rHg4JbXZcI1WdxJ1EOBzfHGe70gf6
# 3tYcz7JAuUC2ozbx0YzrJ46+GXxlmZg6t2UNhOJk8mF5SFhSOGIYfRvV7jCCBgow
# ggTyoAMCAQICEFIA5aolVvwahu2WydRLM8cwDQYJKoZIhvcNAQEFBQAwgcoxCzAJ
# BgNVBAYTAlVTMRcwFQYDVQQKEw5WZXJpU2lnbiwgSW5jLjEfMB0GA1UECxMWVmVy
# aVNpZ24gVHJ1c3QgTmV0d29yazE6MDgGA1UECxMxKGMpIDIwMDYgVmVyaVNpZ24s
# IEluYy4gLSBGb3IgYXV0aG9yaXplZCB1c2Ugb25seTFFMEMGA1UEAxM8VmVyaVNp
# Z24gQ2xhc3MgMyBQdWJsaWMgUHJpbWFyeSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0
# eSAtIEc1MB4XDTEwMDIwODAwMDAwMFoXDTIwMDIwNzIzNTk1OVowgbQxCzAJBgNV
# BAYTAlVTMRcwFQYDVQQKEw5WZXJpU2lnbiwgSW5jLjEfMB0GA1UECxMWVmVyaVNp
# Z24gVHJ1c3QgTmV0d29yazE7MDkGA1UECxMyVGVybXMgb2YgdXNlIGF0IGh0dHBz
# Oi8vd3d3LnZlcmlzaWduLmNvbS9ycGEgKGMpMTAxLjAsBgNVBAMTJVZlcmlTaWdu
# IENsYXNzIDMgQ29kZSBTaWduaW5nIDIwMTAgQ0EwggEiMA0GCSqGSIb3DQEBAQUA
# A4IBDwAwggEKAoIBAQD1I0tepdeKuzLp1Ff37+THJn6tGZj+qJ19lPY2axDXdYEw
# fwRof8srdR7NHQiM32mUpzejnHuA4Jnh7jdNX847FO6G1ND1JzW8JQs4p4xjnRej
# CKWrsPvNamKCTNUh2hvZ8eOEO4oqT4VbkAFPyad2EH8nA3y+rn59wd35BbwbSJxp
# 58CkPDxBAD7fluXF5JRx1lUBxwAmSkA8taEmqQynbYCOkCV7z78/HOsvlvrlh3fG
# tVayejtUMFMb32I0/x7R9FqTKIXlTBdOflv9pJOZf9/N76R17+8V9kfn+Bly2C40
# Gqa0p0x+vbtPDD1X8TDWpjaO1oB21xkupc1+NC2JAgMBAAGjggH+MIIB+jASBgNV
# HRMBAf8ECDAGAQH/AgEAMHAGA1UdIARpMGcwZQYLYIZIAYb4RQEHFwMwVjAoBggr
# BgEFBQcCARYcaHR0cHM6Ly93d3cudmVyaXNpZ24uY29tL2NwczAqBggrBgEFBQcC
# AjAeGhxodHRwczovL3d3dy52ZXJpc2lnbi5jb20vcnBhMA4GA1UdDwEB/wQEAwIB
# BjBtBggrBgEFBQcBDARhMF+hXaBbMFkwVzBVFglpbWFnZS9naWYwITAfMAcGBSsO
# AwIaBBSP5dMahqyNjmvDz4Bq1EgYLHsZLjAlFiNodHRwOi8vbG9nby52ZXJpc2ln
# bi5jb20vdnNsb2dvLmdpZjA0BgNVHR8ELTArMCmgJ6AlhiNodHRwOi8vY3JsLnZl
# cmlzaWduLmNvbS9wY2EzLWc1LmNybDA0BggrBgEFBQcBAQQoMCYwJAYIKwYBBQUH
# MAGGGGh0dHA6Ly9vY3NwLnZlcmlzaWduLmNvbTAdBgNVHSUEFjAUBggrBgEFBQcD
# AgYIKwYBBQUHAwMwKAYDVR0RBCEwH6QdMBsxGTAXBgNVBAMTEFZlcmlTaWduTVBL
# SS0yLTgwHQYDVR0OBBYEFM+Zqep7JvRLyY6P1/AFJu/j0qedMB8GA1UdIwQYMBaA
# FH/TZafC3ey78DAJ80M5+gKvMzEzMA0GCSqGSIb3DQEBBQUAA4IBAQBWIuY0pMRh
# y0i5Aa1WqGQP2YyRxLvMDOWteqAif99HOEotbNF/cRp87HCpsfBP5A8MU/oVXv50
# mEkkhYEmHJEUR7BMY4y7oTTUxkXoDYUmcwPQqYxkbdxxkuZFBWAVWVE5/FgUa/7U
# pO15awgMQXLnNyIGCb4j6T9Emh7pYZ3MsZBc/D3SjaxCPWU21LQ9QCiPmxDPIybM
# SyDLkB9djEw0yjzY5TfWb6UgvTTrJtmuDefFmvehtCGRM2+G6Fi7JXx0Dlj+dRtj
# P84xfJuPG5aexVN2hFucrZH6rO2Tul3IIVPCglNjrxINUIcRGz1UUpaKLJw9khoI
# mgUux5OlSJHTMYIEejCCBHYCAQEwgckwgbQxCzAJBgNVBAYTAlVTMRcwFQYDVQQK
# Ew5WZXJpU2lnbiwgSW5jLjEfMB0GA1UECxMWVmVyaVNpZ24gVHJ1c3QgTmV0d29y
# azE7MDkGA1UECxMyVGVybXMgb2YgdXNlIGF0IGh0dHBzOi8vd3d3LnZlcmlzaWdu
# LmNvbS9ycGEgKGMpMTAxLjAsBgNVBAMTJVZlcmlTaWduIENsYXNzIDMgQ29kZSBT
# aWduaW5nIDIwMTAgQ0ECEAy2evuzuKcphgjgDpTPNT4wCQYFKw4DAhoFAKB4MBgG
# CisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcC
# AQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYE
# FDI9/913epwpj3MJkYDkyAS5ftV6MA0GCSqGSIb3DQEBAQUABIIBAEMTxe8YgoT9
# Ll5U5fMGCu2GFdPasP0gABXIxwOTau7aKM+PwG6wUW/7XZXuOIDALEYkF7U9rr4x
# AY9Na0q9PU6BFHc9eHcwSzFzQ0qoxRcAv+MeDdv5FrTcWP0mWJX6cZPF4o67viZE
# SwnDaaP0bAoYm2KG+4IN/ThdtTTXBmcC8PKRGZRfEIdb+O+lL4j9H0Bq8I0rFnob
# 1a8jmjG6JD80/7tBRdQT6EhFxD92T9Gyd2NHEFmXj0rtTSDesgdbLbfQyTkNwnV/
# EIWad5rOzfrNKB/wGWzQAWVOo3tcLYm3HPVHdKSbf2YGX+Cfyag1Xlzw5n+qXZmE
# lvjZT4HQmDihggILMIICBwYJKoZIhvcNAQkGMYIB+DCCAfQCAQEwcjBeMQswCQYD
# VQQGEwJVUzEdMBsGA1UEChMUU3ltYW50ZWMgQ29ycG9yYXRpb24xMDAuBgNVBAMT
# J1N5bWFudGVjIFRpbWUgU3RhbXBpbmcgU2VydmljZXMgQ0EgLSBHMgIQfh/fcpno
# 0kWhXQuo5bFZujAJBgUrDgMCGgUAoF0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
# ATAcBgkqhkiG9w0BCQUxDxcNMTMwMTA0MTIzMzM1WjAjBgkqhkiG9w0BCQQxFgQU
# MYn5f6+ryAhJjW3hUzp6TQPzC54wDQYJKoZIhvcNAQEBBQAEggEAX18m8/z/oPTh
# zsKUt0wmdB0yeyieVv2KSswDqRGsC3MYfPiJLGhzHrOAKPBpGCPiJF8mSeMTTqt/
# Bu7OwhVdkF2sM6KfJ4Ddwfljdcg3okeumJthByz1Ez9zrYmHq9Gl58YV1qWcblhY
# KgEWdcS02LW39cKLDMixqoCpGBBGS1O+UYl/uK/djkmLc/Bm8ZbE8lF10ZXVRfdS
# bBz9i2amjM6POpN+jFK4PvalRvBYaQsu0nqjASzAmn75N6IBj1MJt320gKTkqbZU
# zU0X/NU5/ecCRV695lUXenAaasFXHgW/JsYtb4hcmCyYGwywa7zhUatcPHPsDea1
# f01pGnC10A==
# SIG # End signature block
