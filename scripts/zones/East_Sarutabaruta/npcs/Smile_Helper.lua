-----------------------------------
-- Area: East Sarutabaruta
--  NPC: Smile Helper
-- Type: Smilebringer Bootcamp Checkpoint NPCs
-- Multiple locations
-----------------------------------
local ID = require("scripts/zones/East_Sarutabaruta/IDs")
require("scripts/globals/events/starlight_celebrations")
-----------------------------------

local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if xi.events.starlightCelebration.isStarlightEnabled ~= 0 then
        xi.events.starlightCelebration.smileHelperTrigger(player, npc, ID)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
