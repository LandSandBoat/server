-----------------------------------
-- Area: Quicksand Caves
--  Mob: Girtablulu
-- Note: Popped by qm3
-- Involved in Quest: Old Wounds
-- !pos -141.6 -2 450.48 208
-----------------------------------
require("scripts/globals/wsquest")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobDeath(mob, player, isKiller)
    tpz.wsquest.handleWsnmDeath(tpz.wsquest.savage_blade, player)
end
