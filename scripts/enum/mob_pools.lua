-----------------------------------
-- Mob pools, same as the pools in mob_pools.sql
-- Usually used for some custom mobskill effects for NMs
-----------------------------------
xi = xi or {}

---@enum xi.mobPools
xi.mobPools =
{
    ARMED_GEARS            = 243,  -- Armed Gears Restoral
    ASANBOSAM              = 256,  -- Asanbosam's Blood Drain ignores shadows
    AWZDEI_RIGHT           = 301,  -- Aw'zdei right rotation
    BUGBEAR_MATMAN         = 562,  -- Stronger Flying Hip Press (fTP 10.0)
    BUGBOY                 = 569,  -- Stronger Flying Hip Press (fTP 7.0)
    CEMETERY_CHERRY        = 671,  -- Specific variant of Entangle
    CERNUNNOS              = 682,  -- Specific variant of Entangle
    CYRANUCE_M_CUTAULEON   = 884,  -- Dread Shriek bonus potency
    EOZDEI_RIGHT           = 1242, -- Eo'zdei right rotation
    LEAFLESS_JIDRA         = 1346, -- Specific variant of Entangle
    FEELER_ANTLION         = 1318, -- Needed for Feeler Antlion special behavior
    GULOOL_JA_JA           = 1846, -- Gulool Ja Ja skill check
    KING_VINEGARROON       = 2262, -- KV poison on Wild Rage
    NIDHOGG                = 2840, -- Nidhogg's stronger hurricane wing
    PEALLAIDH              = 3109, -- Peallaidh's chigoe pets
    PEPPER                 = 3116, -- BCNM20 Charming Trio, Absorbing Kiss
    PHOEDME                = 3132, -- BCNM20 Charming Trio, Deep Kiss
    PLATOON_SCORPION       = 3157, -- KS30 Platoon Scorpion Wild Rage behavior
    QNAERN_RDM             = 3269, -- Qn'Aern RDM chainspell check
    RASKOVNIK              = 3326, -- Raskovnik Soothing Aroma
    QUBIA_ARENA_TRION      = 4006, -- Qu'Bia Arena Trion
    THRONE_ROOM_VOLKER     = 4249, -- Throne Room BC, Volker
    QNAERN_WHM             = 4651, -- Qn'Aern WHM benediction check
    AMNAF_PSYCHEFLAYER     = 5310, -- Reset enmity on sleepga
    FAHRAFAHR_THE_BLOODIED = 6750, -- Reset Enmity on Drop Hammer
    HPEMDE_NO_DIVING       = 7033, -- Hpemde that don't dive, such as those in the north end of Al'Taieu
    EOZDEI_LEFT            = 7095, -- Eo'zdei left rotation
    AWZDEI_LEFT            = 7096, -- Aw'zdei left rotation
    AWZDEI_FAST_R          = 7097, -- Aw'zdei fast right rotation
    AWZDEI_FAST_L          = 7098, -- Aw'zdei fast left rotation
}
