-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Rose Garden
-----------------------------------
local ID = zones[xi.zone.YUHTUNGA_JUNGLE]
-----------------------------------
---@type TMobEntity
local entity = {}

local roseGardenPH = ID.mob.ROSE_GARDEN - 1

entity.onMobSpawn = function(mob)
    mob:setLocalVar('timeToGrow', os.time() + math.random(36000, 37800)) -- 10:00:00 to 10:30:00
end

entity.onMobDisengage = function(mob)
    mob:setLocalVar('timeToGrow', os.time() + math.random(36000, 37800)) -- 10:00:00 to 10:30:00
end

entity.onMobRoam = function(mob)
    -- Rose Garden has been left alone for 10.25 hours
    if os.time() >= mob:getLocalVar('timeToGrow') then
        DisallowRespawn(ID.mob.ROSE_GARDEN, true)
        DespawnMob(ID.mob.ROSE_GARDEN)
        DisallowRespawn(ID.mob.VOLUPTUOUS_VILMA, false)
        local pos = mob:getPos()
        SpawnMob(ID.mob.VOLUPTUOUS_VILMA):setPos(pos.x, pos.y, pos.z, pos.rot)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    if os.time() < mob:getLocalVar('timeToGrow') then
        DisallowRespawn(ID.mob.ROSE_GARDEN, true)
        DisallowRespawn(roseGardenPH, false)
        GetMobByID(roseGardenPH):setRespawnTime(GetMobRespawnTime(roseGardenPH))
    end
end

return entity
