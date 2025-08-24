-----------------------------------
-- Area: Jugner_Forest_[S]
--   NM: Drumskull Zogdregg
-----------------------------------
local ID = zones[xi.zone.JUGNER_FOREST_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.DRUMSKULL_ZOGDREGG - 1] = ID.mob.DRUMSKULL_ZOGDREGG, -- 195.578 -0.556 -347.699
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PETRIFY)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 484)
end

return entity
