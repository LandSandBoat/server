-----------------------------------
-- Area: Windurst Waters
--  NPC: Arukoko
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/events/starlight_celebrations")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
        xi.events.starlightCelebration.onStarlightSmilebringersTrade(player, trade, npc)
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(509)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
