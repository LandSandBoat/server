-----------------------------------
-- Area: LaLoff_Amphitheater
--  NPC: qm0 (warp player outside after they win fight)
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(12)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 12 and option == 1 then
        player:setPos(-291.480, -42.088, -401.311, 11, 130)
    end
end

return entity
