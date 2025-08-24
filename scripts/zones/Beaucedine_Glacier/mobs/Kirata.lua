-----------------------------------
-- Area: Beaucedine Glacier (111)
--   NM: Kirata
-----------------------------------
local ID = zones[xi.zone.BEAUCEDINE_GLACIER]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.KIRATA - 2] = ID.mob.KIRATA, -- 75.797 -0.335 -323.659
    [ID.mob.KIRATA - 1] = ID.mob.KIRATA, -- 69.336 -0.234 -276.561
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENAERO)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 311)
    xi.magian.onMobDeath(mob, player, optParams, set{ 432 })
end

return entity
