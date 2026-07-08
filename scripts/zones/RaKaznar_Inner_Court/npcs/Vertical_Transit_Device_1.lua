-----------------------------------
-- Area: RaKaznar_Inner_Court
--  NPC: Vertical Transit Device (1)
-- !pos 747 119 20 276
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(82, 0, 300, 0, 100, 322090, 1, 222935, 2)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 82 and option == 4 then
        player:setPos(70, -30, 20, 0, xi.zone.RAKAZNAR_TURRIS)
    end
end

return entity
