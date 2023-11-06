-----------------------------------
-- Campaign Global
-----------------------------------
xi = xi or {}
xi.campaign = {}

xi.campaign.control =
{
    SANDORIA = 2,
    BASTOK   = 4,
    WINDURST = 6,
    BEASTMEN = 8,
}

xi.campaign.union =
{
    ADDER  = 1,
    BISON  = 2,
    COYOTE = 3,
    DHOLE  = 4,
    ELAND  = 5,
}

xi.campaign.army =
{
    SANDORIA = 0,
    BASTOK   = 1,
    WINDURST = 2,
    ORCISH   = 3,
    QUADAV   = 4,
    YAGUDO   = 5,
    KINDRED  = 6,
}

-- First nibble: 2, Second Nibble: Page, rshift 8: entry
local noteRewardItems =
{
    [xi.zone.SOUTHERN_SAN_DORIA_S] =
    {
        [0] = -- Common
        {
            -- BitPos = { itemId, basePrice (allied), isAdjusted },
            [0] = { xi.item.SPRINTERS_SHOES,                  980, false },
            [1] = { xi.item.SCROLL_OF_INSTANT_RETRACE,         10, false },
            [2] = { xi.item.IRON_RAM_JACK_COAT,              1000, true  },
            [3] = { xi.item.PILGRIM_TUNICA,                  1000, true  },
            [4] = { xi.item.IRON_RAM_SHIELD,                 3000, true  },
            [5] = { xi.item.RECALL_RING_JUGNER,              5000, false },
            [6] = { xi.item.RECALL_RING_PASHHOW,             5000, false },
            [7] = { xi.item.RECALL_RING_MERIPHATAUD,         5000, false },
            [8] = { xi.item.CIPHER_OF_VALAINERALS_ALTER_EGO, 2000, false },
            [9] = { xi.item.CIPHER_OF_ADELHEIDS_ALTER_EGO,   2000, false },
        },

        [1] = -- Stars of Service
        {
            [0] = { xi.item.IRON_RAM_CHAINMAIL, 10000, true },
            [1] = { xi.item.IRON_RAM_MUFFLERS,   7000, true },
            [2] = { xi.item.IRON_RAM_SOLLERETS,  7000, true },
            [3] = { xi.item.IRON_RAM_HELM,       7000, true },
            [4] = { xi.item.IRON_RAM_BREECHES,   7000, true },
        },

        [2] = -- Emblems of Service
        {
            [0] = { xi.item.IRON_RAM_HORN,     20000, true },
            [1] = { xi.item.IRON_RAM_LANCE,    20000, true },
            [2] = { xi.item.IRON_RAM_PICK,     20000, true },
            [3] = { xi.item.IRON_RAM_SALLET,   40000, true },
            [4] = { xi.item.IRON_RAM_DASTANAS, 40000, true },
        },

        [3] = -- Wings of Service
        {
            [0] = { xi.item.IRON_RAM_GREAVES, 50000, true },
            [1] = { xi.item.IRON_RAM_HOSE,    50000, true },
        },

        [4] = -- Medals of Service
        {
            [0] = { xi.item.PATRONUS_RING,      30000, true },
            [1] = { xi.item.FOX_EARRING,        30000, true },
            [2] = { xi.item.TEMPLE_EARRING,     30000, true },
            [3] = { xi.item.CRIMSON_BELT,       30000, true },
            [4] = { xi.item.ROSE_STRAP,         30000, true },
            [5] = { xi.item.IRON_RAM_HAUBERK,   75000, true },
            [6] = { xi.item.ROYAL_GUARD_LIVERY, 10000, true },
            [7] = { xi.item.ALLIED_RING,        15000, true },
        },

        [5] = -- Medals of Altana
        {
            [0] = { xi.item.GRIFFINCLAW,             100000, true },
            [1] = { xi.item.ROYAL_KNIGHT_SIGIL_RING,  50000, true },
        },
    },

    [xi.zone.BASTOK_MARKETS_S] =
    {
        [0] = -- Common
        {
            [0] = { xi.item.SPRINTERS_SHOES,                  980, false },
            [1] = { xi.item.SCROLL_OF_INSTANT_RETRACE,         10, false },
            [2] = { xi.item.FOURTH_DIVISION_TUNICA,          1000, true  },
            [3] = { xi.item.PILGRIM_TUNICA,                  1000, true  },
            [4] = { xi.item.FOURTH_DIVISION_GUN,             3000, true  },
            [5] = { xi.item.RECALL_RING_JUGNER,              5000, false },
            [6] = { xi.item.RECALL_RING_PASHHOW,             5000, false },
            [7] = { xi.item.RECALL_RING_MERIPHATAUD,         5000, false },
            [8] = { xi.item.CIPHER_OF_VALAINERALS_ALTER_EGO, 2000, false },
            [9] = { xi.item.CIPHER_OF_ADELHEIDS_ALTER_EGO,   2000, false },
        },

        [1] = -- Stars of Service
        {
            [0] = { xi.item.FOURTH_DIVISION_CUIRASS,   10000, true },
            [1] = { xi.item.FOURTH_DIVISION_GAUNTLETS,  7000, true },
            [2] = { xi.item.FOURTH_DIVISION_SABATONS,   7000, true },
            [3] = { xi.item.FOURTH_DIVISION_ARMET,      7000, true },
            [4] = { xi.item.FOURTH_DIVISION_CUISSES,    7000, true },
        },

        [2] = -- Emblems of Service
        {
            [0] = { xi.item.FOURTH_DIVISION_TOPOROK, 20000, true },
            [1] = { xi.item.FOURTH_DIVISION_MACE,    20000, true },
            [2] = { xi.item.FOURTH_DIVISION_ZAGHNAL, 20000, true },
            [3] = { xi.item.FOURTH_DIVISION_HAUBE,   40000, true },
            [4] = { xi.item.FOURTH_DIVISION_HENTZES, 40000, true },
        },

        [3] = -- Wings of Service
        {
            [0] = { xi.item.FOURTH_DIVISION_SCHUHS, 50000, true },
            [1] = { xi.item.FOURTH_DIVISION_SCHOSS, 50000, true },
        },

        [4] = -- Medals of Service
        {
            [0] = { xi.item.SHIELD_COLLAR,            30000, true },
            [1] = { xi.item.STURMS_REPORT,            30000, true },
            [2] = { xi.item.SONIAS_PLECTRUM,          30000, true },
            [3] = { xi.item.BULL_NECKLACE,            30000, true },
            [4] = { xi.item.ARRESTOR_MANTLE,          30000, true },
            [5] = { xi.item.FOURTH_DIVISION_BRUNNE,   75000, true },
            [6] = { xi.item.MYTHRIL_MUSKETEER_LIVERY, 10000, true },
            [7] = { xi.item.ALLIED_RING,              15000, true },
        },

        [5] = -- Medals of Altana
        {
            [0] = { xi.item.LEX_TALIONIS,           100000, true },
            [1] = { xi.item.FOURTH_DIVISION_MANTLE,  50000, true },
        },
    },

    [xi.zone.WINDURST_WATERS_S] =
    {
        [0] = -- Common
        {
            [0] = { xi.item.SPRINTERS_SHOES,                  980, false },
            [1] = { xi.item.SCROLL_OF_INSTANT_RETRACE,         10, false },
            [2] = { xi.item.COBRA_UNIT_TUNICA,               1000, true  },
            [3] = { xi.item.PILGRIM_TUNICA,                  1000, true  },
            [4] = { xi.item.COBRA_UNIT_CLAYMORE,             3000, true  },
            [5] = { xi.item.RECALL_RING_JUGNER,              5000, false },
            [6] = { xi.item.RECALL_RING_PASHHOW,             5000, false },
            [7] = { xi.item.RECALL_RING_MERIPHATAUD,         5000, false },
            [8] = { xi.item.CIPHER_OF_VALAINERALS_ALTER_EGO, 2000, false },
            [9] = { xi.item.CIPHER_OF_ADELHEIDS_ALTER_EGO,   2000, false },
        },

        [1] = -- Stars of Service
        {
            [0] = { xi.item.COBRA_UNIT_COAT,    10000, true },
            [1] = { xi.item.COBRA_UNIT_CUFFS,    7000, true },
            [2] = { xi.item.COBRA_UNIT_PIGACHES, 7000, true },
            [3] = { xi.item.COBRA_UNIT_HAT,      7000, true },
            [4] = { xi.item.COBRA_UNIT_SLOPS,    7000, true },
        },

        [2] = -- Emblems of Service
        {
            [0] = { xi.item.COBRA_UNIT_BAGHNAKHS, 20000, true },
            [1] = { xi.item.COBRA_UNIT_KNIFE,     20000, true },
            [2] = { xi.item.COBRA_UNIT_BOW,       20000, true },
            [3] = { xi.item.COBRA_UNIT_CAP,       40000, true },
            [4] = { xi.item.COBRA_UNIT_MITTENS,   40000, true },
            [5] = { xi.item.COBRA_UNIT_CLOCHE,    40000, true },
            [6] = { xi.item.COBRA_UNIT_GLOVES,    40000, true },
        },

        [3] = -- Wings of Service
        {
            [0] = { xi.item.COBRA_UNIT_LEGGINGS, 50000, true },
            [1] = { xi.item.COBRA_UNIT_SUBLIGAR, 50000, true },
            [2] = { xi.item.COBRA_UNIT_CRACKOWS, 50000, true },
            [3] = { xi.item.COBRA_UNIT_TREWS,    50000, true },
        },

        [4] = -- Medals of Service
        {
            [0] = { xi.item.CAPRICORNIAN_ROPE,  30000, true },
            [1] = { xi.item.EARTHY_BELT,        30000, true },
            [2] = { xi.item.COUGAR_PENDANT,     30000, true },
            [3] = { xi.item.CROCODILE_COLLAR,   30000, true },
            [4] = { xi.item.ARIESIAN_GRIP,      30000, true },
            [5] = { xi.item.COBRA_UNIT_HARNESS, 75000, true },
            [6] = { xi.item.COBRA_UNIT_ROBE,    75000, true },
            [7] = { xi.item.ALLIED_RING,        15000, true }
        },

        [5] = -- Medals of Altana
        {
            [0] = { xi.item.SAMUDRA,               100000, true },
            [1] = { xi.item.MERCENARY_MAJOR_CHARM,  50000, true },
        },
    },
}

local sigilNpcInfo =
{
    [xi.zone.BASTOK_MARKETS_S    ] = {  13, 2 }, -- !pos -248.5 0 81.2 87
    [xi.zone.SOUTHERN_SAN_DORIA_S] = { 110, 1 }, -- !pos 107 1 -31 80
    [xi.zone.WINDURST_WATERS_S   ] = {  13, 3 }, -- !pos -31.869 -6.009 226.793 94
}

-- There appears to be no mathematical correlation between combination of effects and their
-- cost.  Each index in the table represents the bitmask value, and corresponding cost.
local bonusEffectCosts =
{
    [ 1] = 50,
    [ 2] = 50,
    [ 3] = 100,
    [ 4] = 50,
    [ 5] = 100,
    [ 6] = 100,
    [ 7] = 150,
    [ 8] = 100,
    [ 9] = 150,
    [10] = 150,
    [11] = 150,
    [12] = 100,
    [13] = 150,
    [14] = 150,
    [15] = 200,
}

-- Returns the Vanadiel time in which Sigil will expire or 0
local function getSigilTimeStamp(player)
    local sigilTimestamp = VanadielTime()
    local sigilEffect    = player:getStatusEffect(xi.effect.SIGIL)

    if sigilEffect then
        sigilTimestamp = sigilTimestamp + sigilEffect:getTimeRemaining() / 1000
    end

    return sigilTimestamp
end

local function getSigilRankMask(player)
    local rankMask = 0

    -- Rank Category is separated into five groups, each with four KIs and represented as bits 0..4 in
    -- the mask.
    for keyItemId = xi.ki.BRONZE_RIBBON_OF_SERVICE, xi.ki.MEDAL_OF_ALTANA do
        if player:hasKeyItem(keyItemId) then
            utils.mask.setBit(rankMask, math.floor(keyItemId - xi.ki.BRONZE_RIBBON_OF_SERVICE) / 4, true)
        else
            break
        end
    end

    -- TODO: If the nation in question (based on zone) controls Throne Room (S), then set bit 5 to allow
    -- for purchase of Allied Ring.

    return rankMask
end

local function getSigilMenuOptions(player)
    -- Bit Values:
    -- 0: Medal Expired (1 = Expired)
    -- 1: Sigil state (1 = No Sigil Active)
    -- 2: Valaineral Available (1 = Available)
    -- 3: Adelheid Available (1 = Available)

    local optionMask = xi.extravaganza.campaignActive() * 4

    if not player:hasStatusEffect(xi.effect.SIGIL) then
        optionMask = utils.mask.setBit(optionMask, 1, true)
    end

    -- TODO: Hangle Campaign Medal Active/Expired when implemented

    return optionMask
end

-- TODO: Is this deprecated by the mask function?
xi.campaign.getMedalRank = function(player)
    local rank = 0

    for keyItemId = xi.ki.BRONZE_RIBBON_OF_SERVICE, xi.ki.MEDAL_OF_ALTANA do
        if player:hasKeyItem(keyItemId) then
            rank = rank + 1
        else
            break
        end
    end

    return rank
end

-- Sigil NPC
xi.campaign.sigilOnTrigger = function(player, npc)
    local baseEvent     = sigilNpcInfo[player:getZoneID()][1]
    local freelanceMask = 0

    -- TODO: Update freelanceMask on implementation.  Bit 0 is required
    -- to be true to allow for Reduced XP Loss

    if xi.campaign.getMedalRank(player) == 0 then
        player:startEvent(baseEvent + 1)
    else
        player:startEvent(baseEvent,
            player:getCampaignAllegiance(),
            player:getCurrency('allied_notes'),
            freelanceMask,
            getSigilMenuOptions(player),
            getSigilRankMask(player),
            0,
            getSigilTimeStamp(player),
            0
        )
    end
end

xi.campaign.sigilOnEventUpdate = function(player, csid, option, npc)
    local optionType   = bit.band(option, 0xF)

    if
        csid == 13 and
        optionType == 2
    then
        local itemPage     = bit.band(bit.rshift(option, 4), 0xF)
        local selectedItem = bit.rshift(option, 8)
        local itemInfo     = noteRewardItems[player:getZoneID()][itemPage][selectedItem]
        local canEquip     = 2

        -- canEquip Values:
        -- 0: Incorrect Job
        -- 1: Incorrect Level
        -- 2: Everything is in order
        -- 3: (Or Greater) exits the menu

        -- NOTE: There are some items that are not equipment, and checking reqLvl will
        -- return 0 for non-equippable items.  There are two canEquipItem calls to simplify
        -- needing to check types.  The first checks job requirement only, followed by
        -- job requirement _and_ level so that the appropriate message is displayed.

        if GetItemByID(itemInfo[1]):getReqLvl() > 0 then
            if not player:canEquipItem(itemInfo[1]) then
                canEquip = 0
            elseif not player:canEquipItem(itemInfo[1], true) then
                canEquip = 1
            end
        end

        player:updateEvent(0, 0, 0, 0, 0, 0, 0, canEquip)
    end
end

xi.campaign.sigilOnEventFinish = function(player, csid, option, npc)
    local zoneId = player:getZoneID()

    if
        option ~= utils.EVENT_CANCELLED_OPTION and
        csid == sigilNpcInfo[zoneId][1]
    then
        local optionType = bit.band(option, 0xF)

        if optionType == 1 then
            local selectedEffects = bit.rshift(option, 16)
            local bonusCost       = bonusEffectCosts[selectedEffects] and bonusEffectCosts[selectedEffects] or 0
            local duration        = 10800 + ((15 * xi.campaign.getMedalRank(player)) * 60) -- 3hrs +15 min per medal (minimum 3hr 15 min with 1st medal)
            local subPower        = 35 -- Sets % trigger for regen/refresh. Static at minimum value (35%) for now.
            -- Selected Effect Mask:
            -- 0: Regen
            -- 1: Refresh
            -- 2: Meal Duration
            -- 3: EXP Loss Reduction

            player:delStatusEffectsByFlag(xi.effectFlag.INFLUENCE, true)
            player:addStatusEffect(xi.effect.SIGIL, selectedEffects, 0, duration, 0, subPower, 0)
            player:messageSpecial(zones[zoneId].text.ALLIED_SIGIL)

            if bonusCost > 0 then
                player:delCurrency('allied_notes', bonusCost)
            end

        elseif optionType == 2 then
            local itemPage     = bit.band(bit.rshift(option, 4), 0xF)
            local selectedItem = bit.rshift(option, 8)
            local itemInfo     = noteRewardItems[zoneId][itemPage][selectedItem]

            if npcUtil.giveItem(player, itemInfo[1]) then
                local itemPrice = itemInfo[2]

                if
                    itemInfo[3] and
                    player:getCampaignAllegiance() ~= sigilNpcInfo[zoneId][2]
                then
                    itemPrice = itemPrice * 1.5
                end

                player:delCurrency('allied_notes', itemPrice)
            end
        end
    end
end
