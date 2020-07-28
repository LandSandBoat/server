-----------------------------------
-- Area: Ro'Maeve (122)
--  Mob: Eldhrimnir
-- Note: Popped by qm1
-- Involved in Quest: Orastery Woes
-- !pos 200.3 -11 -24.8 122
-----------------------------------
require("scripts/globals/wsquest")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobDeath(mob, player, isKiller)
    tpz.wsquest.handleWsnmDeath(tpz.wsquest.black_halo, player)
end
