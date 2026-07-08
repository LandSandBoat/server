-----------------------------------
-- Area: Monastic Cavern
--   NM: Bugaboo
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.UFASTCAST, 50)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 35)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.STORETP, 75) -- 8 hits to 1k tp
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 0)
    mob:setMod(xi.mod.PARALYZE_RES_RANK, 10)
    mob:setMod(xi.mod.BIND_RES_RANK, 10)
    mob:setMod(xi.mod.BLIND_RES_RANK, 10)
    mob:setMod(xi.mod.STUN_RES_RANK, 10)
    mob:setMod(xi.mod.DARK_RES_RANK, 10)
    mob:setMod(xi.mod.ICE_RES_RANK, 10)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN, { chance = 25, power = 347 })
end

entity.onMobDeath = function(mob, player, optParams)
    if player:getCharVar('circleTime') == 7 then
        player:setCharVar('circleTime', 8) -- Set flag so that final CS will show when you interact with alter again
    end
end

return entity
