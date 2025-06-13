package com.example.youtubepip

import android.app.PictureInPictureParams
import android.os.Build
import android.util.Rational
import android.webkit.WebView
import android.webkit.WebViewClient
import com.getcapacitor.*
import android.content.Intent
import android.app.Activity
import android.net.Uri

@CapacitorPlugin(name = "YouTubePiP")
class YouTubePiPPlugin : Plugin() {
    @PluginMethod
    fun open(call: PluginCall) {
        val videoId = call.getString("videoId")
        if (videoId == null) {
            call.reject("videoId obrigatório")
            return
        }

        val context = this.bridge.activity
        val intent = Intent(context, PiPActivity::class.java)
        intent.putExtra("videoId", videoId)
        context.startActivity(intent)

        call.resolve()
    }
}