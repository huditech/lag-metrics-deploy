param location string = resourceGroup().location

@secure()
param eventHubConnectionString string

@secure()
param storageAccountConnectionString string

param offsetContainerName string

@secure()
param applicationInsightsConnectionString string

resource managedApp 'Microsoft.Solutions/applications@2021-07-01' = {
  name: 'lag-metrics'
  kind: 'marketplace'
  location: location
  plan: {
    name: 'standard'
    product: 'lag-metrics'
    publisher: 'huditechughaftungsbeschrnkt1673457598758'
    version: '2.0.3'
  }
  properties: {
    #disable-next-line use-resource-id-functions
    managedResourceGroupId: '${resourceGroup().id}-resources-${uniqueString(resourceGroup().id)}'
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
