package com.example.appbasica

import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {

    private var counter: Int = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.d("MainActivity", "onCreate")
        setContentView(R.layout.activity_main)

        val nameInput = findViewById<EditText>(R.id.editTextName)
        val counterText = findViewById<TextView>(R.id.textCounter)

        val btnIncrement = findViewById<Button>(R.id.btnIncrement)
        val btnReset = findViewById<Button>(R.id.btnReset)
        val btnToast = findViewById<Button>(R.id.btnToast)
        val btnDetails = findViewById<Button>(R.id.btnDetails)

        fun render() {
            counterText.text = getString(R.string.counter_value, counter)
        }
        render()

        btnIncrement.setOnClickListener {
            counter++
            render()
        }

        btnReset.setOnClickListener {
            counter = 0
            render()
        }

        btnToast.setOnClickListener {
            val name = nameInput.text.toString().trim()
            val finalName = if (name.isBlank()) getString(R.string.default_name) else name
            Toast.makeText(
                this,
                getString(R.string.toast_message, finalName, counter),
                Toast.LENGTH_SHORT
            ).show()
        }

        btnDetails.setOnClickListener {
            val name = nameInput.text.toString().trim()
            val finalName = if (name.isBlank()) getString(R.string.default_name) else name

            val intent = Intent(this, DetailsActivity::class.java).apply {
                putExtra(DetailsActivity.EXTRA_NAME, finalName)
                putExtra(DetailsActivity.EXTRA_COUNTER, counter)
            }
            startActivity(intent)
        }
    }

    override fun onStart() {
        super.onStart()
        Log.d("MainActivity", "onStart")
    }

    override fun onResume() {
        super.onResume()
        Log.d("MainActivity", "onResume")
    }

    override fun onPause() {
        super.onPause()
        Log.d("MainActivity", "onPause")
    }

    override fun onStop() {
        super.onStop()
        Log.d("MainActivity", "onStop")
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d("MainActivity", "onDestroy")
    }
}
