package com.example.datadogtest

import org.koin.core.qualifier.named
import org.koin.dsl.module

internal val commonModule = module {
    single { ApiPerformer(get(named("client"))) }
}