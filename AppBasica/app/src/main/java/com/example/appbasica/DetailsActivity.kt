package com.example.appbasica

import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity

class DetailsActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_details)

        val name = intent.getStringExtra(EXTRA_NAME) ?: getString(R.string.default_name)
        val counter = intent.getIntExtra(EXTRA_COUNTER, 0)

        findViewById<TextView>(R.id.textDetails).text =
            getString(R.string.details_message, name, counter)

        findViewById<Button>(R.id.btnBack).setOnClickListener {
            finish()
        }
    }

    companion object {
        const val EXTRA_NAME = "extra_name"
        const val EXTRA_COUNTER = "extra_counter"
    }
}
