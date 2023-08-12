-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Pogigi
-- !pos -29.787 -4.499 42.603 94
-- Sealed Container NPC
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters_[S]/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local itemID = trade:getItemId()
    local itemKeyItemMapping =
    {
        [xi.items.BAMBOO_GRASS_BASKET] = xi.ki.HABALOS_ECLOGUE_VERSE_I,
        [xi.items.BAMBOO_MEDICINE_BASKET] = xi.ki.HABALOS_ECLOGUE_VERSE_II,
        [xi.items.BAMBOO_BUGCAGE] = xi.ki.HABALOS_ECLOGUE_VERSE_III,
        [xi.items.BAMBOO_FLOWER_BASKET] = xi.ki.HABALOS_ECLOGUE_VERSE_IV,
        [xi.items.BAMBOO_BIRDCAGE] = xi.ki.HABALOS_ECLOGUE_VERSE_V,
        [xi.items.BAMBOO_CHARCOAL_BASKET] = xi.ki.HABALOS_ECLOGUE_VERSE_VI,
        [xi.items.BAMBOO_TEA_BASKET] = xi.ki.HABALOS_ECLOGUE_VERSE_VII,
        [xi.items.BAMBOO_SNAKECAGE] = xi.ki.HABALOS_ECLOGUE_VERSE_VIII
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

entity.onTrigger = function(player, npc)
    player:startEvent(330)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
