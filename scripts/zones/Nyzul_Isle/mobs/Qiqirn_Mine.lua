-----------------------------------
-- Area: Nyzul Isle
--  MOB: Qiqirn Mine
-- Note: Explosive mine from Qiqrin
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setUnkillable(true)
    mob:hideHP(true)
    mob:SetAutoAttackEnabled(false)
    mob:setStatus(xi.status.DISAPPEAR)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 15)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)
end

function onMobDeath(mob, player, isKiller, firstCall)
end
