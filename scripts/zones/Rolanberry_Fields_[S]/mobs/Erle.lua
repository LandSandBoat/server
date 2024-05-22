-----------------------------------
-- Area: Rolanberry Fields [S]
--   NM: Erle
-- https://www.bg-wiki.com/ffxi/Erle
-- TODO allow deaggro based on distance (core CMobEntity::CanDeaggro() forces NM and Battlefield mobs to never stop chasing)
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 35)
    mob:setMod(xi.mod.MDEF, 100)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENAERO, { power = math.random(25, 50) })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 512)
end

return entity
