-----------------------------------
-- Area: Maze of Shakhrami
--   NM: Lost Soul
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.STORETP, 30) -- 11 hits to 1k TP
end

return entity
