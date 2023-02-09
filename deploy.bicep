param serviceCatalog bool = false

param location string = resourceGroup().location

@secure()
param eventHubConnectionString string

@secure()
param storageAccountConnectionString string

param offsetContainerName string

@secure()
param applicationInsightsConnectionString string

var managedGroupId = '${resourceGroup().id}-resources-${uniqueString(resourceGroup().id)}'

var kind = serviceCatalog ? 'servicecatalog' : 'marketplace'

resource managedApp 'Microsoft.Solutions/applications@2021-07-01' = {
  name: 'lag-metrics'
  kind: kind
  location: location
  plan: serviceCatalog ? null : {
    name: 'standard'
    product: 'lag-metrics'
    publisher: 'tbd'
    version: '1.0.0'
  }
  properties: {
    managedResourceGroupId: managedGroupId
    applicationDefinitionId: serviceCatalog ? '/subscriptions/55c079e7-8c64-4e3d-b797-a71ebda23e81/resourceGroups/lag-metrics-definition/providers/Microsoft.Solutions/applicationDefinitions/lag-metrics' : null
    parameters: {
      eventHubConnectionString: {
        value: eventHubConnectionString
      }
      storageAccountConnectionString: {
        value: storageAccountConnectionString
      }
      offsetContainerName: {
        value: offsetContainerName
      }
      applicationInsightsConnectionString: {
        value: applicationInsightsConnectionString
      }
    }
  }
}
