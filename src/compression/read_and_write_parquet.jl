chars_to_df(dataset) = (Parquet2.Dataset(dataset) |> DataFrame)

df_to_chars(g_db_df) = Parquet2.writefile(Vector{UInt8}, g_db_df)

parquet_size(g_db_df) = (df_to_chars(g_db_df) |> Base.summarysize)

parquet_ratio(g_db_df) = (g_db_df|>Base.summarysize)/(parquet_size(g_db_df))