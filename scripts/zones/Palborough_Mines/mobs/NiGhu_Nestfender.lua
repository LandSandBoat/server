-----------------------------------
-- Area: Palborough Mines
--   NM: Ni'Ghu_Nestfender
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 300)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 0)

    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 9)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 9)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 10)

    mob:setMod(xi.mod.SLASH_SDT, -5000)
    mob:setMod(xi.mod.PIERCE_SDT, -5000)
    mob:setMod(xi.mod.IMPACT_SDT, -5000)
    mob:setMod(xi.mod.HTH_SDT, -5000)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
