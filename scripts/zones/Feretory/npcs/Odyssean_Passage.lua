-----------------------------------
-- Area: Feretory
--  NPC: Odyssean Passage
-- !pos TODO
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
