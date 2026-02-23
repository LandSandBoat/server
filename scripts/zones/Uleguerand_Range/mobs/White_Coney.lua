-----------------------------------
-- Area: Uleguerand Range
--  MOB: White Coney
-- Note: exclusively uses Wild Carrot
-----------------------------------
local ID = zones[xi.zone.ULEGUERAND_RANGE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 33)
    mob:setMod(xi.mod.STORETP, 30)
    mob:setMod(xi.mod.ICE_RES_RANK, 4)
    mob:setMod(xi.mod.PARALYZE_RES_RANK, 4)
    mob:setMod(xi.mod.BIND_RES_RANK, 4)
end

entity.onMobDespawn = function(mob)
    GetNPCByID(ID.npc.RABBIT_FOOTPRINT):setLocalVar('activeTime', GetSystemTime() + math.random(60 * 9, 60 * 15))
end

return entity
