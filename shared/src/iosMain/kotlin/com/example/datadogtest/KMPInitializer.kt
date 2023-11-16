package com.example.datadogtest

import org.koin.core.KoinApplication
import org.koin.core.context.startKoin
import org.koin.dsl.module
import org.koin.mp.KoinPlatformTools
import platform.Foundation.NSURLSession
import platform.Foundation.NSURLSessionDelegateProtocol

object KoinFactory {
    inline fun <reified T> get(): T = KoinPlatformTools.defaultContext().get().get(clazz = T::class)
}

object KMPInitializer {

    fun load(sessionBuilder: (NSURLSessionDelegateProtocol) -> NSURLSession): KoinApplication {
        return startKoin {
                modules(module {
                    single { sessionBuilder }
                },
                platformModule,
                commonModule
            )
        }
    }
}

object Dependencies {
    fun getApiPerformer(): ApiPerformer = KoinFactory.get()
}