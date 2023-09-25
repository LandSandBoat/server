-----------------------------------
-- Area: Nyzul Isle
--  MOB: Qiqirn Mine
-- Note: Explosive mine from Qiqrin
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setUnkillable(true)
    mob:hideHP(true)
    mob:setAutoAttackEnabled(false)
    mob:setStatus(xi.status.DISAPPEAR)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 15)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
