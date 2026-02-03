-----------------------------------
-- Area: Middle Delkfutt's Tower
--   NM: Scythe_Victim
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 50)
end

return entity
