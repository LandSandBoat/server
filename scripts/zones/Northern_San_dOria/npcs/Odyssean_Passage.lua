-----------------------------------
-- Area: Northern San d'Oria (231)
--  NPC: Odyssean Passage
-- !pos 82.273 -0.199 41.176 231
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
