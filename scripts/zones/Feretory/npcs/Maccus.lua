-----------------------------------
-- Area: Feretory
--  NPC: Maccus
-- !pos TODO
-----------------------------------
require('scripts/globals/monstrosity')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.monstrosity.maccusOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.monstrosity.maccusOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.monstrosity.maccusOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.monstrosity.maccusOnEventFinish(player, csid, option, npc)
end

return entity
