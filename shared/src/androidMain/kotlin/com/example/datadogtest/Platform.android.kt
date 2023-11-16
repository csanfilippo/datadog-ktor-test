package com.example.datadogtest

import io.ktor.client.HttpClient
import io.ktor.client.engine.okhttp.OkHttp
import org.koin.core.module.Module
import org.koin.core.qualifier.named
import org.koin.dsl.module

actual val platformModule: Module = module {
    single<HttpClient>(named("client")) {
        HttpClient(OkHttp)
    }
}