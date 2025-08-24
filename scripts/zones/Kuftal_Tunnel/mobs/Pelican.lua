-----------------------------------
-- Area: Kuftal Tunnel
--   NM: Pelican
-----------------------------------
local ID = zones[xi.zone.KUFTAL_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.PELICAN - 4] = ID.mob.PELICAN, -- 178.857 20.256 -44.151
    [ID.mob.PELICAN - 3] = ID.mob.PELICAN, -- 179.394 20.061 -34.062
    [ID.mob.PELICAN - 1] = ID.mob.PELICAN, -- 188.610 19.245 -50.076
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.GIL_MIN, 18000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 18000)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PETRIFY)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 422)
end

return entity
