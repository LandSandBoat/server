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
xi.garrison.onWin = function(player, npc)
    local zoneId = npc:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local garrisonLoot = {}
    garrisonLoot = xi.garrison.loot[garrisonZoneData.levelCap]
    -- Talk to NPC to Remove effects
    for _, v in ipairs(player:getAlliance()) do
        v:setCharVar("Garrison_Won", 1)
    end
    -- Add loot to Treasure Pool
    for _, loot in pairs(garrisonLoot) do
        local roll = math.random(0,1000)
        if roll <= loot.dropRate then
            player:addTreasure(loot.itemId)
        end
    end
    player:setCharVar("Garrison_Won", 0)
    -- Talk to Guard to Remove effects
    player:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
    player:delStatusEffect(xi.effect.BATTLEFIELD)
    player:getZone():setLocalVar(string.format("[GARRISON]Treasure_%s", zoneId), 0)
    -- They dont despawn until party leader talks to gaurd
    xi.garrison.despawnNPCs(npc)
    -- Reset Garrison lockout and Time Limit
    npc:getZone():setLocalVar(string.format("[GARRISON]EndTime_%s", zoneId), os.time())
    npc:getZone():setLocalVar(string.format("[GARRISON]LockOut_%s", zoneId), os.time())
end

xi.garrison.onLose = function(player, npc)
    local zoneId = npc:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local mob = garrisonZoneData.mobs
    local mobnum = 1
    -- Talk to NPC to Remove effects
    for _, v in ipairs(player:getAlliance()) do
        v:setCharVar("Garrison_Lose", 1)
    end
    -- Despawn all the mobs
    while mobnum <= 9 do
        DespawnMob(mob)
        mobnum = mobnum + 1
        mob = mob + 1
    end
    player:getZone():setLocalVar(string.format("[GARRISON]Treasure_%s", zoneId), 0)
    -- Despawn all the NPCs
    xi.garrison.despawnNPCs(npc)
    -- Reset Garrison lockout and Time Limit
    npc:getZone():setLocalVar(string.format("[GARRISON]EndTime_%s", zoneId), os.time())
    npc:getZone():setLocalVar(string.format("[GARRISON]LockOut_%s", zoneId), os.time())
end

xi.garrison.onRemove = function(player)
    -- Talk to Guard to Remove effects
    player:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
    player:delStatusEffect(xi.effect.BATTLEFIELD)
    player:setCharVar("Garrison_Won", 0)
    player:setCharVar("Garrison_Lose", 0)
end

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

xi.garrison.npcAlive = function(player)
    local zoneId = player:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local npcs = garrisonZoneData.npcs
    local killedAllNPC = true
    -- Check all NPCs are dead
    for _, npcID in pairs(npcs) do
        if GetMobByID(npcID):isAlive() then
            killedAllNPC = false
        end
    end
    -- return result
    if killedAllNPC == false then
        return true
    else
        return false
    end
end

xi.garrison.despawnNPCs = function(npc)
    local zoneId = npc:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local npcs = garrisonZoneData.npcs
    for _, npcID in ipairs(npcs) do
        DespawnMob(npcID)
    end
end

xi.garrison.npcTableEmpty = function(zone)
    local zoneId = zone:getID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local npcs = garrisonZoneData.npcs
    local npcEmpty = true
    -- check if npc table is empty
    for _, npcID in pairs(npcs) do
        npcEmpty = false
    end
    -- return result
    if npcEmpty == false then
        return false
    else
        return true
    end
end
-----------------------------------
-- Main Functions
-----------------------------------
xi.garrison.tick = function(player, npc, wave, party)
    print("Garrison Tick wave:", wave)
    local zoneId = npc:getZoneID()
    local garrisonRunning = npc:getZone():getLocalVar(string.format("[GARRISON]EndTime_%s", zoneId))
    -- Check all NPCs are dead -> lose
    if
        xi.garrison.mobsAlive(player) == false and
        wave == 4 and
        xi.garrison.npcAlive(player, party) == true
    then
        -- Win
        -- Var to give rewards to Trader to trigger from guard
        player:getZone():setLocalVar(string.format("[GARRISON]Treasure_%s", zoneId), garrisonRunning)
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
        xi.garrison.onLose(player, npc)
    else
    -- start next tick
        npc:timer(10000, function(npcArg)
            xi.garrison.tick(player, npc, wave, party)
        end)
    end
end

xi.garrison.spawnNPCs = function(npc, party)
    local zoneId = npc:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local xPos = garrisonZoneData.xPos
    local yPos = garrisonZoneData.yPos
    local zPos = garrisonZoneData.zPos
    local rot = garrisonZoneData.rot
    local npcnum = 1
    local npcs = garrisonZoneData.npcs
    for _, mobId in pairs(npcs) do
    local mob = GetMobByID(mobId)
        if npcnum <= party then
        -- Use the mob object as you normally would
        mob:setSpawn(xPos, yPos, zPos, rot)
        mob:spawn()
        mob:setMobLevel(garrisonZoneData.levelCap)
        -- TODO need pathing so they return to spawnpoint
        mob:setSpeed(0)
        -- BATTLEFIELD this is to prevent outside help, is not retail
        mob:addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0)
        mob:setAllegiance(1)
        if npcnum == 6 then
            xPos = garrisonZoneData.xPos - garrisonZoneData.xSecondLine
            zPos = garrisonZoneData.zPos - garrisonZoneData.zSecondLine
        elseif npcnum == 12 then
            xPos = garrisonZoneData.xPos - garrisonZoneData.xThirdLine
            zPos = garrisonZoneData.zPos - garrisonZoneData.zThirdLine
        else
            xPos = xPos - garrisonZoneData.xChange
            zPos = zPos - garrisonZoneData.zChange
        end
        npcnum = npcnum + 1
        end
    end
end

xi.garrison.spawnWave = function(player, npc, wave, party)
    local zoneId = npc:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local allianceSize = 0
    local boss = garrisonZoneData.mobs + 8
    local npcs = garrisonZoneData.npcs
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
        SpawnMob(mobId)
        -- BATTLEFIELD this is to prevent outside help, is not retail
        GetMobByID(mobId):addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0)
        for _, npcID in ipairs(npcs) do
            if GetMobByID(npcID):isAlive() then
                GetMobByID(npcID):addEnmity(GetMobByID(mobId), 1, 1)
                GetMobByID(mobId):addEnmity(GetMobByID(npcID), 1, 1)
            end
        end
    end
    if wave == 4 then
        npc:timer(60000, function(npcArg)
            --spawn boss after 1 minute
            SpawnMob(boss)
            -- BATTLEFIELD this is to prevent outside help, is not retail
            GetMobByID(boss):addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0)
            for _, npcID in ipairs(npcs) do
                if GetMobByID(npcID):isAlive() then
                    GetMobByID(npcID):addEnmity(GetMobByID(boss), 1, 1)
                    GetMobByID(boss):addEnmity(GetMobByID(npcID), 1, 1)
                end
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

xi.garrison.start = function(player, npc, party)
    local zoneId = npc:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    -- Apply level restriction
        for _, v in ipairs(player:getAlliance()) do
            -- Make sure they are in the same zone
            if v:getZoneID() == zoneId then
                v:addStatusEffect(xi.effect.LEVEL_RESTRICTION, garrisonZoneData.levelCap, 0, 0)
                -- BATTLEFIELD this is to prevent outside help, is not retail
                v:addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0)
            end
        end
    -- Spawn NPCs
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
-- Zone tick Create NPC Tables if empty
xi.garrison.npcTable = function(zone)
    local zoneId = zone:getID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    if xi.garrison.npcTableEmpty(zone) == true then
        local npcs = garrisonZoneData.npcs
        local xPos = garrisonZoneData.xPos
        local yPos = garrisonZoneData.yPos
        local zPos = garrisonZoneData.zPos
        local rot = garrisonZoneData.rot
        local npcName = garrisonZoneData.name
        local npcnum = 1
        while npcnum <= 18 do
            local mob = zone:insertDynamicEntity({
                objtype = xi.objType.MOB,
                name = npcName,
                x = xPos,
                y = yPos,
                z = zPos,
                rotation = rot,
                groupId = 74,
                groupZoneId = 103,
                onMobDeath = function(mob, playerArg, isKiller)
                end,
                releaseIdOnDeath = false,
            })
            -- Use the mob object as you normally would
            mob:setSpawn(xPos, yPos, zPos, rot)
            mob:spawn()
            mob:setMobLevel(garrisonZoneData.levelCap)
            -- TODO need pathing so they return to spawnpoint
            mob:setSpeed(0)
            -- BATTLEFIELD this is to prevent outside help, is not retail
            mob:addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0)
            mob:setAllegiance(1)
            if npcnum == 6 then
                xPos = garrisonZoneData.xPos - garrisonZoneData.xSecondLine
                zPos = garrisonZoneData.zPos - garrisonZoneData.zSecondLine
            elseif npcnum == 12 then
                xPos = garrisonZoneData.xPos - garrisonZoneData.xThirdLine
                zPos = garrisonZoneData.zPos - garrisonZoneData.zThirdLine
            else
                xPos = xPos - garrisonZoneData.xChange
                zPos = zPos - garrisonZoneData.zChange
            end
            npcnum = npcnum + 1
            table.insert(npcs, mob:getID())
            DespawnMob(mob:getID())
        end
    end
end
