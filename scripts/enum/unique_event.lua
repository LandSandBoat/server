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

---@enum xi.uniqueEvent
xi.uniqueEvent =
{
    EKOKOKO_INTRODUCTION   =  0,
    RECEIVED_NEXUS_CAPE    =  1,
    MET_MATHILDES_SON      =  2,
    RAMONA_INTRODUCTION    =  3,
    TOVRUTAUX_BITTEN       =  4,
    MONBERAUX_INTRODUCTION =  5,
    SELBINA_INTRODUCTION   =  6,
    GABWALEID_INTRODUCTION =  7,
    MHAURA_INTRODUCTION    =  8,
    HYRIA_INTRODUCTION     =  9,
    VANESSA_ENM_COMPLETE   = 10,
}
