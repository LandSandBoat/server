-----------------------------------
-- Area: Meriphataud Mountains
--  NPC: qm1 (???)
-- Involved in Quest: The Holy Crest
-- !pos 641 -15 7 119
-----------------------------------
local ID = zones[xi.zone.MERIPHATAUD_MOUNTAINS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.WYVERN_EGG) and
        player:getCharVar('TheHolyCrest_Event') == 4
    then
        player:startEvent(56)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_FOUND)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 56 then
        player:setCharVar('TheHolyCrest_Event', 5)
        player:confirmTrade()
        player:startEvent(33)
    end
end

return entity
