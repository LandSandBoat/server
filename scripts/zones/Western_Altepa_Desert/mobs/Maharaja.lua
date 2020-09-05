-----------------------------------
-- Area: Western Altepa Desert (125)
--  Mob: Maharaja
-- Note: Popped by qm1
-- Involved in Quest: Inheritance
-- !pos -652.3 0.2 -341.5 125
-----------------------------------
require("scripts/globals/wsquest")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobDeath(mob, player, isKiller)
    tpz.wsquest.handleWsnmDeath(tpz.wsquest.ground_strike, player)
end
