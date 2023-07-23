-----------------------------------
-- Area: Selbina
--  NPC: Aleria
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getZPos() < -28.750 then
        player:startEvent(223)
    else
        player:startEvent(228)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
