-----------------------------------
-- Assault: Seagull Grounded
-----------------------------------
local ID = zones[xi.zone.PERIQIA]
-----------------------------------
local instanceObject = {}

instanceObject.registryRequirements = function(player)
    return player:hasKeyItem(xi.ki.PERIQIA_ASSAULT_ORDERS) and
        player:getCurrentAssault() == xi.assault.mission.SEAGULL_GROUNDED and
        player:getCharVar('assaultEntered') == 0 and
        player:hasKeyItem(xi.ki.ASSAULT_ARMBAND) and
        player:getMainLvl() > 50
end

instanceObject.entryRequirements = function(player)
    return player:hasKeyItem(xi.ki.PERIQIA_ASSAULT_ORDERS) and
        player:getCurrentAssault() == xi.assault.mission.SEAGULL_GROUNDED and
        player:getCharVar('assaultEntered') == 0 and
        player:getMainLvl() > 50
end

instanceObject.onInstanceCreated = function(instance)
end

instanceObject.onInstanceCreatedCallback = function(player, instance)
    xi.assault.onInstanceCreatedCallback(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

instanceObject.afterInstanceRegister = function(player)
    local instance = player:getInstance()

    xi.assault.afterInstanceRegister(player, xi.item.CAGE_OF_REEF_FIREFLIES)
    GetNPCByID(ID.npc.RUNE_OF_RELEASE, instance):setPos(-495.000, -9.695, -72.000, 0)
    GetNPCByID(ID.npc.ANCIENT_LOCKBOX, instance):setPos(-490.000, -9.900, -72.000, 0)
end

instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    local mob = GetMobByID(ID.mob[xi.assault.mission.SEAGULL_GROUNDED].MOBS_START.EXCALIAC, instance)
    if mob ~= nil then
        instanceObject.onTrack(instance)
    end

    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instanceObject.onInstanceFailure = function(instance)
    xi.assault.onInstanceFailure(instance)
end

instanceObject.onInstanceProgressUpdate = function(instance, progress)
end

instanceObject.onInstanceComplete = function(instance)
    xi.assault.onInstanceComplete(instance, 8, 8)
end

instanceObject.onEventFinish = function(player, csid, option, npc)
end

-- TODO: Reduce complexity
-- Disable cyclomatic complexity check for this function:
-- luacheck: ignore 561
instanceObject.onTrack = function(instance)
    local pathNodes =
    {
        [0] =
        {
            [0]  = { -322, -16, 380 }, -- Spawn Pos
            [1]  = { -309, -16, 378 },
            [2]  = { -307, -16, 374 },
            [3]  = { -300, -16, 366 }, -- START
        },

        [1] = -- main pathing
        {
            [1]  = { -243, -16, 420 }, -- END Mission Fail
            [2]  = { -250, -16, 419 },
            [3]  = { -254, -16, 413 },
            [4]  = { -261, -16, 411 },
            [5]  = { -266, -16, 415 },
            [6]  = { -271, -16, 419 },
            [7]  = { -277, -16, 420 },
            [8]  = { -285, -16, 420 },
            [9]  = { -292, -16, 424 },
            [10] = { -299, -16, 429 },
            [11] = { -304, -16, 420 },
            [12] = { -301, -16, 411 },
            [13] = { -300, -16, 403 },
            [14] = { -301, -16, 395 },
            [15] = { -303, -16, 388 },
            [16] = { -300, -16, 381 },
            [17] = { -296, -16, 376 },
            [18] = { -297, -16, 371 },
            [19] = { -300, -16, 366 }, -- START
            [20] = { -300, -16, 355 },
            [21] = { -302, -16, 342 },
            [22] = { -314, -16, 341 },
            [23] = { -326, -16, 341 },
            [24] = { -333, -16, 345 },
            [25] = { -340, -16, 349 },
            [26] = { -344, -16, 340 },
            [27] = { -341, -16, 330 },
            [28] = { -340, -16, 320 },
            [29] = { -341, -16, 308 },
            [30] = { -340, -16, 300 }, -- Top Rooms Option
            [31] = { -341, -16, 293 },
            [32] = { -340, -16, 284 },
            [33] = { -340, -16, 273 },
            [34] = { -340, -16, 262 }, -- Middle Rooms Option
            [35] = { -340, -16, 252 },
            [36] = { -340, -16, 240 },
            [37] = { -340, -16, 229 },
            [38] = { -341, -16, 221 }, -- Bottom Rooms Option
            [39] = { -340, -16, 209 },
            [40] = { -340, -17, 201 },
            [41] = { -340, -17, 192 }, -- Lower Fork Option
        },

        [2] = -- Top Rooms Right path
        {
            [1]  = { -344, -16, 300 },
            [2]  = { -349, -16, 300 },
            [3]  = { -358, -16, 300 },
            [4]  = { -366, -16, 300 },
            [5]  = { -373, -16, 300 },
            [6]  = { -380, -16, 300 },
            [7]  = { -387, -16, 300 }, -- Room End Point
        },

        [3] = -- Top Rooms Left path
        {
            [1]  = { -336, -16, 300 },
            [2]  = { -329, -16, 300 },
            [3]  = { -323, -16, 300 },
            [4]  = { -313, -16, 300 },
            [5]  = { -302, -16, 300 },
            [6]  = { -297, -16, 300 },
            [7]  = { -290, -16, 300 }, -- Room End Point
        },

        [4] = -- Middle Rooms Right path
        {
            [1]  = { -344, -16, 260 },
            [2]  = { -349, -16, 260 },
            [3]  = { -358, -16, 260 },
            [4]  = { -366, -16, 260 },
            [5]  = { -373, -16, 260 },
            [6]  = { -380, -16, 260 },
            [7]  = { -387, -16, 260 }, -- Room End Point
        },

        [5] = -- Middle Rooms Left path
        {
            [1]  = { -335, -16, 260 },
            [2]  = { -329, -16, 260 },
            [3]  = { -323, -16, 260 },
            [4]  = { -313, -16, 260 },
            [5]  = { -302, -16, 260 },
            [6]  = { -297, -16, 260 },
            [7]  = { -290, -16, 260 }, -- Room End Point
        },

        [6] = -- Bottom Rooms Right path
        {
            [1]  = { -344, -16, 220 },
            [2]  = { -349, -16, 220 },
            [3]  = { -358, -16, 220 },
            [4]  = { -366, -16, 220 },
            [5]  = { -373, -16, 220 },
            [6]  = { -380, -16, 220 },
            [7]  = { -387, -16, 220 }, -- Room End Point
        },

        [7] = -- Bottom Rooms Left path
        {
            [1]  = { -335, -16, 220 },
            [2]  = { -329, -16, 220 },
            [3]  = { -323, -16, 220 },
            [4]  = { -313, -16, 220 },
            [5]  = { -302, -16, 220 },
            [6]  = { -297, -16, 220 },
            [7]  = { -290, -16, 220 }, -- Room End Point
        },

        [8] = -- Lower Fork Right Path
        {
            [1]  = { -346, -17, 189 },
            [2]  = { -351, -17, 184 },
            [3]  = { -357, -17, 180 },
            [4]  = { -367, -17, 180 },
            [5]  = { -377, -17, 178 },
            [6]  = { -381, -17, 169 },
            [7]  = { -380, -17, 161 },
            [8]  = { -380, -17, 151 },
            [9]  = { -386, -17, 146 },
            [10] = { -389, -17, 141 },
            [11] = { -386, -17, 135 },
            [12] = { -381, -17, 129 },
            [13] = { -380, -17, 119 },
            [14] = { -380, -17, 114 },
            [15] = { -377, -17, 108 },
            [16] = { -379, -17, 102 },
            [17] = { -383, -17,  98 },
            [18] = { -383, -17,  93 },
            [19] = { -381, -17,  86 },
            [20] = { -380, -17,  77 }, -- common path start
            [21] = { -378, -17,  67 },
            [22] = { -376, -17,  59 },
            [23] = { -379, -17,  52 },
            [24] = { -385, -17,  52 },
            [25] = { -389, -17,  58 },
            [26] = { -395, -17,  60 },
            [27] = { -403, -17,  61 },
            [28] = { -410, -17,  62 },
            [29] = { -417, -17,  68 },
            [30] = { -423, -17,  66 },
            [31] = { -424, -17,  57 },
            [32] = { -420, -17,  48 },
            [33] = { -419, -17,  40 },
            [34] = { -419, -17,  33 },
            [35] = { -414, -17,  26 },
            [36] = { -409, -17,  19 },
            [37] = { -411, -17,  14 },
            [38] = { -416, -17,  10 },
            [39] = { -420, -17,   5 },
            [40] = { -420, -17,  -3 },
            [41] = { -419, -17, -12 },
            [42] = { -416, -17, -21 },
            [43] = { -420, -17, -28 },
            [44] = { -426, -17, -27 },
            [45] = { -432, -17, -21 },
            [46] = { -439, -17, -20 },
            [47] = { -445, -17, -20 },
            [48] = { -451, -17, -26 },
            [49] = { -460, -10, -30 },
            [50] = { -461, -10, -40 },
            [51] = { -460, -10, -50 },
            [52] = { -462, -10, -60 },
            [53] = { -467, -10, -63 },
            [54] = { -478, -10, -63 },
            [55] = { -481, -10, -71 },
            [56] = { -486, -10, -76 },
            [57] = { -485, -10, -75 }, -- END Mission Complete
        },

        [9] = -- Lower Fork Left Path
        {
            [1]  = { -336, -16, 190 },
            [2]  = { -332, -16, 185 },
            [3]  = { -324, -16, 180 },
            [4]  = { -315, -16, 180 },
            [5]  = { -308, -16, 179 },
            [6]  = { -302, -16, 174 },
            [7]  = { -300, -16, 169 },
            [8]  = { -300, -16, 162 },
            [9]  = { -300, -16, 155 },
            [10] = { -295, -16, 150 },
            [11] = { -293, -16, 146 },
            [12] = { -296, -16, 142 },
            [13] = { -302, -16, 138 },
            [14] = { -306, -16, 137 },
            [15] = { -314, -16, 139 },
            [16] = { -320, -16, 140 },
            [17] = { -332, -16, 140 },
            [18] = { -341, -16, 135 },
            [19] = { -341, -16, 129 },
            [20] = { -340, -16, 120 },
            [21] = { -340, -16, 111 },
            [22] = { -341, -16, 105 },
            [23] = { -346, -16, 102 },
            [24] = { -355, -16, 101 },
            [25] = { -364, -16, 100 },
            [26] = { -370, -16,  97 },
            [27] = { -374, -16,  93 },
            [28] = { -378, -16,  87 },
            [29] = { -380, -16,  83 },
            [30] = { -380, -17,  77 }, -- common path start
            [31] = { -378, -17,  67 },
            [32] = { -376, -17,  59 },
            [33] = { -379, -17,  52 },
            [34] = { -385, -17,  52 },
            [35] = { -389, -17,  58 },
            [36] = { -395, -17,  60 },
            [37] = { -403, -17,  61 },
            [38] = { -410, -17,  62 },
            [39] = { -417, -17,  68 },
            [40] = { -423, -17,  66 },
            [41] = { -424, -17,  57 },
            [42] = { -420, -17,  48 },
            [43] = { -419, -17,  40 },
            [44] = { -419, -17,  33 },
            [45] = { -414, -17,  26 },
            [46] = { -409, -17,  19 },
            [47] = { -411, -17,  14 },
            [48] = { -416, -17,  10 },
            [49] = { -420, -17,   5 },
            [50] = { -420, -17,  -3 },
            [51] = { -419, -17, -12 },
            [52] = { -416, -17, -21 },
            [53] = { -420, -17, -28 },
            [54] = { -426, -17, -27 },
            [55] = { -432, -17, -21 },
            [56] = { -439, -17, -20 },
            [57] = { -445, -17, -20 },
            [58] = { -451, -17, -26 },
            [59] = { -460, -10, -30 },
            [60] = { -461, -10, -40 },
            [61] = { -460, -10, -50 },
            [62] = { -462, -10, -60 },
            [63] = { -467, -10, -63 },
            [64] = { -478, -10, -63 },
            [65] = { -481, -10, -71 },
            [66] = { -486, -10, -76 },
            [67] = { -485, -10, -75 }, -- END Mission Complete
        },
    }

    local mob = GetMobByID(ID.mob[xi.assault.mission.SEAGULL_GROUNDED].MOBS_START.EXCALIAC, instance)
    if not mob then
        return
    end

    local chars = instance:getChars()
    local mobs = instance:getMobs()
    local missionActive = mob:getLocalVar('missionActive')
    local pathLeg = mob:getLocalVar('pathLeg')
    local pathPoint = mob:getLocalVar('pathPoint')
    pathPoint = utils.clamp(pathPoint, 1, #pathNodes[pathLeg]) -- pathPoint cannot be 0
    local pathProgressMask = mob:getLocalVar('pathProgressMask')
        -- 0 = Incomplete  1 = Complete
        -- bit 0: Mission Start [1]
        -- bit 1: Top Rooms Option Completed [2]
        -- bit 2: Middle Rooms Option Completed [4]
        -- bit 3: Bottom Rooms Option Completed [8]
        -- bit 4: Lower Fork Option Completed (Mission PASS) [16] **Currently NOT Used**
    local topRoomsOption = mob:getLocalVar('topRoomsOption')
    local middleRoomsOption = mob:getLocalVar('middleRoomsOption')
    local bottomRoomsOption = mob:getLocalVar('bottomRoomsOption')
    local lowerForkOption = mob:getLocalVar('lowerForkOption')
    local chatMessage = mob:getLocalVar('chatMessage') -- 0 = No Msg Sent, 1 = Msg Sent
    local mobChatMessage = mob:getLocalVar('mobChatMessage') -- 0 = No Msg Sent, 1 = Msg Sent
    local moveStatus = mob:getLocalVar('moveStatus') -- 0 = Walking Forward, 1 = Running Back
    local runTimeCheck = mob:getLocalVar('runTimeCheck')
    local moveLock = mob:getLocalVar('moveLock') -- 0 = mob canNOT move, 1 = mob can move
    local lockToggle = mob:getLocalVar('lockToggle')
    local stopTimer = mob:getLocalVar('stopTimer') -- resets while moving, counts while stopped
    local runTimer = mob:getLocalVar('runTimer')
    local runStart = mob:getLocalVar('runStart')
    local constantMove = mob:getLocalVar('constantMove') -- 0 = mob canNOT move, 1 = mob can move
    local rangeClose = false
    local rangeStop = false
    local rangeFollow = false

    if pathProgressMask > 0 and missionActive == 1 then
-- Check for nearby mobs
        for _, enemys in pairs(mobs) do
            if
                mob:checkDistance(enemys) < 12 and
                mob:getID() ~= enemys:getID() and
                enemys:isSpawned()
            then
                if mobChatMessage == 0 then
                    mob:setLocalVar('runTimer', os.time() + math.random(20, 40))
                    mob:setLocalVar('mobChatMessage', 1)
                    mob:setLocalVar('moveStatus', 1)
                    mob:setLocalVar('runStart', 1)
                    if enemys:isEngaged() then
                        mob:showText(mob, ID.text.EXCALIACE_CRAB2)
                        break
                    else
                        if enemys:getFamily() == 1011 then -- crab
                            if pathProgressMask == 7 then
                                mob:setLocalVar('pathPoint', 38)
                            elseif pathProgressMask == 3 then
                                mob:setLocalVar('pathPoint', 34)
                            elseif pathProgressMask == 1 then
                                mob:setLocalVar('pathPoint', 30)
                            end

                            mob:setLocalVar('pathLeg', 1)
                            mob:showText(mob, ID.text.EXCALIACE_CRAB1)
                            mob:setBaseSpeed(60)
                            break
                        elseif enemys:getFamily() == 197 then -- pugil
                            mob:setBaseSpeed(75)
                            mob:showText(mob, ID.text.EXCALIACE_DEBAUCHER1)
                            break
                        elseif enemys:getFamily() == 86 then -- doomed
                            mob:setBaseSpeed(100)
                            mob:showText(mob, ID.text.EXCALIACE_DEBAUCHER2)
                            break
                        end
                    end
                end
            end
        end
-- Check for nearby players
        for _, players in pairs(chars) do
            if
                mob:checkDistance(players) < 5 and
                mob:isFacing(players) and
                players:isFacing(mob)
            then
                rangeStop = true
            end

            if mob:checkDistance(players) < 4 then
                rangeClose = true
            end

            if mob:checkDistance(players) < 10 and players:isFacing(mob) then -- check if at least 1 player is tailing the NPC
                rangeFollow = true
            end

            if stopTimer + 5 <= os.time() then
                mob:setLocalVar('stopTimer', os.time())
                if rangeStop then
                    mob:setLocalVar('constantMove', 0)
                    mob:setLocalVar('moveStatus', 0)
                    if chatMessage == 0 then
                        if runStart == 1 then
                            mob:showText(mob, ID.text.EXCALIACE_CAUGHT)
                            mob:setLocalVar('runStart', 0)
                            mob:setLocalVar('chatMessage', 1)
                            mob:setLocalVar('mobChatMessage', 0)
                            mob:setBaseSpeed(40)
                            break
                        else
                            mob:showText(mob, ID.text.EXCALIACE_TOO_CLOSE)
                            mob:setLocalVar('chatMessage', 1)
                            mob:setLocalVar('mobChatMessage', 0)
                            mob:setBaseSpeed(40)
                            break
                        end
                    end
                elseif rangeClose then
                    if runStart == 0 then
                        mob:setLocalVar('constantMove', 0)
                        mob:setLocalVar('moveStatus', 0)
                        if chatMessage == 0 then
                            mob:showText(mob, ID.text.EXCALIACE_TOO_CLOSE)
                            mob:setBaseSpeed(40)
                            mob:setLocalVar('chatMessage', 1)
                            mob:setLocalVar('mobChatMessage', 0)
                            break
                        end
                    end
                else
                    mob:setLocalVar('chatMessage', 0)
                    mob:setLocalVar('constantMove', 1)
                end
            end

            if rangeFollow then
                mob:setLocalVar('runTimeCheck', os.time() + 10) --  wont run off if closer than 10 yalms
            elseif runTimeCheck <= os.time() then
                mob:setLocalVar('moveStatus', 1)
            end
        end
    end

-- Start the Escort Mission
    if missionActive == 0 then
        for _, players in pairs(chars) do
            if mob:checkDistance(players) < 10 then
                mob:showText(mob, ID.text.EXCALIACE_START)
                mob:setLocalVar('missionActive', 1)
                mob:setLocalVar('moveLock', 1)
                mob:setLocalVar('constantMove', 1)
                print('Pathing active, top option: '..mob:getLocalVar('topRoomsOption'))
                print('Pathing active, middle option: '..mob:getLocalVar('middleRoomsOption'))
                print('Pathing active, bottom option: '..mob:getLocalVar('bottomRoomsOption'))
                print('Pathing active, fork option: '..mob:getLocalVar('lowerForkOption'))
                break
            end
        end
    end

    if moveLock == 1 and constantMove == 1 then
        if mob:atPoint(pathNodes[pathLeg][pathPoint]) then
            if moveStatus == 0 then
                mob:setLocalVar('pathPoint', pathPoint + 1)
            else
                if runTimer >= os.time() then
                    mob:setLocalVar('pathPoint', pathPoint - 1)
                else
                    if runStart == 1 then
                        mob:setLocalVar('moveLock', 0)
                        if lockToggle == 0 then
                            mob:showText(mob, ID.text.EXCALIACE_TIRED)
                            mob:timer(15000, function(mobArg)
                                mobArg:setLocalVar('runTimer', os.time() + math.random(20, 40))
                                mobArg:setLocalVar('moveLock', 1)
                                mobArg:setLocalVar('lockToggle', 0)
                            end)

                            mob:setLocalVar('lockToggle', 1)
                        end
                    else
                        mob:setLocalVar('runTimer', os.time() + math.random(30, 40))
                        mob:showText(mob, ID.text.EXCALIACE_RUN)
                        mob:setLocalVar('runStart', 1)
                        mob:setBaseSpeed(100)
                    end
                end
            end
-- Pathing Control Conditions
            if moveStatus == 0 then
                if
                    mob:atPoint(pathNodes[0][#pathNodes[0]]) and
                    bit.band(pathProgressMask, bit.lshift(1, 0)) == 0
                then
                    mob:setLocalVar('pathLeg', 1)
                    mob:setLocalVar('pathPoint', 19)
                    mob:setLocalVar('pathProgressMask', 1)
-- Top Room Option Conditions
                elseif
                    mob:atPoint(pathNodes[1][30]) and
                    bit.band(pathProgressMask, bit.lshift(1, 1)) == 0
                then
                    mob:setLocalVar('moveLock', 0)
                    if lockToggle == 0 then
                        mob:timer(10000, function(mobArg)
                            mobArg:setLocalVar('pathLeg', topRoomsOption)
                            mobArg:setLocalVar('pathPoint', 1)
                            mobArg:setLocalVar('moveLock', 1)
                            mobArg:setLocalVar('lockToggle', 0)
                        end)

                        mob:setLocalVar('lockToggle', 1)
                    end
                elseif
                    mob:atPoint(pathNodes[topRoomsOption][7]) and
                    bit.band(pathProgressMask, bit.lshift(1, 1)) == 0
                then
                    mob:setLocalVar('moveLock', 0)
                    if lockToggle == 0 then
                        mob:timer(10000, function(mobArg)
                            mobArg:setLocalVar('pathLeg', 1)
                            mobArg:setLocalVar('pathPoint', 30)
                            mobArg:setLocalVar('pathProgressMask', pathProgressMask + 2)
                            mobArg:setLocalVar('moveLock', 1)
                            mobArg:setLocalVar('lockToggle', 0)
                        end)

                        mob:setLocalVar('lockToggle', 1)
                    end
-- Middle Room Option Conditions
                elseif
                    mob:atPoint(pathNodes[1][34]) and
                    bit.band(pathProgressMask, bit.lshift(1, 2)) == 0
                then
                    mob:setLocalVar('moveLock', 0)
                    if lockToggle == 0 then
                        mob:timer(10000, function(mobArg)
                            mobArg:setLocalVar('pathLeg', middleRoomsOption)
                            mobArg:setLocalVar('pathPoint', 1)
                            mobArg:setLocalVar('moveLock', 1)
                            mobArg:setLocalVar('lockToggle', 0)
                        end)

                        mob:setLocalVar('lockToggle', 1)
                    end
                elseif
                    mob:atPoint(pathNodes[middleRoomsOption][7]) and
                    bit.band(pathProgressMask, bit.lshift(1, 2)) == 0
                then
                    mob:setLocalVar('moveLock', 0)
                    if lockToggle == 0 then
                        mob:timer(10000, function(mobArg)
                            mobArg:setLocalVar('pathLeg', 1)
                            mobArg:setLocalVar('pathPoint', 34)
                            mobArg:setLocalVar('pathProgressMask', pathProgressMask + 4)
                            mobArg:setLocalVar('moveLock', 1)
                            mobArg:setLocalVar('lockToggle', 0)
                        end)

                        mob:setLocalVar('lockToggle', 1)
                    end
-- Bottom Room Option Conditions
                elseif
                    mob:atPoint(pathNodes[1][38]) and
                    bit.band(pathProgressMask, bit.lshift(1, 3)) == 0
                then
                    mob:setLocalVar('moveLock', 0)
                    if lockToggle == 0 then
                        mob:timer(10000, function(mobArg)
                            mobArg:setLocalVar('pathLeg', bottomRoomsOption)
                            mobArg:setLocalVar('pathPoint', 1)
                            mobArg:setLocalVar('moveLock', 1)
                            mobArg:setLocalVar('lockToggle', 0)
                        end)

                        mob:setLocalVar('lockToggle', 1)
                    end
                elseif
                    mob:atPoint(pathNodes[bottomRoomsOption][7]) and
                    bit.band(pathProgressMask, bit.lshift(1, 3)) == 0
                then
                    mob:setLocalVar('moveLock', 0)
                    if lockToggle == 0 then
                        mob:timer(10000, function(mobArg)
                            mobArg:setLocalVar('pathLeg', 1)
                            mobArg:setLocalVar('pathPoint', 38)
                            mobArg:setLocalVar('pathProgressMask', pathProgressMask + 8)
                            mobArg:setLocalVar('moveLock', 1)
                            mobArg:setLocalVar('lockToggle', 0)
                        end)

                        mob:setLocalVar('lockToggle', 1)
                    end
-- Lower Fork Option Conditions
                elseif mob:atPoint(pathNodes[1][#pathNodes[1]]) then
                    mob:setLocalVar('pathLeg', lowerForkOption)
                    mob:setLocalVar('pathPoint', 1)
-- Mission Complete Conditions
                elseif mob:atPoint(pathNodes[lowerForkOption][#pathNodes[lowerForkOption]]) then
                -- mob reached the escort point - PASS mission
                    mob:showText(mob, ID.text.EXCALIACE_END1)
                    mob:showText(mob, ID.text.EXCALIACE_END2)
                    mob:setLocalVar('missionActive', 3) -- End Mission
                    mob:setLocalVar('moveLock', 0) -- stop Movement and condition checks
                    instance:setProgress(1)
                end
-- else moveStatus == 1 (Running)
            else
                if mob:atPoint(pathNodes[1][1]) then
                -- mob reached the escape point - FAIL mission
                    mob:showText(mob, ID.text.EXCALIACE_ESCAPE)
                    mob:setLocalVar('missionActive', 3) -- End Mission
                    mob:setLocalVar('moveLock', 0) -- stop Movement and condition checks
                    instance:fail()
                elseif mob:atPoint(pathNodes[topRoomsOption][1]) then
                    mob:setLocalVar('pathLeg', 1)
                    mob:setLocalVar('pathPoint', 30)
                elseif mob:atPoint(pathNodes[middleRoomsOption][1]) then
                    mob:setLocalVar('pathLeg', 1)
                    mob:setLocalVar('pathPoint', 34)
                elseif mob:atPoint(pathNodes[bottomRoomsOption][1]) then
                    mob:setLocalVar('pathLeg', 1)
                    mob:setLocalVar('pathPoint', 38)
                elseif mob:atPoint(pathNodes[lowerForkOption][1]) then
                    mob:setLocalVar('pathLeg', 1)
                    mob:setLocalVar('pathPoint', #pathNodes[1])
                end
            end
-- mob not at assigned point yet so move there
        else
            mob:pathThrough(pathNodes[pathLeg][pathPoint])
        end
    end
end

return instanceObject
