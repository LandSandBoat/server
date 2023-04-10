-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Artisan Moogle
-----------------------------------
require("scripts/globals/artisan")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    xi.artisan.moogleOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
    xi.artisan.moogleOnUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.artisan.moogleOnFinish(player, csid, option)
end

return entity
