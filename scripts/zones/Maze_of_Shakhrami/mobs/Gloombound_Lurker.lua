-----------------------------------
-- Area: Maze of Shakhrami
--   NM: Gloombound Lurker
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 5)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.CURSE)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 295)
end
