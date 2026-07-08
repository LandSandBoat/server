-----------------------------------
-- Area: LaLoff_Amphitheater
--  NPC: qm0 (warp player outside after they win fight)
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(12)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 12 and option == 1 then
        player:setPos(471.776, -42.088, 153.301, 163, 130)
    end
end

return entity
