-----------------------------------
-- Area: Attohwa Chasm
--   NM: Sekhmet
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.SIGHT, xi.detects.HEARING, xi.detects.SCENT))
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.FASTCAST, 15)

    mob:setRespawnTime(math.randomInt(5400, 7200)) -- When server restarts, reset timer
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.MP_DRAIN, { power = math.randomInt(1, 10) })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 276)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(5400, 7200)) -- 1.5 to 2 hours.
end

return entity
