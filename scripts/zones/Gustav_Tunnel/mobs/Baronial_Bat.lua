-----------------------------------
-- Area: Gustav Tunnel (212)
--  Mob: Baronial Bat
-- Note: Popped by qm1
-- !pos 56 -1 16 212
-- Involved in Quest: Cloak and Dagger
-----------------------------------
require("scripts/globals/wsquest")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobDeath(mob, player, isKiller)
    tpz.wsquest.handleWsnmDeath(tpz.wsquest.evisceration, player)
end
