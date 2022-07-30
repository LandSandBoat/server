-----------------------------------
-- Module to revert Argus to 75 Era repop times and add persistence through crashes.
-- Area: Maze of Shakhrami
--   NM: Argus
--   NM: Leech King
-----------------------------------
local ID = require("scripts/zones/Maze_of_Shakhrami/IDs")
require("scripts/globals/treasure")
require("scripts/globals/helm")
-----------------------------------
local entity = {}
local m = Module:new("75_era_argus")

m:addOverride("xi.zones.Maze_of_Shakhrami.Zone.onInitialize", function(zone)
    local respawnTime = GetServerVariable("ArgusRespawn")

    if os.time() < respawnTime then
        if math.random(0,2) == 1 then
            DisallowRespawn(ID.mob.LEECH_KING, true)
            DisallowRespawn(ID.mob.ARGUS, false)
            UpdateNMSpawnPoint(ID.mob.ARGUS)
            GetMobByID(ID.mob.ARGUS):setRespawnTime(respawnTime - os.time())
        else
            DisallowRespawn(ID.mob.ARGUS, true)
            DisallowRespawn(ID.mob.LEECH_KING, false)
            UpdateNMSpawnPoint(ID.mob.LEECH_KING)
            GetMobByID(ID.mob.LEECH_KING):setRespawnTime(respawnTime - os.time())
        end
    else
        if math.random(0,2) == 1 then
            DisallowRespawn(ID.mob.LEECH_KING, true)
            DisallowRespawn(ID.mob.ARGUS, false)
            UpdateNMSpawnPoint(ID.mob.ARGUS)
            SpawnMob(ID.mob.ARGUS)
        else
            DisallowRespawn(ID.mob.ARGUS, true)
            DisallowRespawn(ID.mob.LEECH_KING, false)
            UpdateNMSpawnPoint(ID.mob.LEECH_KING)
            SpawnMob(ID.mob.LEECH_KING)
        end
    end


    xi.treasure.initZone(zone)
    xi.helm.initZone(zone, xi.helm.type.EXCAVATION)
end)

m:addOverride("xi.zones.Maze_of_Shakhrami.mobs.Argus.onMobDespawn", function(mob)
    local respawnTime = math.random(64800,108000) -- 18-30 hours

    if math.random(0,2) == 1 then
        DisallowRespawn(ID.mob.LEECH_KING, true)
        DisallowRespawn(ID.mob.ARGUS, false)
        UpdateNMSpawnPoint(ID.mob.ARGUS)
        GetMobByID(ID.mob.ARGUS):setRespawnTime(respawnTime)
    else
        DisallowRespawn(ID.mob.ARGUS, true)
        DisallowRespawn(ID.mob.LEECH_KING, false)
        UpdateNMSpawnPoint(ID.mob.LEECH_KING)
        GetMobByID(ID.mob.LEECH_KING):setRespawnTime(respawnTime)
    end

    SetServerVariable("ArgusRespawn",(os.time() + respawnTime))
end)

m:addOverride("xi.zones.Maze_of_Shakhrami.mobs.Leech_King.onMobDespawn", function(mob)
    local respawnTime = math.random(64800,108000) -- 18-30 hours

    if math.random(0,2) == 1 then
        DisallowRespawn(ID.mob.LEECH_KING, true)
        DisallowRespawn(ID.mob.ARGUS, false)
        UpdateNMSpawnPoint(ID.mob.ARGUS)
        GetMobByID(ID.mob.ARGUS):setRespawnTime(respawnTime)
    else
        DisallowRespawn(ID.mob.ARGUS, true)
        DisallowRespawn(ID.mob.LEECH_KING, false)
        UpdateNMSpawnPoint(ID.mob.LEECH_KING)
        GetMobByID(ID.mob.LEECH_KING):setRespawnTime(respawnTime)
    end

    SetServerVariable("ArgusRespawn",(os.time() + respawnTime))
end)

return m
