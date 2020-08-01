-----------------------------------
-- Area: West Sarutabaruta
--   NM: Numbing Norman
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PARALYZE)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 252)
    tpz.regime.checkRegime(player, mob, 61, 2, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
end
