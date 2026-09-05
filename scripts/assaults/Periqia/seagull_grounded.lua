-----------------------------------
-- Assault: Seagull Grounded
-- Instance 5601
-- Objective: Escort the prisoner Excaliace to the holding area in F-11.
-----------------------------------
local ID = zones[xi.zone.PERIQIA]
-----------------------------------

local content = InstanceAssault:new(
{
    zoneID           = xi.zone.PERIQIA,
    assaultID        = xi.assault.mission.SEAGULL_GROUNDED,
    instanceID       = xi.assault.instance.SEAGULL_GROUNDED,
    assaultArea      = xi.assault.assaultArea.PERIQIA,
    requiredOrders   = xi.ki.PERIQIA_ASSAULT_ORDERS,

    runeOfReleasePos = { x = -495.000, y = -9.695, z = -75.000, rot = 0 },
    ancientBoxPos    = { x = -495.000, y = -9.900, z = -72.000, rot = 0 },
    releasePos       = { x = 5, z = 11 }, -- "Unlocking Rune of Release (F-11)"

    suggestedLevel   = 70,
    basePoints       = 1100,
    requiredProgress = 1,

    entranceParams   =
    {
        instanceID   = xi.assault.instance.SEAGULL_GROUNDED,
        entryEvent   = { 143, 31, -4, 0, 70, 0, 1 },
        confirmEvent = { 143, 4 },
        memberEvent  = { 147, 0 },
    },
})

content.mobs =
{
    { baseID = ID.mob.EXCALIACE, offset = 15 },
    { baseID = ID.mob.DEBAUCHER, offset = 1 },
}

content.loot =
{
    appraisalReward =
    {
        {
            { itemId = xi.item.UNAPPRAISED_GLOVES,  weight =  4500 },
            { itemId = xi.item.UNAPPRAISED_BOX,     weight =  3000 },
            { itemId = xi.item.UNAPPRAISED_SWORD,   weight =  1300 },
            { itemId = xi.item.UNAPPRAISED_POLEARM, weight =  1200 },
        },
    },

    bonusLoot =
    {
        {
            { itemId = xi.item.HI_POTION_P3,        weight = 10000 },
        },

        {
            { itemId = xi.item.HI_POTION_TANK,      weight =  3300 },
            { itemId = xi.item.NONE,                weight =  6700 },
        },

        {
            { itemId = xi.item.HI_RERAISER,         weight =  1700 },
            { itemId = xi.item.NONE,                weight =  8300 },
        },

        {
            { itemId = xi.item.HI_ETHER_TANK,       weight =  1200 },
            { itemId = xi.item.NONE,                weight =  8800 },
        },
    },
}

local section =
{
    startPoints =
    {
        [1] = { x = -311.427, y = -16.171, z =  380.434 },
        [2] = { x = -306.218, y = -16.394, z =  376.906 },
        [3] = { x = -304.320, y = -16.310, z =  369.537 },
        [4] = { x = -300.172, y = -16.159, z =  363.752 },
    },

    initialPath =
    {
        [ 1] = { x = -240.000, y = -15.620, z =  420.000 },
        [ 2] = { x = -244.353, y = -16.109, z =  419.121 },
        [ 3] = { x = -253.095, y = -15.975, z =  415.364 },
        [ 4] = { x = -259.992, y = -16.011, z =  411.470 },
        [ 5] = { x = -265.910, y = -16.386, z =  414.958 },
        [ 6] = { x = -270.617, y = -16.300, z =  420.347 },
        [ 7] = { x = -285.937, y = -16.172, z =  421.105 },
        [ 8] = { x = -287.426, y = -16.190, z =  421.537 },
        [ 9] = { x = -293.400, y = -16.340, z =  425.800 },
        [10] = { x = -300.280, y = -15.964, z =  426.120 },
        [11] = { x = -303.010, y = -15.637, z =  418.183 },
        [12] = { x = -299.148, y = -16.433, z =  410.676 },
        [13] = { x = -299.382, y = -16.025, z =  397.021 },
        [14] = { x = -302.133, y = -16.135, z =  390.716 },
        [15] = { x = -302.073, y = -16.280, z =  386.479 },
        [16] = { x = -299.586, y = -16.090, z =  380.067 },
        [17] = { x = -296.129, y = -16.319, z =  375.366 },
        [18] = { x = -295.874, y = -16.361, z =  373.553 },
        [19] = { x = -299.382, y = -16.140, z =  362.300 },
        [20] = { x = -298.429, y = -16.140, z =  342.763 },
        [21] = { x = -308.588, y = -16.278, z =  340.953 },
        [22] = { x = -324.166, y = -16.174, z =  340.258 },
        [23] = { x = -325.166, y = -16.178, z =  340.376 },
        [24] = { x = -331.779, y = -16.281, z =  344.733 },
        [25] = { x = -337.689, y = -16.161, z =  347.081 },
        [26] = { x = -338.334, y = -16.128, z =  347.046 },
        [27] = { x = -342.448, y = -15.524, z =  341.266 },
        [28] = { x = -340.097, y = -16.395, z =  333.285 },
        [29] = { x = -339.163, y = -16.312, z =  324.616 },
        [30] = { x = -339.031, y = -16.135, z =  311.706 },
        [31] = { x = -340.000, y = -15.752, z =  300.000 },
        [32] = { x = -339.125, y = -16.207, z =  294.714 },
        [33] = { x = -337.400, y = -16.250, z =  262.600 },
        [34] = { x = -339.490, y = -16.268, z =  254.195 },
        [35] = { x = -338.807, y = -16.115, z =  247.592 },
        [36] = { x = -338.712, y = -16.355, z =  222.700 },
        [37] = { x = -339.215, y = -16.285, z =  215.881 },
        [38] = { x = -339.162, y = -16.237, z =  198.496 },
        [39] = { x = -342.953, y = -16.159, z =  192.803 },
        [40] = { x = -343.300, y = -16.350, z =  187.100 },
    },

    sideRooms =
    {
        sideRoomOne =
        {
            west =
            {
                [1] = { x = -356.409, y = -16.132, z =  299.665 },
                [2] = { x = -362.488, y = -16.141, z =  299.575 },
                [3] = { x = -365.691, y = -16.035, z =  300.555 },
                [4] = { x = -385.800, y = -15.693, z =  300.198 },
                [5] = { x = -389.831, y = -15.748, z =  302.730 },
                [6] = { x = -390.031, y = -15.481, z =  301.343 },
            },
            east =
            {
                [1] = { x = -332.645, y = -16.147, z =  300.703 },
                [2] = { x = -323.262, y = -16.104, z =  299.115 },
                [3] = { x = -317.463, y = -16.183, z =  299.061 },
                [4] = { x = -293.495, y = -15.723, z =  300.787 },
                [5] = { x = -290.000, y = -15.245, z =  300.000 },
            },
        },

        sideRoomTwo =
        {
            west =
            {
                [1] = { x = -345.325, y = -16.193, z =  260.865 },
                [2] = { x = -365.063, y = -16.090, z =  260.988 },
                [3] = { x = -379.556, y = -15.808, z =  259.648 },
                [4] = { x = -385.077, y = -15.818, z =  260.303 },
                [5] = { x = -390.000, y = -15.261, z =  260.000 },
            },
            east =
            {
                [1] = { x = -330.251, y = -16.139, z =  260.601 },
                [2] = { x = -311.042, y = -16.018, z =  259.619 },
                [3] = { x = -302.363, y = -15.754, z =  264.075 },
                [4] = { x = -296.234, y = -15.803, z =  261.627 },
                [5] = { x = -290.201, y = -15.773, z =  261.328 },
                [6] = { x = -289.513, y = -15.672, z =  261.050 },
                [7] = { x = -289.923, y = -15.312, z =  260.165 },
            },
        },

        sideRoomThree =
        {
            west =
            {
                [1] = { x = -346.153, y = -16.236, z =  220.347 },
                [2] = { x = -356.428, y = -16.148, z =  220.026 },
                [3] = { x = -365.906, y = -16.005, z =  220.785 },
                [4] = { x = -386.462, y = -15.793, z =  219.010 },
                [5] = { x = -390.000, y = -15.245, z =  220.000 },
            },
            east =
            {
                [1] = { x = -330.255, y = -16.139, z =  220.015 },
                [2] = { x = -317.352, y = -16.151, z =  220.591 },
                [3] = { x = -310.799, y = -16.019, z =  219.858 },
                [4] = { x = -303.162, y = -15.843, z =  219.930 },
                [5] = { x = -291.294, y = -15.817, z =  220.836 },
                [6] = { x = -290.696, y = -15.809, z =  220.681 },
                [7] = { x = -289.903, y = -15.365, z =  219.450 },
            },
        },
    },

    lowerFork =
    {
        west =
        {
            [ 1] = { x = -349.380, y = -16.187, z =  185.222 },
            [ 2] = { x = -355.752, y = -16.137, z =  181.029 },
            [ 3] = { x = -374.879, y = -16.187, z =  178.631 },
            [ 4] = { x = -377.567, y = -16.093, z =  171.737 },
            [ 5] = { x = -379.308, y = -16.177, z =  164.260 },
            [ 6] = { x = -378.903, y = -16.287, z =  151.932 },
            [ 7] = { x = -384.466, y = -16.357, z =  146.695 },
            [ 8] = { x = -387.182, y = -16.028, z =  141.600 },
            [ 9] = { x = -380.123, y = -16.109, z =  125.349 },
            [10] = { x = -379.176, y = -16.033, z =  119.887 },
            [11] = { x = -376.252, y = -16.104, z =  111.672 },
            [12] = { x = -377.127, y = -16.459, z =  106.477 },
            [13] = { x = -379.202, y = -16.080, z =  100.783 },
            [14] = { x = -382.994, y = -16.299, z =   94.765 },
        },

        east =
        {
            [ 1] = { x = -334.210, y = -16.270, z =  189.140 },
            [ 2] = { x = -332.380, y = -16.240, z =  184.710 },
            [ 3] = { x = -327.995, y = -16.120, z =  183.339 },
            [ 4] = { x = -322.123, y = -16.016, z =  181.003 },
            [ 5] = { x = -306.962, y = -16.340, z =  179.115 },
            [ 6] = { x = -300.189, y = -16.111, z =  174.499 },
            [ 7] = { x = -299.222, y = -15.989, z =  169.554 },
            [ 8] = { x = -299.522, y = -16.252, z =  158.490 },
            [ 9] = { x = -302.870, y = -16.210, z =  152.605 },
            [10] = { x = -302.824, y = -16.400, z =  147.329 },
            [11] = { x = -309.356, y = -16.292, z =  145.173 },
            [12] = { x = -315.181, y = -16.151, z =  141.080 },
            [13] = { x = -324.153, y = -15.838, z =  140.443 },
            [14] = { x = -335.726, y = -15.934, z =  131.351 },
            [15] = { x = -338.241, y = -16.079, z =  123.296 },
            [16] = { x = -338.368, y = -16.088, z =  110.702 },
            [17] = { x = -334.235, y = -16.176, z =  104.564 },
            [18] = { x = -332.606, y = -16.200, z =  103.709 },
            [19] = { x = -311.740, y = -15.936, z =  101.007 },
            [20] = { x = -307.578, y = -15.808, z =  101.551 },
            [21] = { x = -301.914, y = -15.782, z =   97.236 },
            [22] = { x = -300.222, y = -15.720, z =   92.478 },
            [23] = { x = -300.000, y = -15.309, z =   95.000 },
            [24] = { x = -300.585, y = -15.539, z =   95.828 },
            [25] = { x = -306.164, y = -15.766, z =  100.870 },
            [26] = { x = -331.173, y = -16.445, z =   99.307 },
            [27] = { x = -335.813, y = -16.195, z =  100.339 },
            [28] = { x = -359.838, y = -16.286, z =  100.703 },
            [29] = { x = -372.999, y = -16.521, z =   92.426 },
        },
    },

    finalPath =
    {
        [ 1] = { x = -377.160, y = -16.130, z =   88.558 },
        [ 2] = { x = -378.482, y = -16.139, z =   84.031 },
        [ 3] = { x = -379.401, y = -16.241, z =   74.315 },
        [ 4] = { x = -375.370, y = -15.467, z =   61.008 },
        [ 5] = { x = -375.713, y = -15.573, z =   56.332 },
        [ 6] = { x = -377.823, y = -15.960, z =   53.003 },
        [ 7] = { x = -382.155, y = -16.086, z =   53.221 },
        [ 8] = { x = -390.062, y = -16.052, z =   58.919 },
        [ 9] = { x = -405.316, y = -16.109, z =   60.108 },
        [10] = { x = -411.645, y = -16.349, z =   64.864 },
        [11] = { x = -418.268, y = -16.196, z =   67.472 },
        [12] = { x = -422.123, y = -15.540, z =   61.139 },
        [13] = { x = -419.891, y = -16.369, z =   53.640 },
        [14] = { x = -419.214, y = -16.145, z =   34.359 },
        [15] = { x = -421.697, y = -16.678, z =   28.603 },
        [16] = { x = -422.582, y = -16.429, z =   23.933 },
        [17] = { x = -428.293, y = -16.132, z =   18.866 },
        [18] = { x = -428.999, y = -16.136, z =   12.626 },
        [19] = { x = -428.412, y = -16.161, z =    7.661 },
        [20] = { x = -420.830, y = -16.096, z =    6.212 },
        [21] = { x = -420.433, y = -16.096, z =    5.663 },
        [22] = { x = -419.332, y = -16.118, z =    1.032 },
        [23] = { x = -419.083, y = -16.131, z =   -5.882 },
        [24] = { x = -416.431, y = -16.220, z =  -14.212 },
        [25] = { x = -415.198, y = -15.613, z =  -20.422 },
        [26] = { x = -415.620, y = -15.638, z =  -21.303 },
        [27] = { x = -419.786, y = -16.058, z =  -27.061 },
        [28] = { x = -434.263, y = -16.202, z =  -20.546 },
        [29] = { x = -442.929, y = -16.171, z =  -20.063 },
        [30] = { x = -452.453, y = -15.150, z =  -27.295 },
        [31] = { x = -458.569, y = -10.989, z =  -27.494 },
        [32] = { x = -458.776, y =  -8.647, z =  -34.805 },
        [33] = { x = -457.681, y =  -9.599, z =  -51.307 },
        [34] = { x = -459.024, y = -10.045, z =  -59.911 },
        [35] = { x = -467.172, y = -10.172, z =  -64.002 },
        [36] = { x = -478.190, y = -10.118, z =  -62.838 },
        [37] = { x = -485.000, y =  -9.811, z =  -75.000 },
    },
}

local restPoints =
{
    [section.initialPath[31]]    = 'restPointOne',
    [section.lowerFork.west[13]] = 'restPointTwo',
    [section.lowerFork.east[22]] = 'restPointThree',
}

local branchPoints =
{
    [section.initialPath[31]] = 'sideRoomOne',
    [section.initialPath[33]] = 'sideRoomTwo',
    [section.initialPath[36]] = 'sideRoomThree',
    [section.initialPath[40]] = 'lowerFork',
}

for roomName, room in pairs(section.sideRooms) do
    restPoints[room.west[#room.west]] = string.format('%sWest', roomName)
    restPoints[room.east[#room.east]] = string.format('%sEast', roomName)
end

local branchOrder = { 'sideRoomOne', 'sideRoomTwo', 'sideRoomThree', 'lowerFork' }

local savedRoute = {}

-- Generates a route to travel - when fleeing he does not return to previously visited side rooms.
local function generateRoute(instance)
    local routeKey = 0

    for _, branch in ipairs(branchOrder) do
        routeKey = routeKey * 2 + instance:getLocalVar(string.format('[Seagull]%s', branch))
    end

    if savedRoute[routeKey] then
        return savedRoute[routeKey]
    end

    local route = {}

    local function add(point)
        if restPoints[point] then
            table.insert(route, { x = point.x, y = point.y, z = point.z, pause = true })
        else
            table.insert(route, point)
        end
    end

    local function choose(branch)
        return instance:getLocalVar(string.format('[Seagull]%s', branch)) == 1 and 'west' or 'east'
    end

    for _, point in ipairs(section.initialPath) do
        add(point)

        local junction = #route
        local branch   = branchPoints[point]
        local rooms    = branch and section.sideRooms[branch]

        if rooms then
            local room = rooms[choose(branch)]

            for i = 1, #room do
                add(room[i])
            end

            for i = #room - 1, 1, -1 do
                add(room[i])
            end

            table.insert(route, { x = point.x, y = point.y, z = point.z, rejoin = junction })

            if not restPoints[point] then
                route[junction] = { x = point.x, y = point.y, z = point.z }
            end

            route[junction].detour = #route

            -- Handles the escape route for points inside a side room.
            for index = junction + 1, #route - 1 do
                local roomPoint = route[index]

                route[index] =
                {
                    x         = roomPoint.x,
                    y         = roomPoint.y,
                    z         = roomPoint.z,
                    pause     = roomPoint.pause,
                    escapeVia = #route,
                }
            end

        elseif branch == 'lowerFork' then
            for _, forkPoint in ipairs(section.lowerFork[choose(branch)]) do
                add(forkPoint)
            end

            for _, finalPoint in ipairs(section.finalPath) do
                add(finalPoint)
            end
        end
    end

    savedRoute[routeKey] = route

    return route
end

local escortState =
{
    WAITING   = 0, -- Initial state, waiting for someone to approach to start the escort.
    STARTING  = 1, -- Walking the start points onto the route. He never returns to these points once has left them.
    ADVANCING = 2, -- Advancing towards the victory point.
    FLEEING   = 3, -- Fleeing, pathing to the escape point.
    RESTING   = 4, -- Resting to catch his breath.
    DONE      = 5, -- At the escape point or victory point. No more pathing.
}

-- The speed that Excaliace runs at when fleeing, based on the level difference between him and the monster. Also changes the flavor text.
local fleeTiers =
{
    { maxLevelDifference = -2, text = ID.text.EXCALIACE_MESSAGE_OFFSET +  9, speed =  40 }, -- Over to you.
    { maxLevelDifference =  0, text = ID.text.EXCALIACE_MESSAGE_OFFSET + 10, speed =  52 }, -- What's this guy up to?
    { maxLevelDifference =  1, text = ID.text.EXCALIACE_MESSAGE_OFFSET + 11, speed =  68 }, -- Uh-oh.
    { maxLevelDifference =  2, text = ID.text.EXCALIACE_MESSAGE_OFFSET + 12, speed =  80 }, -- Wh-what the...!?
    { maxLevelDifference =  4, text = ID.text.EXCALIACE_MESSAGE_OFFSET + 13, speed = 120 }, -- H-help!!!
}

local function startFleeing(excaliace, currentTime, flee)
    excaliace:clearPath()

    if flee.text then
        excaliace:showText(excaliace, flee.text)
    end

    if flee.speed then
        excaliace:setBaseSpeed(flee.speed)
    end

    excaliace:setLocalVar('catchableAt', currentTime + flee.catchTime)
    excaliace:setLocalVar('state', escortState.FLEEING)
    excaliace:setLocalVar('fleeTime', currentTime + math.randomInt(20, 30))
    excaliace:setLocalVar('reachedAt', 0)
    excaliace:setLocalVar('waitTime', 0)
end

local function stopFleeing(excaliace, currentTime)
    excaliace:showText(excaliace, ID.text.EXCALIACE_MESSAGE_OFFSET + 17) -- Damn...
    excaliace:setBaseSpeed(40)
    excaliace:clearPath()
    excaliace:setLocalVar('state', escortState.ADVANCING)
    excaliace:setLocalVar('reachedAt', 0)
    excaliace:setLocalVar('waypoint', excaliace:getLocalVar('waypoint') + 1)
    excaliace:setLocalVar('waitTime', currentTime + 7)
end

local escortHandlers =
{
    -- Waiting in the doorway for someone to approach - this begins the escort.
    [escortState.WAITING] = function(excaliace, instance, currentTime, playerDistance)
        if playerDistance < 10 then
            excaliace:showText(excaliace, ID.text.EXCALIACE_MESSAGE_OFFSET) -- Such a lot of trouble for one little corsair... Shall we be on our way?
            excaliace:setLocalVar('state', escortState.STARTING)
        end
    end,

    [escortState.STARTING] = function(excaliace, instance, currentTime, playerDistance)
        local step  = excaliace:getLocalVar('approachStep') + 1
        local point = section.startPoints[step]

        if point then
            if not excaliace:atPoint(point.x, point.y, point.z) then
                excaliace:pathThrough({ point.x, point.y, point.z })

                return
            end

            excaliace:setLocalVar('approachStep', step)

            point = section.startPoints[step + 1]

            if point then
                excaliace:pathThrough({ point.x, point.y, point.z })

                return
            end
        end

        -- Point 19 is the the point on the main path where the Assault begins. The points before it are used for the escape route.
        excaliace:setLocalVar('waypoint', 19)
        excaliace:setLocalVar('state', escortState.ADVANCING)
    end,

    [escortState.ADVANCING] = function(excaliace, instance, currentTime, playerDistance)
        local flee

        -- Excaliace flees when encountering an enemy, the higher level the enemy, the faster he runs.
        for _, enemy in pairs(instance:getMobs()) do
            if
                enemy:getID() ~= excaliace:getID() and
                enemy:isAlive() and
                excaliace:checkDistance(enemy) < 12
            then
                local levelDifference = enemy:getMainLvl() - excaliace:getMainLvl()

                for _, tier in ipairs(fleeTiers) do
                    if levelDifference <= tier.maxLevelDifference then
                        flee = { text = tier.text, speed = tier.speed, catchTime = 15 }
                        break
                    end
                end

                break
            end
        end

        -- If Excaliace hasn't been escorted for 10 seconds, he flees.
        if
            not flee and
            currentTime - excaliace:getLocalVar('escortSeen') >= 10
        then
            flee = { text = ID.text.EXCALIACE_MESSAGE_OFFSET + 14, speed = 80, catchTime = 10 } -- Now's my chance!
        end

        if flee then
            local waypoint  = excaliace:getLocalVar('waypoint')
            local fleePoint = generateRoute(instance)[waypoint]

            excaliace:setLocalVar('waypoint', fleePoint.escapeVia or fleePoint.rejoin or math.max(waypoint - 1, 1))
            startFleeing(excaliace, currentTime, flee)

            return escortState.FLEEING
        end

        if playerDistance < 2 then
            excaliace:clearPath()
            excaliace:setLocalVar('waitTime', math.max(excaliace:getLocalVar('waitTime'), currentTime + 3))

            if currentTime >= excaliace:getLocalVar('complainTime') then
                excaliace:showText(excaliace, ID.text.EXCALIACE_MESSAGE_OFFSET + 15) -- Okay, okay, you got me! I promise I won't run again if you step back a bit...please.
                excaliace:setLocalVar('complainTime', currentTime + 30)
            end
        end

        return escortState.ADVANCING
    end,

    -- Excaliace is fleeing, will continue until he runs out of breath or a player catches him.
    [escortState.FLEEING] = function(excaliace, instance, currentTime, playerDistance)
        if
            playerDistance < 6 and
            currentTime >= excaliace:getLocalVar('catchableAt')
        then
            stopFleeing(excaliace, currentTime)

            return
        end

        if currentTime >= excaliace:getLocalVar('fleeTime') then
            excaliace:showText(excaliace, ID.text.EXCALIACE_MESSAGE_OFFSET + 16) -- <Pant>...<wheeze>...
            excaliace:clearPath()
            excaliace:setLocalVar('state', escortState.RESTING)
            excaliace:setLocalVar('waitTime', currentTime + 30)

            return
        end

        return escortState.FLEEING
    end,

    -- Escaliace is catching his breath, he will resume fleeing once he has rested enough unless intercepted by a player.
    [escortState.RESTING] = function(excaliace, instance, currentTime, playerDistance)
        if playerDistance < 6 then
            local reachedAt = excaliace:getLocalVar('reachedAt')

            if reachedAt == 0 then
                excaliace:setLocalVar('reachedAt', currentTime)
            elseif currentTime >= reachedAt + 2 then
                stopFleeing(excaliace, currentTime)
            end

            return
        end

        excaliace:setLocalVar('reachedAt', 0)

        if currentTime < excaliace:getLocalVar('waitTime') then
            return
        end

        startFleeing(excaliace, currentTime, { catchTime = 10 })

        return escortState.FLEEING
    end,
}

local function updateEscort(excaliace, instance)
    -- Excaliace has reached the escape point or end point. Nothing else to do.
    local pathingState = excaliace:getLocalVar('state')
    if pathingState == escortState.DONE then
        return
    end

    local currentTime    = GetSystemTime()
    local playerDistance = math.huge

    -- Check if Excaliace is being escorted by a player.
    for _, player in pairs(instance:getChars()) do
        playerDistance = math.min(playerDistance, excaliace:checkDistance(player))
    end

    if playerDistance < 10 then
        excaliace:setLocalVar('escortSeen', currentTime)
    end

    local handler = escortHandlers[pathingState]
    local pathing = handler and handler(excaliace, instance, currentTime, playerDistance)

    if not pathing then
        return
    end

    local route    = generateRoute(instance)
    local waypoint = excaliace:getLocalVar('waypoint')
    local point    = route[waypoint]

    if
        not point or
        currentTime < excaliace:getLocalVar('waitTime')
    then
        return
    end

    if not excaliace:atPoint(point.x, point.y, point.z) then
        excaliace:pathThrough({ point.x, point.y, point.z })

        return
    end

    if pathing == escortState.ADVANCING then
        if
            point.pause and
            waypoint > excaliace:getLocalVar('pausedThrough')
        then
            excaliace:setLocalVar('pausedThrough', waypoint)
            excaliace:setLocalVar('waitTime', currentTime + 17)

            return
        end

        -- The goal is the last waypoint on the route, the escape point the first.
        if waypoint == #route then
            excaliace:setLocalVar('state', escortState.DONE)
            excaliace:showText(excaliace, ID.text.EXCALIACE_MESSAGE_OFFSET + 1) -- Yeah, I got it. Stay here and keep quiet.

            excaliace:timer(2000, function(excaliaceArg)
                excaliaceArg:showText(excaliaceArg, ID.text.EXCALIACE_MESSAGE_OFFSET + 2) -- Hey... It was a short trip, but nothing is ever dull around you, huh?
            end)

            -- Setting instance progress to 1 spawns the chest & rune of release.
            excaliace:timer(7000, function()
                instance:setProgress(1)
            end)

            return
        end

        if
            point.detour and
            excaliace:getLocalVar('pausedThrough') > waypoint
        then
            waypoint = point.detour
        end

        waypoint = waypoint + 1
    else
        if waypoint == 1 then
            excaliace:showText(excaliace, ID.text.EXCALIACE_MESSAGE_OFFSET + 3) -- Heh. The Immortals really must be having troubles finding troops if they sent this bunch of slowpokes...
            excaliace:setLocalVar('state', escortState.DONE)
            instance:fail()

            return
        end

        waypoint = (point.rejoin or waypoint) - 1
    end

    excaliace:setLocalVar('waypoint', waypoint)

    local nextPoint = route[waypoint]
    if nextPoint then
        excaliace:pathThrough({ nextPoint.x, nextPoint.y, nextPoint.z })
    end
end

-- The instance tick runs once per second which is too slow to emulate retail. Use a 400ms timer instead.
local function scheduleEscortUpdate(excaliace, instance)
    excaliace:timer(400, function(excaliaceArg)
        if
            not excaliaceArg:isSpawned() or
            instance:failed() or
            instance:completed() or
            excaliaceArg:getLocalVar('state') == escortState.DONE
        then
            return
        end

        updateEscort(excaliaceArg, instance)
        scheduleEscortUpdate(excaliaceArg, instance)
    end)
end

-- Route branches are rolled on instance creation and saved as variables for building the path.
function content:onInstanceCreated(instance)
    InstanceAssault.onInstanceCreated(self, instance)

    for branch in pairs(section.sideRooms) do
        instance:setLocalVar(string.format('[Seagull]%s', branch), math.randomInt(0, 1))
    end

    instance:setLocalVar('[Seagull]lowerFork', math.randomInt(0, 1))

    local excaliace = GetMobByID(ID.mob.EXCALIACE, instance)
    if excaliace and excaliace:isSpawned() then
        scheduleEscortUpdate(excaliace, instance)
    end
end

return content:register()
