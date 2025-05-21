-----------------------------------
-- Area: Walk Of Echoes
--  NPC: Veridical Conflux
-- !pos -414 14 -60 182
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(1004)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 1004 and option == 0 then
        player:setPos(238, -8, -248, 0, 137)
    end
end

return entity
