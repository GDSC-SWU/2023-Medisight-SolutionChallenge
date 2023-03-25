package com.gdscswu.medisight

import android.content.Intent
import android.os.Bundle
import android.provider.AlarmClock

import androidx.annotation.NonNull

import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

    private var sharedTitle: String? = null
    private var sharedHour: Int? = null
    private var sharedMinutes: Int? = null

    private val CHANNEL = "app.channel.medisight.data"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val intent = getIntent();
        val action = intent.getAction();
        val type = intent.getType();

        if (AlarmClock.ACTION_SET_ALARM == action && type != null) {
            if ("text/plain" == type) {
                handleSetAlarm(intent) // Handle alarm being set
            }
        }
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler { call, result ->
                    if (call.method.contentEquals("getsharedTitle")) {
                        result.success(sharedTitle)
                        sharedTitle = null
                    }
                    else if (call.method.contentEquals("getsharedHour")) {
                        result.success(sharedHour)
                        sharedHour = null
                    }
                    else if (call.method.contentEquals("getsharedMinutes")) {
                        result.success(sharedMinutes)
                        sharedMinutes = null
                    }
                }
    }

    private fun handleSetAlarm(intent: Intent) {
        sharedTitle = intent.getStringExtra(AlarmClock.EXTRA_MESSAGE)
        sharedHour = intent.getIntExtra(AlarmClock.EXTRA_HOUR, -1) // getIntExtra
        sharedMinutes = intent.getIntExtra(AlarmClock.EXTRA_MINUTES, -1) // getIntExtra
    }
}
