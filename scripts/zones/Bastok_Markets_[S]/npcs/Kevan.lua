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
        [2686] = xi.ki.THE_WORDS_OF_DONHU_I,
        [2687] = xi.ki.THE_WORDS_OF_DONHU_II,
        [2688] = xi.ki.THE_WORDS_OF_DONHU_III,
        [2689] = xi.ki.THE_WORDS_OF_DONHU_IV,
        [2690] = xi.ki.THE_WORDS_OF_DONHU_V,
        [2691] = xi.ki.THE_WORDS_OF_DONHU_VI,
        [2692] = xi.ki.THE_WORDS_OF_DONHU_VII,
        [2693] = xi.ki.THE_WORDS_OF_DONHU_VIII
    }
    -- Make sure we're only trading 1 Strongbox at a time.
    if npcUtil.tradeHasExactly(trade, itemID) and itemKeyItemMapping[itemID]
    then
        player:tradeComplete()
        local keyItem = itemKeyItemMapping[itemID]
        npc:showText(npc, 13565)
        npcUtil.giveKeyItem(player, keyItem)
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(334)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
