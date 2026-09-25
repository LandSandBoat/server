-----------------------------------
-- Area: Toraimarai Canal
--   NM: Konjac
-----------------------------------
local ID = zones[xi.zone.TORAIMARAI_CANAL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.KONJAC - 3] = ID.mob.KONJAC, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN, { chance = 20 })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 285)
end

return entity
