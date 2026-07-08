-----------------------------------
-- Area: Sauromugue Champaign [S]
--  NPC: Ebon Door
-- !pos -103.959 -26 -416.869 98
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(103)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 103 and
        option == 1
    then
        player:setPos(-300, -12.08, 157, 64, xi.zone.GARLAIGE_CITADEL_S)
    end
end

return entity
