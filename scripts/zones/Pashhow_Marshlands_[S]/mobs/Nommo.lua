-----------------------------------
-- Area: Pashhow Marshlands [S]
--   NM: Nommo
-- https://www.bg-wiki.com/ffxi/Nommo
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENAMNESIA, { chance = 10, duration = 30 })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 509)
end

return entity
