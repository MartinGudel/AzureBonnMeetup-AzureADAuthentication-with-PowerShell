$resourceUrl                = "https://graph.microsoft.com"
$endpoint                   = "login.microsoftonline.com"
$authorizationEndpointUrl   = "https://" + $endpoint + "/common/oauth2/devicecode"
$clientid                   = "1b730954-1685-4b74-9bfd-dac224a7b894";
$requestid                  = New-Guid

write-host     "generating requestID " requestid;

$requestUri = $authorizationEndpointUrl + "?" `
                    + "resource=" + $resourceUrl + "&" `
                    + "client_id=" + $clientid + "&" `
                    + "client-request-id=" + $requestid + "&" `
                    + "x-client-SKU=PCL.CoreCLR&" `
                    + "x-client-Ver=3.19.2.6005"
write-host "getGrantTypeCodeAuthentication: Request: " $request

# now go and get the device code

$devicecoderequest = Invoke-WebRequest -Uri $requestUri 

write-host "device code authentication request response"

$devicecoderequestobj = $devicecoderequest | ConvertFrom-Json

write-host "device code authentication request  object"

$devicecoderequestobj | fl
$devicecodevalue = $devicecoderequestobj.device_code

$pressAnyKey = Read-Host "press any key"

##
## now go and try if we're already authenticated. if yes receive your OAuth Token
##

$tokenEndpointUrl           = "https://" + $endpoint + "/common/oauth2/token";
$reqbody                     = @{Authorization = ("Bearer "+$token)}
$reqbody.Add("resource",     $resourceUrl)
$reqbody.Add("grant_type",   "device_code")
$reqbody.Add("client_id",    $clientid)
$reqbody.Add("code",         $devicecodevalue)

$res = Invoke-RestMethod -Method POST -Body $reqbody -Uri $tokenEndpointUrl


write-host "Authentication result "
$res | fl




