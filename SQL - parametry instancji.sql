--- wyswietlenie parametrow bazy danych ---
SELECT object_name, 
       instance_name AS deprecated_feature, 
       cntr_value
FROM sys.dm_os_performance_counters
WHERE object_name LIKE '%Deprecated%'
      AND cntr_value > 0
ORDER BY deprecated_feature DESC