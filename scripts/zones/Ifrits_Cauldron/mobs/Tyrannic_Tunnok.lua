-----------------------------------
-- Area: Ifrit's Cauldron
--   NM: Tyrannic Tunnok
-----------------------------------
local ID = zones[xi.zone.IFRITS_CAULDRON]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -119.790, y =  19.797, z = -106.198 }
}

entity.phList =
{
    [ID.mob.TYRANNIC_TUNNOK - 3] = ID.mob.TYRANNIC_TUNNOK,
    [ID.mob.TYRANNIC_TUNNOK + 1] = ID.mob.TYRANNIC_TUNNOK,
    [ID.mob.TYRANNIC_TUNNOK + 2] = ID.mob.TYRANNIC_TUNNOK,
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.POISON, { power = 50 })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 400)
end

return entity
