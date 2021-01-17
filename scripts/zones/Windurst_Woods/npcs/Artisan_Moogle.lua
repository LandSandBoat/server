-----------------------------------
-- Area: Windurst Woods
--  NPC: Artisan Moogle
-----------------------------------
require("scripts/globals/artisan")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    tpz.artisan.moogleOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
    tpz.artisan.moogleOnUpdate(player, npc, option)
end

entity.onEventFinish = function(player, csid, option)
    tpz.artisan.moogleOnFinish(player, npc, option)
end
return entity
