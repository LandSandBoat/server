-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Pogigi
-- !pos -29.787 -4.499 42.603 94
-- Sealed Container NPC
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local itemID = trade:getItemId()
    local itemKeyItemMapping =
    {
        [xi.item.BAMBOO_GRASS_BASKET] = xi.ki.HABALOS_ECLOGUE_VERSE_I,
        [xi.item.BAMBOO_MEDICINE_BASKET] = xi.ki.HABALOS_ECLOGUE_VERSE_II,
        [xi.item.BAMBOO_BUGCAGE] = xi.ki.HABALOS_ECLOGUE_VERSE_III,
        [xi.item.BAMBOO_FLOWER_BASKET] = xi.ki.HABALOS_ECLOGUE_VERSE_IV,
        [xi.item.BAMBOO_BIRDCAGE] = xi.ki.HABALOS_ECLOGUE_VERSE_V,
        [xi.item.BAMBOO_CHARCOAL_BASKET] = xi.ki.HABALOS_ECLOGUE_VERSE_VI,
        [xi.item.BAMBOO_TEA_BASKET] = xi.ki.HABALOS_ECLOGUE_VERSE_VII,
        [xi.item.BAMBOO_SNAKECAGE] = xi.ki.HABALOS_ECLOGUE_VERSE_VIII
    }
    -- Make sure we're only trading 1 Basket at a time.
    if
        npcUtil.tradeHasExactly(trade, itemID) and
        itemKeyItemMapping[itemID]
    then
        player:tradeComplete()
        local keyItem = itemKeyItemMapping[itemID]
        npc:showText(npc, ID.text.POGIGI_TURN_IN)
        npcUtil.giveKeyItem(player, keyItem)
    end
end

return entity
