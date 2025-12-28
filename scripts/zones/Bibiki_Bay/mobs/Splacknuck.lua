-----------------------------------
-- Area: Bibiki Bay
--   NM: Splacknuck
-----------------------------------
local ID = zones[xi.zone.BIBIKI_BAY]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  88.000, y = -45.000, z =  920.000 }
}

entity.phList =
{
    [ID.mob.SPLACKNUCK - 1] = ID.mob.SPLACKNUCK,
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENWATER)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 267)
end

return entity
