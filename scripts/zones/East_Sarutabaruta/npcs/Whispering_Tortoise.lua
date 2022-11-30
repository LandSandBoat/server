----------------------------------
-- Area: East Sarutabaruta
--  NPC: Whispering Tortoise
-- Type: Smilebringers Bootcamp Sergeant
-- !pos 79.690 -59.999 236.672
-----------------------------------
local ID = require("scripts/zones/East_Sarutabaruta/IDs")
require("scripts/globals/events/starlight_celebrations")
require("scripts/globals/utils")
require('scripts/globals/npc_util')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if xi.events.starlightCelebration.isStarlightEnabled ~= 0 then
        xi.events.starlightCelebration.smileBringerSergeantOnTrigger(player, npc)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local npc = GetNPCByID(ID.npc.STARLIGHT_DECORATIONS[17253113])
    if xi.events.starlightCelebration.isStarlightEnabled ~= 0 then
        xi.events.starlightCelebration.smileBringerSergeantOnFinish(player, npc, ID, csid, option)
    end
end

return entity
