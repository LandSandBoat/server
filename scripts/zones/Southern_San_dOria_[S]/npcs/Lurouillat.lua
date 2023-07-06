-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Lurouillat
-- !pos 44 2 -35 80
-- Sealed Container NPC
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local itemID = trade:getItemId()
local itemKeyItemMapping = {
    [2678] = xi.ki.IMPERIAL_LINEAGE_CHAPTER_I,
    [2679] = xi.ki.IMPERIAL_LINEAGE_CHAPTER_II,
    [2680] = xi.ki.IMPERIAL_LINEAGE_CHAPTER_III,
    [2681] = xi.ki.IMPERIAL_LINEAGE_CHAPTER_IV,
    [2682] = xi.ki.IMPERIAL_LINEAGE_CHAPTER_V,
    [2683] = xi.ki.IMPERIAL_LINEAGE_CHAPTER_VI,
    [2684] = xi.ki.IMPERIAL_LINEAGE_CHAPTER_VII,
    [2685] = xi.ki.IMPERIAL_LINEAGE_CHAPTER_VIII
}
    -- Make sure we're only trading 1 Basket at a time.
    if trade:hasItemQty(itemID, 1) and trade:getItemCount() == 1 and itemKeyItemMapping[itemID] then
        player:tradeComplete()
        local keyItem = itemKeyItemMapping[itemID]
        npc:showText(npc, 13640)
        player:addKeyItem(keyItem)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, keyItem)

    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(350)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
