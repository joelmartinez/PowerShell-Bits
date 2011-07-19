$global:sysdataloaded = $false

<#
.SYNOPSIS
Executes SQL against the supplied connection string.
.DESCRIPTION
Executes SQL against the supplied connection string. The result set is then pipelined as a PSObject which can subsequently be formatted and filtered any way you choose.
.PARAMETER query
The query to execute
.PARAMETER connstring
The connection string to use
.EXAMPLE
PS C:\> Exec-Sql -q "select top 1 * from common.country" -conn "<Connection_String>"
.EXAMPLE
PS C:\> Exec-Sql -q "select * from common.country (nolock)" -conn "<Connection_String>" | where {$_.Code -eq "AX" } | select code, name
#>
function global:Exec-Sql
{
	param	([Alias("q")]$query, [Alias("conn")]$connstring)
		
		if (!$global:sysdataloaded) {
			[system.reflection.assembly]::LoadWithPartialName("System.Data")
			$global:sysdataloaded = $true
		}

		$connection = New-Object -TypeName System.Data.SqlClient.SqlConnection
		$connection.ConnectionString = $connstring
		$connection.Open()

		$command = New-Object -TypeName System.Data.SqlClient.SqlCommand

		$command.Connection = $connection
		$command.CommandText = $query
		$reader = $command.ExecuteReader()

		$fieldcount = $reader.FieldCount

		while ($reader.Read())
		{
			$o = new-object psobject
		
			for ($i=0;$i -lt $fieldcount;$i++)
			{	
				$o | add-member -membertype noteproperty $reader.GetName($i) $reader[$reader.GetName($i)].ToString()

			}

			write-output -inputobject $o
		}

		$connection.Close()
	
}