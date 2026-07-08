-----------------------------------
-- Area: Bastok Markets [S]
--  NPC: Kevan
-- !pos -308.590 -012.000 -094.227 189
-- Sealed Container NPC
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local itemID = trade:getItemId()
    local itemKeyItemMapping =
    {
        [xi.item.BRONZE_LETTERBOX] = xi.ki.THE_WORDS_OF_DONHU_I,
        [xi.item.BRASS_LETTERBOX] = xi.ki.THE_WORDS_OF_DONHU_II,
        [xi.item.SHAKUDO_LETTERBOX] = xi.ki.THE_WORDS_OF_DONHU_III,
        [xi.item.PAKTONG_LETTERBOX] = xi.ki.THE_WORDS_OF_DONHU_IV,
        [xi.item.PIG_IRON_LETTERBOX] = xi.ki.THE_WORDS_OF_DONHU_V,
        [xi.item.IRON_LETTERBOX] = xi.ki.THE_WORDS_OF_DONHU_VI,
        [xi.item.CAST_IRON_LETTERBOX] = xi.ki.THE_WORDS_OF_DONHU_VII,
        [xi.item.WROUGHT_IRON_LETTERBOX] = xi.ki.THE_WORDS_OF_DONHU_VIII
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

return entity
