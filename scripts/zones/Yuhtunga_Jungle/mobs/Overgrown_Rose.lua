-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Overgrown Rose
-----------------------------------
local ID = zones[xi.zone.YUHTUNGA_JUNGLE]
-----------------------------------
local entity = {}

local roseGardenPH = ID.mob.ROSE_GARDEN - 1

entity.onMobSpawn = function(mob)
    if mob:getID() == roseGardenPH then
        mob:setLocalVar('timeToGrow', os.time() + math.random(36000, 37800)) -- 10:00:00 to 10:30:00
    end
end

entity.onMobDisengage = function(mob)
    if mob:getID() == roseGardenPH then
        mob:setLocalVar('timeToGrow', os.time() + math.random(36000, 37800)) -- 10:00:00 to 10:30:00
    end
end

entity.onMobRoam = function(mob)
    -- Rose Garden PH has been left alone for 10.25 hours
    if
        mob:getID() == roseGardenPH and
        os.time() > mob:getLocalVar('timeToGrow')
    then
        DisallowRespawn(roseGardenPH, true)
        DespawnMob(roseGardenPH)
        DisallowRespawn(ID.mob.ROSE_GARDEN, false)
        local pos = mob:getPos()
        SpawnMob(ID.mob.ROSE_GARDEN):setPos(pos.x, pos.y, pos.z, pos.rot)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
