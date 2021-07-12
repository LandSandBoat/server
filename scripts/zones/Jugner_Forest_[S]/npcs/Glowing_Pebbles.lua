-----------------------------------
-- Area: Jugner Forest (S)
--  NPC: Glowing Pebbles
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, 2558) and player:getCharVar("roadToDivadomCS") == 3 then
        player:startEvent(107)
    end
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("roadToDivadomCS") == 2 then
        player:startEvent(106)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 106 then
        player:setCharVar("roadToDivadomCS", 3)
    elseif csid == 107 then
        player:confirmTrade()
        player:setCharVar("roadToDivadomCS", 4)
    end
end

return entity
