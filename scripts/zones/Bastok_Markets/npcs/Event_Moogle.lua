-----------------------------------
-- Area: Bastok Markets
--  NPC: Event Moogle
-- Type: Special Event/Seasonal NPC
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require('scripts/globals/events/starlight_celebrations')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if xi.events.starlightCelebration.isStarlightEnabled ~= 0 then
        xi.events.starlightCelebration.merryMakersMoogleOnTrigger(player, npc)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.events.starlightCelebration.merryMakersMoogleOnFinish(player, ID, csid, option)
end

return entity
