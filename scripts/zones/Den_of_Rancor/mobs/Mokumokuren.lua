-----------------------------------
-- Area: Den of Rancor
--   NM: Mokumokuren
-- Note: Popped by qm2
-- !pos 117 36 -280 160
-- Involved in Quest: Souls in Shadow
-----------------------------------
require("scripts/globals/wsquest")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobDeath(mob, player, isKiller)
    tpz.wsquest.handleWsnmDeath(tpz.wsquest.spiral_hell, player)
end
