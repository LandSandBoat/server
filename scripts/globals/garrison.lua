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
-----------------------------------
-- Helpers
-----------------------------------

-----------------------------------
-- Main Functions
-----------------------------------
xi.garrison.tick = function(player, npc, wave, party)
    print("Garrison Tick wave:", wave)
    local zoneId = npc:getZoneID()
    local garrisonData = xi.garrison.lookup[zoneId]
    xi.garrison.waveAlive(player, npc, wave, party)
end

xi.garrison.spawnNPCs = function(npc, party)
    local zoneId = npc:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local npcs = garrisonZoneData.npcs
    local npcnum = 1
    while npcnum <= party do
        SpawnMob(npcs)
        -- Apply BATTLEFIELD effect
        GetMobByID(npcs):addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0)
        -- TODO need pathing so they return to spawnpoint
        GetMobByID(npcs):setSpeed(1)
        -- increment up the list
        npcnum = npcnum + 1
        npcs = npcs + 1
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

xi.garrison.spawnWave = function(player, npc, wave, party)
    local zoneId = npc:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local mob = garrisonZoneData.mobs
    local allianceSize = 0
    if party >= 1 then
        allianceSize = 1
    end
    if party > 6 then
        allianceSize = 2
    end
    if party > 12 then
        allianceSize = 3
    end
    local partySize = xi.garrison.waveSize[allianceSize]
    local waveSize = partySize[wave]
    local mob = garrisonZoneData.mobs
    local boss = garrisonZoneData.mobs + 8
    local npcs = garrisonZoneData.npcs
    local npcnum = 1
    local mobnum = 1
    --TODO spawn mobs in mini waves also make random from list (not sure how to do this)
    while mobnum <= waveSize.size do
    npcs = garrisonZoneData.npcs
    npcnum = 1
        SpawnMob(mob)
        -- Apply BATTLEFIELD effect
        GetMobByID(mob):addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0)
        while npcnum <= party do
            if GetMobByID(npcs):isAlive()==true then
                GetMobByID(npcs):addEnmity(GetMobByID(mob), 1, 1)
                GetMobByID(mob):addEnmity(GetMobByID(npcs), 1, 1)
            end
            npcnum = npcnum + 1
            npcs = npcs + 1
        end
        mobnum = mobnum + 1
        mob = mob + 1
    end
    if wave == 4 then
        npc:timer(20000, function(npcArg)
            --spawn boss after a little bit... use something similar for mini waves???
            SpawnMob(boss)
            GetMobByID(boss):addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0)
            local npcs = garrisonZoneData.npcs
            local npcnum = 1
            while npcnum <= party do
                if GetMobByID(npcs):isAlive()==true then
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
    local killedAllMobs = true
    local npcs = garrisonZoneData.npcs
    local killedAllNPC = true
    local npcnum = 1
    local mob = garrisonZoneData.mobs
    local mobnum = 1
    -- Check all NPCs are dead -> lose
    while npcnum <= party do
        if GetMobByID(npcs):isAlive() then
            killedAllNPC = false
        end
        npcnum = npcnum + 1
        npcs = npcs + 1
    end
    -- Check all Mobs are dead -> New Wave/Win
    while mobnum <= 9 do
        if GetMobByID(mob):isAlive() then
            killedAllMobs = false
        end
        mobnum = mobnum + 1
        mob = mob + 1
    end
    -- If logic im sorry!!!
    if 
        killedAllMobs == true and 
        wave == 4 and 
        killedAllNPC == false 
    then
        --win
        npc:getZone():setLocalVar(string.format("[GARRISON]EndTime_%s", zoneID), os.time())
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
            -- Pretty sure they dont despawn until party leader talks to gaurd
            xi.garrison.despawnNPCs(npc, party)
            -- Var to give rewards to party trigger from guard
            player:setCharVar("Garrison_Treasure", 1)
    elseif 
        killedAllMobs == true and 
        wave <=3 and 
        killedAllNPC == false 
    then
        -- next wave
        wave = wave + 1
        npc:timer(30000, function(npcArg)
            xi.garrison.spawnWave(player, npc, wave, party)
        end)
    elseif killedAllNPC == true then
        -- lose
        npc:getZone():setLocalVar(string.format("[GARRISON]EndTime_%s", zoneID), os.time())
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
    else
    -- start next tick
        npc:timer(10000, function(npcArg)
            xi.garrison.tick(player, npc, wave, party)
        end)
    end
end

xi.garrison.start = function(player, npc)
    local zoneId = npc:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    -- Collect entrant information
    local party = player:getAlliance()
    --gets party size for spawning each NPC
    party = #party
    -- Apply level cap + BATTLEFIELD??? effect
        for _, v in ipairs(player:getAlliance()) do
            v:addStatusEffect(xi.effect.LEVEL_RESTRICTION, garrisonZoneData.levelCap, 0, 0)
            v:addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0)
        end
    -- Spawn NPC needs to be changed to dynamic similar to pets/trusts/fellows shifting ids
    xi.garrison.spawnNPCs(npc, party)
    -- Start First Wave
    local wave = 1
    xi.garrison.spawnWave(player, npc, wave, party)
end

xi.garrison.onTrade = function(player, npc, trade)
    -- TODO: Once Per Conquest Tally
    -- TODO: Check to see if there is Ballista in the Zone
    -- TODO: 30 minute time limit
    local lockout = 1800000 -- 30 mins set to settings/main
    local garrisonRunning = npc:getZone():getLocalVar(string.format("[GARRISON]EndTime_%s", zoneID))
    local zoneId = npc:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local item = garrisonZoneData.itemReq
    if 
        npcUtil.tradeHasExactly(trade, item) and 
        os.time() > garrisonRunning
    then
        xi.garrison.start(player, npc)
        player:confirmTrade()
        npc:getZone():setLocalVar(string.format("[GARRISON]EndTime_%s", zoneID), os.time() + lockout)
    else
        -- TODO event for not having met requirements
    end
end

