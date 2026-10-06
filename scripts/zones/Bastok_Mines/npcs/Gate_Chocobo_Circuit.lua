-----------------------------------
-- Area: Bastok Mines
--  NPC: Gate: Chocobo Circuit
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(566)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 566 and option == 1 then
        player:setPos(-509.802, 0.000, -528.480, 32, xi.zone.CHOCOBO_CIRCUIT)
    end
end

return entity
