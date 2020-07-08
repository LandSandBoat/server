-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Metal Crab
-- BCNM: Crustacean Conundrum
-- TODO: You can only do 0-2 damage no matter what your attack is.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
    if VanadielDayOfTheWeek() == tpz.day.WATERSDAY then
        mob:setMod(tpz.mod.REGEN, 6, 3, 0)
    end
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.HP_DRAIN)
end

function onMobDeath(mob, player, isKiller)
end
