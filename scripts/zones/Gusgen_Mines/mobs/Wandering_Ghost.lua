-----------------------------------
-- Area: Gusgen Mines
--   NM: Wandering Ghost
-- Involved In Quest: Ghosts of the Past
-- !pos -174 0.1 369 196
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)

    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 0)
    mob:setMod(xi.mod.PARALYZE_RES_RANK, 10)
    mob:setMod(xi.mod.BIND_RES_RANK, 10)
    mob:setMod(xi.mod.BLIND_RES_RANK, 10)
    mob:setMod(xi.mod.STUN_RES_RANK, 10)
    mob:setMod(xi.mod.DARK_RES_RANK, 10)
    mob:setMod(xi.mod.ICE_RES_RANK, 10)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
