-----------------------------------
-- Area: Temenos
--  NPC: Armoury Crate
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/limbus")
require("scripts/globals/zone")
local ID = require("scripts/zones/Temenos/IDs")
-----------------------------------
local entity = {}

local loot =
{
    [1299] =
    {
        -- northern tower floor 1
        [1] =
        {
            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid =    0, droprate = 1000 },
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid =    0, droprate = 1000 },
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid =    0, droprate = 250 },
                { itemid = 1954, droprate = 159 },
                { itemid = 1940, droprate = 146 },
                { itemid = 1932, droprate =  85 },
                { itemid = 1956, droprate = 171 },
                { itemid = 1934, droprate = 110 },
                { itemid = 2658, droprate = 220 },
                { itemid = 2716, droprate =  98 },
            },

            {
                { itemid =    0, droprate = 250 },
                { itemid = 1954, droprate = 159 },
                { itemid = 1940, droprate = 146 },
                { itemid = 1932, droprate =  85 },
                { itemid = 1956, droprate = 171 },
                { itemid = 1934, droprate = 110 },
                { itemid = 2658, droprate = 220 },
                { itemid = 2716, droprate =  98 },
            },
        },

        -- northern tower floor 2
        [2] =
        {
            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid =    0, droprate = 1000 },
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid =    0, droprate = 1000 },
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid =    0, droprate = 400 },
                { itemid = 1932, droprate = 333 },
                { itemid = 1954, droprate = 200 },
                { itemid = 1950, droprate = 100 },
                { itemid = 1940, droprate =  90 },
                { itemid = 1942, droprate =  70 },
                { itemid = 1934, droprate =  90 },
                { itemid = 1936, droprate = 100 },
                { itemid = 1958, droprate =  90 },
                { itemid = 2656, droprate =  67 },
                { itemid = 1956, droprate = 167 },
            },

            {
                { itemid =    0, droprate = 400 },
                { itemid = 1932, droprate = 333 },
                { itemid = 1954, droprate = 200 },
                { itemid = 1950, droprate = 100 },
                { itemid = 1940, droprate =  90 },
                { itemid = 1942, droprate =  70 },
                { itemid = 1934, droprate =  90 },
                { itemid = 1936, droprate = 100 },
                { itemid = 1958, droprate =  90 },
                { itemid = 2656, droprate =  67 },
                { itemid = 1956, droprate = 167 },
            },
        },

        -- northern tower floor 3
        [3] =
        {
            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid =    0, droprate = 1000 },
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid =    0, droprate = 1000 },
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1956, droprate =  27 },
                { itemid = 1932, droprate = 324 },
                { itemid = 1950, droprate =  80 },
                { itemid = 1934, droprate = 189 },
                { itemid = 1930, droprate =  50 },
                { itemid = 1940, droprate =  27 },
                { itemid = 1936, droprate =  81 },
                { itemid = 1944, droprate =  80 },
                { itemid = 1958, droprate =  81 },
                { itemid = 2658, droprate = 270 },
                { itemid = 2714, droprate = 108 },
            },

            {
                { itemid =    0, droprate = 300 },
                { itemid = 1956, droprate =  27 },
                { itemid = 1932, droprate = 324 },
                { itemid = 1950, droprate =  80 },
                { itemid = 1934, droprate = 189 },
                { itemid = 1930, droprate =  50 },
                { itemid = 1940, droprate =  27 },
                { itemid = 1936, droprate =  81 },
                { itemid = 1944, droprate =  80 },
                { itemid = 1958, droprate =  81 },
                { itemid = 2658, droprate = 270 },
                { itemid = 2714, droprate = 108 },
            },
        },

        -- northern tower floor 4
        [4] =
        {
            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid =    0, droprate = 1000 },
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid =    0, droprate = 1000 },
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid =    0, droprate = 300 },
                { itemid = 1942, droprate =  90 },
                { itemid = 1934, droprate = 435 },
                { itemid = 1956, droprate =  80 },
                { itemid = 1940, droprate = 174 },
                { itemid = 1958, droprate =  87 },
                { itemid = 1954, droprate =  90 },
                { itemid = 1936, droprate =  87 },
                { itemid = 1930, droprate =  43 },
                { itemid = 2656, droprate =  27 },
                { itemid = 2658, droprate = 261 },
            },

            {
                { itemid =    0, droprate = 300 },
                { itemid = 1942, droprate =  90 },
                { itemid = 1934, droprate = 435 },
                { itemid = 1956, droprate =  80 },
                { itemid = 1940, droprate = 174 },
                { itemid = 1958, droprate =  87 },
                { itemid = 1954, droprate =  90 },
                { itemid = 1936, droprate =  87 },
                { itemid = 1930, droprate =  43 },
                { itemid = 2656, droprate =  27 },
                { itemid = 2658, droprate = 261 },
            },
        },

        -- northern tower floor 5
        [5] =
        {
            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid =    0, droprate = 1000 },
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid =    0, droprate = 1000 },
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid =    0, droprate = 200 },
                { itemid = 1954, droprate =  67 },
                { itemid = 1940, droprate = 353 },
                { itemid = 1936, droprate =  87 },
                { itemid = 1956, droprate = 110 },
                { itemid = 1958, droprate =  87 },
                { itemid = 1942, droprate =  50 },
                { itemid = 1950, droprate =  60 },
                { itemid = 1932, droprate =  59 },
                { itemid = 2716, droprate = 100 },
                { itemid = 2714, droprate = 110 },
            },

            {
                { itemid =    0, droprate = 200 },
                { itemid = 1954, droprate =  67 },
                { itemid = 1940, droprate = 353 },
                { itemid = 1936, droprate =  87 },
                { itemid = 1956, droprate = 110 },
                { itemid = 1958, droprate =  87 },
                { itemid = 1942, droprate =  50 },
                { itemid = 1950, droprate =  60 },
                { itemid = 1932, droprate =  59 },
                { itemid = 2716, droprate = 100 },
                { itemid = 2714, droprate = 110 },
            },
        },
    -- northern tower floor 6
        [6] =
        {
            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid =    0, droprate = 1000 },
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid =    0, droprate = 1000 },
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1954, droprate = 263 },
                { itemid = 1932, droprate =  59 },
                { itemid = 1942, droprate =  53 },
                { itemid = 1934, droprate =  60 },
                { itemid = 1956, droprate = 526 },
                { itemid = 1930, droprate =  60 },
                { itemid = 1936, droprate =  53 },
                { itemid = 1950, droprate = 158 },
                { itemid = 2716, droprate = 105 },
            },

            {
                { itemid =    0, droprate = 300 },
                { itemid = 1954, droprate = 263 },
                { itemid = 1932, droprate =  59 },
                { itemid = 1942, droprate =  53 },
                { itemid = 1934, droprate =  60 },
                { itemid = 1956, droprate = 526 },
                { itemid = 1930, droprate =  60 },
                { itemid = 1936, droprate =  53 },
                { itemid = 1950, droprate = 158 },
                { itemid = 2716, droprate = 105 },
            },
        },

        -- northern tower floor 7
        [7] =
        {
            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1956, droprate = 240 },
                { itemid = 1932, droprate = 120 },
                { itemid = 1940, droprate = 200 },
                { itemid = 1934, droprate =  40 },
                { itemid = 1954, droprate = 120 },
                { itemid = 2658, droprate = 200 },
                { itemid = 2716, droprate =  80 },
            },

            {
                { itemid = 1904, droprate = 1000 },
            },

            {
                { itemid =    0, droprate = 100 },
                { itemid = 2127, droprate =  55 },
            },
        },
    },

    -- central temenos basement
    [1301] =
    {
        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1875, droprate = 1000 },
        },
    },

    -- central temenos floor 1
    [1303] =
    {
        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1930, droprate = 265 },
            { itemid = 1938, droprate = 118 },
            { itemid = 1948, droprate = 147 },
            { itemid = 1958, droprate = 147 },
            { itemid = 1952, droprate = 118 },
            { itemid = 2656, droprate = 235 },
        },

        {
            { itemid = 1986, droprate = 1000 },
        },
    },

    -- central temenos floor 2
    [1304] =
    {
        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1944, droprate = 250 },
            { itemid = 1936, droprate =  94 },
            { itemid = 1950, droprate =  63 },
            { itemid = 1942, droprate = 125 },
            { itemid = 1946, droprate =  63 },
            { itemid = 2660, droprate = 281 },
            { itemid = 2714, droprate = 125 },
        },

        {
            { itemid = 1908, droprate = 1000 },
        },
    },

    -- central temenos floor 3
    [1305] =
    {
        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1934, droprate =  53 },
            { itemid = 1940, droprate = 132 },
            { itemid = 1954, droprate = 105 },
            { itemid = 1932, droprate = 211 },
            { itemid = 1956, droprate = 211 },
            { itemid = 1930, droprate = 100 },
            { itemid = 2658, droprate = 211 },
            { itemid = 2716, droprate = 105 },
        },

        {
            { itemid = 1907, droprate = 1000 },
        },
    },

    -- central temenos floor 4
    [1306] =
    {
        [1] =
        {
            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1920, droprate = 659 },
                { itemid = 1924, droprate = 394 },
                { itemid = 1923, droprate = 388 },
                { itemid = 1922, droprate = 404 },
            },

            {
                { itemid = 1924, droprate = 394 },
                { itemid = 1922, droprate = 402 },
                { itemid = 1920, droprate = 659 },
                { itemid = 1923, droprate = 383 },
            },

            {
                { itemid = 1921, droprate = 265 },
                { itemid =    0, droprate = 735 },
            },
        },

        -- central temenos floor 4 side loot
        [2] =
        {
            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1875, droprate = 1000 },
            },

            {
                { itemid = 1934, droprate = 200 },
                { itemid = 1930, droprate = 200 },
                { itemid = 1958, droprate = 200 },
                { itemid = 2658, droprate = 400 },
                { itemid = 1940, droprate = 200 },
            },
        },
    },
}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local battlefield = player:getBattlefield()
    if not battlefield then
        return
    end
    local crateID = npc:getID()
    local model = npc:getModelId()
    local xPos = npc:getXPos()
    local yPos = npc:getYPos()
    local zPos = npc:getZPos()
    local bfid = battlefield:getID()
    local hold = false
    if npc:getLocalVar("open") == 0 then
        switch (bfid): caseof
        {
            [1299] = function() -- Temenos North Crate Handling
                if crateID ~= ID.npc.TEMENOS_N_CRATE[7] then
                    for i = 1, 6 do
                        for j = 0, 2 do
                            if crateID == ID.npc.TEMENOS_N_CRATE[i] + j then
                                if j ~= 0 then GetNPCByID(ID.npc.TEMENOS_N_CRATE[i]):setStatus(xi.status.DISAPPEAR) end
                                if j ~= 1 then GetNPCByID(ID.npc.TEMENOS_N_CRATE[i] + 1):setStatus(xi.status.DISAPPEAR) end
                                if j ~= 2 then GetNPCByID(ID.npc.TEMENOS_N_CRATE[i] + 2):setStatus(xi.status.DISAPPEAR) end
                                if model == 960 then
                                    xi.battlefield.HealPlayers(battlefield)
                                elseif model == 961 then
                                    xi.limbus.handleLootRolls(battlefield, loot[bfid][i], nil, npc)
                                elseif model == 962 then
                                    xi.limbus.extendTimeLimit(battlefield, 15, xi.zone.TEMENOS)
                                end
                            end
                        end
                    end
                else
                    xi.limbus.handleLootRolls(battlefield, loot[bfid][7], nil, npc)
                    battlefield:setLocalVar("cutsceneTimer", 10)
                    battlefield:setLocalVar("lootSeen", 1)
                end
            end,
            [1301] = function() -- Temenos Central Basement Crate Handling
                xi.limbus.handleLootRolls(battlefield, loot[bfid], nil, npc)
                battlefield:setLocalVar("cutsceneTimer", 10)
                battlefield:setLocalVar("lootSeen", 1)
            end,
            [1303] = function() -- Temenos Central F1 Crate Handling
                xi.limbus.handleLootRolls(battlefield, loot[bfid], nil, npc)
                battlefield:setLocalVar("cutsceneTimer", 10)
                battlefield:setLocalVar("lootSeen", 1)
            end,
            [1304] = function() -- Temenos Central F2 Crate Handling
                xi.limbus.handleLootRolls(battlefield, loot[bfid], nil, npc)
                battlefield:setLocalVar("cutsceneTimer", 10)
                battlefield:setLocalVar("lootSeen", 1)
            end,
            [1305] = function() -- Temenos Central F3 Crate Handling
                xi.limbus.handleLootRolls(battlefield, loot[bfid], nil, npc)
                battlefield:setLocalVar("cutsceneTimer", 10)
                battlefield:setLocalVar("lootSeen", 1)
            end,
            [1306] = function() -- Temenos Central F4 Crate Handling
                if crateID ~= ID.npc.TEMENOS_C_CRATE[4][1] then
                    local randmimic = math.random(1, 24)
                    if randmimic < 17 then
                        local mimicList =
                        {
                            ID.mob.TEMENOS_C_MOB[4] + 20, ID.mob.TEMENOS_C_MOB[4] + 21,
                            ID.mob.TEMENOS_C_MOB[4] + 22, ID.mob.TEMENOS_C_MOB[4] + 25,
                            ID.mob.TEMENOS_C_MOB[4] + 26, ID.mob.TEMENOS_C_MOB[4] + 27,
                            ID.mob.TEMENOS_C_MOB[4] + 28, ID.mob.TEMENOS_C_MOB[4] + 29,
                            ID.mob.TEMENOS_C_MOB[4] + 30, ID.mob.TEMENOS_C_MOB[4] + 31,
                            ID.mob.TEMENOS_C_MOB[4] + 32, ID.mob.TEMENOS_C_MOB[4] + 33,
                            ID.mob.TEMENOS_C_MOB[4] + 34, ID.mob.TEMENOS_C_MOB[4] + 35,
                            ID.mob.TEMENOS_C_MOB[4] + 36, ID.mob.TEMENOS_C_MOB[4] + 37,
                        }
                        GetMobByID(mimicList[randmimic]):setSpawn(xPos, yPos, zPos)
                        SpawnMob(mimicList[randmimic]):setPos(xPos, yPos, zPos)
                        GetMobByID(mimicList[randmimic]):updateClaim(player)
                    else
                        xi.limbus.handleLootRolls(battlefield, loot[bfid][2], nil, npc)
                    end
                    for i = ID.npc.TEMENOS_C_CRATE[4][1] + 2, ID.npc.TEMENOS_C_CRATE[4][1] + 20 do
                        if ID.npc.TEMENOS_C_CRATE[4][crateID] == ID.npc.TEMENOS_C_CRATE[4][i] then
                            if crateID ~= i then
                                GetNPCByID(i):setStatus(xi.status.DISAPPEAR)
                            end
                        end
                    end
                else
                    xi.limbus.handleLootRolls(battlefield, loot[bfid][1], nil, npc)
                    battlefield:setLocalVar("cutsceneTimer", 10)
                    battlefield:setLocalVar("lootSeen", 1)
                end
            end,
        }
        if not hold then
            npc:entityAnimationPacket("open")
            npc:setLocalVar("open", 1)
            npc:timer(15000, function(npcArg)
                npcArg:entityAnimationPacket("kesu")
            end)
            npc:timer(16000, function(npcArg)
                npcArg:setStatus(xi.status.DISAPPEAR)
                npcArg:timer(500, function(mob)
                    mob:setLocalVar("open", 0)
                end)
            end)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end
return entity
