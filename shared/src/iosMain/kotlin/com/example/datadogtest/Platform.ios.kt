package com.example.datadogtest

import io.ktor.client.HttpClient
import io.ktor.client.engine.darwin.Darwin
import io.ktor.client.engine.darwin.KtorNSURLSessionDelegate
import io.ktor.client.plugins.HttpTimeout
import org.koin.core.module.Module
import org.koin.core.qualifier.named
import org.koin.dsl.module
import platform.Foundation.NSURLSession
import platform.Foundation.NSURLSessionDelegateProtocol

actual val platformModule: Module = module {
    single(named("client")) {
        HttpClient(Darwin) {
            install(HttpTimeout) {
                requestTimeoutMillis = 2
            }
            engine {
                val ktorDelegate = KtorNSURLSessionDelegate()
                val sessionBuilder: (NSURLSessionDelegateProtocol) -> NSURLSession = get()

                val session = sessionBuilder(ktorDelegate)

                usePreconfiguredSession(session, ktorDelegate)
            }
        }
    }
}