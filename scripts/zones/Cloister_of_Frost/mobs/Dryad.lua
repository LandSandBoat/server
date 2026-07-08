-----------------------------------
-- Area: Cloister of Frost
--  Mob: Dryad
-- Involved in Quest: Class Reunion
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)
end

entity.onMobSpawn = function(mob)
    mob:setRoamFlags(xi.roamFlag.NONE)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 5)
    mob:setMobMod(xi.mobMod.DONT_ROAM_HOME, 1)
    mob:setMobMod(xi.mobMod.ROAM_COOL, 5)
end

return entity
