import Datadog
import Foundation

// The conformance to __URLSessionDelegateProviding is due to DataDog internals
final class CustomDelegate: NSObject, __URLSessionDelegateProviding, URLSessionDataDelegate {
    
    private let dataDogDelegate: DDURLSessionDelegate
    private let ktorDelegate: URLSessionDelegate
    
    init(dataDogDelegate: DDURLSessionDelegate, ktorDelegate: URLSessionDelegate) {
        self.dataDogDelegate = dataDogDelegate
        self.ktorDelegate = ktorDelegate
        
    }
    
    var ddURLSessionDelegate: DDURLSessionDelegate { dataDogDelegate }
    
    // Requested by KtorNSURLSessionDelegate
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        dataDogDelegate.urlSession(session, dataTask: dataTask, didReceive: data)
        
        if let del = ktorDelegate as? URLSessionDataDelegate {
            del.urlSession?(session, dataTask: dataTask, didReceive: data)
        }
    }
    
    // Requested by KtorNSURLSessionDelegate
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        dataDogDelegate.urlSession(session, task: task, didCompleteWithError: error)
        
        if let del = ktorDelegate as? URLSessionDataDelegate {
            del.urlSession?(session, task: task, didCompleteWithError: error)
        }
    }
    
    // Requested by KtorNSURLSessionDelegate
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        
        if let del = dataDogDelegate as? URLSessionTaskDelegate {
            del.urlSession?(session, task: task, willPerformHTTPRedirection: response, newRequest: request, completionHandler: completionHandler)
        }
        
        if let del = ktorDelegate as? URLSessionDataDelegate {
            del.urlSession?(session, task: task, willPerformHTTPRedirection: response, newRequest: request, completionHandler: completionHandler)
        }
    }
    
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        dataDogDelegate.urlSession(session, task: task, didFinishCollecting: metrics)
    }
}
