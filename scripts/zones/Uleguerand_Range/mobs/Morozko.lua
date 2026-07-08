-----------------------------------
-- Area: Uleguerand Range
--   Mob: Morozko
-----------------------------------
local ID = zones[xi.zone.ULEGUERAND_RANGE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    if mob:getID() == ID.mob.SNOW_MAIDEN - 1 then
        mob:setLocalVar('timeToGrow', GetSystemTime() + math.randomInt(115200, 158400)) -- 32 to 44 hours
    end
end

entity.onMobRoam = function(mob)
    -- Snow Maiden PH has been left alone for 32 to 44 hours
    if
        mob:getID() == ID.mob.SNOW_MAIDEN - 1 and
        GetSystemTime() > mob:getLocalVar('timeToGrow')
    then
        DisallowRespawn(ID.mob.SNOW_MAIDEN - 1, true)
        DespawnMob(ID.mob.SNOW_MAIDEN - 1)
        DisallowRespawn(ID.mob.SNOW_MAIDEN, false)
        local pos = mob:getPos()
        SpawnMob(ID.mob.SNOW_MAIDEN):setPos(pos.x, pos.y, pos.z, pos.rot)
    end
end

entity.onMobDisengage = function(mob)
    if mob:getID() == ID.mob.SNOW_MAIDEN - 1 then
        mob:setLocalVar('timeToGrow', GetSystemTime() + math.randomInt(115200, 158400)) -- 32 to 44 hours
    end
end

return entity
