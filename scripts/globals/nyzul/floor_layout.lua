-----------------------------------
-- Nyzul Isle: Floor generation methods and data.
-----------------------------------
local ID = zones[xi.zone.NYZUL_ISLE]
-----------------------------------
xi = xi or {}
xi.nyzul = xi.nyzul or {}

-----------------------------------
-- Enums
-----------------------------------
local room = -- Name: room.BLOCK_GROUP_ROOM-NUMBER/NAME
{
    -- Rooms located in North-East block.

    -- Rooms located in Central block.

    -- Rooms located in East block.
    E_1_1 = 1,
    E_1_2 = 2,
    E_1_3 = 3,
    E_1_4 = 4,
    E_2_1 = 5,
    E_2_2 = 6,
    E_2_3 = 7,
    E_2_4 = 8,
    E_3_1 = 9,
    E_3_2 = 10,
    E_3_3 = 11,
    E_3_4 = 12,
    E_3_5 = 13,
    E_3_6 = 14,
    E_4_1 = 15,
    E_4_2 = 16,
    E_4_3 = 17,
    E_4_4 = 18,
    E_4_5 = 19,
    E_5_1 = 20,
    E_5_2 = 21,
    E_5_3 = 22,
    E_5_4 = 23,

    -- Rooms located in South block.

    -- Rooms located in South-East block.

    -- Rooms located in South-East block.
    SE_1_EXT_N       = 24,
    SE_2_EXT_E       = 25,
    SE_3_EXT_S       = 26,
    SE_4_INT_N       = 27,
    SE_4_INT_NE      = 28,
    SE_5_INT_E       = 29,
    SE_5_INT_SE      = 30,
    SE_6_INT_S       = 31,
    SE_6_INT_SW      = 32,
    SE_6_EXT_W_LOWER = 33,
    SE_7_INT_W       = 34,
    SE_7_INT_NW      = 35,
    SE_7_EXT_W_UPPER = 36,
}

local group = -- Name: group.BLOCK_GROUP
{
    -- Room groups located in North-East block.

    -- Room groups located in Central block.

    -- Room groups located in East block.
    E_1 = 1,
    E_2 = 2,
    E_3 = 3,
    E_4 = 4,
    E_5 = 5,

    -- Room groups located in South-West block.

    -- Room groups located in South block.

    -- Room groups located in South-East block.
    SE_1 = 6,
    SE_2 = 7,
    SE_3 = 8,
    SE_4 = 9,
    SE_5 = 10,
    SE_6 = 11,
    SE_7 = 12,
}

local block = -- Name: block.BLOCK
{
    NORTH_EAST = 1,
    CENTRAL    = 2,
    EAST       = 3,
    SOUTH_WEST = 4,
    SOUTH      = 5,
    SOUTH_EAST = 6,
}

-----------------------------------
-- Data
-----------------------------------
-- Information of all individual rooms.
local roomInfoTable =
{
    -- East block (5 groups, 23 rooms).
    [room.E_1_1] = -- In group E_1.
    {
        mobSpawnPoints  = {  },
        lampSpawnPoints = {  },
    },
    [room.E_1_2] = -- In group E_1.
    {
        mobSpawnPoints  = {  },
        lampSpawnPoints = {  },
    },
    [room.E_1_3] = -- In group E_1.
    {
        mobSpawnPoints  = {  },
        lampSpawnPoints = {  },
    },
    [room.E_1_4] = -- In group E_1.
    {
        mobSpawnPoints  = {  },
        lampSpawnPoints = {  },
    },
    [room.E_2_1] = -- In group E_2.
    {
        mobSpawnPoints  = {  },
        lampSpawnPoints = {  },
    },
    [room.E_2_2] = -- In group E_2.
    {
        mobSpawnPoints  = {  },
        lampSpawnPoints = {  },
    },
    [room.E_2_3] = -- In group E_2.
    {
        mobSpawnPoints  = {  },
        lampSpawnPoints = {  },
    },
    [room.E_2_4] = -- In group E_2.
    {
        mobSpawnPoints  = {  },
        lampSpawnPoints = {  },
    },
    [room.E_3_1] = -- In group E_3.
    {
        mobSpawnPoints  = {  },
        lampSpawnPoints = {  },
    },
    [room.E_3_2] = -- In group E_3.
    {
        mobSpawnPoints  = {  },
        lampSpawnPoints = {  },
    },
    [room.E_3_3] = -- In group E_3.
    {
        mobSpawnPoints  = {  },
        lampSpawnPoints = {  },
    },
    [room.E_3_4] = -- In group E_3.
    {
        mobSpawnPoints  = {  },
        lampSpawnPoints = {  },
    },
    [room.E_3_5] = -- In group E_3.
    {
        mobSpawnPoints  = {  },
        lampSpawnPoints = {  },
    },
    [room.E_3_6] = -- In group E_3.
    {
        mobSpawnPoints  = {  },
        lampSpawnPoints = {  },
    },
    [room.E_4_1] = -- In group E_4.
    {
        mobSpawnPoints  = {  },
        lampSpawnPoints = {  },
    },
    [room.E_4_2] = -- In group E_4.
    {
        mobSpawnPoints  = {  },
        lampSpawnPoints = {  },
    },
    [room.E_4_3] = -- In group E_4.
    {
        mobSpawnPoints  = {  },
        lampSpawnPoints = {  },
    },
    [room.E_4_4] = -- In group E_4.
    {
        mobSpawnPoints  = {  },
        lampSpawnPoints = {  },
    },
    [room.E_4_5] = -- In group E_4.
    {
        mobSpawnPoints  = {  },
        lampSpawnPoints = {  },
    },
    [room.E_5_1] = -- In group E_5.
    {
        mobSpawnPoints  = {  },
        lampSpawnPoints = {  },
    },
    [room.E_5_2] = -- In group E_5.
    {
        mobSpawnPoints  = {  },
        lampSpawnPoints = {  },
    },
    [room.E_5_3] = -- In group E_5.
    {
        mobSpawnPoints  = {  },
        lampSpawnPoints = {  },
    },
    [room.E_5_4] = -- In group E_5.
    {
        mobSpawnPoints  = {  },
        lampSpawnPoints = {  },
    },

    -- South-East block (7 groups, 13 rooms).
    [room.SE_1_EXT_N] = -- In group SE_1.
    {
        mobSpawnPoints  = { { 460, 0, -446.5 }, { 460, 0, -433.5 }, { 433.5, 0, -433.5 }, { 486.5, 0, -433.5 }, { 460, 0, -429 } },
        lampSpawnPoints = { { 480, 0, -440   }, { 460, 0, -440   }, { 440,   0, -440   } },
    },
    [room.SE_2_EXT_E] = -- In group SE_2.
    {
        mobSpawnPoints  = { { 553, 0, -560 }, { 560, 0, -552.5 }, { 560, 0, -527.5 }, { 553.5, 0, -513.5 }, { 553.5, 0, -540 } },
        lampSpawnPoints = { { 560, 0, -540 }, { 560, 0, -520   }, { 560, 0, -560   } },
    },
    [room.SE_3_EXT_S] = -- In group SE_3.
    {
        mobSpawnPoints  = { { 460, 0, -640   }, { 486.5, 0, -646.5 }, { 433.5, 0, -646.5 }, { 486.5, 0, -633.5 }, { 433.5, 0, -633.5 } },
        lampSpawnPoints = { { 460, 0, -646.5 }, { 460,   0, -633.5 } },
    },
    [room.SE_4_INT_N] = -- In group SE_4.
    {
        mobSpawnPoints  = { { 473.5, 0, -486.5 }, { 446.5, 0, -486.5 }, { 455.5, 0, -495.5 }, { 464.5, 0, -500 }, { 455.5, 0, -513.5 } },
        lampSpawnPoints = { { 451,   0, -486.5 }, { 469,   0, -486.5 } },
    },
    [room.SE_4_INT_NE] = -- In group SE_4.
    {
        mobSpawnPoints  = { { 509, 0, -500 }, { 491, 0, -500 }, { 491, 0, -509 }, { 486.5, 0, -513.5 }, { 500, 0, -486.5 } },
        lampSpawnPoints = { { 491, 0, -500 }, { 500, 0, -509 } },
    },
    [room.SE_5_INT_E] = -- In group SE_5.
    {
        mobSpawnPoints  = { { 500, 0, -540 }, { 509, 0, -531 }, { 491, 0, -549 }, { 491, 0, -531 }, { 509, 0, -549 } },
        lampSpawnPoints = { { 491, 0, -540 }, { 509, 0, -540 } },
    },
    [room.SE_5_INT_SE] = -- In group SE 5.
    {
        mobSpawnPoints  = { { 513.5, 0, -593.5 }, { 505.5, 0, -585.5 }, { 491, 0, -571 }, { 486.5, 0, -566.5 }, { 486.5, 0, -593.5 } },
        lampSpawnPoints = { { 509,   0, -589   }, { 491,   0, -580   } },
    },
    [room.SE_6_INT_S] = -- In group SE 6.
    {
        mobSpawnPoints  = { { 464.5, 0, -566.5 }, { 464.5, 0, -580   }, { 455.5, 0, -584.5 }, { 455.5, 0, -566.5 }, { 446.5, 0, -571 } },
        lampSpawnPoints = { { 446.5, 0, -566.5 }, { 473.5, 0, -566.5 } },
    },
    [room.SE_6_INT_SW] = -- In group SE 6.
    {
        mobSpawnPoints  = { { 424.5, 0, -575.5 }, { 415.5, 0, -580   }, { 411, 0, -593.5 }, { 406.5, 0, -566.5 }, { 429, 0, -566.5 } },
        lampSpawnPoints = { { 424.5, 0, -580   }, { 420,   0, -575.5 } },
    },
    [room.SE_6_EXT_W_LOWER] = -- In group SE_6.
    {
        mobSpawnPoints  = { { 366.5, 0, -535.5 }, { 375.5, 0, -535.5 }, { 384.5, 0, -540 }, { 375.5, 0, -544.5 }, { 366.5, 0, -549 } },
        lampSpawnPoints = { { 366.5, 0, -535.5 }, { 366.5, 0, -535.5 } },
    },
    [room.SE_7_INT_W] = -- In group SE 7.
    {
        mobSpawnPoints  = { { 433.5, 0, -553.5 }, { 415.5, 0, -535.5 }, { 429, 0, -531 }, { 411, 0, -549 }, { 420, 0, -540 } },
        lampSpawnPoints = { { 420,   0, -540   }, { 429,   0, -549   } },
    },
    [room.SE_7_INT_NW] = -- In group SE 7.
    {
        mobSpawnPoints  = { { 406.5, 0, -513.5 }, { 433.5, 0, -509   }, { 433.5, 0, -486.5 }, { 424.5, 0, -495.5 }, { 415.5, 0, -495.5 } },
        lampSpawnPoints = { { 420,   0, -504.5 }, { 411,   0, -513.5 } },
    },
    [room.SE_7_EXT_W_UPPER] = -- In group SE_7.
    {
        mobSpawnPoints  = { { 366.5, 0, -526.5 }, { 393.5, 0, -553.5 }, { 393.5, 0, -526.5 }, { 380, 0, -526.5 }, { 393.5, 0, -540 } },
        lampSpawnPoints = { { 366.5, 0, -526.5 }, { 393.5, 0, -553.5 } },
    },
}

-- Information of all rooms that form an indivisible group (No doors to separate them).
local groupInfoTable =
{
    -- East block (5 groups, 23 rooms).
    [group.E_1] =
    {
        rooms       = { room.E_1_1, room.E_1_2, room.E_1_3, room.E_1_4 },
        connections =
        {
            { group.E_2, { ID.npc.DOOR_OFFSET + 14 } }, -- _25f
            { group.E_3, { ID.npc.DOOR_OFFSET + 16 } }, -- _25h
        },
    },
    [group.E_2] =
    {
        rooms       = { room.E_2_1, room.E_2_2, room.E_2_3, room.E_2_4 },
        connections =
        {
            { group.E_1, { ID.npc.DOOR_OFFSET + 14 } }, -- _25f
            { group.E_3, { ID.npc.DOOR_OFFSET + 15 } }, -- _25g
            { group.E_4, { ID.npc.DOOR_OFFSET + 13 } }, -- _25e
        },
    },
    [group.E_3] =
    {
        rooms       = { room.E_3_1, room.E_3_2, room.E_3_3, room.E_3_4, room.E_3_5, room.E_3_6 },
        connections =
        {
            { group.E_1, { ID.npc.DOOR_OFFSET + 16                          } }, -- _25h
            { group.E_2, { ID.npc.DOOR_OFFSET + 15                          } }, -- _25g
            { group.E_4, { ID.npc.DOOR_OFFSET + 10, ID.npc.DOOR_OFFSET + 12 } }, -- _25b, _25d
        },
    },
    [group.E_4] =
    {
        rooms       = { room.E_4_1, room.E_4_2, room.E_4_3, room.E_4_4, room.E_4_5 },
        connections =
        {
            { group.E_2, { ID.npc.DOOR_OFFSET + 13                          } }, -- _25e
            { group.E_3, { ID.npc.DOOR_OFFSET + 10, ID.npc.DOOR_OFFSET + 12 } }, -- _25b, _25d
            { group.E_5, { ID.npc.DOOR_OFFSET +  9, ID.npc.DOOR_OFFSET + 11 } }, -- _25a, _25c
        },
    },
    [group.E_5] =
    {
        rooms       = { room.E_5_1, room.E_5_2, room.E_5_3, room.E_5_4 },
        connections =
        {
            { group.E_4, { ID.npc.DOOR_OFFSET + 9, ID.npc.DOOR_OFFSET + 11 } }, -- _25a, _25c
        },
    },

    -- South-East block (7 groups, 13 rooms).
    [group.SE_1] =
    {
        rooms       = { room.SE_1_EXT_N },
        connections =
        {
            { group.SE_4, { ID.npc.DOOR_OFFSET + 8 } }, -- _259
        },
    },
    [group.SE_2] =
    {
        rooms       = { room.SE_2_EXT_E },
        connections =
        {
            { group.SE_5, { ID.npc.DOOR_OFFSET + 5 } }, -- _256
        },
    },
    [group.SE_3] =
    {
        rooms       = { room.SE_3_EXT_S },
        connections =
        {
            { group.SE_6, { ID.npc.DOOR_OFFSET + 2 } }, -- _251
        },
    },
    [group.SE_4] =
    {
        rooms       = { room.SE_4_INT_N, room.SE_4_INT_NE },
        connections =
        {
            { group.SE_1, { ID.npc.DOOR_OFFSET + 8 } }, -- _259
            { group.SE_5, { ID.npc.DOOR_OFFSET + 6 } }, -- _257
            { group.SE_7, { ID.npc.DOOR_OFFSET + 7 } }, -- _258
        },
    },
    [group.SE_5] =
    {
        rooms       = { room.SE_5_INT_E, room.SE_5_INT_SE },
        connections =
        {
            { group.SE_2, { ID.npc.DOOR_OFFSET + 5 } }, -- _256
            { group.SE_4, { ID.npc.DOOR_OFFSET + 6 } }, -- _257
            { group.SE_6, { ID.npc.DOOR_OFFSET + 3 } }, -- _252
        },
    },
    [group.SE_6] =
    {
        rooms       = { room.SE_6_INT_S, room.SE_6_INT_SW, room.SE_6_EXT_W_LOWER },
        connections =
        {
            { group.SE_3, { ID.npc.DOOR_OFFSET + 2                                             } }, -- _251
            { group.SE_5, { ID.npc.DOOR_OFFSET + 3                                             } }, -- _252
            { group.SE_7, { ID.npc.DOOR_OFFSET, ID.npc.DOOR_OFFSET + 1, ID.npc.DOOR_OFFSET + 4 } }, -- _253, _254, _255
        },
    },
    [group.SE_7] =
    {
        rooms       = { room.SE_7_INT_W, room.SE_7_INT_NW, room.SE_7_EXT_W_UPPER },
        connections =
        {
            { group.SE_4, { ID.npc.DOOR_OFFSET + 7                                             } }, -- _258
            { group.SE_6, { ID.npc.DOOR_OFFSET, ID.npc.DOOR_OFFSET + 1, ID.npc.DOOR_OFFSET + 4 } }, -- _253, _254, _255
        },
    },
}

-- Blocks are independent. Contain groups of rooms. The selection of those room groups define a layout.
local blockInfoTable =
{
    [block.NORTH_EAST] = {  },
    [block.CENTRAL   ] = {  },
    [block.EAST      ] = { group.E_1,  group.E_2,  group.E_3,  group.E_4,  group.E_5                          },
    [block.SOUTH_WEST] = {  },
    [block.SOUTH     ] = {  },
    [block.SOUTH_EAST] = { group.SE_1, group.SE_2, group.SE_3, group.SE_4, group.SE_5, group.SE_6, group.SE_7 },
}

-----------------------------------
-- Logic
-----------------------------------
xi.nyzul.generateRandomLayout = function()
    local layout               = {}
    layout.mobSpwanPointTable  = {}
    layout.lampSpawnPointTable = {}
    layout.doorsToOpenTable    = {}
    layout.runeSpawnPoint      = {}

    -- 1. Select one block (currently hardcoded to 6; later use math.random(1, 6))
    local chosenBlockId      = 6

    -- 2: Select 1 (any) group from the block to start the layout.
    local allowedGroupsTable = blockInfoTable[chosenBlockId]       -- This table is used to track which groups can be picked.
    local randomEntry        = math.random(1, #allowedGroupsTable) -- We pick an entry from the table at random.
    local initialGroupId     = allowedGroupsTable[randomEntry]     -- We fetch the data picked.
    table.remove(allowedGroupsTable, randomEntry)                  -- We remove the picked entry, to ensure we don't repeat it.

    -- 3: Create a list of rooms and track the amount we have.
    local roomTable   = {}                              -- We will store all individual room IDs from all groups used here.
    local groupTable  = {}                              -- This secondary group table is used to store CONNECTED groups + door data. This is because we have to pick adjacent groups mandatorily.
    local roomsNeeded = 6 + math.random(0, 2)           -- We need 6 rooms at the bare minimum.
    table.insert(groupTable, { initialGroupId, { 0 } }) -- Populate secondary group table with our initial pick. DO NOT populate doors.

    -- Repeat process until we ensure the amount of rooms we need is reached.
    while #roomTable < roomsNeeded do
        -- 3a. Pick a random entry from the secondary table. Contains connection and door data.
        randomEntry = math.random(1, #groupTable)

        -- 3b. Unpack info and delete entry.
        local groupId   = groupTable[randomEntry][1]
        local doorTable = groupTable[randomEntry][2]
        table.remove(groupTable, randomEntry)

        -- 3c. Handle doors.
        randomEntry = math.random(1, #doorTable) -- This will choose how many doors we open.
        for i = 1, randomEntry do
            local doorId = doorTable[i]
            if doorId ~= 0 then
                table.insert(layout.doorsToOpenTable, doorId)
            end
        end

        -- Store room IDs contained in chosen group entry.
        local groupInfo = groupInfoTable[groupId]
        for i = 1, #groupInfo.rooms do
            table.insert(roomTable, groupInfo.rooms[i])
        end

        -- 3d. Prepare next loop with chosen group entry.
        for i = 1, #groupInfo.connections do -- First loop: Runs for all entries always.
            -- Ensure entry can be chosen in the first place.
            local connectedGroupId = groupInfo.connections[i][1]
            for j = 1, #allowedGroupsTable do -- Second loop. Break if we find a match. A match means it can be picked.
                if connectedGroupId == allowedGroupsTable[j] then
                    table.insert(groupTable, groupInfo.connections[i])
                    table.remove(allowedGroupsTable, j)

                    break
                end
            end
        end
    end

    -- 4. Choose one room from roomTable as the initial spawn for the rune.
    local initialRoomIndex    = math.random(1, #roomTable)
    local runicPortalPosTable = roomInfoTable[roomTable[initialRoomIndex]].lampSpawnPoints

    table.insert(layout.runeSpawnPoint, runicPortalPosTable[math.random(1, #runicPortalPosTable)])
    table.remove(roomTable, initialRoomIndex)

    -- 5. Populate the mob and lamp spawn point tables from the remaining rooms.
    for _, roomId in ipairs(roomTable) do
        local roomData = roomInfoTable[roomId]

        for _, coordinates in ipairs(roomData.mobSpawnPoints) do
            table.insert(layout.mobSpwanPointTable, coordinates)
        end

        for _, coordinates in ipairs(roomData.lampSpawnPoints) do
            table.insert(layout.lampSpawnPointTable, coordinates)
        end
    end

    return layout
end
