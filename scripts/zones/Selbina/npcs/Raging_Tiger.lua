-----------------------------------
-- Area: Selbina
--  NPC: Raging Tiger
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getZPos() > -28.750 then
        player:startEvent(214)
    else
        player:startEvent(235)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
