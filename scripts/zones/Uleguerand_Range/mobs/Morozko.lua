-----------------------------------
-- Area: Uleguerand Range
--  Mob: Morozko
-- Note: PH for Snow Maiden
-----------------------------------
local ID = require("scripts/zones/Uleguerand_Range/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    if mob:getID() == ID.mob.MAIDEN_PH then
        mob:setLocalVar("timeToGrow", os.time() + math.random(36000, 37800)) -- 10:00:00 to 10:30:00
    end
end

entity.onMobDisengage = function(mob)
    if mob:getID() == ID.mob.MAIDEN_PH then
        mob:setLocalVar("timeToGrow", os.time() + math.random(36000, 37800)) -- 10:00:00 to 10:30:00
    end
end

entity.onMobRoam = function(mob)
    -- If left alone, morphs into Snow Maiden
    if mob:getID() == ID.mob.MAIDEN_PH and os.time() > mob:getLocalVar("timeToGrow") then
        DisallowRespawn(ID.mob.MAIDEN_PH, true)
        DespawnMob(ID.mob.MAIDEN_PH)
        DisallowRespawn(ID.mob.SNOW_MAIDEN, false)
        local pos = mob:getPos()
        SpawnMob(ID.mob.SNOW_MAIDEN):setPos(pos.x, pos.y, pos.z, pos.rot)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
