-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Gate: Chocobo Circuit
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(882)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 882 and option == 1 then
        player:setPos(-488.574, 0.000, -371.233, 128, xi.zone.CHOCOBO_CIRCUIT)
    end
end

return entity
