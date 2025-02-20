-----------------------------------
-- Area: Abyssea - Vunkerl
--  NPC: Cruor Prospector
-- Type: Cruor NPC
-----------------------------------
---@type TNpcEntity
local entity = {}

---@class itemEntry
---@field [xi.item] xi.item
---@field [integer] integer

---@class itemTypeTable
---@field [integer] itemEntry

---@class prospectorItems
---@field [xi.abyssea.itemType] itemTypeTable
local prospectorItems =
{
    [xi.abyssea.itemType.ITEM] =
    {
    --  Sel      Item                         Cost
        [ 1] = { xi.item.UNKAI_KABUTO,       5000 },
        [ 2] = { xi.item.IGA_ZUKIN,          5000 },
        [ 3] = { xi.item.LANCERS_MEZAIL,     5000 },
        [ 4] = { xi.item.CALLERS_HORN,       5000 },
        [ 5] = { xi.item.MAVI_KAVUK,         5000 },
        [ 6] = { xi.item.NAVARCHS_TRICORNE,  5000 },
        [ 7] = { xi.item.CIRQUE_CAPPELLO,    5000 },
        [ 8] = { xi.item.CHARIS_TIARA,       5000 },
        [ 9] = { xi.item.SAVANTS_BONNET,     5000 },
        [10] = { xi.item.FORBIDDEN_KEY,       500 },
        [11] = { xi.item.SHADOW_THRONE,   2000000 },
    },

    [xi.abyssea.itemType.TEMP] =
    {
    --  Sel      Item                               Cost
        [ 1] = { xi.item.LUCID_POTION_I,             80 },
        [ 2] = { xi.item.LUCID_ETHER_I,              80 },
        [ 3] = { xi.item.BOTTLE_OF_CATHOLICON,       80 },
        [ 4] = { xi.item.DUSTY_ELIXIR,              120 },
        [ 5] = { xi.item.TUBE_OF_CLEAR_SALVE_I,     120 },
        [ 6] = { xi.item.BOTTLE_OF_STALWARTS_TONIC, 150 },
        [ 7] = { xi.item.BOTTLE_OF_ASCETICS_TONIC,  150 },
        [ 8] = { xi.item.BOTTLE_OF_CHAMPIONS_TONIC, 150 },
        [ 9] = { xi.item.LUCID_POTION_II,           200 },
        [10] = { xi.item.LUCID_ETHER_II,            200 },
        [11] = { xi.item.LUCID_ELIXIR_I,            300 },
        [12] = { xi.item.FLASK_OF_HEALING_POWDER,   300 },
        [13] = { xi.item.PINCH_OF_MANA_POWDER,      300 },
        [14] = { xi.item.TUBE_OF_HEALING_SALVE_I,   300 },
        [15] = { xi.item.BOTTLE_OF_VICARS_DRINK,    300 },
        [16] = { xi.item.TUBE_OF_CLEAR_SALVE_II,    300 },
        [17] = { xi.item.PRIMEVAL_BREW,         2000000 },
    },

    [xi.abyssea.itemType.KEYITEM] =
    {
    --  Sel     Item                                 Cost
        [1] = { xi.ki.MAP_OF_ABYSSEA_VUNKERL,        4500 },
        [2] = { xi.ki.IVORY_ABYSSITE_OF_AVARICE,     8000 },
        [3] = { xi.ki.IVORY_ABYSSITE_OF_KISMET,      5000 },
        [4] = { xi.ki.LUNAR_ABYSSITE1,             100000 },
        [5] = { xi.ki.CLEAR_DEMILUNE_ABYSSITE,        300 },
    },
}

-- Each selection can contain multiple effects in the format of { abysseaEffect, actualEffect, Amt, keyItemRequired, bonusMultiplier }
-- and after that table, the cruor cost is defined.
local prospectorEnhancement =
{
    [6] =
    {
        {
            { xi.effect.ABYSSEA_HP, xi.effect.MAX_HP_BOOST, 20, xi.abyssea.abyssiteType.MERIT, 10 },
        },

        50,
    },

    [7] =
    {
        {
            { xi.effect.ABYSSEA_MP, xi.effect.MAX_MP_BOOST, 10, xi.abyssea.abyssiteType.MERIT, 5 },
        },

        120,
    },

    [8] =
    {
        {
            { xi.effect.ABYSSEA_STR, xi.effect.STR_BOOST, 10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
            { xi.effect.ABYSSEA_DEX, xi.effect.DEX_BOOST, 10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
        },

        120,
    },

    [9] =
    {
        {
            { xi.effect.ABYSSEA_VIT, xi.effect.VIT_BOOST, 10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
            { xi.effect.ABYSSEA_AGI, xi.effect.AGI_BOOST, 10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
        },

        100,
    },

    [10] =
    {
        {
            { xi.effect.ABYSSEA_INT, xi.effect.INT_BOOST, 10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
            { xi.effect.ABYSSEA_CHR, xi.effect.CHR_BOOST, 10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
            { xi.effect.ABYSSEA_MND, xi.effect.MND_BOOST, 10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
        },

        100,
    },

    [11] =
    {
        {
            { xi.effect.ABYSSEA_HP,  xi.effect.MAX_HP_BOOST, 20, xi.abyssea.abyssiteType.MERIT,       10 },
            { xi.effect.ABYSSEA_MP,  xi.effect.MAX_MP_BOOST, 10, xi.abyssea.abyssiteType.MERIT,        5 },
            { xi.effect.ABYSSEA_STR, xi.effect.STR_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
            { xi.effect.ABYSSEA_DEX, xi.effect.DEX_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
            { xi.effect.ABYSSEA_VIT, xi.effect.VIT_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
            { xi.effect.ABYSSEA_AGI, xi.effect.AGI_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
            { xi.effect.ABYSSEA_INT, xi.effect.INT_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
            { xi.effect.ABYSSEA_CHR, xi.effect.CHR_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
            { xi.effect.ABYSSEA_MND, xi.effect.MND_BOOST,    10, xi.abyssea.abyssiteType.FURTHERANCE, 10 },
        },

        470,
    },
}

entity.onTrigger = function(player, npc)
    local cruor = player:getCurrency('cruor')
    local demilune = xi.abyssea.getDemiluneAbyssite(player)

    player:startEvent(2002, cruor, demilune)
end

entity.onEventFinish = function(player, csid, option, npc)
    local itemCategory = bit.band(option, 0x07)
    local itemSelected = bit.band(bit.rshift(option, 16), 0x1F)
    local cruorTotal = player:getCurrency('cruor')

    if itemCategory == xi.abyssea.itemType.ITEM then
        local itemData = prospectorItems[itemCategory][itemSelected]
        local itemQty = itemData[1] ~= xi.item.FORBIDDEN_KEY and 1 or bit.rshift(option, 24)
        local itemCost = itemData[2] * itemQty

        if
            itemCost <= cruorTotal and
            npcUtil.giveItem(player, { { itemData[1], itemQty } })
        then
            player:delCurrency('cruor', itemCost)
        end
    elseif itemCategory == xi.abyssea.itemType.TEMP then
        local itemData = prospectorItems[itemCategory][itemSelected]
        local itemCost = itemData[2]

        if
            itemCost <= cruorTotal and
            npcUtil.giveTempItem(player, { { itemData[1], 1 } })
        then
            player:delCurrency('cruor', itemCost)
        end
    elseif itemCategory == xi.abyssea.itemType.KEYITEM then
        local itemData = prospectorItems[itemCategory][itemSelected]

        if
            itemData[2] <= cruorTotal and
            npcUtil.giveKeyItem(player, itemData[1])
        then
            player:delCurrency('cruor', itemData[2])
        end
    elseif itemCategory == xi.abyssea.itemType.ENHANCEMENT then
        local enhanceData = prospectorEnhancement[itemSelected]

        if enhanceData[2] <= cruorTotal then
            for _, v in ipairs(enhanceData[1]) do
                player:addStatusEffectEx(v[1], v[2], v[3] + xi.abyssea.getAbyssiteTotal(player, v[4]) * v[5], 0, 0)

                if v[1] == xi.effect.ABYSSEA_HP then
                    player:addHP(v[3] + xi.abyssea.getAbyssiteTotal(player, v[4]) * v[5])
                elseif v[1] == xi.effect.ABYSSEA_MP then
                    player:addMP(v[3] + xi.abyssea.getAbyssiteTotal(player, v[4]) * v[5])
                end
            end

            player:delCurrency('cruor', enhanceData[2])
        end
    end
end

return entity
