# .SYNOPSIS
# A script that reads, in real time, your instances log file and applies functional colours.
#
# .DESCRIPTION
# A script that reads, in real time, your instances log file and applies functional colours.
# Takes in your instance id and instance location as a parameters.
#
# .EXAMPLE
# p6logs.ps1 -instanceId patient-sky-1975 -location ~/platform6/instances/ -lineamount 100
# .EXAMPLE
# p6logs.ps1 -instanceId patient-sky-1975 -location ~/platform6/instances/
# .EXAMPLE
# p6logs.ps1 -instanceId patient-sky-1975 
# .EXAMPLE
# p6logs.ps1 patient-sky-1975  ~/platform6/instances/ 100
# .EXAMPLE
# p6logs.ps1 patient-sky-1975  ~/platform6/instances/
# .EXAMPLE
# p6logs.ps1 patient-sky-1975 

Param(
		[Parameter(HelpMessage = "The ID of your instance")]
		[string]$InstanceId = "",
		[Parameter(HelpMessage = "The install location of your instance")]
		[string]$Location = "$env:USERPROFILE\platform6\instances\",
		[Parameter(HelpMessage = "The amount of lines from logfile to display")]
		[UInt16]$LineAmount = 1000
     )

# https://stackoverflow.com/a/29022748
function Get-LogColor {
# .SYNOPSIS
# Return a colour based upon the text within the parameter
	Param([Parameter(Position=0)]
			[String]$LogEntry)

		process {
			if ($LogEntry.Contains("INFO")) {Return "Cyan"}
			elseif ($LogEntry.Contains("WARN")) {Return "Yellow"}
			elseif ($LogEntry.Contains("ERROR") -or $LogEntry.Contains("FATAL")) {Return "Red"}
			else {Return "White"}
		}
}

function Load-EnvVars {
# .SYNOPSIS
# Load variables into the environment using the file passed by parameter
	Param([String]$EnvFile)

		Get-Content $EnvFile | foreach {
			$name, $value = $_.split('=')
				if ([string]::IsNullOrWhiteSpace($name) -or $name.Contains('#')) {
					return
				}
			echo "Loaded $name"
				Set-Content env:\$name $value
		}
}

if (Test-Path .env) {
	Load-EnvVars .env
	if (-not ([string]::IsNullOrEmpty($env:INSTANCE_ID))) {
		$InstanceId = $env:INSTANCE_ID
	}
	if (-not ([string]::IsNullOrEmpty($env:PLATFORM6_DATA_PATH))) {
		$Location = $env:PLATFORM6_DATA_PATH
	}
} else { echo "To utilise your .env file: Please run from your deployment folder as: ../../scripts/p6logs.sh" }


Get-Content -tail $LineAmount -wait "$Location/$InstanceId/p6core.data/logs/p6core.log" | ForEach {Write-Host -ForegroundColor (Get-LogColor $_) $_}
