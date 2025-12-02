-----------------------------------
-- Area: Xarcabard
--   NM: Timeworn Warrior
--  WOTG Nov 2009 NM: Immune to Bind, Sleep, Gravity.
-----------------------------------
local ID = zones[xi.zone.XARCABARD]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  47.210, y = -24.020, z = -367.510 }
}

entity.phList =
{
    [ID.mob.TIMEWORN_WARRIOR - 4] = ID.mob.TIMEWORN_WARRIOR,
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 317)
end

return entity
