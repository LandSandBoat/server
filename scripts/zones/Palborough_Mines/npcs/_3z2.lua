-----------------------------------
-- Area: Palborough Mines
--  NPC: Old Toolbox
-- Continues Quest: The Eleventh's Hour (100%)
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(14)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 14 then
        player:setPos(-73, 0, 60, 1, 172)
    end
end

return entity
