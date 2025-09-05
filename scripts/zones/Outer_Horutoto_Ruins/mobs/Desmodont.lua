-----------------------------------
-- Area: Outer Horutoto Ruins
--   NM: Desmodont
-----------------------------------
local ID = zones[xi.zone.OUTER_HORUTOTO_RUINS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -377.758, y = -0.054, z =  737.730 }
}

entity.phList =
{
    [ID.mob.DESMODONT - 2] = ID.mob.DESMODONT,
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.BLIND)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 290)
    xi.magian.onMobDeath(mob, player, optParams, set{ 891 })
end

return entity
