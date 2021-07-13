-----------------------------------
--
-- xi.effect.ATMA
--
-- Also used for Voidwatch Atmacite (it is a single effect in the client).
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/status")
-----------------------------------

xi = xi or {}
xi.atma = xi.atma or {}

local ATMA_OFFSET = xi.ki.ATMA_OF_THE_LION - 1

local atmaMods =
{
    -- GROUP 1
    [xi.ki.ATMA_OF_THE_LION]                   = {xi.mod.TRIPLE_ATTACK, 7, xi.mod.DMGPHYS, -10, xi.mod.THUNDERATT, 30},
    [xi.ki.ATMA_OF_THE_STOUT_ARM]              = {xi.mod.STR, 40, xi.mod.ATT, 50, xi.mod.RATT, 40},
    [xi.ki.ATMA_OF_THE_TWIN_CLAW]              = {xi.mod.DEF, 40, xi.mod.MDEF, 20, xi.mod.CHARMRES, 20},
    [xi.ki.ATMA_OF_ALLURE]                     = {xi.mod.MPP, 30, xi.mod.MND, 30, xi.mod.ENMITY, -30},
    [xi.ki.ATMA_OF_ETERNITY]                   = {xi.mod.ENEMYCRITRATE, -20, xi.mod.SLOWRES, 30, xi.mod.CURSERES, 30},
    [xi.ki.ATMA_OF_THE_HEAVENS]                = {xi.mod.MACC, 30, xi.mod.DMGPHYS, -10, xi.mod.PARALYZERES, 30},
    [xi.ki.ATMA_OF_THE_BAYING_MOON]            = {xi.mod.ATT, 30, xi.mod.MATT, 30},
    [xi.ki.ATMA_OF_THE_EBON_HOOF]              = {xi.mod.HPP, 30, xi.mod.SLEEPRES, 50},
    [xi.ki.ATMA_OF_TREMORS]                    = {xi.mod.DMG, -20, xi.mod.SILENCERES, 40},
    [xi.ki.ATMA_OF_THE_SAVAGE_TIGER]           = {xi.mod.AGI, 30, xi.mod.DOUBLE_ATTACK, 10},
    [xi.ki.ATMA_OF_THE_VORACIOUS_VIOLET]       = {xi.mod.STR, 50, xi.mod.DOUBLE_ATTACK, 10, xi.mod.REGAIN, 20},
    [xi.ki.ATMA_OF_CLOAK_AND_DAGGER]           = {xi.mod.ACC, 40, xi.mod.EVA, 40},
    [xi.ki.ATMA_OF_THE_STORMBIRD]              = {xi.mod.ACC, 40, xi.mod.THUNDERATT, 40, xi.mod.REFRESH, 5},
    [xi.ki.ATMA_OF_THE_NOXIOUS_FANG]           = {xi.mod.SUBTLE_BLOW, 40, xi.mod.WATERATT, 40, xi.mod.POISONRES, 40},
    [xi.ki.ATMA_OF_VICISSITUDE]                = {xi.mod.DEF, 40, xi.mod.MDEF, 20, xi.mod.REGEN, 15},
    [xi.ki.ATMA_OF_THE_BEYOND]                 = {xi.mod.MATT, 30, xi.mod.ICEATT, 30, xi.mod.LIGHTATT, 30},
    [xi.ki.ATMA_OF_STORMBREATH]                = {xi.mod.VIT, 30, xi.mod.DMGBREATH, -30},
    [xi.ki.ATMA_OF_GALES]                      = {xi.mod.WINDATT, 30, xi.mod.WINDACC, 30},
    [xi.ki.ATMA_OF_THRASHING_TENDRILS]         = {xi.mod.CHR, 30, xi.mod.CRITHITRATE, 20},
    [xi.ki.ATMA_OF_THE_DRIFTER]                = {xi.mod.RATT, 30, xi.mod.RACC, 40},
    [xi.ki.ATMA_OF_THE_STRONGHOLD]             = {xi.mod.ATT, 40, xi.mod.DEF, 40, xi.mod.REGEN, 15},
    [xi.ki.ATMA_OF_THE_HARVESTER]              = {xi.mod.STR, 30, xi.mod.DOUBLE_ATTACK, 10, xi.mod.SLEEPRES, 40},
    [xi.ki.ATMA_OF_DUNES]                      = {xi.mod.STORETP, 20, xi.mod.SLOWRES, 40},
    [xi.ki.ATMA_OF_THE_COSMOS]                 = {xi.mod.DARKATT, 40, xi.mod.AMNESIARES, 40, xi.mod.SILENCERES, 40},
    [xi.ki.ATMA_OF_THE_SIREN_SHADOW]           = {xi.mod.ATT, 40, xi.mod.EVA, 40, xi.mod.PARALYZERES, 40},
    [xi.ki.ATMA_OF_THE_IMPALER]                = {xi.mod.DOUBLE_ATTACK, 20, xi.mod.BINDRES, 40, xi.mod.BLINDRES, 40},
    [xi.ki.ATMA_OF_THE_ADAMANTINE]             = {xi.mod.VIT, 20, xi.mod.DEF, 40},
    [xi.ki.ATMA_OF_CALAMITY]                   = {xi.mod.SLOWRES, 40, xi.mod.BLINDRES, 40},
    [xi.ki.ATMA_OF_THE_CLAW]                   = {xi.mod.EARTHATT, 30, xi.mod.EARTHACC, 40},
    [xi.ki.ATMA_OF_BALEFUL_BONES]              = {xi.mod.STR, 20, xi.mod.DARKACC, 40},
    [xi.ki.ATMA_OF_THE_CLAWED_BUTTERFLY]       = {xi.mod.FIREACC, 40, xi.mod.INT, 30},
    [xi.ki.ATMA_OF_THE_DESERT_WORM]            = {xi.mod.MND, 20, xi.mod.ACC, 40, xi.mod.MAGIC_NULL, 5},
    [xi.ki.ATMA_OF_THE_UNDYING]                = {xi.mod.MND, 40, xi.mod.CONSERVE_MP, 10, xi.mod.ICEATT, 20},
    [xi.ki.ATMA_OF_THE_IMPREGNABLE_TOWER]      = {xi.mod.HPP, 30, xi.mod.MACC, 40, xi.mod.MATT, 40},
    [xi.ki.ATMA_OF_THE_SMOLDERING_SKY]         = {xi.mod.ATT, 20, xi.mod.MACC, 40, xi.mod.FIREATT, 30},
    [xi.ki.ATMA_OF_THE_DEMONIC_SKEWER]         = {xi.mod.STR, 20, xi.mod.TP_BONUS, 20, xi.mod.NULL_PHYSICAL_DAMAGE, 5},
    [xi.ki.ATMA_OF_THE_GOLDEN_CLAW]            = {xi.mod.SKILLCHAINBONUS, 20, xi.mod.STR, 20},
    [xi.ki.ATMA_OF_THE_GLUTINOUS_OOZE]         = {xi.mod.MND, 20, xi.mod.WATERACC, 20},
    [xi.ki.ATMA_OF_THE_LIGHTNING_BEAST]        = {xi.mod.FASTCAST, 20, xi.mod.SPELLINTERRUPT, 20},
    [xi.ki.ATMA_OF_THE_NOXIOUS_BLOOM]          = {xi.mod.STORETP, 20, xi.mod.WALTZ_POTENTCY, 10},
    [xi.ki.ATMA_OF_THE_GNARLED_HORN]           = {xi.mod.AGI, 50, xi.mod.CRITHITRATE, 20, xi.mod.COUNTER, 10},
    [xi.ki.ATMA_OF_THE_STRANGLING_WIND]        = {xi.mod.STR, 20, xi.mod.VIT, 20, xi.mod.AGI, 30},
    [xi.ki.ATMA_OF_THE_DEEP_DEVOURER]          = {xi.mod.SUBTLE_BLOW, 5, xi.mod.STORETP, 5, xi.mod.SONG_SPELLCASTING_TIME, 20},
    [xi.ki.ATMA_OF_THE_MOUNTED_CHAMPION]       = {xi.mod.VIT, 50, xi.mod.REGEN, 20, xi.mod.ENMITY_REDUCTION_PHYSICAL, -20},
    [xi.ki.ATMA_OF_THE_RAZED_RUINS]            = {xi.mod.DEX, 50, xi.mod.CRITHITRATE, 30, xi.mod.CRIT_DMG_INCREASE, 30},
    [xi.ki.ATMA_OF_THE_BLUDGEONING_BRUTE]      = {xi.mod.REGAIN, 10, xi.mod.THUNDER_RES, 50, xi.mod.WATER_RES, 50},
    [xi.ki.ATMA_OF_THE_RAPID_REPTILIAN]        = {xi.mod.TRIPLE_ATTACK, 5, xi.mod.DMGBREATH, -40},
    [xi.ki.ATMA_OF_THE_WINGED_ENIGMA]          = {xi.mod.HASTE_GEAR, 100},
    [xi.ki.ATMA_OF_THE_CRADLE]                 = {xi.mod.VIT, 20, xi.mod.DEX, 20},
    [xi.ki.ATMA_OF_THE_UNTOUCHED]              = {xi.mod.CHR, 20, xi.mod.TRIPLE_ATTACK, 5},
    [xi.ki.ATMA_OF_THE_SANGUINE_SCYTHE]        = {xi.mod.HPP, 20, xi.mod.CRIT_DMG_INCREASE, 30, xi.mod.ENMITY, 20},
    [xi.ki.ATMA_OF_THE_TUSKED_TERROR]          = {xi.mod.FASTCAST, 20, xi.mod.WATERATT, 20, xi.mod.WATERACC, 20},
    [xi.ki.ATMA_OF_THE_MINIKIN_MONSTROSITY]    = {xi.mod.REFRESH, 10, xi.mod.INT, 50, xi.mod.ENMITY, -20},
    [xi.ki.ATMA_OF_THE_WOULD_BE_KING]          = {xi.mod.REGAIN, 100, xi.mod.STORETP, 20, xi.mod.TP_BONUS, 20},
    [xi.ki.ATMA_OF_THE_BLINDING_HORN]          = {xi.mod.CONSERVE_MP, 20, xi.mod.THUNDERATT, 30, xi.mod.DMGMAGIC, -20},
    [xi.ki.ATMA_OF_THE_DEMONIC_LASH]           = {xi.mod.ATT, 40, xi.mod.DOUBLE_ATTACK, 10, xi.mod.MAGIC_ABSORB, 20},
    [xi.ki.ATMA_OF_APPARITIONS]                = {xi.mod.EVA, 20, xi.mod.WIND_RES, 50},
    [xi.ki.ATMA_OF_THE_SHIMMERING_SHELL]       = {xi.mod.AGI, 20, xi.mod.FIRE_RES, 50},
    [xi.ki.ATMA_OF_THE_MURKY_MIASMA]           = {xi.mod.DARK_RES, 50, xi.mod.STUNRES, 30},
    [xi.ki.ATMA_OF_THE_AVARICIOUS_APE]         = {xi.mod.HASTE_GEAR, 100}, -- not implemented: Monster Correlation
    [xi.ki.ATMA_OF_THE_MERCILESS_MATRIARCH]    = {xi.mod.MACC, 50, xi.mod.FASTCAST, 20, xi.mod.ENMITY, -50},
    [xi.ki.ATMA_OF_THE_BROTHER_WOLF]           = {xi.mod.MATT, 20, xi.mod.MDEF, 20, xi.mod.FIRE_RES, 100},
    [xi.ki.ATMA_OF_THE_EARTH_WYRM]             = {xi.mod.EARTH_RES, 100, xi.mod.DMG, -20, xi.mod.FORCE_EARTH_DWBONUS, 1},
    [xi.ki.ATMA_OF_THE_ASCENDING_ONE]          = {xi.mod.WIND_RES, 100, xi.mod.HASTE_GEAR, 500, xi.mod.SNAP_SHOT, 5},
    [xi.ki.ATMA_OF_THE_SCORPION_QUEEN]         = {xi.mod.STORETP, 20, xi.mod.CRITHITRATE, 30, xi.mod.BINDRES, 50},
    [xi.ki.ATMA_OF_A_THOUSAND_NEEDLES]         = {xi.mod.HPP, 20, xi.mod.MPP, 20, xi.mod.DEX, 10},
    [xi.ki.ATMA_OF_THE_BURNING_EFFIGY]         = {xi.mod.STR, 20, xi.mod.FORCE_FIRE_DWBONUS, 1}, -- fire based ws + 0.2 fTP] = {},
    [xi.ki.ATMA_OF_THE_SMITING_BLOW]           = {xi.mod.TP_BONUS, 50, xi.mod.WSACC, 50},
    [xi.ki.ATMA_OF_THE_LONE_WOLF]              = {xi.mod.ATT, 20, xi.mod.FIREATT, 30},
    [xi.ki.ATMA_OF_THE_CRIMSON_SCALE]          = {xi.mod.HASTE_GEAR, 300, xi.mod.ENMITY, -20},
    [xi.ki.ATMA_OF_THE_SCARLET_WING]           = {xi.mod.ELEM, 10, xi.mod.FORCE_WIND_DWBONUS, 1},
    [xi.ki.ATMA_OF_THE_RAISED_TAIL]            = {xi.mod.ATT, 40, xi.mod.EVA, 40},
    [xi.ki.ATMA_OF_THE_SAND_EMPEROR]           = {xi.mod.ACC, 40, xi.mod.EVA, 40},
    [xi.ki.ATMA_OF_THE_OMNIPOTENT]             = {xi.mod.DEX, 50, xi.mod.HASTE_GEAR, 1000, xi.mod.ENMITY, 20},
    [xi.ki.ATMA_OF_THE_WAR_LION]               = {xi.mod.DEX, 20, xi.mod.THUNDER_RES, 100, xi.mod.FORCE_LIGHTNING_DWBONUS, 1},
    [xi.ki.ATMA_OF_THE_FROZEN_FETTERS]         = {xi.mod.INT, 20, xi.mod.ICE_RES, 100, xi.mod.FORCE_ICE_DWBONUS, 1},
    [xi.ki.ATMA_OF_THE_PLAGUEBRINGER]          = {xi.mod.REGEN, 10, xi.mod.STORETP, 20, xi.mod.DOUBLE_ATTACK, 7},
    [xi.ki.ATMA_OF_THE_SHRIEKING_ONE]          = {xi.mod.DEF, 60, xi.mod.MDEF, 20, xi.mod.STORETP, 20},
    [xi.ki.ATMA_OF_THE_HOLY_MOUNTAIN]          = {xi.mod.LIGHT_RES, 100, xi.mod.LIGHTACC, 50, xi.mod.FORCE_LIGHT_DWBONUS, 1},
    [xi.ki.ATMA_OF_THE_LAKE_LURKER]            = {xi.mod.MND, 20, xi.mod.WATER_RES, 100, xi.mod.FORCE_WATER_DWBONUS, 1},
    [xi.ki.ATMA_OF_THE_CRUSHING_CUDGEL]        = {xi.mod.ACC, 20, xi.mod.SKILLCHAINDMG, 5},
    [xi.ki.ATMA_OF_PURGATORY]                  = {xi.mod.VIT, 40, xi.mod.INT, 40},
    [xi.ki.ATMA_OF_BLIGHTED_BREATH]            = {xi.mod.SONG_SPELLCASTING_TIME, 40, xi.mod.LIGHTACC, 40},
    [xi.ki.ATMA_OF_THE_PERSISTENT_PREDATOR]    = {xi.mod.STORETP, 40, xi.mod.TP_BONUS, 10},
    [xi.ki.ATMA_OF_THE_STONE_GOD]              = {xi.mod.SUBTLE_BLOW, 40, xi.mod.ENMITY, 40},
    [xi.ki.ATMA_OF_THE_SUN_EATER]              = {xi.mod.STORETP, 40, xi.mod.TP_BONUS, 40},
    [xi.ki.ATMA_OF_THE_DESPOT]                 = {xi.mod.CHR, 50, xi.mod.MAGIC_ABSORB, 15, xi.mod.TP_BONUS, 40},
    [xi.ki.ATMA_OF_THE_SOLITARY_ONE]           = {xi.mod.TRIPLE_ATTACK, 7, xi.mod.DMGBREATH, -25, xi.mod.ZANSHIN, 10},
    [xi.ki.ATMA_OF_THE_WINGED_GLOOM]           = {xi.mod.DMG, -25, xi.mod.REGEN, 2},
    [xi.ki.ATMA_OF_THE_SEA_DAUGHTER]           = {xi.mod.REGAIN, 50, xi.mod.HASTE_GEAR, -1500, xi.mod.REGEN, 30},
    [xi.ki.ATMA_OF_THE_HATEFUL_STREAM]         = {}, -- Not yet implemented. No easy way to do this ATMA. No way I am doing bit work in onTick for it..
    [xi.ki.ATMA_OF_THE_FOE_FLAYER]             = {xi.mod.MPP, 20, xi.mod.REFRESH, 20, xi.mod.FASTCAST, 20, xi.mod.MACC, 50},
    [xi.ki.ATMA_OF_THE_ENDLESS_NIGHTMARE]      = {xi.mod.MND, 20, xi.mod.DARK_RES, 100, xi.mod.FORCE_DARK_DWBONUS, 1},
    [xi.ki.ATMA_OF_THE_SUNDERING_SLASH]        = {xi.mod.ATT, 20, xi.mod.REGAIN, 30},
    [xi.ki.ATMA_OF_ENTWINED_SERPENTS]          = {xi.mod.ATT, 20, xi.mod.DOUBLE_ATTACK, 15},
    [xi.ki.ATMA_OF_THE_HORNED_BEAST]           = {xi.mod.ACC, 60, xi.mod.PETRIFYRES, 50},
    [xi.ki.ATMA_OF_AQUATIC_ARDOR]              = {xi.mod.ABSORB_DMG_CHANCE, 6, xi.mod.MAGIC_ABSORB, 6},
    [xi.ki.ATMA_OF_THE_FALLEN_ONE]             = {xi.mod.INT, 30, xi.mod.MND, 30},
    [xi.ki.ATMA_OF_FIRES_AND_FLARES]           = {xi.mod.AGI, 20, xi.mod.RATT, 40},
    [xi.ki.ATMA_OF_THE_APOCALYPSE]             = {xi.mod.TRIPLE_ATTACK, 15, xi.mod.RERAISE_III, 1, xi.mod.QUICK_MAGIC, 10},

    -- GROUP 2
    [xi.ki.ATMA_OF_THE_HEIR]                   = {},
    [xi.ki.ATMA_OF_THE_HERO]                   = {},
    [xi.ki.ATMA_OF_THE_FULL_MOON]              = {},
    [xi.ki.ATMA_OF_ILLUSIONS]                  = {},
    [xi.ki.ATMA_OF_THE_BANISHER]               = {},
    [xi.ki.ATMA_OF_THE_SELLSWORD]              = {},
    [xi.ki.ATMA_OF_A_FUTURE_FABULOUS]          = {},
    [xi.ki.ATMA_OF_CAMARADERIE]                = {},
    [xi.ki.ATMA_OF_THE_TRUTHSEEKER]            = {},
    [xi.ki.ATMA_OF_THE_AZURE_SKY]              = {},
    [xi.ki.ATMA_OF_ECHOES]                     = {},
    [xi.ki.ATMA_OF_DREAD]                      = {},
    [xi.ki.ATMA_OF_AMBITION]                   = {},
    [xi.ki.ATMA_OF_THE_BEAST_KING]             = {},
    [xi.ki.ATMA_OF_THE_KIRIN]                  = {},
    [xi.ki.ATMA_OF_HELLS_GUARDIAN]             = {},
    [xi.ki.ATMA_OF_LUMINOUS_WINGS]             = {},
    [xi.ki.ATMA_OF_THE_DRAGON_RIDER]           = {},
    [xi.ki.ATMA_OF_THE_IMPENETRABLE]           = {},
    [xi.ki.ATMA_OF_ALPHA_AND_OMEGA]            = {},
    [xi.ki.ATMA_OF_THE_ULTIMATE]               = {},
    [xi.ki.ATMA_OF_THE_HYBRID_BEAST]           = {},
    [xi.ki.ATMA_OF_THE_DARK_DEPTHS]            = {},
    [xi.ki.ATMA_OF_THE_ZENITH]                 = {},
    [xi.ki.ATMA_OF_PERFECT_ATTENDANCE]         = {},
    [xi.ki.ATMA_OF_THE_RESCUER]                = {},
    [xi.ki.ATMA_OF_NIGHTMARES]                 = {},
    [xi.ki.ATMA_OF_THE_EINHERJAR]              = {},
    [xi.ki.ATMA_OF_THE_ILLUMINATOR]            = {},
    [xi.ki.ATMA_OF_THE_BUSHIN]                 = {},
    [xi.ki.ATMA_OF_THE_ACE_ANGLER]             = {},
    [xi.ki.ATMA_OF_THE_MASTER_CRAFTER]         = {},
    [xi.ki.ATMA_OF_INGENUITY]                  = {},
    [xi.ki.ATMA_OF_THE_GRIFFONS_CLAW]          = {},
    [xi.ki.ATMA_OF_THE_FETCHING_FOOTPAD]       = {},
    [xi.ki.ATMA_OF_UNDYING_LOYALTY]            = {},
    [xi.ki.ATMA_OF_THE_ROYAL_LINEAGE]          = {},
    [xi.ki.ATMA_OF_THE_SHATTERING_STAR]        = {},
    [xi.ki.ATMA_OF_THE_COBRA_COMMANDER]        = {},
    [xi.ki.ATMA_OF_ROARING_LAUGHTER]           = {},
    [xi.ki.ATMA_OF_THE_DARK_BLADE]             = {},
    [xi.ki.ATMA_OF_THE_DUCAL_GUARD]            = {},
    [xi.ki.ATMA_OF_HARMONY]                    = {},
    [xi.ki.ATMA_OF_REVELATIONS]                = {},
    [xi.ki.ATMA_OF_THE_SAVIOR]                 = {},
}

xi.atma.onEffectGain = function(target, effect)
    local atma = ATMA_OFFSET + effect:getPower()
    local mods = atmaMods[atma]
    if mods ~= nil then
        for i = 1, #mods, 2 do
            target:addMod(i, i + 1)
        end
    end
end

xi.atma.onEffectLose = function(target, effect)
    local atma = ATMA_OFFSET + effect:getPower()
    local mods = atmaMods[atma]
    if mods ~= nil then
        for i = 1, #mods, 2 do
            target:delMod(i, i + 1)
        end
    end
end
