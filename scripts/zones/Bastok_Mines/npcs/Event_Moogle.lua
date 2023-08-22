-----------------------------------
-- Area: Bastok Mines
--  NPC: Moogle
-- Type: Special Events Moogle
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/events/starlight_celebrations")
require("scripts/globals/utils")
require("scripts/globals/npc_util")
-----------------------------------

local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if xi.events.starlightCelebration.isStarlightEnabled ~= 0 then
        xi.events.starlightCelebration.npcGiftsMoogleOnTrigger(player)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
        xi.events.starlightCelebration.npcGiftsMoogleOnFinish(player, ID, csid, option)
    end
end

return entity
