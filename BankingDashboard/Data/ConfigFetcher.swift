import Foundation

class ConfigFetcher {

    func fetchConfig() async throws -> DashboardConfig {
       
        guard let url = Bundle.main.url(forResource: "Config", withExtension: "json") else {
            throw URLError(.fileDoesNotExist)
        }
        
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        
        return try decoder.decode(DashboardConfig.self, from: data)
        
    }
}

