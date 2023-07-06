-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Pogigi
-- !pos -29.787 -4.499 42.603 94
-- Sealed Container NPC
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local itemID = trade:getItemId()
    local itemKeyItemMapping = {
        [2694] = xi.ki.HABALOS_ECLOGUE_VERSE_I,
        [2695] = xi.ki.HABALOS_ECLOGUE_VERSE_II,
        [2696] = xi.ki.HABALOS_ECLOGUE_VERSE_III,
        [2697] = xi.ki.HABALOS_ECLOGUE_VERSE_IV,
        [2698] = xi.ki.HABALOS_ECLOGUE_VERSE_V,
        [2699] = xi.ki.HABALOS_ECLOGUE_VERSE_VI,
        [2700] = xi.ki.HABALOS_ECLOGUE_VERSE_VII,
        [2701] = xi.ki.HABALOS_ECLOGUE_VERSE_VIII
    }
    -- Make sure we're only trading 1 Basket at a time.
    if trade:hasItemQty(itemID, 1) and trade:getItemCount() == 1 and itemKeyItemMapping[itemID] then
        player:tradeComplete()
        local keyItem = itemKeyItemMapping[itemID]
        npc:showText(npc, 13398) --Need to confirm these texts, used KO captures but might be outdated.
        player:addKeyItem(keyItem)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, keyItem)

    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(330)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
