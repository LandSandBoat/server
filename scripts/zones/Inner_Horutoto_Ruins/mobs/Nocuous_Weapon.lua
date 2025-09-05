-----------------------------------
-- Area: Inner Horutoto Ruins
--   NM: Nocuous Weapon
-----------------------------------
local ID = zones[xi.zone.INNER_HORUTOTO_RUINS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -236.855, y =  0.476, z = -51.263 },
    { x = -237.426, y =  0.500, z = -23.412 },
    { x = -230.732, y = -0.025, z = -52.324 }
}

entity.phList =
{
    [ID.mob.NOCUOUS_WEAPON - 3] = ID.mob.NOCUOUS_WEAPON, -- -236.855 0.476 -51.263
    [ID.mob.NOCUOUS_WEAPON - 2] = ID.mob.NOCUOUS_WEAPON, -- -237.426 0.5 -23.412
    [ID.mob.NOCUOUS_WEAPON - 1] = ID.mob.NOCUOUS_WEAPON, -- -230.732 -0.025 -52.324
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.POISON)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.magian.onMobDeath(mob, player, optParams, set{ 2 })
    xi.hunts.checkHunt(mob, player, 287)
end

return entity
