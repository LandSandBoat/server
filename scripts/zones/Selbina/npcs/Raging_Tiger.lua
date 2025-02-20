-----------------------------------
-- Area: Selbina
--  NPC: Raging Tiger
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getZPos() > -28.750 then
        player:startEvent(214)
    else
        player:startEvent(235)
    end
end

return entity
