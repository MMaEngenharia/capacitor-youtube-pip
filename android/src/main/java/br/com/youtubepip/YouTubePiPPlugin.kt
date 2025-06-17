package br.com.youtubepip

import android.content.Intent
import com.getcapacitor.Plugin
import com.getcapacitor.PluginCall
import com.getcapacitor.*
import com.getcapacitor.annotation.CapacitorPlugin

@CapacitorPlugin(name = "YouTubePiP")
class YouTubePiPPlugin : Plugin() {

    @PluginMethod
    fun play(call: PluginCall) {
        val videoId = call.getString("videoId")
        if (videoId == null) {
            call.reject("videoId é obrigatório")
            return
        }

        val intent = Intent(this.activity, PiPActivity::class.java)
        intent.putExtra("videoId", videoId)
        activity.startActivity(intent)
        call.resolve()
    }

    @PluginMethod
    fun close(call: PluginCall) {
        activity.runOnUiThread {
            (activity as? PiPActivity)?.finish()
            call.resolve()
        }
    }
}
