-----------------------------------
-- Area: Outer Horutoto Ruins (194)
--   NM: Doppelganger Dio
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.spawnPoints =
{
    { x =  310.000, y =  0.000, z =  710.000 },
    { x =  508.000, y =  0.000, z =  709.000 },
    { x =  530.000, y =  0.000, z =  775.000 }
}

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.EVASION_DOWN, { chance = 20, power = 10 })
end

return entity
