-----------------------------------
-- Abyssea Atma Global
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.atma = xi.atma or {}

xi.atma.atmaMods =
{
    -- GROUP 1
    [xi.ki.ATMA_OF_THE_LION]                   = { xi.mod.TRIPLE_ATTACK, 7, xi.mod.DMGPHYS, -1000, xi.mod.THUNDERATT, 30 },
    [xi.ki.ATMA_OF_THE_STOUT_ARM]              = { xi.mod.STR, 40, xi.mod.ATT, 50, xi.mod.RATT, 40 },
    [xi.ki.ATMA_OF_THE_TWIN_CLAW]              = { xi.mod.DEF, 40, xi.mod.MDEF, 20, xi.mod.CHARMRES, 20 },
    [xi.ki.ATMA_OF_ALLURE]                     = { xi.mod.MPP, 30, xi.mod.MND, 30, xi.mod.ENMITY, -30 },
    [xi.ki.ATMA_OF_ETERNITY]                   = { xi.mod.CRITICAL_HIT_EVASION, -20, xi.mod.SLOWRES, 30, xi.mod.CURSERES, 30 },
    [xi.ki.ATMA_OF_THE_HEAVENS]                = { xi.mod.MACC, 30, xi.mod.DMGPHYS, -1000, xi.mod.PARALYZERES, 30 },
    [xi.ki.ATMA_OF_THE_BAYING_MOON]            = { xi.mod.ATT, 30, xi.mod.MATT, 30 },
    [xi.ki.ATMA_OF_THE_EBON_HOOF]              = { xi.mod.HPP, 30, xi.mod.SLEEPRES, 50 },
    [xi.ki.ATMA_OF_TREMORS]                    = { xi.mod.DMG, -2000, xi.mod.SILENCERES, 40 },
    [xi.ki.ATMA_OF_THE_SAVAGE_TIGER]           = { xi.mod.AGI, 30, xi.mod.DOUBLE_ATTACK, 10 },
    [xi.ki.ATMA_OF_THE_VORACIOUS_VIOLET]       = { xi.mod.STR, 50, xi.mod.DOUBLE_ATTACK, 10, xi.mod.REGAIN, 20 },
    [xi.ki.ATMA_OF_CLOAK_AND_DAGGER]           = { xi.mod.ACC, 40, xi.mod.EVA, 40 },
    [xi.ki.ATMA_OF_THE_STORMBIRD]              = { xi.mod.ACC, 40, xi.mod.THUNDERATT, 40, xi.mod.REFRESH, 5 },
    [xi.ki.ATMA_OF_THE_NOXIOUS_FANG]           = { xi.mod.SUBTLE_BLOW, 40, xi.mod.WATERATT, 40, xi.mod.POISONRES, 40 },
    [xi.ki.ATMA_OF_VICISSITUDE]                = { xi.mod.DEF, 40, xi.mod.MDEF, 20, xi.mod.REGEN, 15 },
    [xi.ki.ATMA_OF_THE_BEYOND]                 = { xi.mod.MATT, 30, xi.mod.ICEATT, 30, xi.mod.LIGHTATT, 30 },
    [xi.ki.ATMA_OF_STORMBREATH]                = { xi.mod.VIT, 30, xi.mod.DMGBREATH, -3000 },
    [xi.ki.ATMA_OF_GALES]                      = { xi.mod.WINDATT, 30, xi.mod.WINDACC, 30 },
    [xi.ki.ATMA_OF_THRASHING_TENDRILS]         = { xi.mod.CHR, 30, xi.mod.CRITHITRATE, 20 },
    [xi.ki.ATMA_OF_THE_DRIFTER]                = { xi.mod.RATT, 30, xi.mod.RACC, 40 },
    [xi.ki.ATMA_OF_THE_STRONGHOLD]             = { xi.mod.ATT, 40, xi.mod.DEF, 40, xi.mod.REGEN, 15 },
    [xi.ki.ATMA_OF_THE_HARVESTER]              = { xi.mod.STR, 30, xi.mod.DOUBLE_ATTACK, 10, xi.mod.SLEEPRES, 40 },
    [xi.ki.ATMA_OF_DUNES]                      = { xi.mod.STORETP, 20, xi.mod.SLOWRES, 40 },
    [xi.ki.ATMA_OF_THE_COSMOS]                 = { xi.mod.DARKATT, 40, xi.mod.AMNESIARES, 40, xi.mod.SILENCERES, 40 },
    [xi.ki.ATMA_OF_THE_SIREN_SHADOW]           = { xi.mod.ATT, 40, xi.mod.EVA, 40, xi.mod.PARALYZERES, 40 },
    [xi.ki.ATMA_OF_THE_IMPALER]                = { xi.mod.DOUBLE_ATTACK, 20, xi.mod.BINDRES, 40, xi.mod.BLINDRES, 40 },
    [xi.ki.ATMA_OF_THE_ADAMANTINE]             = { xi.mod.VIT, 20, xi.mod.DEF, 40 },
    [xi.ki.ATMA_OF_CALAMITY]                   = { xi.mod.SLOWRES, 40, xi.mod.BLINDRES, 40 },
    [xi.ki.ATMA_OF_THE_CLAW]                   = { xi.mod.EARTHATT, 30, xi.mod.EARTHACC, 40 },
    [xi.ki.ATMA_OF_BALEFUL_BONES]              = { xi.mod.STR, 20, xi.mod.DARKACC, 40 },
    [xi.ki.ATMA_OF_THE_CLAWED_BUTTERFLY]       = { xi.mod.FIREACC, 40, xi.mod.INT, 30 },
    [xi.ki.ATMA_OF_THE_DESERT_WORM]            = { xi.mod.MND, 20, xi.mod.ACC, 40, xi.mod.NULL_MAGICAL_DAMAGE, 5 },
    [xi.ki.ATMA_OF_THE_UNDYING]                = { xi.mod.MND, 40, xi.mod.CONSERVE_MP, 10, xi.mod.ICEATT, 20 },
    [xi.ki.ATMA_OF_THE_IMPREGNABLE_TOWER]      = { xi.mod.HPP, 30, xi.mod.MACC, 40, xi.mod.MATT, 40 },
    [xi.ki.ATMA_OF_THE_SMOLDERING_SKY]         = { xi.mod.ATT, 20, xi.mod.MACC, 40, xi.mod.FIREATT, 30 },
    [xi.ki.ATMA_OF_THE_DEMONIC_SKEWER]         = { xi.mod.STR, 20, xi.mod.TP_BONUS, 20, xi.mod.NULL_PHYSICAL_DAMAGE, 5, xi.mod.NULL_RANGED_DAMAGE, 5 },
    [xi.ki.ATMA_OF_THE_GOLDEN_CLAW]            = { xi.mod.SKILLCHAINBONUS, 20, xi.mod.STR, 20 },
    [xi.ki.ATMA_OF_THE_GLUTINOUS_OOZE]         = { xi.mod.MND, 20, xi.mod.WATERACC, 20 },
    [xi.ki.ATMA_OF_THE_LIGHTNING_BEAST]        = { xi.mod.FASTCAST, 20, xi.mod.SPELLINTERRUPT, 20 },
    [xi.ki.ATMA_OF_THE_NOXIOUS_BLOOM]          = { xi.mod.STORETP, 20, xi.mod.WALTZ_POTENCY, 10 },
    [xi.ki.ATMA_OF_THE_GNARLED_HORN]           = { xi.mod.AGI, 50, xi.mod.CRITHITRATE, 20, xi.mod.COUNTER, 10 },
    [xi.ki.ATMA_OF_THE_STRANGLING_WIND]        = { xi.mod.STR, 20, xi.mod.VIT, 20, xi.mod.AGI, 30 },
    [xi.ki.ATMA_OF_THE_DEEP_DEVOURER]          = { xi.mod.SUBTLE_BLOW, 5, xi.mod.STORETP, 5, xi.mod.SONG_SPELLCASTING_TIME, 20 },
    [xi.ki.ATMA_OF_THE_MOUNTED_CHAMPION]       = { xi.mod.VIT, 50, xi.mod.REGEN, 20, xi.mod.ENMITY_LOSS_REDUCTION, -20 },
    [xi.ki.ATMA_OF_THE_RAZED_RUINS]            = { xi.mod.DEX, 50, xi.mod.CRITHITRATE, 30, xi.mod.CRIT_DMG_INCREASE, 30 },
    [xi.ki.ATMA_OF_THE_BLUDGEONING_BRUTE]      = { xi.mod.REGAIN, 10, xi.mod.THUNDER_MEVA, 50, xi.mod.WATER_MEVA, 50 },
    [xi.ki.ATMA_OF_THE_RAPID_REPTILIAN]        = { xi.mod.TRIPLE_ATTACK, 5, xi.mod.DMGBREATH, -4000 },
    [xi.ki.ATMA_OF_THE_WINGED_ENIGMA]          = { xi.mod.HASTE_GEAR, 100 },
    [xi.ki.ATMA_OF_THE_CRADLE]                 = { xi.mod.VIT, 20, xi.mod.DEX, 20 },
    [xi.ki.ATMA_OF_THE_UNTOUCHED]              = { xi.mod.CHR, 20, xi.mod.TRIPLE_ATTACK, 5 },
    [xi.ki.ATMA_OF_THE_SANGUINE_SCYTHE]        = { xi.mod.HPP, 20, xi.mod.CRIT_DMG_INCREASE, 30, xi.mod.ENMITY, 20 },
    [xi.ki.ATMA_OF_THE_TUSKED_TERROR]          = { xi.mod.FASTCAST, 20, xi.mod.WATERATT, 20, xi.mod.WATERACC, 20 },
    [xi.ki.ATMA_OF_THE_MINIKIN_MONSTROSITY]    = { xi.mod.REFRESH, 10, xi.mod.INT, 50, xi.mod.ENMITY, -20 },
    [xi.ki.ATMA_OF_THE_WOULD_BE_KING]          = { xi.mod.REGAIN, 100, xi.mod.STORETP, 20, xi.mod.TP_BONUS, 20 },
    [xi.ki.ATMA_OF_THE_BLINDING_HORN]          = { xi.mod.CONSERVE_MP, 20, xi.mod.THUNDERATT, 30, xi.mod.DMGMAGIC, -2000 },
    [xi.ki.ATMA_OF_THE_DEMONIC_LASH]           = { xi.mod.ATT, 40, xi.mod.DOUBLE_ATTACK, 10, xi.mod.MAGIC_ABSORB, 20 },
    [xi.ki.ATMA_OF_APPARITIONS]                = { xi.mod.EVA, 20, xi.mod.WIND_MEVA, 50 },
    [xi.ki.ATMA_OF_THE_SHIMMERING_SHELL]       = { xi.mod.AGI, 20, xi.mod.FIRE_MEVA, 50 },
    [xi.ki.ATMA_OF_THE_MURKY_MIASMA]           = { xi.mod.DARK_MEVA, 50, xi.mod.STUNRES, 30 },
    [xi.ki.ATMA_OF_THE_AVARICIOUS_APE]         = { xi.mod.HASTE_GEAR, 100 }, -- not implemented: Monster Correlation
    [xi.ki.ATMA_OF_THE_MERCILESS_MATRIARCH]    = { xi.mod.MACC, 50, xi.mod.FASTCAST, 20, xi.mod.ENMITY, -50 },
    [xi.ki.ATMA_OF_THE_BROTHER_WOLF]           = { xi.mod.MATT, 20, xi.mod.MDEF, 20, xi.mod.FIRE_MEVA, 100 },
    [xi.ki.ATMA_OF_THE_EARTH_WYRM]             = { xi.mod.EARTH_MEVA, 100, xi.mod.DMG, -2000, xi.mod.FORCE_EARTH_DWBONUS, 1 },
    [xi.ki.ATMA_OF_THE_ASCENDING_ONE]          = { xi.mod.WIND_MEVA, 100, xi.mod.HASTE_GEAR, 500, xi.mod.SNAPSHOT, 5 },
    [xi.ki.ATMA_OF_THE_SCORPION_QUEEN]         = { xi.mod.STORETP, 20, xi.mod.CRITHITRATE, 30, xi.mod.BINDRES, 50 },
    [xi.ki.ATMA_OF_A_THOUSAND_NEEDLES]         = { xi.mod.HPP, 20, xi.mod.MPP, 20, xi.mod.DEX, 10 },
    [xi.ki.ATMA_OF_THE_BURNING_EFFIGY]         = { xi.mod.STR, 20, xi.mod.FORCE_FIRE_DWBONUS, 1 }, -- fire based ws + 0.2 fTP] = {},
    [xi.ki.ATMA_OF_THE_SMITING_BLOW]           = { xi.mod.TP_BONUS, 50, xi.mod.WSACC, 50 },
    [xi.ki.ATMA_OF_THE_LONE_WOLF]              = { xi.mod.ATT, 20, xi.mod.FIREATT, 30 },
    [xi.ki.ATMA_OF_THE_CRIMSON_SCALE]          = { xi.mod.HASTE_GEAR, 300, xi.mod.ENMITY, -20 },
    [xi.ki.ATMA_OF_THE_SCARLET_WING]           = { xi.mod.ELEM, 10, xi.mod.FORCE_WIND_DWBONUS, 1 },
    [xi.ki.ATMA_OF_THE_RAISED_TAIL]            = { xi.mod.ATT, 40, xi.mod.EVA, 40 },
    [xi.ki.ATMA_OF_THE_SAND_EMPEROR]           = { xi.mod.ACC, 40, xi.mod.EVA, 40 },
    [xi.ki.ATMA_OF_THE_OMNIPOTENT]             = { xi.mod.DEX, 50, xi.mod.HASTE_GEAR, 1000, xi.mod.ENMITY, 20 },
    [xi.ki.ATMA_OF_THE_WAR_LION]               = { xi.mod.DEX, 20, xi.mod.THUNDER_MEVA, 100, xi.mod.FORCE_LIGHTNING_DWBONUS, 1 },
    [xi.ki.ATMA_OF_THE_FROZEN_FETTERS]         = { xi.mod.INT, 20, xi.mod.ICE_MEVA, 100, xi.mod.FORCE_ICE_DWBONUS, 1 },
    [xi.ki.ATMA_OF_THE_PLAGUEBRINGER]          = { xi.mod.REGEN, 10, xi.mod.STORETP, 20, xi.mod.DOUBLE_ATTACK, 7 },
    [xi.ki.ATMA_OF_THE_SHRIEKING_ONE]          = { xi.mod.DEF, 60, xi.mod.MDEF, 20, xi.mod.STORETP, 20 },
    [xi.ki.ATMA_OF_THE_HOLY_MOUNTAIN]          = { xi.mod.LIGHT_MEVA, 100, xi.mod.LIGHTACC, 50, xi.mod.FORCE_LIGHT_DWBONUS, 1 },
    [xi.ki.ATMA_OF_THE_LAKE_LURKER]            = { xi.mod.MND, 20, xi.mod.WATER_MEVA, 100, xi.mod.FORCE_WATER_DWBONUS, 1 },
    [xi.ki.ATMA_OF_THE_CRUSHING_CUDGEL]        = { xi.mod.ACC, 20, xi.mod.SKILLCHAINDMG, 500 },
    [xi.ki.ATMA_OF_PURGATORY]                  = { xi.mod.VIT, 40, xi.mod.INT, 40 },
    [xi.ki.ATMA_OF_BLIGHTED_BREATH]            = { xi.mod.SONG_SPELLCASTING_TIME, 40, xi.mod.LIGHTACC, 40 },
    [xi.ki.ATMA_OF_THE_PERSISTENT_PREDATOR]    = { xi.mod.STORETP, 40, xi.mod.TP_BONUS, 10 },
    [xi.ki.ATMA_OF_THE_STONE_GOD]              = { xi.mod.SUBTLE_BLOW, 40, xi.mod.ENMITY, 40 },
    [xi.ki.ATMA_OF_THE_SUN_EATER]              = { xi.mod.STORETP, 40, xi.mod.TP_BONUS, 40 },
    [xi.ki.ATMA_OF_THE_DESPOT]                 = { xi.mod.CHR, 50, xi.mod.MAGIC_ABSORB, 15, xi.mod.TP_BONUS, 40 },
    [xi.ki.ATMA_OF_THE_SOLITARY_ONE]           = { xi.mod.TRIPLE_ATTACK, 7, xi.mod.DMGBREATH, -2500, xi.mod.ZANSHIN, 10 },
    [xi.ki.ATMA_OF_THE_WINGED_GLOOM]           = { xi.mod.DMG, -2500, xi.mod.REGEN, 2 },
    [xi.ki.ATMA_OF_THE_SEA_DAUGHTER]           = { xi.mod.REGAIN, 50, xi.mod.HASTE_GEAR, -1500, xi.mod.REGEN, 30 },
    [xi.ki.ATMA_OF_THE_HATEFUL_STREAM]         = { }, -- Not yet implemented. No easy way to do this ATMA. No way I am doing bit work in onTick for it..
    [xi.ki.ATMA_OF_THE_FOE_FLAYER]             = { xi.mod.MPP, 20, xi.mod.REFRESH, 20, xi.mod.FASTCAST, 20, xi.mod.MACC, 50 },
    [xi.ki.ATMA_OF_THE_ENDLESS_NIGHTMARE]      = { xi.mod.MND, 20, xi.mod.DARK_MEVA, 100, xi.mod.FORCE_DARK_DWBONUS, 1 },
    [xi.ki.ATMA_OF_THE_SUNDERING_SLASH]        = { xi.mod.ATT, 20, xi.mod.REGAIN, 30 },
    [xi.ki.ATMA_OF_ENTWINED_SERPENTS]          = { xi.mod.ATT, 20, xi.mod.DOUBLE_ATTACK, 15 },
    [xi.ki.ATMA_OF_THE_HORNED_BEAST]           = { xi.mod.ACC, 60, xi.mod.PETRIFYRES, 50 },
    [xi.ki.ATMA_OF_AQUATIC_ARDOR]              = { xi.mod.ABSORB_DMG_CHANCE, 6, xi.mod.MAGIC_ABSORB, 6 },
    [xi.ki.ATMA_OF_THE_FALLEN_ONE]             = { xi.mod.INT, 30, xi.mod.MND, 30 },
    [xi.ki.ATMA_OF_FIRES_AND_FLARES]           = { xi.mod.AGI, 20, xi.mod.RATT, 40 },
    [xi.ki.ATMA_OF_THE_APOCALYPSE]             = { xi.mod.TRIPLE_ATTACK, 15, xi.mod.RERAISE_III, 1, xi.mod.QUICK_MAGIC, 10 },

    -- GROUP 2
    [xi.ki.ATMA_OF_THE_HEIR]                   = { xi.mod.MPP, 5, xi.mod.REGAIN, 5, xi.mod.LIGHTACC, 20 },
    [xi.ki.ATMA_OF_THE_HERO]                   = { xi.mod.STR, 10, xi.mod.CRIT_DMG_INCREASE, 15, xi.mod.REGEN, 5 },
    [xi.ki.ATMA_OF_THE_FULL_MOON]              = { xi.mod.INT, 10, xi.mod.MATT, 10, xi.mod.REFRESH, 5 },
    [xi.ki.ATMA_OF_ILLUSIONS]                  = { xi.mod.MND, 10, xi.mod.MAGIC_BURST_BONUS_CAPPED, 10, xi.mod.DAY_NUKE_BONUS, 10 },
    [xi.ki.ATMA_OF_THE_BANISHER]               = { },
    [xi.ki.ATMA_OF_THE_SELLSWORD]              = { },
    [xi.ki.ATMA_OF_A_FUTURE_FABULOUS]          = { },
    [xi.ki.ATMA_OF_CAMARADERIE]                = { },
    [xi.ki.ATMA_OF_THE_TRUTHSEEKER]            = { },
    [xi.ki.ATMA_OF_THE_AZURE_SKY]              = { },
    [xi.ki.ATMA_OF_ECHOES]                     = { },
    [xi.ki.ATMA_OF_DREAD]                      = { },
    [xi.ki.ATMA_OF_AMBITION]                   = { }, -- Note: Speed modifier is the same as positive gear. Meaning, it doesnt stack.
    [xi.ki.ATMA_OF_THE_BEAST_KING]             = { },
    [xi.ki.ATMA_OF_THE_KIRIN]                  = { },
    [xi.ki.ATMA_OF_HELLS_GUARDIAN]             = { },
    [xi.ki.ATMA_OF_LUMINOUS_WINGS]             = { },
    [xi.ki.ATMA_OF_THE_DRAGON_RIDER]           = { },
    [xi.ki.ATMA_OF_THE_IMPENETRABLE]           = { },
    [xi.ki.ATMA_OF_ALPHA_AND_OMEGA]            = { },
    [xi.ki.ATMA_OF_THE_ULTIMATE]               = { },
    [xi.ki.ATMA_OF_THE_HYBRID_BEAST]           = { },
    [xi.ki.ATMA_OF_THE_DARK_DEPTHS]            = { },
    [xi.ki.ATMA_OF_THE_ZENITH]                 = { },
    [xi.ki.ATMA_OF_PERFECT_ATTENDANCE]         = { },
    [xi.ki.ATMA_OF_THE_RESCUER]                = { },
    [xi.ki.ATMA_OF_NIGHTMARES]                 = { },
    [xi.ki.ATMA_OF_THE_EINHERJAR]              = { },
    [xi.ki.ATMA_OF_THE_ILLUMINATOR]            = { },
    [xi.ki.ATMA_OF_THE_BUSHIN]                 = { },
    [xi.ki.ATMA_OF_THE_ACE_ANGLER]             = { },
    [xi.ki.ATMA_OF_THE_MASTER_CRAFTER]         = { }, -- Note: Speed modifier is the same as positive gear. Meaning, it doesnt stack
    [xi.ki.ATMA_OF_INGENUITY]                  = { },
    [xi.ki.ATMA_OF_THE_GRIFFONS_CLAW]          = { },
    [xi.ki.ATMA_OF_THE_FETCHING_FOOTPAD]       = { },
    [xi.ki.ATMA_OF_UNDYING_LOYALTY]            = { },
    [xi.ki.ATMA_OF_THE_ROYAL_LINEAGE]          = { },
    [xi.ki.ATMA_OF_THE_SHATTERING_STAR]        = { },
    [xi.ki.ATMA_OF_THE_COBRA_COMMANDER]        = { },
    [xi.ki.ATMA_OF_ROARING_LAUGHTER]           = { },
    [xi.ki.ATMA_OF_THE_DARK_BLADE]             = { },
    [xi.ki.ATMA_OF_THE_DUCAL_GUARD]            = { },
    [xi.ki.ATMA_OF_HARMONY]                    = { },
    [xi.ki.ATMA_OF_REVELATIONS]                = { },
    [xi.ki.ATMA_OF_THE_SAVIOR]                 = { },
}

local atmaPrice = 100

local function getSortedKeysFromArray(array, isReverse)
    local keys = {}

    for key, v in pairs(array) do
        table.insert(keys, key)
    end

    if isReverse then
        table.sort(keys, function(a, b)
            return a > b
        end)
    else
        table.sort(keys)
    end

    return keys
end

local function getIdByKeyItemId(keyitemId)
    local keys = getSortedKeysFromArray(xi.atma.atmaMods, false)
    for index, v in ipairs(keys) do
        if keyitemId == v then
            return index
        end
    end

    return nil
end

-- Group 1 Atma consists of 4 parameter values, followed by 2 parameter values for
-- Group 2.  Calculate these separately just in case there's future additions or changes.
-- There is minimal impact to efficiency, as we only iterate over each individual
-- key item once.  Depending on opinion, this could easily be combined into one loop
-- in the future; however, we would need to check for the offset to modify parameter
-- number in the array.  See: onTrigger function for handling in a single loop
local function getAtmaMask(player)
    local atmaMask = { 0, 0, 0, 0, 0, 0 }
    local atmaCount = xi.ki.ATMA_OF_THE_APOCALYPSE - xi.ki.ATMA_OF_THE_LION
    local atmaBase = xi.ki.ATMA_OF_THE_LION - 1
    for i = 1, atmaCount + 1 do
        if player:hasKeyItem(atmaBase + i) then
            local parameterNum = math.floor((i + 32) / 32)
            local atmaOffset = bit.lshift(1, (i - 1) % 32)

            atmaMask[parameterNum] = atmaMask[parameterNum] + atmaOffset
        end
    end

    atmaCount = xi.ki.ATMA_OF_THE_SAVIOR - xi.ki.ATMA_OF_THE_HEIR
    atmaBase = xi.ki.ATMA_OF_THE_HEIR - 1
    for i = 1, atmaCount + 1 do
        if player:hasKeyItem(atmaBase + i) then
            local parameterNum = math.floor((i + 32) / 32) + 4
            local atmaOffset = bit.lshift(1, (i - 1) % 32)

            atmaMask[parameterNum] = atmaMask[parameterNum] + atmaOffset
        end
    end

    return atmaMask
end

local function getFreeAtmaSlot(player)
    local lunarAbyssiteCount = xi.abyssea.getAbyssiteTotal(player, xi.abyssea.abyssiteType.LUNAR)

    for atmaSlot = 1, lunarAbyssiteCount do
        if not player:hasStatusEffect(xi.effect.ATMA, atmaSlot) then
            return atmaSlot
        end
    end

    return 0
end

local function hasDuplicateAtmaEffect(player, atmaValue)
    for atmaSlot = 1, 3 do
        local atmaEffect = player:getStatusEffect(xi.effect.ATMA, atmaSlot)

        if atmaEffect and atmaEffect:getPower() == atmaValue then
            return true
        end
    end

    return false
end

local function getAtmasFromMask(mask)
    local atmas =
    {
        bit.band(mask, 0xFF),
        bit.band(bit.rshift(mask, 8), 0xFF),
        bit.band(bit.rshift(mask, 16), 0xFF),
        bit.band(bit.rshift(mask, 24), 0xFF),
    }
    return atmas
end

local function updateReinfusedMask(player, atmaSlot, atmaValue)
    local baseMask = player:getCharVar('ABYSSEA_LAST_ATMA_INFUSED')
    local atmas = getAtmasFromMask(baseMask)
    local newMask = 0
    atmas[atmaSlot] = getIdByKeyItemId(atmaValue)

    if atmaSlot == 1 then
        atmas[2] = 0
        atmas[3] = 0
    end

    for key = 3, 1, -1 do
        newMask = bit.lshift(newMask, 8)

        local value = atmas[key]
        if value ~= 0 then
            newMask = newMask + value
        end
    end

    player:setCharVar('ABYSSEA_LAST_ATMA_INFUSED', newMask)
end

local function getHistoryAtmaArray(player)
    local atmaHistory = {}
    local atmasSaved =
    {
        [1] = getAtmasFromMask(player:getCharVar('ABYSSEA_HISTORY_ATMA1')),
        [2] = getAtmasFromMask(player:getCharVar('ABYSSEA_HISTORY_ATMA2')),
        [3] = getAtmasFromMask(player:getCharVar('ABYSSEA_HISTORY_ATMA3'))
    }
    for i = 1, 3 do
        for _, value in pairs(atmasSaved[i]) do
            table.insert(atmaHistory, value)
        end
    end

    return atmaHistory
end

local function updateHistoryMask(player, atmaValue)
    local currentAtma = getIdByKeyItemId(atmaValue)
    local atmaSaved = getHistoryAtmaArray(player)
    local histo =
    {
        currentAtma
    }

    for i = 1, 3 do
        for _, value in ipairs(atmaSaved) do
            if value ~= currentAtma then
                table.insert(histo, value)
            end
        end
    end

    local index = 1

    for i = 1, 9, 4 do
        local maskAtma = 0
        for j = 3, 0, -1 do
            local indexHisto = i + j
            maskAtma = bit.lshift(maskAtma, 8)
            maskAtma = maskAtma + histo[indexHisto]
        end

        player:setCharVar('ABYSSEA_HISTORY_ATMA'..index, maskAtma)
        index = index + 1
    end
end

local function getLunarAbyssiteMask(player)
    local lunarAbyssiteMask = 0
    local freeSlot = getFreeAtmaSlot(player)

    if freeSlot == 0 then
        return lunarAbyssiteMask
    end

    local lunarAbyssiteArray =
    {
        xi.ki.LUNAR_ABYSSITE1,
        xi.ki.LUNAR_ABYSSITE2,
        xi.ki.LUNAR_ABYSSITE3
    }

    for _, abyssite in ipairs(lunarAbyssiteArray) do
        if player:hasKeyItem(abyssite) then
            lunarAbyssiteMask = bit.lshift(lunarAbyssiteMask, 1) + 1
        end
    end

    return lunarAbyssiteMask
end

local function delAtma(player, slot)
    if player:hasStatusEffect(xi.effect.ATMA, slot) then
        player:delStatusEffect(xi.effect.ATMA, slot)
    end
end

local function delAllAtma(player)
    for atmaSlot = 3, 1, -1 do
        delAtma(player, atmaSlot)
    end
end

local function addAtma(player, selectedAtma)
    local keys = getSortedKeysFromArray(xi.atma.atmaMods, false)
    local atmaValue = keys[selectedAtma]
    local availableAtmaSlot = getFreeAtmaSlot(player)
    if
        availableAtmaSlot > 0 and
        not hasDuplicateAtmaEffect(player, atmaValue)
    then
        player:addStatusEffectEx(xi.effect.ATMA, xi.effect.ATMA, atmaValue, 0, 0, availableAtmaSlot)

        local atmaEffect = player:getStatusEffect(xi.effect.ATMA, availableAtmaSlot)
        atmaEffect:addEffectFlag(xi.effectFlag.ON_ZONE)
        atmaEffect:addEffectFlag(xi.effectFlag.INFLUENCE)
        updateReinfusedMask(player, availableAtmaSlot, atmaValue)
        updateHistoryMask(player, atmaValue)
        player:delCurrency('cruor', atmaPrice)
    end
end

xi.atma.onEffectGain = function(target, effect)
    local atma = effect:getPower()
    local mods = xi.atma.atmaMods[atma]
    if mods ~= nil then
        for i = 1, #mods, 2 do
            target:addMod(mods[i], mods[i + 1])
        end
    end
end

xi.atma.onEffectTick = function(target, effect)
    if not xi.abyssea.isInAbysseaZone(target) then
        target:delStatusEffect(effect)
    end
end

xi.atma.onEffectLose = function(target, effect)
    local atma = effect:getPower()
    local mods = xi.atma.atmaMods[atma]

    if mods ~= nil then
        for i = 1, #mods, 2 do
            target:delMod(mods[i], mods[i + 1])
        end
    end
end

xi.atma.onTrigger = function(player, npc)
    local atmaMask   = getAtmaMask(player)
    local activeAtmaMask = getLunarAbyssiteMask(player)
    local playerCruor = player:getCurrency('cruor')

    for atmaSlot = 3, 1, -1 do
        activeAtmaMask = bit.lshift(activeAtmaMask, 8)
        if player:hasStatusEffect(xi.effect.ATMA, atmaSlot) then

            local keyItemId = player:getStatusEffect(xi.effect.ATMA, atmaSlot):getPower()
            local keyItemIndex = getIdByKeyItemId(keyItemId)

            activeAtmaMask = activeAtmaMask + keyItemIndex
        end
    end

    player:startEvent(2003, playerCruor, activeAtmaMask, atmaMask[1], atmaMask[2], atmaMask[3], atmaMask[4], atmaMask[5], atmaMask[6])
end

xi.atma.onEventUpdate = function(player, csid, option, npc)
    local reinfuseAtma = 0
    local histo =
    {
        [1] = player:getCharVar('ABYSSEA_HISTORY_ATMA1'),
        [2] = player:getCharVar('ABYSSEA_HISTORY_ATMA2'),
        [3] = player:getCharVar('ABYSSEA_HISTORY_ATMA3')
    }

    if
        player:getCharVar('ABYSSEA_LAST_ATMA_INFUSED') ~= 0 and
        not player:hasStatusEffect(xi.effect.ATMA)
    then
        reinfuseAtma = player:getCharVar('ABYSSEA_LAST_ATMA_INFUSED')
    end

    player:updateEvent(reinfuseAtma, histo[1], histo[2], histo[3], 0, 0, 0, 0)
end

xi.atma.onEventFinish = function(player, csid, option, npc)
    local ID = zones[player:getZoneID()]

    local optionSelected = bit.band(option, 0xF)
    if
        optionSelected == 1
    then -- Infuse Atma
        local atma = bit.band(bit.rshift(option, 16), 0xFFFF)
        local orderKeyItem = getSortedKeysFromArray(xi.atma.atmaMods, false)
        player:messageSpecial(ID.text.ATMA_INFUSED, atmaPrice, orderKeyItem[atma])
        addAtma(player, atma)
    elseif optionSelected == 2 then -- Purge atma
        local slot = bit.band(bit.rshift(option, 16), 0xFF)
        if slot == 4 then -- Purge all atma
            player:messageSpecial(ID.text.ALL_ATMA_PURGED)
            delAllAtma(player)
        else
            local effectPower = player:getStatusEffect(xi.effect.ATMA, slot):getPower()
            player:messageSpecial(ID.text.ATMA_PURGED, effectPower)
            delAtma(player, slot)
        end
    elseif
        optionSelected == 3 and
        player:getCharVar('ABYSSEA_LAST_ATMA_INFUSED')
    then -- Reinfuse Atma
        local atmaReinfused = getAtmasFromMask(player:getCharVar('ABYSSEA_LAST_ATMA_INFUSED'))
        local numAtma = 0
        for i = 1, 3 do
            if atmaReinfused[i] ~= 0 then
                addAtma(player, atmaReinfused[i])
                numAtma = numAtma + 1
            end
        end

        player:messageSpecial(ID.text.PREVIOUS_ATMA_INFUSED, atmaPrice * numAtma)
    elseif
        optionSelected == 5
    then -- infuse history
        delAllAtma(player)
        local mask = bit.rshift(option, 17)
        local indexPos = { }
        for i = 1, 12 do
            local submask = bit.band(mask, 0x1)
            if submask == 1 then
                table.insert(indexPos, i)
            end

            mask = bit.rshift(mask, 1)
        end

        local histo = getHistoryAtmaArray(player)

        for _, index in ipairs(indexPos) do
            addAtma(player, histo[index])
        end

        player:messageSpecial(ID.text.HISTORY_ATMA_INFUSED, atmaPrice * #histo)
    end
end
