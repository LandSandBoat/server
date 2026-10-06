-----------------------------------
-- Area: Windurst Woods
--  NPC: Gate: Chocobo Circuit
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(795)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 795 and option == 1 then
        player:setPos(-135.987, 0.000, -527.613, 64, xi.zone.CHOCOBO_CIRCUIT)
    end
end

return entity
