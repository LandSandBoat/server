-----------------------------------
-- Area: Feretory
--  NPC: Suibhne
-- !pos TODO
-----------------------------------
require('scripts/globals/monstrosity')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.monstrosity.suibhneOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.monstrosity.suibhneOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.monstrosity.suibhneOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.monstrosity.suibhneOnEventFinish(player, csid, option, npc)
end

return entity
