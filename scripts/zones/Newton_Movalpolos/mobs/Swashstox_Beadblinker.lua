-----------------------------------
-- Area: Newton Movalpolos
--   NM: Swashstox Beadblinker
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------

local entity = {}

entity.onMobSpawn = function(mob)
    local mobId = mob:getID()

    -- Spawn guards that follow NM
    for i = 1, 2 do
        local guardID = mobId + i
        local pos = mob:getPos()

        SpawnMob(guardID)
        GetMobByID(guardID):setSpawn(pos.x + i, pos.y - 0.5, pos.z - i, pos.rot)
    end
end

entity.onMobFight = function(mob, target)
    local mobId = mob:getID()
    for i = 1, 2 do
        local guardID = GetMobByID(mobId + i)
        guardID:updateEnmity(target)
    end
end

entity.onMobRoam = function(mob)
    local guard1 = GetMobByID(mob:getID() + 1)
    local guard2 = GetMobByID(mob:getID() + 2)

    -- Tell guards to follow NM
    if guard1:isSpawned() then
        guard1:pathTo(mob:getXPos() + 1, mob:getYPos(), mob:getZPos())
    end

    if guard2:isSpawned() then
        guard2:pathTo(mob:getXPos() + 3, mob:getYPos(), mob:getZPos() + 1)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 247)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    local mobId = mob:getID()
    for i = 1, 2 do
        local guardID = mobId + i
        DespawnMob(guardID)
    end
end

return entity
