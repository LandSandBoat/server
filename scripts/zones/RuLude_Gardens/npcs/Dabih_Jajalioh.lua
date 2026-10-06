-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Dabih Jajalioh
-- !pos -64.733 12.002 -34.728 243
-----------------------------------
require('scripts/globals/kid_mithra_shop')
-----------------------------------
---@type TNpcEntity
local entity = {}

-- Limits from the Final Fantasy XI Guild Masters Guide Ver.101207.
local levelUpSales = { 10000, 20000, 30000 }

local greetings =
{
    zones[xi.zone.RULUDE_GARDENS].text.DABIHJAJALIOH_SHOP_DIALOG1,
    zones[xi.zone.RULUDE_GARDENS].text.DABIHJAJALIOH_SHOP_DIALOG2,
    zones[xi.zone.RULUDE_GARDENS].text.DABIHJAJALIOH_SHOP_DIALOG3,
    zones[xi.zone.RULUDE_GARDENS].text.DABIHJAJALIOH_SHOP_DIALOG4,
}

local flowers =
{
    { xi.item.CHAMOMILE,  130 },
    { xi.item.WIJNRUIT,   120 },
    { xi.item.CARNATION,   60 },
    { xi.item.RED_ROSE,    80 },
    { xi.item.RAIN_LILY,   96 },
}

local lowLevelFlowers =
{
    { xi.item.LILAC,      120 },
    { xi.item.AMARYLLIS,  120 },
    { xi.item.MARGUERITE, 120 },
}

local extraStock =
{
    [2] =
    {
        { xi.item.OGRE_PUMPKIN,              96 },
        { xi.item.CHOCOBO_EGG_FAINTLY_WARM, 1040 },
    },
    [3] =
    {
        { xi.item.GOBLIN_DOLL,                490 },
        { xi.item.KOMA,                       210 },
        { xi.item.PINCH_OF_TWINKLE_POWDER,    375 },
        { xi.item.CHOCOBO_EGG_SLIGHTLY_WARM, 1040 },
    },
    [4] =
    {
        { xi.item.BAG_OF_FRUIT_SEEDS,        900 },
        { xi.item.LACQUER_TREE_LOG,        50000 },
        { xi.item.LIBATION_ABJURATION,    250000 },
        { xi.item.SCROLL_OF_RERAISE_III,  500000 },
        { xi.item.CHOCOBO_EGG_A_BIT_WARM,   1040 },
    },
}

entity.onTrigger = function(player, npc)
    local level = xi.kidMithraShop.settle('[Dabih]', levelUpSales, 0)
    local stock = {}

    for _, entry in ipairs(flowers) do
        table.insert(stock, entry)
    end

    if level < 4 then
        for _, entry in ipairs(lowLevelFlowers) do
            table.insert(stock, entry)
        end
    end

    for stockLevel = 2, level do
        for _, entry in ipairs(extraStock[stockLevel]) do
            table.insert(stock, entry)
        end
    end

    player:showText(npc, greetings[level])
    xi.shop.general(player, stock, xi.fameArea.JEUNO)
end

entity.onShopBuy = function(player, npc, itemId, quantity, gil)
    local _, rose = xi.kidMithraShop.settle('[Dabih]', levelUpSales, gil)
    if rose then
        player:showText(npc, zones[xi.zone.RULUDE_GARDENS].text.DABIHJAJALIOH_NEW_SHIPMENT)
    end
end

return entity
