﻿<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2018 v5.5.150
	 Created on:   	5/8/2018 3:59 PM
	 Created by:   	Ben Claussen
	 Organization: 	NEOnet
	 Filename:     	Virtualization.ps1
	===========================================================================
	.DESCRIPTION
		Virtualization object functions
#>

#region GET commands

function Get-NetboxVirtualizationChoices {
    [CmdletBinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseSingularNouns", "", Justification = "These are literally 'choices' in Netbox")]
    param ()
    
    $uriSegments = [System.Collections.ArrayList]::new(@('virtualization', '_choices'))
    
    $uri = BuildNewURI -Segments $uriSegments
    
    InvokeNetboxRequest -URI $uri
}

function Get-NetboxVirtualMachine {
<#
    .SYNOPSIS
        Obtains virtual machines from Netbox.
    
    .DESCRIPTION
        Obtains one or more virtual machines based on provided filters.
    
    .PARAMETER Limit
        Number of results to return per page
    
    .PARAMETER Offset
        The initial index from which to return the results
    
    .PARAMETER Query
        A general query used to search for a VM
    
    .PARAMETER Name
        Name of the VM
    
    .PARAMETER Id
        Database ID of the VM
    
    .PARAMETER Status
        Status of the VM
    
    .PARAMETER Tenant
        String value of tenant
    
    .PARAMETER Tenant_ID
        Database ID of the tenant.
    
    .PARAMETER Platform
        String value of the platform
    
    .PARAMETER Platform_ID
        Database ID of the platform
    
    .PARAMETER Cluster_Group
        String value of the cluster group.
    
    .PARAMETER Cluster_Group_Id
        Database ID of the cluster group.
    
    .PARAMETER Cluster_Type
        String value of the Cluster type.
    
    .PARAMETER Cluster_Type_Id
        Database ID of the cluster type.
    
    .PARAMETER Cluster_Id
        Database ID of the cluster.
    
    .PARAMETER Site
        String value of the site.
    
    .PARAMETER Site_Id
        Database ID of the site.
    
    .PARAMETER Role
        String value of the role.
    
    .PARAMETER Role_Id
        Database ID of the role.
    
    .PARAMETER Raw
        A description of the Raw parameter.
    
    .PARAMETER TenantID
        Database ID of tenant
    
    .PARAMETER PlatformID
        Database ID of the platform
    
    .PARAMETER id__in
        Database IDs of VMs
    
    .EXAMPLE
        PS C:\> Get-NetboxVirtualMachine
    
    .NOTES
        Additional information about the function.
#>
    
    [CmdletBinding()]
    param
    (
        [uint16]$Limit,
        
        [uint16]$Offset,
        
        [Alias('q')]
        [string]$Query,
        
        [string]$Name,
        
        [uint16[]]$Id,
        
        [object]$Status,
        
        [string]$Tenant,
        
        [uint16]$Tenant_ID,
        
        [string]$Platform,
        
        [uint16]$Platform_ID,
        
        [string]$Cluster_Group,
        
        [uint16]$Cluster_Group_Id,
        
        [string]$Cluster_Type,
        
        [uint16]$Cluster_Type_Id,
        
        [uint16]$Cluster_Id,
        
        [string]$Site,
        
        [uint16]$Site_Id,
        
        [string]$Role,
        
        [uint16]$Role_Id,
        
        [switch]$Raw
    )
    
    if ($null -ne $Status) {
        $PSBoundParameters.Status = ValidateVirtualizationChoice -ProvidedValue $Status -VirtualMachineStatus
    }
    
    $Segments = [System.Collections.ArrayList]::new(@('virtualization', 'virtual-machines'))
    
    $URIComponents = BuildURIComponents -URISegments $Segments -ParametersDictionary $PSBoundParameters
    
    $uri = BuildNewURI -Segments $URIComponents.Segments -Parameters $URIComponents.Parameters
    
    InvokeNetboxRequest -URI $uri -Raw:$Raw
}

function Get-NetboxVirtualMachineInterface {
<#
    .SYNOPSIS
        Gets VM interfaces
    
    .DESCRIPTION
        Obtains the interface objects for one or more VMs
    
    .PARAMETER Limit
        Number of results to return per page.
    
    .PARAMETER Offset
        The initial index from which to return the results.
    
    .PARAMETER Id
        Database ID of the interface
    
    .PARAMETER Name
        Name of the interface
    
    .PARAMETER Enabled
        True/False if the interface is enabled
    
    .PARAMETER MTU
        Maximum Transmission Unit size. Generally 1500 or 9000
    
    .PARAMETER Virtual_Machine_Id
        ID of the virtual machine to which the interface(s) are assigned.
    
    .PARAMETER Virtual_Machine
        Name of the virtual machine to get interfaces
    
    .PARAMETER MAC_Address
        MAC address assigned to the interface
    
    .PARAMETER Raw
        A description of the Raw parameter.
    
    .EXAMPLE
        PS C:\> Get-NetboxVirtualMachineInterface
    
    .NOTES
        Additional information about the function.
#>
    
    [CmdletBinding()]
    param
    (
        [uint16]$Limit,
        
        [uint16]$Offset,
        
        [Parameter(ValueFromPipeline = $true)]
        [uint16]$Id,
        
        [string]$Name,
        
        [boolean]$Enabled,
        
        [uint16]$MTU,
        
        [uint16]$Virtual_Machine_Id,
        
        [string]$Virtual_Machine,
        
        [string]$MAC_Address,
        
        [switch]$Raw
    )
    
    $Segments = [System.Collections.ArrayList]::new(@('virtualization', 'interfaces'))
    
    $URIComponents = BuildURIComponents -URISegments $Segments -ParametersDictionary $PSBoundParameters
    
    $uri = BuildNewURI -Segments $URIComponents.Segments -Parameters $URIComponents.Parameters
    
    InvokeNetboxRequest -URI $uri -Raw:$Raw
}

function Get-NetboxVirtualizationCluster {
<#
    .SYNOPSIS
        Obtains virtualization clusters from Netbox.
    
    .DESCRIPTION
        Obtains one or more virtualization clusters based on provided filters.
    
    .PARAMETER Limit
        Number of results to return per page
    
    .PARAMETER Offset
        The initial index from which to return the results
    
    .PARAMETER Query
        A general query used to search for a cluster
    
    .PARAMETER Name
        Name of the cluster
    
    .PARAMETER Id
        Database ID(s) of the cluster
    
    .PARAMETER Group
        String value of the cluster group.
    
    .PARAMETER Group_Id
        Database ID of the cluster group.
    
    .PARAMETER Type
        String value of the Cluster type.
    
    .PARAMETER Type_Id
        Database ID of the cluster type.
    
    .PARAMETER Site
        String value of the site.
    
    .PARAMETER Site_Id
        Database ID of the site.
    
    .PARAMETER Raw
        A description of the Raw parameter.
    
    .EXAMPLE
        PS C:\> Get-NetboxVirtualizationCluster
    
    .NOTES
        Additional information about the function.
#>
    
    [CmdletBinding()]
    param
    (
        [uint16]$Limit,
        
        [uint16]$Offset,
        
        [Alias('q')]
        [string]$Query,
        
        [string]$Name,
        
        [Alias('id__in')]
        [uint16[]]$Id,
        
        [string]$Group,
        
        [uint16]$Group_Id,
        
        [string]$Type,
        
        [uint16]$Type_Id,
        
        [string]$Site,
        
        [uint16]$Site_Id,
        
        [switch]$Raw
    )
    
    $uriSegments = [System.Collections.ArrayList]::new(@('virtualization', 'clusters'))
    
    $URIParameters = @{
    }
    
    foreach ($CmdletParameterName in $PSBoundParameters.Keys) {
        if ($CmdletParameterName -in $CommonParameterNames) {
            # These are common parameters and should not be appended to the URI
            Write-Debug "Skipping parameter $CmdletParameterName"
            continue
        }
        
        if ($CmdletParameterName -eq 'Id') {
            # Check if there is one or more values for Id and build a URI or query as appropriate
            if (@($PSBoundParameters[$CmdletParameterName]).Count -gt 1) {
                $URIParameters['id__in'] = $Id -join ','
            } else {
                [void]$uriSegments.Add($PSBoundParameters[$CmdletParameterName])
            }
        } elseif ($CmdletParameterName -eq 'Query') {
            $URIParameters['q'] = $PSBoundParameters[$CmdletParameterName]
        } else {
            $URIParameters[$CmdletParameterName.ToLower()] = $PSBoundParameters[$CmdletParameterName]
        }
    }
    
    $uri = BuildNewURI -Segments $uriSegments -Parameters $URIParameters
    
    InvokeNetboxRequest -URI $uri -Raw:$Raw
}

function Get-NetboxVirtualizationClusterGroup {
    [CmdletBinding()]
    param
    (
        [uint16]$Limit,
        
        [uint16]$Offset,
        
        [string]$Name,
        
        [string]$Slug,
        
        [switch]$Raw
    )
    
    $uriSegments = [System.Collections.ArrayList]::new(@('virtualization', 'cluster-groups'))
    
    $URIParameters = @{}
    
    foreach ($CmdletParameterName in $PSBoundParameters.Keys) {
        if ($CmdletParameterName -in $CommonParameterNames) {
            # These are common parameters and should not be appended to the URI
            Write-Debug "Skipping parameter $CmdletParameterName"
            continue
        }
        
        $URIParameters[$CmdletParameterName.ToLower()] = $PSBoundParameters[$CmdletParameterName]
    }
    
    $uri = BuildNewURI -Segments $uriSegments -Parameters $URIParameters
    
    InvokeNetboxRequest -URI $uri -Raw:$Raw
}

#endregion GET commands


#region ADD/NEW commands

function New-NetboxVirtualMachine {
    [CmdletBinding()]
    [OutputType([pscustomobject])]
    param
    (
        [Parameter(Mandatory = $true)]
        [string]$Name,
        
        [Parameter(Mandatory = $true)]
        [uint16]$Cluster,
        
        [uint16]$Tenant,
        
        [object]$Status = 'Active',
        
        [uint16]$Role,
        
        [uint16]$Platform,
        
        [uint16]$vCPUs,
        
        [uint16]$Memory,
        
        [uint16]$Disk,
        
        [uint16]$Primary_IP4,
        
        [uint16]$Primary_IP6,
        
        [hashtable]$Custom_Fields,
        
        [string]$Comments
    )
    
    $PSBoundParameters.Status = ValidateVirtualizationChoice -ProvidedValue $Status -VirtualMachineStatus
    
    $Segments = [System.Collections.ArrayList]::new(@('virtualization', 'virtual-machines'))
    
    $URIComponents = BuildURIComponents -URISegments $Segments -ParametersDictionary $PSBoundParameters
    
    $URI = BuildNewURI -Segments $URIComponents.Segments
    
    InvokeNetboxRequest -URI $URI -Method POST -Body $URIComponents.Parameters
}

function Add-NetboxVirtualMachineInterface {
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [string]$Name,
        
        [Parameter(Mandatory = $true)]
        [uint16]$Virtual_Machine,
        
        [boolean]$Enabled = $true,
        
        [string]$MAC_Address,
        
        [uint16]$MTU,
        
        [string]$Description,
        
        [switch]$Raw
    )
    
    $Segments = [System.Collections.ArrayList]::new(@('virtualization', 'interfaces'))
    
    $PSBoundParameters.Enabled = $Enabled
    
    $URIComponents = BuildURIComponents -URISegments $Segments -ParametersDictionary $PSBoundParameters
    
    $uri = BuildNewURI -Segments $URIComponents.Segments
    
    InvokeNetboxRequest -URI $uri -Method POST -Body $URIComponents.Parameters
}

#endregion ADD commands


#region SET commands

function Set-NetboxVirtualMachine {
    [CmdletBinding(ConfirmImpact = 'Medium',
                   SupportsShouldProcess = $true)]
    param
    (
        [Parameter(Mandatory = $true,
                   ValueFromPipelineByPropertyName = $true)]
        [uint16]$Id,
        
        [string]$Name,
        
        [uint16]$Role,
        
        [uint16]$Cluster,
        
        [object]$Status,
        
        [uint16]$Platform,
        
        [uint16]$Primary_IP4,
        
        [uint16]$Primary_IP6,
        
        [byte]$VCPUs,
        
        [uint16]$Memory,
        
        [uint16]$Disk,
        
        [uint16]$Tenant,
        
        [string]$Comments,
        
        [hashtable]$Custom_Fields,
        
        [switch]$Force
    )
    
    if ($null -ne $Status) {
        $PSBoundParameters.Status = ValidateVirtualizationChoice -ProvidedValue $Status -VirtualMachineStatus
    }
    
    $Segments = [System.Collections.ArrayList]::new(@('virtualization', 'virtual-machines', $Id))
    
    Write-Verbose "Obtaining VM from ID $Id"
    
    $CurrentVM = Get-NetboxVirtualMachine -Id $Id -ErrorAction Stop
    
    Write-Verbose "Finished obtaining VM"
    
    if ($Force -or $pscmdlet.ShouldProcess($CurrentVM.Name, "Set")) {
        $URIComponents = BuildURIComponents -URISegments $Segments -ParametersDictionary $PSBoundParameters -SkipParameterByName 'Id', 'Force'
        
        $URI = BuildNewURI -Segments $URIComponents.Segments
        
        InvokeNetboxRequest -URI $URI -Body $URIComponents.Parameters -Method PATCH
    }
}

function Set-NetboxVirtualMachineInterface {
    [CmdletBinding(ConfirmImpact = 'Medium',
                   SupportsShouldProcess = $true)]
    [OutputType([pscustomobject])]
    param
    (
        [Parameter(Mandatory = $true,
                   ValueFromPipelineByPropertyName = $true)]
        [uint16[]]$Id,
        
        [string]$Name,
        
        [string]$MAC_Address,
        
        [uint16]$MTU,
        
        [string]$Description,
        
        [boolean]$Enabled,
        
        [uint16]$Virtual_Machine,
        
        [switch]$Force
    )
    
    begin {
        
    }
    
    process {
        foreach ($VMI_ID in $Id) {
            Write-Verbose "Obtaining VM Interface..."
            $CurrentVMI = Get-NetboxVirtualMachineInterface -Id $VMI_ID -ErrorAction Stop
            Write-Verbose "Finished obtaining VM Interface"
            
            $Segments = [System.Collections.ArrayList]::new(@('virtualization', 'interfaces', $CurrentVMI.Id))
            
            if ($Force -or $pscmdlet.ShouldProcess("Interface $($CurrentVMI.Id) on VM $($CurrentVMI.Virtual_Machine.Name)", "Set")) {
                $URIComponents = BuildURIComponents -URISegments $Segments -ParametersDictionary $PSBoundParameters -SkipParameterByName 'Id', 'Force'
                
                $URI = BuildNewURI -Segments $URIComponents.Segments
                
                InvokeNetboxRequest -URI $URI -Body $URIComponents.Parameters -Method PATCH
            }
        }
    }
    
    end {
        
    }
}



#endregion SET commands


#region REMOVE commands

function Remove-NetboxVirtualMachine {
<#
    .SYNOPSIS
        Delete a virtual machine
    
    .DESCRIPTION
        Deletes a virtual machine from Netbox by ID
    
    .PARAMETER Id
        Database ID of the virtual machine
    
    .PARAMETER Force
        Force deletion without any prompts
    
    .EXAMPLE
        PS C:\> Remove-NetboxVirtualMachine -Id $value1
    
    .NOTES
        Additional information about the function.
#>
    
    [CmdletBinding(ConfirmImpact = 'High',
                   SupportsShouldProcess = $true)]
    param
    (
        [Parameter(Mandatory = $true,
                   ValueFromPipelineByPropertyName = $true)]
        [uint16[]]$Id,
        
        [switch]$Force
    )
    
    begin {
        
    }
    
    process {
        foreach ($VMId in $Id) {
            $CurrentVM = Get-NetboxVirtualMachine -Id $VMId -ErrorAction Stop
            
            if ($Force -or $pscmdlet.ShouldProcess("$($CurrentVM.Name)/$($CurrentVM.Id)", "Remove")) {
                $Segments = [System.Collections.ArrayList]::new(@('virtualization', 'virtual-machines', $CurrentVM.Id))
                
                $URI = BuildNewURI -Segments $Segments
                
                InvokeNetboxRequest -URI $URI -Method DELETE
            }
        }
    }
    
    end {
        
    }
}


#endregion REMOVE commands





















