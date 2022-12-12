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
    local xPos = npc:getXPos()
    local yPos = npc:getYPos()
    local zPos = npc:getZPos()
    local bfid = battlefield:getID()
    local hold = false
    if npc:getLocalVar("open") == 0 then
        switch (bfid): caseof
        {
            [1301] = function() -- Temenos Central Basement Crate Handling
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
