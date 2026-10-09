-----------------------------------
-- Area: Feretory (285)
--  NPC: Odyssean Passage
-- !pos -358.000 -3.150 -470.000 285
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.monstrosity.odysseanPassageOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.monstrosity.odysseanPassageOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.monstrosity.odysseanPassageOnEventFinish(player, csid, option, npc)
end

return entity
