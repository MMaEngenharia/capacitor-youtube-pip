package br.com.youtubepip

import android.app.PictureInPictureParams
import android.content.res.Configuration
import android.os.Build
import android.os.Bundle
import android.util.Rational
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import android.webkit.WebChromeClient
import android.webkit.WebSettings
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.FrameLayout
import android.widget.ImageButton
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity
import android.graphics.Color

class PiPActivity : AppCompatActivity() {
    private lateinit var webView: WebView
    private lateinit var pipButton: ImageButton
    private lateinit var closeButton: ImageButton

    override fun onCreate(savedInstanceState: Bundle?) {
        // Remove a ActionBar antes de tudo
        supportRequestWindowFeature(android.view.Window.FEATURE_NO_TITLE)
        super.onCreate(savedInstanceState)
        supportActionBar?.hide()

        val videoId = intent.getStringExtra("videoId") ?: run {
            finish()
            return
        }

        // Layout base
        val layout = FrameLayout(this)

        // WebView
        webView = WebView(this).apply {
            layoutParams = FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT
            )
            settings.javaScriptEnabled = true
            settings.mediaPlaybackRequiresUserGesture = false
            settings.loadsImagesAutomatically = true
            settings.domStorageEnabled = true
            settings.useWideViewPort = true
            settings.loadWithOverviewMode = true
            settings.javaScriptCanOpenWindowsAutomatically = true
            webChromeClient = WebChromeClient()
            webViewClient = WebViewClient()

            val url = "https://www.youtube.com/embed/$videoId?autoplay=1&playsinline=1&fs=1&modestbranding=1&controls=1&showinfo=0"
            loadUrl(url)
        }

        // Botão Fechar
        closeButton = ImageButton(this).apply {
            setImageResource(R.drawable.ic_close)
            background = null
            setColorFilter(Color.WHITE)
            setPadding(50, 100, 50, 50)
            contentDescription = "Fechar"
            setOnClickListener { finish() }
        }

        // Botão Picture In Picture (Pip)
        pipButton = ImageButton(this).apply {
            setImageResource(R.drawable.ic_pip)
            background = null
            setColorFilter(Color.WHITE)
            setPadding(50, 100, 50, 50)
            contentDescription = "Ativar PiP"
            setOnClickListener { enterPiPModeCompat() }
        }

        // Layout para botões
        val buttonLayout = FrameLayout(this).apply {
            val params = FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.WRAP_CONTENT,
                ViewGroup.LayoutParams.WRAP_CONTENT
            )
            params.gravity = Gravity.TOP or Gravity.START
            layoutParams = params

            addView(closeButton)
            val pipParams = FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.WRAP_CONTENT,
                ViewGroup.LayoutParams.WRAP_CONTENT
            )
            pipParams.gravity = Gravity.TOP or Gravity.START
            pipParams.leftMargin = 110 // espaçamento entre os botões
            addView(pipButton, pipParams)
        }

        layout.addView(webView)
        layout.addView(buttonLayout)

        setContentView(layout)
    }

    private fun enterPiPModeCompat() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val aspectRatio = Rational(16, 9) // Força PiP em horizontal
            val pipBuilder = PictureInPictureParams.Builder()
                .setAspectRatio(aspectRatio)
            enterPictureInPictureMode(pipBuilder.build())
        }
    }

    override fun onPictureInPictureModeChanged(
        isInPictureInPictureMode: Boolean,
        newConfig: Configuration
    ) {
        super.onPictureInPictureModeChanged(isInPictureInPictureMode, newConfig)
        if (isInPictureInPictureMode) {
            pipButton.visibility = View.GONE
            closeButton.visibility = View.GONE
        } else {
            pipButton.visibility = View.VISIBLE
            closeButton.visibility = View.VISIBLE
        }
    }

    override fun onUserLeaveHint() {
        // Previne entrar no PiP automático ao sair do app
    }

    override fun onBackPressed() {
        finish()
    }
}
