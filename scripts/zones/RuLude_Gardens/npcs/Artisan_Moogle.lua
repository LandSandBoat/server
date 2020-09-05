-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Artisan Moogle
-----------------------------------
require("scripts/globals/artisan")

function onTrigger(player, npc)
    tpz.artisan.moogleOnTrigger(player, npc)
end

function onEventUpdate(player, csid, option)
    tpz.artisan.moogleOnUpdate(player, npc, option)
end

function onEventFinish(player, csid, option)
    tpz.artisan.moogleOnFinish(player, npc, option)
end