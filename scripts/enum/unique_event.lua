-----------------------------------
-- Unique Events
-----------------------------------
xi = xi or {}

-- NOTE: This enum, and unique events are ONLY ever to be used if there is no
-- other method to track having completed something.  This field is currently
-- 160 bits wide (0..159).  Core changes will be required if this number is
-- exceeded.
--
-- DO NOT USE THIS FOR CUSTOM THINGS, IT WILL GET CLOBBERED BY UPSTREAM DEVS.

xi.uniqueEvent =
{
    EKOKOKO_INTRODUCTION = 0,
    RECEIVED_NEXUS_CAPE  = 1,
}
