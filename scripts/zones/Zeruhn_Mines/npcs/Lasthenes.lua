-----------------------------------
-- Area: Zeruhn Mines
--  NPC: Lasthenes
-- Notes: Opens Gate
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getXPos() > -79.5 then
        player:startEvent(180)
    else
        player:startEvent(181)
    end
end

return entity
