-----------------------------------
-- Area: Beaucedine Glacier [S]
--   NM: Grand'Goule
-----------------------------------
local ID = zones[xi.zone.BEAUCEDINE_GLACIER_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -242.000, y = -80.300, z = -127.000 }
}

entity.phList =
{
    [ID.mob.GRANDGOULE - 7] = ID.mob.GRANDGOULE,
    [ID.mob.GRANDGOULE - 6] = ID.mob.GRANDGOULE,
    [ID.mob.GRANDGOULE - 5] = ID.mob.GRANDGOULE,
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PETRIFY)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 538)
end

return entity
