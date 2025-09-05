-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--   NM: Arioch
-----------------------------------
local ID = zones[xi.zone.BOSTAUNIEUX_OUBLIETTE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -259.000, y =  0.489, z = -188.000 }
}

entity.phList =
{
    [ID.mob.ARIOCH - 11] = ID.mob.ARIOCH, -- -259 0.489 -188
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 178)
end

return entity
