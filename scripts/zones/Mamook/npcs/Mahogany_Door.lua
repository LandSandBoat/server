-----------------------------------
-- Area: Mamook
--  NPC: _1t0 (Mahogany Door)
-- Notes:
--      Door at teleport landing spot from Red Bell Key Item Door
--      Presumably this door teleports players back to the Red Bell Door
--      Not reachable by players until the Mamook Incursion event is coded
-- !pos 420.000, 19.939, 520.000
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(220)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 220 and
        option == 1
    then
        player:setPos(260.033, 8.512, -236.031, 192, xi.zone.JADE_SEPULCHER)
    end
end

return entity
