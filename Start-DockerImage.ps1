function Start-DockerImage
{
    [CmdletBinding()]
    param (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $ImageName,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $FolderToMap,

        [Parameter()]
        [int]
        $LocalPort = 8888
    )

    Begin
    {
        $validFolder = Test-Path $FolderToMap
        if(!$validFolder)
        {
            Write-Error -Message "Unable to find $($FolderToMap)"
            Break
        }
    }
    Process
    {
        $folderBindArg = $FolderToMap + ':/home/jovyan/work'
        $portMapArg = $LocalPort + ':8888'
        docker run --rm -p $portMapArg -e "JUPYTER_ENABLE_LAB=yes" -v $folderBindArg -it $ImageName
    }
}