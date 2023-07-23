-----------------------------------
-- Area: Palborough Mines
--  NPC: Old Toolbox
-- Continues Quest: The Eleventh's Hour (100%)
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(14)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 14 then
        player:setPos(-73, 0, 60, 1, 172)
    end
end

return entity
