-----------------------------------
-- Area: Port Bastok (236)
--  NPC: Odyssean Passage
-- !pos 81.578 8.499 -231.082 236
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
