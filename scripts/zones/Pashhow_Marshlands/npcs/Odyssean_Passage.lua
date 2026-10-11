-----------------------------------
-- Area: Pashhow Marshlands (109)
--  NPC: Odyssean Passage
-- !pos -492.344 24.999 -620.325 109
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.monstrosity.cityPassageOnTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.monstrosity.cityPassageOnEventFinish(player, csid, option, npc)
end

return entity
