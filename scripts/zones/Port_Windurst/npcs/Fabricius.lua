-----------------------------------
-- Area: Port Windurst
--  NPC: Fabricius
-- Type: Abyssea Service NPC
-----------------------------------
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.abyssea.traverserNPCOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.abyssea.traverserNPCOnUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.traverserNPCOnEventFinish(player, csid, option, npc)
end

return entity
