

---------------------------------
SELECT dosi.physical_memory_kb, 
       dosi.virtual_memory_kb, 
       dosi.committed_kb, 
       dosi.committed_target_kb
FROM sys.dm_os_sys_info dosi;

------------------------------

SELECT dosm.total_physical_memory_kb, 
       dosm.available_physical_memory_kb, 
       dosm.system_memory_state_desc
FROM sys.dm_os_sys_memory dosm;

-----------------------------
SELECT dopm.physical_memory_in_use_kb, 
       dopm.process_physical_memory_low, 
       dopm.process_virtual_memory_low
FROM sys.dm_os_process_memory dopm;

-----------------------------
