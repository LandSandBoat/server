-----------------------------------
-- Area: Monastic Cavern
--   NM: Bugaboo
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1) -- "Has additional effect: Drain"
    mob:setMod(xi.mod.UFASTCAST, 50) -- "His spells have very fast cast, my guess would be close to 50% less casting time."
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN, { chance = 20, power = math.random(300, 375) }) -- "more than occasionally for 300 damage or more."
end

entity.onMobDeath = function(mob, player, optParams)
    player:setCharVar('circleTime', 8) -- Set flag so that final CS will show when you interact with alter again
end

return entity
