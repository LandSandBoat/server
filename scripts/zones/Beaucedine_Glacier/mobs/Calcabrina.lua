-----------------------------------
-- Area: Beaucedine Glacier
--   NM: Calcabrina
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(math.randomInt(5400, 6000)) -- When server restarts, reset timer

    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.MAGIC, xi.detects.SCENT)) -- TODO: Verify scent tracking on retail.
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 313)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(5400, 6000)) -- 90 to 100 minutes
end

return entity
