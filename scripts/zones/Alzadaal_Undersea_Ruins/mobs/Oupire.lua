-----------------------------------
-- Area: Alzadaal Undersea Ruins
--   NM: Oupire
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/titles")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PLAGUE)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 478)
    player:addTitle(tpz.title.OUPIRE_IMPALER)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(14400, 18000)) -- 4 to 5 hours
end
