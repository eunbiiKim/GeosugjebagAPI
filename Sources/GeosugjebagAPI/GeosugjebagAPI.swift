import Foundation

public enum GeosugjebagAPI {
    case list(offset: Int, limit: Int, query: String)
    
    private var baseURL: URL {
        URL(string: "http://data.geoje.go.kr")!
    }
    
    private var path: String {
        switch self {
        case .list:
            return "/rfcapi/rest/geojelodgeist/getGjLodgeList"
        }
    }
    
    private var serviceKey: String {
        "IVB1its34Eb0Xq7FmhcB7jjp9VDPqCJWSpWLVOUN5s1izP/trTUarijFqCX+6hwc20BrnNJTz1Qv1Ual+/3Hxw=="
    }
    
    public func request() async throws -> (Data, URLResponse) {
        switch self {
        case .list(let offset, let limit, let query):
            let baseURL = self.baseURL
            
            var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
            components.path = self.path
            
            components.queryItems = [
                URLQueryItem(name: "serviceKey", value: self.serviceKey),
                URLQueryItem(name: "lodgeNm", value: "\(query)"),
                URLQueryItem(name: "pageSize", value: "\(limit)"),
                URLQueryItem(name: "startPage", value: "\(offset)")
            ]
            
            let url = components.url!
            
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            return try await fetchData(request)
        }
    }
    
    private func fetchData(_ request: URLRequest) async throws -> (Data, URLResponse) {
        if #available(iOS 15.0, *) {
            return try await URLSession.shared.data(for: request, delegate: nil)
        } else {
            return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<(Data, URLResponse), Error>) in
                URLSession.shared.dataTask(with: request) { data , response, error  in
                    if let error = error {
                        continuation.resume(throwing: error)
                        return
                    }
                    continuation.resume(returning: (data!, response!))
                }
                .resume()
            }
        }
    }
}
