-----------------------------------
-- Area: Bastok Markets [S]
--  NPC: Kevan
-- !pos -308.590 -012.000 -094.227 189
-- Sealed Container NPC
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets_[S]/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local itemID = trade:getItemId()
    local itemKeyItemMapping =
    {
        [xi.items.BRONZE_LETTERBOX] = xi.ki.THE_WORDS_OF_DONHU_I,
        [xi.items.BRASS_LETTERBOX] = xi.ki.THE_WORDS_OF_DONHU_II,
        [xi.items.SHAKUDO_LETTERBOX] = xi.ki.THE_WORDS_OF_DONHU_III,
        [xi.items.PAKTONG_LETTERBOX] = xi.ki.THE_WORDS_OF_DONHU_IV,
        [xi.items.PIG_IRON_LETTERBOX] = xi.ki.THE_WORDS_OF_DONHU_V,
        [xi.items.IRON_LETTERBOX] = xi.ki.THE_WORDS_OF_DONHU_VI,
        [xi.items.CAST_IRON_LETTERBOX] = xi.ki.THE_WORDS_OF_DONHU_VII,
        [xi.items.WROUGHT_IRON_LETTERBOX] = xi.ki.THE_WORDS_OF_DONHU_VIII
    }
    -- Make sure we're only trading 1 Strongbox at a time.
    if
        npcUtil.tradeHasExactly(trade, itemID) and
        itemKeyItemMapping[itemID]
    then
        player:tradeComplete()
        local keyItem = itemKeyItemMapping[itemID]
        npc:showText(npc, ID.text.KEVAN_TURN_IN)
        npcUtil.giveKeyItem(player, keyItem)
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(334)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
