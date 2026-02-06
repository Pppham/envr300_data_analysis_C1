#averaging the weather data from the three airports

RDU_df_rename <- RDU_df %>%
    rename(CLDD_RDU = CLDD,
           HTDD_RDU = HTDD,
           TAVG_RDU = TAVG,
           TMAX_RDU = TMAX,
           TMIN_RDU = TMIN)

CLT_df_rename <- CLT_df %>%
  rename(CLDD_CLT = CLDD,
         HTDD_CLT = HTDD,
         TAVG_CLT = TAVG,
         TMAX_CLT = TMAX,
         TMIN_CLT = TMIN)

GSO_df_rename <- GSO_df %>%
  rename(CLDD_GSO = CLDD,
         HTDD_GSO = HTDD,
         TAVG_GSO = TAVG,
         TMAX_GSO = TMAX,
         TMIN_GSO = TMIN)

combined_df <- full_join(CLT_df_rename, GSO_df_rename, by = "DATE")

combined_df <- full_join(combined_df, RDU_df_rename, by = "DATE")

airport_df <- combined_df %>%
  rowwise() %>%
  mutate(mean_CLDD = mean(c(CLDD_RDU, CLDD_CLT, CLDD_GSO), na.rm = TRUE),
         mean_HTDD = mean(c(HTDD_RDU, HTDD_CLT, HTDD_GSO), na.rm = TRUE),
         mean_TAVG = mean(c(TAVG_RDU, TAVG_CLT, TAVG_GSO), na.rm = TRUE),
         mean_TMAX = mean(c(TMAX_RDU, TMAX_CLT, TMAX_GSO), na.rm = TRUE),
         mean_TMIN = mean(c(TMIN_RDU, TMIN_CLT, TMIN_GSO), na.rm = TRUE)) %>%
  ungroup() %>%
  select(DATE, mean_CLDD, mean_HTDD, mean_TAVG, mean_TMAX, mean_TMIN)

