-----------------------------------
-- Area: Bastok Mines
--  NPC: Valeri
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/settings")
require("scripts/globals/events/starlight_celebrations")
-----------------------------------

local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.starlightCelebration.onStarlightSmilebringersTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    player:startEvent(33)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
