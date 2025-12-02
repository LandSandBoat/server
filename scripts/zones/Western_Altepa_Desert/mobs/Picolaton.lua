-----------------------------------
-- Area: Western Altepa Desert
--   NM: Picolaton
--  WOTG Nov 2009 NM: Immune to Bind, Sleep, Gravity. Uses only 1 TP move.
-----------------------------------
local ID = zones[xi.zone.WESTERN_ALTEPA_DESERT]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -504.039, y = -0.085, z =  -37.812 },
    { x = -545.469, y =  0.438, z =  -72.377 },
    { x = -515.298, y =  0.757, z =  -57.250 },
    { x = -452.120, y =  0.403, z =  -36.623 },
    { x = -413.287, y = -1.496, z =  -61.436 },
    { x = -389.771, y = -1.449, z =  -92.104 },
    { x = -354.821, y =  0.471, z =  -93.987 },
    { x = -349.252, y =  0.520, z = -137.370 },
    { x = -338.750, y =  0.935, z = -161.939 }
}

entity.phList =
{
    [ID.mob.PICOLATON - 1] = ID.mob.PICOLATON, -- 50.014 0.256 7.088
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:setMod(xi.mod.STORETP, 80)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENAERO)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 414)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
end

return entity
