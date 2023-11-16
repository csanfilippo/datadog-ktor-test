package com.example.datadogtest

import com.rickclephas.kmp.nativecoroutines.NativeCoroutines
import io.ktor.client.HttpClient
import io.ktor.client.request.accept
import io.ktor.client.request.request
import io.ktor.client.statement.bodyAsText
import io.ktor.http.ContentType
import io.ktor.http.HttpMethod

class ApiPerformer(private val apiClient: HttpClient) {

    @NativeCoroutines
    suspend fun perform(): String {
        val url = "https://httpbin.org/get"
        val response = apiClient.request(url) {
            method = HttpMethod.Get
            accept(ContentType.Application.Json)
        }

        return response.bodyAsText()
    }
}