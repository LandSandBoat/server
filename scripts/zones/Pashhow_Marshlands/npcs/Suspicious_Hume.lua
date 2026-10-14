-----------------------------------
-- Area: Pashhow Marshlands (109)
--  NPC: Suspicious Hume
-- !pos -491.817 24.988 -618.552 109
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.monstrosity.suspiciousHumeOnTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.monstrosity.suspiciousHumeOnEventFinish(player, csid, option, npc)
end

return entity
