-----------------------------------
-- Area: Feretory
--  NPC: Teyrnon
-- !pos TODO
-----------------------------------
require('scripts/globals/monstrosity')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.monstrosity.teyrnonOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.monstrosity.teyrnonOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.monstrosity.teyrnonOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.monstrosity.teyrnonOnEventFinish(player, csid, option, npc)
end

return entity
