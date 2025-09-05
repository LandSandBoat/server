-----------------------------------
-- Area: Newton Movalpolos
--   NM: Swashstox Beadblinker
-----------------------------------
local ID = zones[xi.zone.NEWTON_MOVALPOLOS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =   87.880, y =  16.000, z = -19.510 },
    { x =  101.320, y =  16.000, z =  50.140 },
    { x =   45.540, y =  16.120, z =  19.640 },
    { x =   49.850, y =  15.850, z = -20.750 },
    { x =  101.320, y =  16.000, z =  50.140 },
    { x =   45.540, y =  16.120, z =  19.640 },
    { x =   49.850, y =  15.850, z = -20.750 }
}

entity.phList =
{
    [ID.mob.SWASHSTOX_BEADBLINKER[1] - 10] = ID.mob.SWASHSTOX_BEADBLINKER[1], -- 92.145, 15.500, 66.595
    [ID.mob.SWASHSTOX_BEADBLINKER[2] + 4]  = ID.mob.SWASHSTOX_BEADBLINKER[2], -- 88.412, 15.421, -19.950
}

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
        local guardObj = GetMobByID(mobId + i)

        if guardObj then
            guardObj:updateEnmity(target)
        end
    end
end

entity.onMobRoam = function(mob)
    local guard1 = GetMobByID(mob:getID() + 1)
    local guard2 = GetMobByID(mob:getID() + 2)

    -- Tell guards to follow NM
    if guard1 and guard1:isSpawned() then
        guard1:pathTo(mob:getXPos() + 1, mob:getYPos(), mob:getZPos())
    end

    if guard2 and guard2:isSpawned() then
        guard2:pathTo(mob:getXPos() + 3, mob:getYPos(), mob:getZPos() + 1)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 247)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    local mobId = mob:getID()
    for i = 1, 2 do
        local guardID = mobId + i
        DespawnMob(guardID)
    end
end

return entity
