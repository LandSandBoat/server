-----------------------------------
-- Area: Kazham
--  NPC: Cobbi Malgharam
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("BathedInScent") == 1 then
        player:startEvent(161) -- scent from Blue Rafflesias
    else
        player:startEvent(41)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
