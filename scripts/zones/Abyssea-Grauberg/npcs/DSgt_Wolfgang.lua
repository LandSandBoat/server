-----------------------------------
-- Area: Abyssea - Grauberg
--  NPC: Dominion Sergeant
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.abyssea.sergeantOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.abyssea.sergeantOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.sergeantOnEventFinish(player, csid, option, npc)
end

return entity
