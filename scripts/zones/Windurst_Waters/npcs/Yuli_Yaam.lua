-----------------------------------
-- Area: Windurst Waters
--  NPC: Yuli Yaam
-- !pos -61 -4 23 238
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if math.randomInt(1, 2) == 1 then
        player:startEvent(612)
    else
        player:startEvent(613)
    end
end

return entity
