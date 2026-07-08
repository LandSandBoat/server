-----------------------------------
-- Area: Toraimarai Canal
--   NM: Magic Sludge
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.BLIND)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 30)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.UDMGMAGIC, -7500)
    mob:setMod(xi.mod.SLASH_SDT, -8500)
    mob:setMod(xi.mod.PIERCE_SDT, -8500)
    mob:setMod(xi.mod.IMPACT_SDT, -8500)
    mob:setMod(xi.mod.HTH_SDT, -8500)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.DARK_RES_RANK, 10)
    mob:setMod(xi.mod.STUN_RES_RANK, 10)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 9)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 0)
end

entity.onMobDeath = function(mob, player, optParams)
    player:setCharVar('rootProblem', 3)
end

return entity
