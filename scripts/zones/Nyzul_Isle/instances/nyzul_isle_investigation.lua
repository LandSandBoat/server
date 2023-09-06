-----------------------------------
-- Assault 51 : Nyzul Isle Investigation
-----------------------------------
local ID = zones[xi.zone.NYZUL_ISLE]
require('scripts/zones/Nyzul_Isle/globals/points')
-----------------------------------
local instanceObject = {}

local function pickSetPoint(instance)
    local chars        = instance:getChars()
    local currentFloor = instance:getLocalVar('Nyzul_Current_Floor')

    -- Random the floor layout
    instance:setLocalVar('Nyzul_Isle_FloorLayout', math.random(1, (#xi.nyzul.FloorLayout - 1)))
    instance:setLocalVar('gearObjective', 0)

    -- Condition for floors
    -- hard set objective and floor to boss stage for every 20th floor
    if currentFloor % 20 == 0 then
        instance:setStage(xi.nyzul.objective.ELIMINATE_ENEMY_LEADER)
        instance:setLocalVar('Nyzul_Isle_FloorLayout', 0)
    -- 3.33% for a free floor
    elseif math.random(1, 30) == 1 and instance:getLocalVar('freeFloor') == 0 then -- 3.33% for a free floor
        instance:setStage(xi.nyzul.objective.FREE_FLOOR)
        instance:setLocalVar('freeFloor', 1)

        GetNPCByID(ID.npc.RUNE_TRANSFER_START, instance):timer(9000,
        function(m)
            local currentInstance = m:getInstance()
            currentInstance:setProgress(15)
        end) -- Completes objective for free floor
    else
        -- Build the valid objectives list
        local objective = {}

        for i = xi.nyzul.objective.ELIMINATE_ENEMY_LEADER, xi.nyzul.objective.ELIMINATE_ALL_ENEMIES do
            table.insert(objective, i)
        end

        -- Only remove objectives if not the staging room or free floor
        if instance:getStage() ~= 0 and instance:getStage() ~= 6 then
            table.remove(objective, instance:getStage())
        end

        -- Randomly pick the objective from the generated list
        instance:setStage(utils.pickRandom(objective))

        if math.random(1, 30) <= 5 then
            instance:setLocalVar('gearObjective', math.random(xi.nyzul.gearObjective.AVOID_AGRO, xi.nyzul.gearObjective.DO_NOT_DESTROY))
        end
    end

    -- Setup points to travel to
    local layoutPoint = xi.nyzul.FloorLayout[instance:getLocalVar('Nyzul_Isle_FloorLayout')]
    local posX        = layoutPoint[1] local posY = layoutPoint[2] local posZ = layoutPoint[3]

    -- Set Rune of Transfer to Point
    for _, npcID in pairs(ID.npc.RUNE_OF_TRANSFER) do
        local runeOfTransfer = GetNPCByID(npcID, instance)

        if runeOfTransfer:getStatus() == xi.status.DISAPPEAR then
            runeOfTransfer:setAnimationSub(0)
            runeOfTransfer:setPos(posX, posY, posZ)
            runeOfTransfer:setStatus(xi.status.NORMAL)

            break
        end
    end

    -- Set players to Point and messaging
    for _, players in pairs(chars) do
        players:setPos(posX, posY, posZ)
        players:messageName(ID.text.WELCOME_TO_FLOOR, players, currentFloor, currentFloor)

        if instance:getStage() ~= xi.nyzul.objective.FREE_FLOOR then
            players:messageName(ID.text.OBJECTIVE_TEXT_OFFSET + instance:getStage(), players)
            local gearObjective = instance:getLocalVar('gearObjective')

            if gearObjective > 0 then
                players:messageSpecial(ID.text.ELIMINATE_ALL_ENEMIES + gearObjective)
            end
        end
    end

    -- Set Rune of Transfer Menu
    instance:setLocalVar('menuChoice', math.random(1, 20))
end

local function lampsActivate(instance)
    local floorLayout    = instance:getLocalVar('Nyzul_Isle_FloorLayout')
    local lampsObjective = instance:getLocalVar('[Lamps]Objective')
    local runicLamp1     = GetNPCByID(ID.npc.RUNIC_LAMP_OFFSET, instance)
    local partySize      = utils.clamp(instance:getLocalVar('partySize'), 3, 5)
    local lampPoints     = {}

    for i = 1, #xi.nyzulPoint.LampPoint[floorLayout] do
        table.insert(lampPoints, i, xi.nyzulPoint.LampPoint[floorLayout][i])
    end

    -- Lamp Objective: Register
    if lampsObjective == xi.nyzul.lampsObjective.REGISTER then
        local spawnPoint = math.random(1, #lampPoints)

        instance:setLocalVar('[Lamp]PartySize', instance:getLocalVar('partySize'))
        runicLamp1:setPos(lampPoints[spawnPoint])
        runicLamp1:setStatus(xi.status.NORMAL)

    -- Lamp Objective: Activate All
    elseif lampsObjective == xi.nyzul.lampsObjective.ACTIVATE_ALL then
        local runicLamps = math.random(2, partySize - 1)
        instance:setLocalVar('[Lamp]count', runicLamps)

        for i = ID.npc.RUNIC_LAMP_OFFSET, ID.npc.RUNIC_LAMP_OFFSET + runicLamps do
            local spawnPoint = math.random(1, #lampPoints)

            GetNPCByID(i, instance):setPos(lampPoints[spawnPoint])
            GetNPCByID(i, instance):setStatus(xi.status.NORMAL)
            table.remove(lampPoints, spawnPoint)
        end

    -- Lamp Objective: Activate in Order
    elseif lampsObjective == xi.nyzul.lampsObjective.ORDER then
        local runicLamps = math.random(2, 4)
        local lampOrder  = {}

        for j = 1, runicLamps + 1 do
            table.insert(lampOrder, j)
        end

        instance:setLocalVar('[Lamp]count', runicLamps)
        instance:setLocalVar('[Lamp]lampRegister', 0)

        for i = ID.npc.RUNIC_LAMP_OFFSET, ID.npc.RUNIC_LAMP_OFFSET + runicLamps do
            local spawnPoint = math.random(1, #lampPoints)
            local lampRandom = math.random(1, #lampOrder)

            GetNPCByID(i, instance):setPos(lampPoints[spawnPoint])
            GetNPCByID(i, instance):setStatus(xi.status.NORMAL)
            GetNPCByID(i, instance):setLocalVar('[Lamp]order', lampOrder[lampRandom])

            table.remove(lampOrder, lampRandom)
            table.remove(lampPoints, spawnPoint)
        end
    end
end

local function pickMobs(instance)
    local currentFloor = instance:getLocalVar('Nyzul_Current_Floor')

    -- 20th floor bosses.
    if currentFloor % 20 == 0 then
        local floorBoss = 0

        if currentFloor <= 40 then
            floorBoss = math.random(xi.nyzul.enemyLeaders[40][1], xi.nyzul.enemyLeaders[40][2])
        elseif currentFloor <= 100 then
            floorBoss = math.random(xi.nyzul.enemyLeaders[100][1], xi.nyzul.enemyLeaders[100][2])
        end

        GetMobByID(ID.mob[51].ARCHAIC_RAMPART1, instance):setSpawn(-36, 0, -362, 0)
        GetMobByID(floorBoss, instance):setSpawn(-55.000, 1, -380.000, 250)
        SpawnMob(ID.mob[51].ARCHAIC_RAMPART1, instance)
        SpawnMob(floorBoss, instance)

    -- All other floors except free.
    elseif instance:getStage() ~= xi.nyzul.objective.FREE_FLOOR then
        -- Build dynamic table with all the possible spawn points.
        local floorLayout      = instance:getLocalVar('Nyzul_Isle_FloorLayout')
        local pointTable       = xi.nyzulPoint.SpawnPoint[floorLayout]
        local sPoint           = 0
        local sPointX          = 0
        local sPointY          = 0
        local sPointZ          = 0
        local sPointRot        = 0
        local dTableSpawnPoint = {}

        for i = 1, #pointTable do
            table.insert(dTableSpawnPoint, i, pointTable[i])
        end

        -- Spawn objective-specific mobs.
        switch (instance:getStage()) : caseof
        {
            -- Enemy Leader Objective
            [xi.nyzul.objective.ELIMINATE_ENEMY_LEADER] = function()
                local floorBoss = math.random(xi.nyzul.enemyLeaders[1][1], xi.nyzul.enemyLeaders[1][2])
                sPoint          = math.random(1, #dTableSpawnPoint)
                sPointX         = dTableSpawnPoint[sPoint][1]
                sPointY         = dTableSpawnPoint[sPoint][2]
                sPointZ         = dTableSpawnPoint[sPoint][3]
                sPointRot       = dTableSpawnPoint[sPoint][4]

                if floorBoss == ID.mob[51].MOKKE + 18 then
                    floorBoss = ID.mob[51].MOKKE + 17 + (math.random(0, 1) * 2)
                end

                GetMobByID(floorBoss, instance):setSpawn(sPointX, sPointY, sPointZ, sPointRot)
                SpawnMob(floorBoss, instance)
                table.remove(dTableSpawnPoint, sPoint)
            end,

            -- Specified Enemy Group Objective
            [xi.nyzul.objective.ELIMINATE_SPECIFIED_ENEMIES] = function()
                local specificGroup         = math.random(1, 7)
                local specificEnemyGroup    = xi.nyzul.specifiedMobs[specificGroup]
                local numberOfMobs          = specificEnemyGroup[2] - specificEnemyGroup[1] + 1
                local groupAmount           = math.random(2, numberOfMobs)
                local dTableSpecificEnemies = {}

                for i = specificEnemyGroup[1], specificEnemyGroup[2] do
                    table.insert(dTableSpecificEnemies, i)
                end

                while groupAmount > 0 do
                    local randomEnemy = math.random(1, #dTableSpecificEnemies)
                    local enemy       = dTableSpecificEnemies[randomEnemy]
                    sPoint            = math.random(1, #dTableSpawnPoint)
                    sPointX           = dTableSpawnPoint[sPoint][1]
                    sPointY           = dTableSpawnPoint[sPoint][2]
                    sPointZ           = dTableSpawnPoint[sPoint][3]
                    sPointRot         = dTableSpawnPoint[sPoint][4]

                    GetMobByID(enemy, instance):setSpawn(sPointX, sPointY, sPointZ, sPointRot)
                    SpawnMob(enemy, instance)
                    table.remove(dTableSpawnPoint, sPoint)
                    table.remove(dTableSpecificEnemies, randomEnemy)
                    instance:setLocalVar('Eliminate', instance:getLocalVar('Eliminate') + 1)

                    groupAmount = groupAmount - 1
                end
            end,

            -- Eliminate All Objective
            [xi.nyzul.objective.ELIMINATE_ALL_ENEMIES] = function()
                if math.random(1, 100) <= 20 then -- 20% chance that Dahank will spawn.
                    sPoint    = math.random(1, #dTableSpawnPoint)
                    sPointX   = dTableSpawnPoint[sPoint][1]
                    sPointY   = dTableSpawnPoint[sPoint][2]
                    sPointZ   = dTableSpawnPoint[sPoint][3]
                    sPointRot = dTableSpawnPoint[sPoint][4]

                    GetMobByID(ID.mob[51].DAHAK, instance):setSpawn(sPointX, sPointY, sPointZ, sPointRot)
                    SpawnMob(ID.mob[51].DAHAK, instance)
                    table.remove(dTableSpawnPoint, sPoint)
                    instance:setLocalVar('Eliminate', instance:getLocalVar('Eliminate') + 1)
                end
            end,

            -- Activate Lamps Objective
            [xi.nyzul.objective.ACTIVATE_ALL_LAMPS] = function()
                instance:setLocalVar('[Lamps]Objective', math.random(xi.nyzul.lampsObjective.REGISTER, xi.nyzul.lampsObjective.ORDER))
                lampsActivate(instance)
            end,
        }

        -- Spawn Rampart-Type mobs.
        if math.random(1, 100) <= 90 then
            sPoint    = math.random(1, #dTableSpawnPoint)
            sPointX   = dTableSpawnPoint[sPoint][1]
            sPointY   = dTableSpawnPoint[sPoint][2]
            sPointZ   = dTableSpawnPoint[sPoint][3]
            sPointRot = dTableSpawnPoint[sPoint][4]

            GetMobByID(ID.mob[51].ARCHAIC_RAMPART1, instance):setSpawn(sPointX, sPointY, sPointZ, sPointRot)

            SpawnMob(ID.mob[51].ARCHAIC_RAMPART1, instance)
            table.remove(dTableSpawnPoint, sPoint)

            if instance:getStage() == xi.nyzul.objective.ELIMINATE_ALL_ENEMIES then
                instance:setLocalVar('Eliminate', instance:getLocalVar('Eliminate') + 1)
            end
        end

        if math.random(1, 100) <= 20 then
            sPoint    = math.random(1, #dTableSpawnPoint)
            sPointX   = dTableSpawnPoint[sPoint][1]
            sPointY   = dTableSpawnPoint[sPoint][2]
            sPointZ   = dTableSpawnPoint[sPoint][3]
            sPointRot = dTableSpawnPoint[sPoint][4]

            GetMobByID(ID.mob[51].ARCHAIC_RAMPART2, instance):setSpawn(sPointX, sPointY, sPointZ, sPointRot)
            SpawnMob(ID.mob[51].ARCHAIC_RAMPART2, instance)
            table.remove(dTableSpawnPoint, sPoint)

            if instance:getStage() == xi.nyzul.objective.ELIMINATE_ALL_ENEMIES then
                instance:setLocalVar('Eliminate', instance:getLocalVar('Eliminate') + 1)
            end
        end

        -- Spawn Gear-Type mobs.
        if instance:getLocalVar('gearObjective') > 0 then
            for i = xi.nyzul.floorEntities[17][1], xi.nyzul.floorEntities[17][2] do
                sPoint    = math.random(1, #dTableSpawnPoint)
                sPointX   = dTableSpawnPoint[sPoint][1]
                sPointY   = dTableSpawnPoint[sPoint][2]
                sPointZ   = dTableSpawnPoint[sPoint][3]
                sPointRot = dTableSpawnPoint[sPoint][4]

                instance:setLocalVar('gearPenalty', math.random(xi.nyzul.penalty.TIME, xi.nyzul.penalty.PATHOS))
                GetMobByID(i, instance):setSpawn(sPointX, sPointY, sPointZ, sPointRot)
                SpawnMob(i, instance)
                table.remove(dTableSpawnPoint, sPoint)
            end
        end

        -- Spawn fodder NM's.
        local spawnedNMs = math.random(0, 4)

        if spawnedNMs > 0 then
            local floorSection   = math.floor(currentFloor / 20) + 1
            local mobGroup       = xi.nyzul.oddFloorRandomNMs[floorSection]
            local dTableFloorNMs = {}

            -- Even floors.
            if currentFloor % 2 == 0 then
                mobGroup = xi.nyzul.evenFloorRandomNMs[floorSection]
            end

            for i = mobGroup[1], mobGroup[2] do
                table.insert(dTableFloorNMs, i)
            end

            while spawnedNMs > 2 do
                local index = math.random(1, #dTableFloorNMs)
                sPoint      = math.random(1, #dTableSpawnPoint)
                sPointX     = dTableSpawnPoint[sPoint][1]
                sPointY     = dTableSpawnPoint[sPoint][2]
                sPointZ     = dTableSpawnPoint[sPoint][3]
                sPointRot   = dTableSpawnPoint[sPoint][4]

                GetMobByID(dTableFloorNMs[index], instance):setSpawn(sPointX, sPointY, sPointZ, sPointRot)
                SpawnMob(dTableFloorNMs[index], instance)

                table.remove(dTableFloorNMs, index)
                table.remove(dTableSpawnPoint, sPoint)

                spawnedNMs = spawnedNMs - 1

                if instance:getStage() == xi.nyzul.objective.ELIMINATE_ALL_ENEMIES then
                    instance:setLocalVar('Eliminate', instance:getLocalVar('Eliminate') + 1)
                end
            end
        end

        -- Spawn fodder regular mobs.
        local mobFamily     = math.random(1, 16)
        local enemyAmount   = math.random(6, 12)
        local dTableEnemies = {}

        for i = xi.nyzul.floorEntities[mobFamily][1], xi.nyzul.floorEntities[mobFamily][2] do
            table.insert(dTableEnemies, i)
        end

        while enemyAmount > 0 do
            local randomEnemy = math.random(1, #dTableEnemies)
            local mobID       = dTableEnemies[randomEnemy]
            sPoint            = math.random(1, #dTableSpawnPoint)
            sPointX           = dTableSpawnPoint[sPoint][1]
            sPointY           = dTableSpawnPoint[sPoint][2]
            sPointZ           = dTableSpawnPoint[sPoint][3]
            sPointRot         = dTableSpawnPoint[sPoint][4]

            if instance:getStage() == xi.nyzul.objective.ELIMINATE_ALL_ENEMIES then
                instance:setLocalVar('Eliminate', instance:getLocalVar('Eliminate') + 1)
            elseif
                instance:getStage() == xi.nyzul.objective.ELIMINATE_SPECIFIED_ENEMY and
                instance:getLocalVar('Nyzul_Specified_Enemy') == 0
            then
                instance:setLocalVar('Nyzul_Specified_Enemy', mobID)
            end

            GetMobByID(mobID, instance):setSpawn(sPointX, sPointY, sPointZ, sPointRot)
            SpawnMob(mobID, instance)

            -- Remove used up entries from dynamic tables.
            table.remove(dTableEnemies, randomEnemy)
            table.remove(dTableSpawnPoint, sPoint)

            -- Decrease loop.
            enemyAmount = enemyAmount - 1
        end
    end
end

-- Requirements for the first player registering the instance
instanceObject.registryRequirements = function(player)
    return player:hasKeyItem(xi.ki.NYZUL_ISLE_ASSAULT_ORDERS)
end

-- Requirements for further players entering an already-registered instance
instanceObject.entryRequirements = function(player)
    return player:hasKeyItem(xi.ki.NYZUL_ISLE_ASSAULT_ORDERS)
end

-- Called on the instance once it is created and ready
instanceObject.onInstanceCreated = function(instance)
end

-- Once the instance is ready inform the requester that it's ready
instanceObject.onInstanceCreatedCallback = function(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)

    -- Kill the Nyzul Isle update spam
    for _, v in ipairs(player:getParty()) do
        if v:getZoneID() == instance:getEntranceZoneID() then
            v:updateEvent(405, 3, 3, 3, 3, 3, 3, 3)
        end
    end
end

-- When the player zones into the instance
instanceObject.afterInstanceRegister = function(player)
    local instance = player:getInstance()

    player:messageName(ID.text.COMMENCE, player, 51)
    player:messageName(ID.text.TIME_TO_COMPLETE, player, instance:getTimeLimit())

    player:addTempItem(xi.item.UNDERSEA_RUINS_FIREFLIES)
end

-- Instance 'tick'
instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed)
end

-- On fail
instanceObject.onInstanceFailure = function(instance)
    local chars = instance:getChars()

    for _, players in ipairs(chars) do
        players:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        players:startCutscene(1)
    end
end

-- When something in the instance calls: instance:setProgress(...)
instanceObject.onInstanceProgressUpdate = function(instance, progress)
    if progress > 0 then
        if xi.nyzul.handleProgress(instance, progress) then
            xi.nyzul.activateRuneOfTransfer(instance)
        end
    end
end

-- On win
instanceObject.onInstanceComplete = function(instance)
end

-- Standard event hooks, these will take priority over everything apart from m_event.Script
-- Omitting this will fallthrough to the same calls in the Zone.lua
instanceObject.onEventUpdate = function(player, csid, option, npc)
    if csid == 95 then
        local instance = player:getInstance()

        if instance:getLocalVar('runeHandler') == player:getID() then
            pickSetPoint(instance)
        end
    end
end

instanceObject.onEventFinish = function(player, csid, option, npc)
    local instance = player:getInstance()
    local chars    = instance:getChars()

    if csid == 1 then
        for _, players in ipairs(chars) do
            players:setPos(0, 0, 0, 0, xi.zone.ALZADAAL_UNDERSEA_RUINS)
        end
    elseif csid == 95 then
        if instance:getLocalVar('runeHandler') == player:getID() then
            pickMobs(instance)
            xi.nyzul.removePathos(instance)
            xi.nyzul.addFloorPathos(instance)
            instance:setLocalVar('runeHandler', 0)
        end
    end
end

return instanceObject
