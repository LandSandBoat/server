-----------------------------------
-- Garrison
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/common")
require("scripts/globals/garrison_data")
require("scripts/globals/npc_util")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/zone")
-----------------------------------
xi = xi or {}
xi.garrison = xi.garrison or {}
xi.garrison.lookup = xi.garrison.lookup or {}
-----------------------------------
-- Helpers
-----------------------------------
xi.garrison.mobsAlive = function(player)
    local zoneId = player:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local killedAllMobs = true
    local mob = garrisonZoneData.mobs
    local mobnum = 1
    -- Check all mobs if alive
    while mobnum <= 9 do
        if GetMobByID(mob):isAlive() then
            killedAllMobs = false
        end
        mobnum = mobnum + 1
        mob = mob + 1
    end
    -- return result
    if killedAllMobs == false then
        return true
    else
        return false
    end
end

xi.garrison.npcAlive = function(player, party)
    local zoneId = player:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local npcs = garrisonZoneData.npcs
    local killedAllNPC = true
    local npcnum = 1
    -- Check all NPCs are dead
    while npcnum <= party do
        if GetMobByID(npcs):isAlive() then
            killedAllNPC = false
        end
        npcnum = npcnum + 1
        npcs = npcs + 1
    end
    -- return result
    if killedAllNPC == false then
        return true
    else
        return false
    end
end

xi.garrison.despawnNPCs = function(npc, party)
    local zoneId = npc:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local npcs = garrisonZoneData.npcs
    local npcnum = 1
    while npcnum <= party do
        DespawnMob(npcs)
        npcnum = npcnum + 1
        npcs = npcs + 1
    end
end
-----------------------------------
-- Main Functions
-----------------------------------
xi.garrison.tick = function(player, npc, wave, party)
    print("Garrison Tick wave:", wave)
    xi.garrison.waveAlive(player, npc, wave, party)
end

xi.garrison.spawnNPCs = function(npc, party)
    local zoneId = npc:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local npcs = garrisonZoneData.npcs
    local npcnum = 1
    while npcnum <= party do
    -- TODO: Dynamic Spawning
        SpawnMob(npcs)
        -- BATTLEFIELD this is to prevent outside help, is not retail
        GetMobByID(npcs):addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0)
        -- TODO need pathing so they return to spawnpoint
        GetMobByID(npcs):setSpeed(0)
        -- increment up the list
        npcnum = npcnum + 1
        npcs = npcs + 1
    end
end

xi.garrison.spawnWave = function(player, npc, wave, party)
    local zoneId = npc:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local allianceSize = 0
    local boss = garrisonZoneData.mobs + 8
    local npcs = garrisonZoneData.npcs
    local npcnum = 1
    if party >= 1 then
        allianceSize = wave + 0
    end
    if party > 6 then
        allianceSize = wave + 1
    end
    if party > 12 then
        allianceSize = wave + 2
    end
    --TODO spawn mobs in 15 second intervals random from table (more relevant in 1 party vs 3 parties)
    for _, mobId in ipairs(garrisonZoneData.waveSize[allianceSize]) do
    npcs = garrisonZoneData.npcs
    npcnum = 1
        SpawnMob(mobId)
        -- BATTLEFIELD this is to prevent outside help, is not retail
        GetMobByID(mobId):addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0)
        while npcnum <= party do
            if GetMobByID(npcs):isAlive() == true then
                GetMobByID(npcs):addEnmity(GetMobByID(mobId), 1, 1)
                GetMobByID(mobId):addEnmity(GetMobByID(npcs), 1, 1)
            end
            npcnum = npcnum + 1
            npcs = npcs + 1
        end
    end
    if wave == 4 then
        npc:timer(60000, function(npcArg)
            --spawn boss after 1 minute
            SpawnMob(boss)
            -- BATTLEFIELD this is to prevent outside help, is not retail
            GetMobByID(boss):addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0)
            npcs = garrisonZoneData.npcs
            npcnum = 1
            while npcnum <= party do
                if GetMobByID(npcs):isAlive() == true then
                    GetMobByID(npcs):addEnmity(GetMobByID(boss), 1, 1)
                    GetMobByID(boss):addEnmity(GetMobByID(npcs), 1, 1)
                end
                npcnum = npcnum + 1
                npcs = npcs + 1
            end
            --start tick again
            xi.garrison.tick(player, npc, wave, party)
        end)
    else
            --start tick again
            npc:timer(1000, function(npcArg)
            xi.garrison.tick(player, npc, wave, party)
        end)
    end
end

xi.garrison.waveAlive = function(player, npc, wave, party)
    local zoneId = npc:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local garrisonLoot = {}
    garrisonLoot = xi.garrison.loot[garrisonZoneData.levelCap]
    local mob = garrisonZoneData.mobs
    local mobnum = 1
    local garrisonRunning = npc:getZone():getLocalVar(string.format("[GARRISON]EndTime_%s", zoneId))
    -- Check all NPCs are dead -> lose
    if
        xi.garrison.mobsAlive(player) == false and
        wave == 4 and
        xi.garrison.npcAlive(player, party) == true
    then
        --win
        npc:getZone():setLocalVar(string.format("[GARRISON]EndTime_%s", zoneId), os.time())
        npc:getZone():setLocalVar(string.format("[GARRISON]LockOut_%s", zoneId), os.time())
        for _, v in ipairs(player:getAlliance()) do
            -- Not sure this is needed but putting here for each member, talk to gaurd to remove effect??
            v:setCharVar("Garrison_Won", 1)
            v:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
            v:delStatusEffect(xi.effect.BATTLEFIELD)
        end
        for _, loot in pairs(garrisonLoot) do
            local roll = math.random(0,1000)
            if roll <= loot.dropRate then
                player:addTreasure(loot.itemId)
            end
        end
            -- They dont despawn until party leader talks to gaurd
            xi.garrison.despawnNPCs(npc, party)
            -- Var to give rewards to party trigger from guard
            player:setCharVar("Garrison_Treasure", 1)
    elseif
        xi.garrison.mobsAlive(player) == false and
        wave <=3 and
        xi.garrison.npcAlive(player, party) == true
    then
        -- next wave
        wave = wave + 1
        npc:timer(30000, function(npcArg)
            xi.garrison.spawnWave(player, npc, wave, party)
        end)
    elseif
        xi.garrison.npcAlive(player, party) == false or
        os.time() >= garrisonRunning
    then
        -- lose
        npc:getZone():setLocalVar(string.format("[GARRISON]EndTime_%s", zoneId), os.time())
        npc:getZone():setLocalVar(string.format("[GARRISON]LockOut_%s", zoneId), os.time())
        for _, v in ipairs(player:getAlliance()) do
            -- Talk to NPC to Remove effects (done here now for testing)
            v:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
            v:delStatusEffect(xi.effect.BATTLEFIELD)
        end
        mob = garrisonZoneData.mobs
        mobnum = 1
        while mobnum <= 9 do
            DespawnMob(mob)
            mobnum = mobnum + 1
            mob = mob + 1
        end
        xi.garrison.despawnNPCs(npc, party)
    else
    -- start next tick
        npc:timer(10000, function(npcArg)
            xi.garrison.tick(player, npc, wave, party)
        end)
    end
end

xi.garrison.start = function(player, npc, party)
    local zoneId = npc:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    -- Apply level restriction
        for _, v in ipairs(player:getAlliance()) do
            v:addStatusEffect(xi.effect.LEVEL_RESTRICTION, garrisonZoneData.levelCap, 0, 0)
            -- BATTLEFIELD this is to prevent outside help, is not retail
            v:addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0)
        end
    -- Spawn NPC needs to be changed to dynamic similar to pets/trusts/fellows shifting ids
    xi.garrison.spawnNPCs(npc, party)
    -- Start First Wave
    local wave = 1
    xi.garrison.spawnWave(player, npc, wave, party)
end

xi.garrison.onTrade = function(player, npc, trade)
    -- TODO: Check to see if there is Ballista in the Zone
    local zoneId = npc:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local lockout = xi.settings.GARRISON_LOCKOUT
    local timeLimit = xi.settings.GARRISON_TIME_LIMIT
    local garrisonRunning = npc:getZone():getLocalVar(string.format("[GARRISON]LockOut_%s", zoneId))
    local item = garrisonZoneData.itemReq
    -- Collect entrant information
    local party = player:getAlliance()
    --gets party size for spawning each NPC
    party = #party
    -- TODO break into different requirements
    if
        npcUtil.tradeHasExactly(trade, item) and
        os.time() > garrisonRunning and
        party <= xi.settings.GARRISON_PARTY_LIMIT and
        ( xi.settings.GARRISON_ONCE_PER_WEEK == 1 or player:getCharVar("GARRISON_CONQUEST_WAIT") < os.time() )
    then
        xi.garrison.start(player, npc, party)
        player:confirmTrade()
        player:setCharVar("GARRISON_CONQUEST_WAIT", getConquestTally())
        npc:getZone():setLocalVar(string.format("[GARRISON]EndTime_%s", zoneId), os.time() + timeLimit)
        npc:getZone():setLocalVar(string.format("[GARRISON]LockOut_%s", zoneId), os.time() + lockout)
    else
        -- TODO event for not having met requirements
    end
end