-----------------------------------
-- Area: Windurst Woods
--  NPC: Artisan Moogle
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    xi.artisan.moogleOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.artisan.moogleOnUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.artisan.moogleOnFinish(player, csid, option, npc)
end

return entity
