-----------------------------------
-- Mob SUBLINK mobMod values. These are assigned in mob_family_mods.sql or in mob scripts.
-- The SUBLINK mobMod enables mobs from different families to link with one another if they share a SUBLINK value and they have linking enabled.
-----------------------------------
xi = xi or {}

---@enum xi.mobSublink
xi.mobSublink =
{
    NONE                  = 0,
    KINDRED_TAURI         = 1,
    ORCS_ORCWARMACHINE    = 2,
    BATS_VAMPYR           = 3,
    SAPLING_TREANT        = 4,
    GOBLIN_MOBLIN_BUGBEAR = 5,
    WAMOURA_WAMOURACAMPA  = 6,
    SABOTENDER            = 7,
    MAMOOL_JA_SAHAGIN     = 8,
    TROLL                 = 9,
    LAMIAE                = 10,
    SOULFLAYER            = 11,
    QIQIRN                = 12,
    IMP                   = 13,
    APKALLU               = 14,
    ARCHAIC_CONSTRUCT     = 15, -- Chariot, Gears, Ramparts
}
