-----------------------------------
-- Area: Abyssea - Uleguerand
--  NPC: Dominion Sergeant
-----------------------------------
require("scripts/globals/abyssea/dominion")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.abyssea.sergeantOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.sergeantOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.sergeantOnEventFinish(player, csid, option, npc)
end

return entity
