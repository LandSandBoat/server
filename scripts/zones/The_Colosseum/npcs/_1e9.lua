-----------------------------------
-- Area: The Colosseum
--  NPC: _1e9 (Gate: The Pit)
-- !pos -604 -1.949 40 71
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(51)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 51 and option == 1 then
        player:setPos(79.981, 0, -104.897, 190, 50)
    end
end

return entity
