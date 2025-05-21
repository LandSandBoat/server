-----------------------------------
-- Area: Walk Of Echoes
--  NPC: Veridical Conflux (Grauberg S Exit)
-- !pos -699 0 -442 182
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(3)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 3 and option == 99 then
        player:setPos(-142.915, -6.75, 580.452, 96, xi.zone.GRAUBERG_S)
    end
end

return entity
