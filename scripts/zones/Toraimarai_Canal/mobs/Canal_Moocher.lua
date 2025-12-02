-----------------------------------
-- Area: Toraimarai Canal
--   NM: Canal Moocher
-----------------------------------
local ID = zones[xi.zone.TORAIMARAI_CANAL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -138.800, y =  22.500, z =  24.550 }
}

entity.phList =
{
    [ID.mob.CANAL_MOOCHER - 3] = ID.mob.CANAL_MOOCHER,
    [ID.mob.CANAL_MOOCHER - 2] = ID.mob.CANAL_MOOCHER,
    [ID.mob.CANAL_MOOCHER - 1] = ID.mob.CANAL_MOOCHER,
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PLAGUE)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 284)
end

return entity
