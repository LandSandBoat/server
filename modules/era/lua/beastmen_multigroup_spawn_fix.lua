-----------------------------------
-- Beastmen Multigroup Spawn Fix
-- Used to disable and limit the number
-- of Beastmen from shared spawn locations.
-----------------------------------
require("modules/module_utils")
require("scripts/globals/zone")
-----------------------------------

local m = Module:new("beastmen_multigroup_spawn_fix")

xi = xi or {}
xi.beastmengroups = xi.beastmengroups or {}

xi.beastmengroups.MONASTIC_CAVERN = {}
xi.beastmengroups.DAVOI = {}
xi.beastmengroups.QULUN_DOME = {}
xi.beastmengroups.BEADEAUX = {}
xi.beastmengroups.CASTLE_OZTROJA = {}
xi.beastmengroups.OLDTON_MOVALPOLOS = {}
xi.beastmengroups.NEWTON_MOVALPOLOS = {}
xi.beastmengroups.LOWER_DELKFUTTS_TOWER = {}
xi.beastmengroups.MIDDLE_DELKFUTTS_TOWER = {}
xi.beastmengroups.UPPER_DELKFUTTS_TOWER = {}
xi.beastmengroups.CASTLE_ZVAHL_BAILEYS = {}
xi.beastmengroups.CASTLE_ZVAHL_KEEP = {}
xi.beastmengroups.VALKURM_DUNES = {}
xi.beastmengroups.BUBURIMU_PENINSULA = {}
xi.beastmengroups.QUFIM_ISLAND = {}
xi.beastmengroups.GIDDEUS = {}
xi.beastmengroups.DANGRUF_WADI = {}
xi.beastmengroups.YUGHOTT_GROTTO = {}
xi.beastmengroups.GHELSBA_OUTPOST = {}
xi.beastmengroups.FORT_GHELSBA = {}
xi.beastmengroups.PALBOROUGH_MINES = {}
xi.beastmengroups.SEA_SERPENT_GROTTO = {}
xi.beastmengroups.MAZE_OF_SHAKHRAMI = {}

xi.beastmengroups.zones =
{
    --{zoneID, zoneName, table, radius}
    {xi.zone.MONASTIC_CAVERN, "Monastic_Cavern", xi.beastmengroups.MONASTIC_CAVERN, 7},
    {xi.zone.DAVOI, "Davoi", xi.beastmengroups.DAVOI, 7},
    {xi.zone.QULUN_DOME, "Qulun_Dome", xi.beastmengroups.QULUN_DOME, 7},
    {xi.zone.BEADEAUX, "Beadeaux", xi.beastmengroups.BEADEAUX, 7},
    {xi.zone.CASTLE_OZTROJA, "Castle_Oztroja", xi.beastmengroups.CASTLE_OZTROJA, 7},
    {xi.zone.OLDTON_MOVALPOLOS, "Oldton_Movalpolos", xi.beastmengroups.OLDTON_MOVALPOLOS, 7},
    {xi.zone.NEWTON_MOVALPOLOS, "Newton_Movalpolos", xi.beastmengroups.NEWTON_MOVALPOLOS, 7},
    {xi.zone.LOWER_DELKFUTTS_TOWER, "Lower_Delkfutts_Tower", xi.beastmengroups.LOWER_DELKFUTTS_TOWER, 7},
    {xi.zone.MIDDLE_DELKFUTTS_TOWER, "Middle_Delkfutts_Tower", xi.beastmengroups.MIDDLE_DELKFUTTS_TOWER, 7},
    {xi.zone.UPPER_DELKFUTTS_TOWER, "Upper_Delkfutts_Tower", xi.beastmengroups.UPPER_DELKFUTTS_TOWER, 7},
    {xi.zone.CASTLE_ZVAHL_BAILEYS, "Castle_Zvahl_Baileys", xi.beastmengroups.CASTLE_ZVAHL_BAILEYS, 7},
    {xi.zone.CASTLE_ZVAHL_KEEP, "Castle_Zvahl_Keep", xi.beastmengroups.CASTLE_ZVAHL_KEEP, 7},
    {xi.zone.VALKURM_DUNES, "Valkurm_Dunes", xi.beastmengroups.VALKURM_DUNES, 3},
    {xi.zone.BUBURIMU_PENINSULA, "Buburimu_Peninsula", xi.beastmengroups.BUBURIMU_PENINSULA, 3},
    {xi.zone.QUFIM_ISLAND, "Qufim_Island", xi.beastmengroups.QUFIM_ISLAND, 3},
    {xi.zone.GIDDEUS, "Giddeus", xi.beastmengroups.GIDDEUS, 3},
    {xi.zone.DANGRUF_WADI, "Dangruf_Wadi", xi.beastmengroups.DANGRUF_WADI, 5},
    {xi.zone.YUGHOTT_GROTTO, "Yughott_Grotto", xi.beastmengroups.YUGHOTT_GROTTO, 5},
    {xi.zone.GHELSBA_OUTPOST, "Ghelsba_Outpost", xi.beastmengroups.GHELSBA_OUTPOST, 5},
    {xi.zone.FORT_GHELSBA, "Fort_Ghelsba", xi.beastmengroups.FORT_GHELSBA, 5},
    {xi.zone.PALBOROUGH_MINES, "Palborough_Mines", xi.beastmengroups.PALBOROUGH_MINES, 5},
    {xi.zone.SEA_SERPENT_GROTTO, "Sea_Serpent_Grotto", xi.beastmengroups.SEA_SERPENT_GROTTO, 5},
    {xi.zone.MAZE_OF_SHAKHRAMI, "Maze_of_Shakhrami", xi.beastmengroups.MAZE_OF_SHAKHRAMI, 5},
}

for _, zoneID in pairs(xi.beastmengroups.zones) do
    m:addOverride(string.format("xi.zones.%s.Zone.onZoneTick", zoneID[2]), function(zone)
        if zone:getLocalVar("[BEASTMEN]GroupIndex") == 0 then
            zone:setLocalVar("[BEASTMEN]GroupIndex", 1)
            local spawnedMobs = zone:getMobs()
            for _, mob in pairs(spawnedMobs) do
                if not mob:isMobType(xi.mobskills.mobType.NOTORIOUS) and mob:getSystem() == xi.ecosystem.BEASTMEN then
                    local mobID = mob:getID()
                    local prevSpawn = 0
                    local originalSpawn = mob:getSpawnPos()
                    local currentIndex = zone:getLocalVar("[BEASTMEN]GroupIndex")
                    local prevCond = {}

                    if GetMobByID(mobID - 1) ~= nil then
                        prevSpawn = GetMobByID(mobID - 1):getSpawnPos()
                        prevCond =
                        {
                            (originalSpawn.x - prevSpawn.x) <= zoneID[4],
                            (originalSpawn.y - prevSpawn.y) <= zoneID[4],
                            (originalSpawn.z - prevSpawn.z) <= zoneID[4],
                        }
                    end

                    if prevCond[1] ~= nil then
                        if not (prevCond[1] and prevCond[2] and prevCond[3]) then -- If this is the first mob in a group.
                            table.insert(zoneID[3], {mob:getID(), currentIndex + 1}) -- Start new group.
                            DisallowRespawn(mob:getID(), true) -- Stop me from respawning.
                            zone:setLocalVar("[BEASTMEN]GroupIndex", currentIndex + 1) -- Set zone's local var so we can ref group number.
                        elseif prevCond[1] and prevCond[2] and prevCond[3] then -- If this is not the first mob for the group.
                            table.insert(zoneID[3], {mob:getID(), currentIndex}) -- Add mob to the group.
                            DisallowRespawn(mob:getID(), true) -- Stop me from respawning.
                            DespawnMob(mob:getID()) -- Despawn me because I shouldn't be out.
                        end
                    elseif prevCond[1] == nil then -- First mob in the zone's list.
                        table.insert(zoneID[3], {mob:getID(), currentIndex + 1}) -- Start new group.
                        DisallowRespawn(mob:getID(), true) -- Stop me from respawning.
                        zone:setLocalVar("[BEASTMEN]GroupIndex", currentIndex + 1) -- Set zone's local var so we can ref group number.
                    end
                end
            end
        end
        local mobs = zone:getMobs()
        for _, mobEntity in pairs(mobs) do
            if not mobEntity:isMobType(xi.mobskills.mobType.NOTORIOUS) and mobEntity:getSystem() == xi.ecosystem.BEASTMEN then
                mobEntity:addListener("DEATH", "DEATH_BEASTMEN_MOB", function(mob)
                    local mobID = mob:getID()
                    local index = 0
                    local count = -1
                    local startMob = 0
                    for _, mobId in pairs(zoneID[3]) do
                        if mobId[1] == mobID then
                            index = mobId[2]
                            break
                        end
                    end

                    if index == 0 or index == nil then
                        return
                    end

                    for _, mobId in pairs(zoneID[3]) do
                        if mobId[2] == index then
                            if count == -1 then
                                startMob = mobId[1]
                            end
                            count = count + 1
                        end
                    end

                    local selection = math.random(startMob, startMob + count)
                    DisallowRespawn(mobID, true)
                    DisallowRespawn(selection, false)
                end)
            end
        end
    end)
end

return m
