package com.frag.noteflutter.Database

import androidx.room.Entity
import androidx.room.PrimaryKey


@Entity
data class UserModel(
    @PrimaryKey(autoGenerate = true) var id : Int = 0,
    var title : String,
    var description : String,
    var date : String
)
