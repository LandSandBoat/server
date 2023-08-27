-----------------------------------
-- Area: Mhaura
--  NPC: Condor Eye
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getZPos() <= 39 then
        player:startEvent(13)
    else
        player:startEvent(229)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
