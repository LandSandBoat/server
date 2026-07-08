-----------------------------------
-- Area: Xarcabard
--  Mob: Chaos_Elemental
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)

    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SLASH_SDT, -7500)
    mob:setMod(xi.mod.PIERCE_SDT, -7500)
    mob:setMod(xi.mod.IMPACT_SDT, -7500)
    mob:setMod(xi.mod.HTH_SDT, -7500)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 9)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 10)
    mob:setMod(xi.mod.STUN_RES_RANK, 10)
    mob:setMod(xi.mod.ACC, 700)
end

return entity
