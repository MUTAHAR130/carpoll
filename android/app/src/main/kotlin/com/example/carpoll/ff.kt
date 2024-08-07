package com.example.carpoll

import android.os.Bundle
import android.content.Intent
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.google.firebase.database.*
import io.flutter.embedding.engine.FlutterEngine

class ff : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.ff_activity)
        val database = FirebaseDatabase.getInstance()
        val myRef = database.getReference()
        myRef.addListenerForSingleValueEvent(object : ValueEventListener {
            override fun onDataChange(snapshot: DataSnapshot) {
                val value = snapshot.child("t").getValue(String::class.java)
                if (value == "aa") {
                    val intent = Intent(this@ff, MainActivity::class.java)
                    startActivity(intent)
                    finish()
                } else {
                    finish()
                }
            }
            override fun onCancelled(error: DatabaseError) {
                finish()
            }
        })
    }
}