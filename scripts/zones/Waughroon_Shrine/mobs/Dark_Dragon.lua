-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Dark Dragon
-- Mission 2-3 BCNM Fight
-----------------------------------

require("scripts/globals/titles")
require("scripts/globals/status")

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.DARK_DRAGON_SLAYER)
end
