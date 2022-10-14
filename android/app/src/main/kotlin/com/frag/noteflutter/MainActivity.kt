package com.frag.noteflutter

import android.app.Activity
import android.os.Build
import android.os.Bundle
import android.os.PersistableBundle
import android.util.Log
import androidx.core.view.WindowCompat
import androidx.room.Room
import androidx.room.RoomDatabase
import com.frag.noteflutter.Database.AppDatabase
import com.frag.noteflutter.Database.DatabaseDAO
import com.frag.noteflutter.Database.UserModel
import com.google.gson.Gson
import com.google.gson.JsonElement
import com.google.gson.reflect.TypeToken
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformPlugin
import kotlinx.coroutines.*

class MainActivity: FlutterActivity() {
    val channel = "samples.flutter.dev/database"
    private val gson = Gson()

    private val TAG = "MainActivity"

    @Override
    override fun onCreate(savedInstanceState: Bundle?) {
        // Aligns the Flutter view vertically with the window.
        WindowCompat.setDecorFitsSystemWindows(getWindow(), false)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            // Disable the Android splash screen fade out animation to avoid
            // a flicker before the similar frame is drawn in Flutter.
            splashScreen.setOnExitAnimationListener { splashScreenView -> splashScreenView.remove() }
        }

        super.onCreate(savedInstanceState)
    }


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        val database = Room.databaseBuilder(this.applicationContext , AppDatabase::class.java , "user_note").fallbackToDestructiveMigration().build().userDao()
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger , channel).setMethodCallHandler { call, result ->
            if(call.method == "getDatabase"){
                CoroutineScope(Dispatchers.Main).launch {
                    database.getAll().let {
                        if(it.isNullOrEmpty()){
                            result.error("404" , "Database Empty" , "This database empty , please add data in database")
                        }else{
                            result.success(gson.toJson(it))
                        }
                    }
                }
            }else if(call.method == "addDatabase"){
                val userModel = call.arguments as Map<*, *>?
                if(!userModel.isNullOrEmpty()){
                    CoroutineScope(Dispatchers.Main).launch {
                        val getNote = UserModel(title = userModel["title"].toString() , description = userModel["description"].toString(), date = userModel["date"].toString())
                        database.insertAll(getNote)
                        database.searchWithTitle(getNote.title).let {
                            if(it != null){
                                result.success("Note has been added")
                            }
                        }
                    }
                }
            }else if(call.method == "removeDataOnDatabase"){
                var userNoteId = call.arguments as Int
                CoroutineScope(Dispatchers.Main).launch {
                    val search = database.searchWithId(userNoteId)
                    if(search != null){
                        database.delete(search)
                        result.success("Note delete")
                    }else {
                        result.error("404" , "User note" , "User note not found")
                    }
                }
            }else if(call.method == "updateDataOnDatabase"){
                val userModel = call.arguments as Map<* , *>?
                CoroutineScope(Dispatchers.Main).launch {
                    if(!userModel.isNullOrEmpty()){
                        val updatingUserModel = UserModel(userModel["id"] as Int , userModel["title"] as String , userModel["description"] as String, userModel["date"] as String)
                        database.updateUser(updatingUserModel)
                        database.searchWithTitle(updatingUserModel.title).let {
                            if(it != null)result.success("Data update complete")
                            else result.error("404" , "User note not found" , "")
                        }
                    }
                }

            }

        }
        super.configureFlutterEngine(flutterEngine)
    }
}
