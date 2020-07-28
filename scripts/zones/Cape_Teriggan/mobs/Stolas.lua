-----------------------------------
-- Area: Cape Teriggan
--   NM: Stolas
-- Note: Popped by qm1
-- !pos -151.65 -8.5 191.37 113
-- Involved in Quest: From Saplings Grow
-----------------------------------
require("scripts/globals/wsquest")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobDeath(mob, player, isKiller)
    tpz.wsquest.handleWsnmDeath(tpz.wsquest.empyreal_arrow, player)
end
