-----------------------------------
-- Area: Abyssea - La Theine
--  NPC: Cruor Prospector
-- Type: Cruor NPC
-----------------------------------
require("scripts/globals/abyssea")
require("scripts/globals/keyitems")
require("scripts/globals/status")
-----------------------------------
local entity = {}

local itemType =
{
    ITEM        = 1,
    TEMP        = 2,
    KEYITEM     = 3,
    ENHANCEMENT = 4,
}

local prospectorItems =
{
    [itemType.ITEM] =
    {-- Sel      Item                         Cost,  Qty
        [ 1] = { xi.items.PERLE_SALADE,       4000,  1 },
        [ 2] = { xi.items.PERLE_HAUBERK,      5000,  1 },
        [ 3] = { xi.items.PERLE_MOUFLES,      3000,  1 },
        [ 4] = { xi.items.PERLE_BRAYETTES,    3000,  1 },
        [ 5] = { xi.items.PERLE_SOLLERETS,    3000,  1 },
        [ 6] = { xi.items.AURORE_BERET,       4000,  1 },
        [ 7] = { xi.items.AURORE_DOUBLET,     5000,  1 },
        [ 8] = { xi.items.AURORE_GLOVES,      3000,  1 },
        [ 9] = { xi.items.AURORE_BRAIS,       3000,  1 },
        [10] = { xi.items.AURORE_GAITERS,     3000,  1 },
        [11] = { xi.items.TEAL_CHAPEAU,       4000,  1 },
        [12] = { xi.items.TEAL_SAIO,          5000,  1 },
        [13] = { xi.items.TEAL_CUFFS,         3000,  1 },
        [14] = { xi.items.TEAL_SLOPS,         3000,  1 },
        [15] = { xi.items.TEAL_PIGACHES,      3000,  1 },
        [16] = { xi.items.FORBIDDEN_KEY,       500,  1 },
        [17] = { xi.items.FORBIDDEN_KEY,       500,  5 },
        [18] = { xi.items.FORBIDDEN_KEY,       500, 10 },
        [19] = { xi.items.FORBIDDEN_KEY,       500, 30 },
        [20] = { xi.items.FORBIDDEN_KEY,       500, 50 },
        [21] = { xi.items.SHADOW_THRONE,   2000000,  1 },
    },

    [itemType.TEMP] =
    {-- Sel      Item                         Cost, Qty
        [ 1] = { xi.items.LUCID_POTION_I,       80, 1 },
        [ 2] = { xi.items.LUCID_ETHER_I,        80, 1 },
        [ 3] = { xi.items.CATHOLICON,           80, 1 },
        [ 4] = { xi.items.DUSTY_ELIXIR,        120, 1 },
        [ 5] = { xi.items.CLEAR_SALVE_I,       120, 1 },
        [ 6] = { xi.items.STALWARTS_TONIC,     150, 1 },
        [ 7] = { xi.items.ASCETICS_TONIC,      150, 1 },
        [ 8] = { xi.items.CHAMPIONS_TONIC,     150, 1 },
        [ 9] = { xi.items.LUCID_POTION_II,     200, 1 },
        [10] = { xi.items.LUCID_ETHER_II,      200, 1 },
        [11] = { xi.items.LUCID_ELIXIR_I,      300, 1 },
        [12] = { xi.items.HEALING_POWDER,      300, 1 },
        [13] = { xi.items.MANA_POWDER,         300, 1 },
        [14] = { xi.items.HEALING_SALVE_I,     300, 1 },
        [15] = { xi.items.VICARS_DRINK,        300, 1 },
        [16] = { xi.items.CLEAR_SALVE_II,      300, 1 },
        [17] = { xi.items.PRIMEVAL_BREW,   2000000, 1 },
    },

    [itemType.KEYITEM] =
    {-- Sel     Item                                Cost
        [1] = { xi.ki.MAP_OF_ABYSSEA_LA_THEINE,     3500 },
        [2] = { xi.ki.IVORY_ABYSSITE_OF_SOJOURN,    6000 },
        [3] = { xi.ki.IVORY_ABYSSITE_OF_CONFLUENCE, 4800 },
        [4] = { xi.ki.IVORY_ABYSSITE_OF_EXPERTISE,  4800 },
        [5] = { xi.ki.CLEAR_DEMILUNE_ABYSSITE,       300 },
    },

    [itemType.ENHANCEMENT] =
    {-- Sel          Effect (Abyssea)       Actual Effect          Amt, KeyItem for Bonus,           Bonus Mult      Cost
        [ 6] = { { { xi.effect.ABYSSEA_HP,  xi.effect.MAX_HP_BOOST, 20, xi.abyssea.abyssiteType.MERIT,       10 }, },  50 },
        [ 7] = { { { xi.effect.ABYSSEA_MP,  xi.effect.MAX_MP_BOOST, 10, xi.abyssea.abyssiteType.MERIT,        5 }, }, 120 },
        [ 8] = { { { xi.effect.ABYSSEA_STR, xi.effect.STR_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
                   { xi.effect.ABYSSEA_DEX, xi.effect.DEX_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 }, }, 120 },
        [ 9] = { { { xi.effect.ABYSSEA_VIT, xi.effect.VIT_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
                   { xi.effect.ABYSSEA_AGI, xi.effect.AGI_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 }, }, 100 },
        [10] = { { { xi.effect.ABYSSEA_INT, xi.effect.INT_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
                   { xi.effect.ABYSSEA_CHR, xi.effect.CHR_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
                   { xi.effect.ABYSSEA_MND, xi.effect.MND_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 }, }, 100 },
        [11] = { { { xi.effect.ABYSSEA_HP,  xi.effect.MAX_HP_BOOST, 20, xi.abyssea.abyssiteType.MERIT,       10 },
                   { xi.effect.ABYSSEA_MP,  xi.effect.MAX_MP_BOOST, 10, xi.abyssea.abyssiteType.MERIT,        5 },
                   { xi.effect.ABYSSEA_STR, xi.effect.STR_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
                   { xi.effect.ABYSSEA_DEX, xi.effect.DEX_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
                   { xi.effect.ABYSSEA_VIT, xi.effect.VIT_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
                   { xi.effect.ABYSSEA_AGI, xi.effect.AGI_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
                   { xi.effect.ABYSSEA_INT, xi.effect.INT_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
                   { xi.effect.ABYSSEA_CHR, xi.effect.CHR_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
                   { xi.effect.ABYSSEA_MND, xi.effect.MND_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 }, }, 470 },
    },
}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local cruor = player:getCurrency("cruor")
    local demilune = xi.abyssea.getDemiluneAbyssite(player)

    player:startEvent(2002, cruor, demilune)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local itemCategory = bit.band(option, 0x07)
    local itemSelected = bit.rshift(option, 16)
    local cruorTotal = player:getCurrency("cruor")

    if itemCategory == itemType.ITEM then
        local itemData = prospectorItems[itemCategory][itemSelected]
        local itemCost = itemData[2] * itemData[3]

        if
            itemCost <= cruorTotal and
            npcUtil.giveItem(player, {{ itemData[1], itemData[3] }})
        then
            player:delCurrency("cruor", itemCost)
        end
    elseif itemCategory == itemType.TEMP then
        local itemData = prospectorItems[itemCategory][itemSelected]
        local itemCost = itemData[2] * itemData[3]

        if
            itemCost <= cruorTotal and
            npcUtil.giveTempItem(player, {{ itemData[1], itemData[3] }})
        then
            player:delCurrency("cruor", itemCost)
        end
    elseif itemCategory == itemType.KEYITEM then
        local itemData = prospectorItems[itemCategory][itemSelected]

        if
            itemData[2] <= cruorTotal and
            npcUtil.giveKeyItem(player, itemData[1])
        then
            player:delCurrency("cruor", itemData[2])
        end
    elseif itemCategory == itemType.ENHANCEMENT then
        local enhanceData = prospectorItems[itemCategory][itemSelected]

        if enhanceData <= cruorTotal then
            for _, v in ipairs(enhanceData[1]) do
                player:addStatusEffectEx(v[1], v[2], v[3] + xi.abyssea.getAbyssiteTotal(player, v[4]) * v[5])

                if v[1] == xi.effect.ABYSSEA_HP then
                    player:addHP(v[3] + xi.abyssea.getAbyssiteTotal(player, v[4]) * v[5])
                elseif v[1] == xi.effect.ABYSSEA_MP then
                    player:addMP(v[3] + xi.abyssea.getAbyssiteTotal(player, v[4]) * v[5])
                end
            end

            player:delCurrency("cruor", enhanceData[2])
        end
    end
end

return entity
