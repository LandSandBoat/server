-----------------------------------
-- Area: Feretory
--  NPC: Aengus
-- !pos TODO
-----------------------------------
require('scripts/globals/monstrosity')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.monstrosity.aengusOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.monstrosity.aengusOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.monstrosity.aengusOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.monstrosity.aengusOnEventFinish(player, csid, option, npc)
end

return entity
