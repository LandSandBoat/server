-----------------------------------
-- Area: Meriphataud Mountains
--   NM: Patripatan
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 10) -- "Noted Double Attack"
    mob:addMod(tpz.mod.REGAIN, 50) -- "fairly potent Regain effect"
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PARALYZE)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 269)
    tpz.regime.checkRegime(player, mob, 63, 1, tpz.regime.type.FIELDS)
end
