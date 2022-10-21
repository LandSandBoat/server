-----------------------------------
-- Area: Ordelles Caves
--   NM: Gerwitz's Soul
-- !pos -51 0.1 3 193
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 15)
    mob:setMod(xi.mod.UFASTCAST, 50)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN, { chance = 20, power = damage * 2}) -- Drains for double its damage
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
