-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Overgrown Rose
-----------------------------------
local ID = require("scripts/zones/Yuhtunga_Jungle/IDs")

function onMobSpawn(mob)
    if mob:getID() == ID.mob.ROSE_GARDEN_PH then
        mob:setLocalVar("timeToGrow", os.time() + math.random(36000, 37800)) -- 10:00:00 to 10:30:00
    end
end

function onMobDisengage(mob)
    if mob:getID() == ID.mob.ROSE_GARDEN_PH then
        mob:setLocalVar("timeToGrow", os.time() + math.random(36000, 37800)) -- 10:00:00 to 10:30:00
    end
end

function onMobRoam(mob)
    -- Rose Garden PH has been left alone for 10.25 hours
    if mob:getID() == ID.mob.ROSE_GARDEN_PH and os.time() > mob:getLocalVar("timeToGrow") then
        DisallowRespawn(ID.mob.ROSE_GARDEN_PH, true)
        DespawnMob(ID.mob.ROSE_GARDEN_PH)
        DisallowRespawn(ID.mob.ROSE_GARDEN, false)
        pos = mob:getPos()
        SpawnMob(ID.mob.ROSE_GARDEN):setPos(pos.x, pos.y, pos.z, pos.rot)
    end
end

function onMobDeath(mob, player, isKiller)
end
