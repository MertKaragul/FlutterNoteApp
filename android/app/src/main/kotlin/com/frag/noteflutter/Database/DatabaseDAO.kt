package com.frag.noteflutter.Database

import androidx.room.*

@Dao
interface DatabaseDAO {
    @Query("SELECT * FROM usermodel")
    suspend fun getAll(): List<UserModel>?

    @Query("SELECT * FROM usermodel WHERE title IN (:title)")
    suspend fun searchWithTitle(title: String): UserModel?

    @Query("SELECT * FROM usermodel WHERE id IN (:id)")
    suspend fun searchWithId(id: Int): UserModel?

    @Update
    suspend fun updateUser(vararg user: UserModel)

    @Insert
    suspend fun insertAll(vararg users: UserModel)

    @Delete
    suspend fun delete(user: UserModel)
}