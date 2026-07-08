-----------------------------------
-- Area: Lower Jeuno
--  NPC: Chatnachoq
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.mmm.shopOnTrigger(player)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.mmm.shopOnEventUpdate(player, csid, option)
end

return entity
