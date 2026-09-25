-----------------------------------
-- Area: Riverne - Site B01
--  Mob: Imdugud
-- !pos 655.263 20.664 651.320 29
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_B01]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.IMDUGUD - 1] = ID.mob.IMDUGUD, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.WEIGHT, { power = 50 })
end

return entity
