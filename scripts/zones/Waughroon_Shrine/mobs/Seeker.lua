-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Seeker
-- Mission 2-3 BCNM Fight
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, 50)
end

function onMobDeath(mob, player, isKiller)
end
