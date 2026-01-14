-----------------------------------
-- Area: Gusgen Mines
--   NM: Juggler Hecatomb
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(75600, 86400)) -- 21 to 24 hours
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1) -- Has an Additional Effect of Enwater on all attacks.
    mob:setMod(xi.mod.DOUBLE_ATTACK, 15)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENWATER)
end

return entity
