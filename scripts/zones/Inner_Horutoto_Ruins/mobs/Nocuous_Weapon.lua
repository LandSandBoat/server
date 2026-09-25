-----------------------------------
-- Area: Inner Horutoto Ruins
--   NM: Nocuous Weapon
-----------------------------------
local ID = zones[xi.zone.INNER_HORUTOTO_RUINS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.NOCUOUS_WEAPON - 4] = ID.mob.NOCUOUS_WEAPON, -- Confirmed on retail
    [ID.mob.NOCUOUS_WEAPON - 2] = ID.mob.NOCUOUS_WEAPON, -- Confirmed on retail
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
