-----------------------------------
-- Area: Bastok Mines
--  NPC: Gumbah
-- !pos 52 0 -36 234
-----------------------------------
require("scripts/globals/settings")
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/events/starlight_celebrations")
-----------------------------------

local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.starlightCelebration.onStarlightSmilebringersTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
