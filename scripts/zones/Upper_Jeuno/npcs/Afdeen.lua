-----------------------------------
-- Area: Upper Jeuno
--  NPC: Afdeen
-- !pos 1.462 0.000 21.627 244
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(179)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 179 and option == 1 then
        player:setPos(0, 0, 0, 0, 44)
    end
end

return entity
