-----------------------------------
-- Area: Bastok Mines
--  NPC: Linkshell Concierge
-- !pos 115.880 1.000 -90.280 234
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.linkshellConcierge.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.linkshellConcierge.onEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.linkshellConcierge.onEventFinish(player, csid, option, npc)
end

return entity
