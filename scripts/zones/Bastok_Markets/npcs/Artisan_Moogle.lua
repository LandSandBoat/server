-----------------------------------
-- Area: Bastok Markets
--  NPC: Artisan Moogle
-----------------------------------
require("scripts/globals/artisan")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    xi.artisan.moogleOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
    xi.artisan.moogleOnUpdate(player, npc, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.artisan.moogleOnFinish(player, npc, option)
end
return entity
