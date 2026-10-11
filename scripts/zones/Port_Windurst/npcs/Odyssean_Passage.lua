-----------------------------------
-- Area: Port Windurst (240)
--  NPC: Odyssean Passage
-- !pos 221.107 -12.000 223.535 240
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
