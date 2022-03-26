-----------------------------------
-- Global file for Apollyopn and Temenos
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/status")
require("scripts/globals/zone")
-----------------------------------

xi = xi or {}
xi.limbus = xi.limbus or {}

function xi.limbus.enter(player, entrance)
    switch (entrance): caseof
    {
        [0] = function ()
            player:setPos(-668, 0.1, -666, 209, 38)  --  instance entrer -599 0 -600
        end, --  sortiezone -642, -4, -642, -637, 4, -637
        [1] = function ()
            player:setPos(643, 0.1, -600, 124, 38)  --  instance entrer 600 1 -600
        end, --  sortiezone  637, -4, -642, 642, 4, -637
    }
end

function xi.limbus.setupArmouryCrates(bfid, hide)
    local ID
    if
        bfid == 1290 or
        bfid == 1291 or
        bfid == 1292 or
        bfid == 1293 or
        bfid == 1294 or
        bfid == 1296
    then
        ID = zones[xi.zone.APOLLYON]
    else
        ID = zones[xi.zone.TEMENOS]
    end

    switch (bfid): caseof
    {
        -- NW Apollyon
        [1290] = function()
            for i = 1, 4 do
                GetNPCByID(ID.npc.APOLLYON_NW_CRATE[i][1]):setStatus(xi.status.DISAPPEAR)
                for j = 2, 5 do
                    GetNPCByID(ID.npc.APOLLYON_NW_CRATE[i][j]):setStatus(xi.status.NORMAL)
                end
            end

            GetNPCByID(ID.npc.APOLLYON_NW_CRATE[5]):setStatus(xi.status.DISAPPEAR)
        end,

        -- SW Apollyon
        [1291] = function()
            for i = 1, 2 do
                for j = 0, 2 do
                    GetNPCByID(ID.npc.APOLLYON_SW_CRATE[i] + j):setStatus(xi.status.DISAPPEAR)
                end
            end

            for i = 0, 9 do
                GetNPCByID(ID.npc.APOLLYON_SW_CRATE[3] + i):untargetable(false)
                GetNPCByID(ID.npc.APOLLYON_SW_CRATE[3] + i):setStatus(xi.status.NORMAL)
            end

            GetNPCByID(ID.npc.APOLLYON_SW_CRATE[4]):setStatus(xi.status.DISAPPEAR)
        end,

        -- NE Apollyon
        [1292] = function()
            for i = 1, 4 do
                GetNPCByID(ID.npc.APOLLYON_NE_CRATE[i][1]):setStatus(xi.status.DISAPPEAR)

                for j = 2, 5 do
                    GetNPCByID(ID.npc.APOLLYON_NE_CRATE[i][j]):setStatus(xi.status.NORMAL)
                end
            end

            GetNPCByID(ID.npc.APOLLYON_NE_CRATE[5]):setStatus(xi.status.DISAPPEAR)
        end,

        -- SE Apollyon
        [1293] = function()
            for i = 1, 3 do
                for j = 0, 2 do
                    GetNPCByID(ID.npc.APOLLYON_SE_CRATE[i] + j):setStatus(xi.status.DISAPPEAR)
                end
            end

            GetNPCByID(ID.mob.APOLLYON_SE_MOB[4]):setStatus(xi.status.NORMAL)
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[4]):setStatus(xi.status.DISAPPEAR)
        end,

        -- CS Apollyon
        [1294] = function()
            for i = 0, 2 do
                GetNPCByID(ID.npc.APOLLYON_CS_CRATE + i):setStatus(xi.status.DISAPPEAR)
            end
        end,

        -- Central Apollyon
        [1296] = function()
            GetNPCByID(ID.npc.APOLLYON_CENTRAL_CRATE):setStatus(xi.status.DISAPPEAR)
        end,

        -- Temenos: Western Tower
        [1298] = function()
            for i = 1, #ID.npc.TEMENOS_W_CRATE - 1 do
                for j = 0, 2 do
                    GetNPCByID(ID.npc.TEMENOS_W_CRATE[i] + j):setStatus(xi.status.DISAPPEAR)
                end
            end

            GetNPCByID(ID.npc.TEMENOS_W_CRATE[7]):setStatus(xi.status.DISAPPEAR)
        end,

        -- Temenos: Northern Tower
        [1299] = function()
            for i = 1, #ID.npc.TEMENOS_N_CRATE-1 do
                for j = 0, 2 do
                    GetNPCByID(ID.npc.TEMENOS_N_CRATE[i] + j):setStatus(xi.status.DISAPPEAR)
                end
            end

            GetNPCByID(ID.npc.TEMENOS_N_CRATE[7]):setStatus(xi.status.DISAPPEAR)
        end,

        -- Temenos: Eastern Tower
        [1300] = function()
            for i = 1, #ID.npc.TEMENOS_E_CRATE-1 do
                for j = 0, 3 do
                    GetNPCByID(ID.npc.TEMENOS_E_CRATE[i] + j):setStatus(xi.status.DISAPPEAR)
                end
            end

            GetNPCByID(ID.npc.TEMENOS_E_CRATE[7]):setStatus(xi.status.DISAPPEAR)
            GetNPCByID(ID.npc.TEMENOS_E_CRATE[7] + 1):setStatus(xi.status.DISAPPEAR)
        end,

        -- Central Temenos: Basement
        [1301] = function()
            GetNPCByID(ID.npc.TEMENOS_C_CRATE[5]):setStatus(xi.status.DISAPPEAR)
        end,

        -- Central Temenos: 1st Floor
        [1303] = function()
            GetNPCByID(ID.npc.TEMENOS_C_CRATE[1]):setStatus(xi.status.DISAPPEAR)
        end,

        -- Central Temenos: 2nd Floor
        [1304] = function()
            GetNPCByID(ID.npc.TEMENOS_C_CRATE[2]):setStatus(xi.status.DISAPPEAR)
        end,

        -- Central Temenos: 3rd Floor
        [1305] = function()
            GetNPCByID(ID.npc.TEMENOS_C_CRATE[3]):setStatus(xi.status.DISAPPEAR)
        end,

        -- Central Temenos: 4th Floor
        [1306] = function()
            GetNPCByID(ID.npc.TEMENOS_C_CRATE[4][1]):setStatus(xi.status.DISAPPEAR)

            for i = ID.npc.TEMENOS_C_CRATE[4][1]+2, ID.npc.TEMENOS_C_CRATE[4][1]+20 do
                if hide then
                    GetNPCByID(i):setStatus(xi.status.DISAPPEAR)
                else
                    GetNPCByID(i):setStatus(xi.status.NORMAL)
                end
            end
        end,
    }
end

function xi.limbus.handleDoors(battlefield, open, door)
    local battlefieldID = battlefield:getID()
    local animation     = xi.animation.CLOSE_DOOR
    local ID

    if open then
        animation = xi.animation.OPEN_DOOR
    end

    if
        battlefieldID == 1290 or
        battlefieldID == 1291 or
        battlefieldID == 1292 or
        battlefieldID == 1293
    then
        ID = zones[xi.zone.APOLLYON]
    else
        ID = zones[xi.zone.TEMENOS]
    end

    if door then
        if open then
            local players = battlefield:getPlayers()

            for i, member in pairs(players) do
                member:messageSpecial(ID.text.GATE_OPEN)
                member:messageSpecial(ID.text.TIME_LEFT, battlefield:getRemainingTime() / 60)
            end
        end

        GetNPCByID(door):setAnimation(animation)
        return
    end

    switch (battlefieldID): caseof
    {
        -- NW Apollyon
        [1290] = function()
            for i = 1, 5 do
                GetNPCByID(ID.npc.APOLLYON_NW_PORTAL[i]):setAnimation(animation)
            end
        end,

        -- SW Apollyon
        [1291] = function()
            for i = 1, 3 do
                GetNPCByID(ID.npc.APOLLYON_SW_PORTAL[i]):setAnimation(animation)
            end
        end,

        -- NE Apollyon
        [1292] = function()
            for i = 1, 4 do
                GetNPCByID(ID.npc.APOLLYON_NE_PORTAL[i]):setAnimation(animation)
            end
        end,

        -- SE Apollyon
        [1293] = function()
            for i = 1, 3 do
                GetNPCByID(ID.npc.APOLLYON_SE_PORTAL[i]):setAnimation(animation)
            end
        end,

        -- Temenos: Northern Tower
        [1299] = function()
            for i = 1, 7 do
                GetNPCByID(ID.npc.TEMENOS_N_GATE[i]):setAnimation(animation)
            end
        end,

        -- Temenos: Eastern Tower
        [1300] = function()
            for i = 1, 7 do
                GetNPCByID(ID.npc.TEMENOS_E_GATE[i]):setAnimation(animation)
            end
        end,

        -- Temenos: Western Tower
        [1298] = function()
            for i = 1, 7 do
                GetNPCByID(ID.npc.TEMENOS_W_GATE[i]):setAnimation(animation)
            end
        end,

        -- Central Temenos: 1st Floor
        [1303] = function()
            GetNPCByID(ID.npc.TEMENOS_C_GATE[1]):setAnimation(animation)
        end,

        -- Central Temenos: 2nd Floor
        [1304] = function()
            GetNPCByID(ID.npc.TEMENOS_C_GATE[2]):setAnimation(animation)
        end,

        -- Central Temenos: 3rd Floor
        [1305] = function()
            GetNPCByID(ID.npc.TEMENOS_C_GATE[3]):setAnimation(animation)
        end,

        -- Central Temenos: 4th Floor
        [1306] = function()
            GetNPCByID(ID.npc.TEMENOS_C_GATE[4]):setAnimation(animation)
        end,

        -- Central Temenos: Basement
        [1301] = function()
            GetNPCByID(ID.npc.TEMENOS_C_GATE[5]):setAnimation(animation)
        end,
    }
end

function xi.limbus.handleLootRolls(battlefield, lootTable, players, npc)
    players = players or battlefield:getPlayers()

    for i = 1, #lootTable do
        local lootGroup = lootTable[i]

        if lootGroup then
            local max = 0

            for _, entry in pairs(lootGroup) do
                max = max + entry.droprate
            end

            local roll = math.random(max)

            for _, entry in pairs(lootGroup) do
                max = max - entry.droprate

                if roll > max then
                    if entry.itemid ~= 0 then
                        players[1]:addTreasure(entry.itemid, npc)
                    end

                    break
                end
            end
        end
    end
end

function xi.limbus.extendTimeLimit(battlefield, minutes, zone, npc)
    local ID        = zones[zone]
    local players   = battlefield:getPlayers()
    local timeLimit = battlefield:getTimeLimit()
    local extension = minutes * 60
    battlefield:setTimeLimit(timeLimit + extension)

    for _, player in pairs(players) do
        player:messageSpecial(ID.text.TIME_EXTENDED, minutes)
        player:messageSpecial(ID.text.TIME_LEFT, battlefield:getRemainingTime() / 60)
    end
end

function xi.limbus.spawnRandomCrate(npc, battlefield, var, mask, canMimic)
    if mask < 8 then
        local spawnMimic = math.random(0, 1) == 1

        switch (mask): caseof
        {
            -- Spawn anything
            [0] = function()
                if spawnMimic and canMimic then
                    GetNPCByID(npc):setModelId(961) -- Mimic
                    GetNPCByID(npc):setStatus(xi.status.NORMAL)
                    battlefield:setLocalVar(var, mask + 8)
                else
                    local random = math.random(0, 2)

                    switch (random): caseof
                    {
                        -- Bronze
                        [0] = function()
                            GetNPCByID(npc):setModelId(960)
                        end,

                        -- Gold
                        [1] = function()
                            GetNPCByID(npc):setModelId(961)
                        end,

                        -- Blue
                        [2] = function()
                            GetNPCByID(npc):setModelId(962)
                        end,
                    }

                    GetNPCByID(npc):setStatus(xi.status.NORMAL)
                    battlefield:setLocalVar(var, bit.bor(math.pow(2, random), mask))
                end
            end,

            -- Spawn gold or blue
            [1] = function()
                if spawnMimic and canMimic then
                    GetNPCByID(npc):setModelId(961) -- Mimic
                    GetNPCByID(npc):setStatus(xi.status.NORMAL)
                    battlefield:setLocalVar(var, mask + 8)
                else
                    local random = math.random(1, 2)
                    switch (random): caseof
                    {
                        -- Gold
                        [1] = function()
                            GetNPCByID(npc):setModelId(961)
                        end,

                        -- Blue
                        [2] = function()
                            GetNPCByID(npc):setModelId(962)
                        end,
                    }

                    GetNPCByID(npc):setStatus(xi.status.NORMAL)
                    battlefield:setLocalVar(var, bit.bor(math.pow(2, random), mask))
                end
            end,

            -- Spawn bronze or blue
            [2] = function()
                if spawnMimic and canMimic then
                    GetNPCByID(npc):setModelId(961) --mimic
                    GetNPCByID(npc):setStatus(xi.status.NORMAL)
                    battlefield:setLocalVar(var, mask+8)
                else
                    local random = math.random(0,1)
                    if random == 1 then random = 2 end
                    switch (random): caseof
                    {
                        [0] = function() GetNPCByID(npc):setModelId(960) end, -- Bronze
                        [2] = function() GetNPCByID(npc):setModelId(962) end, -- Blue
                    }
                    GetNPCByID(npc):setStatus(xi.status.NORMAL)
                    battlefield:setLocalVar(var, bit.bor(math.pow(2,random), mask))
                end
            end,

            -- Spawn blue
            [3] = function()
                if spawnMimic and canMimic then
                    GetNPCByID(npc):setModelId(961) -- Mimic
                    GetNPCByID(npc):setStatus(xi.status.NORMAL)
                    battlefield:setLocalVar(var, mask + 8)
                else
                    GetNPCByID(npc):setModelId(962) -- Blue
                    GetNPCByID(npc):setStatus(xi.status.NORMAL)
                    battlefield:setLocalVar(var, mask + 4)
                end
            end,

            -- Spawn bronze or gold
            [4] = function()
                if spawnMimic and canMimic then
                    GetNPCByID(npc):setModelId(961) -- Mimic
                    GetNPCByID(npc):setStatus(xi.status.NORMAL)
                    battlefield:setLocalVar(var, mask + 8)
                else
                    local random = math.random(0, 1)

                    switch (random): caseof
                    {
                        -- Bronze
                        [0] = function()
                            GetNPCByID(npc):setModelId(960)
                        end,

                        -- Gold
                        [1] = function()
                            GetNPCByID(npc):setModelId(961)
                        end,
                    }

                    GetNPCByID(npc):setStatus(xi.status.NORMAL)
                    battlefield:setLocalVar(var, bit.bor(math.pow(2, random), mask))
                end
            end,

            -- Spawn gold
            [5] = function()
                if spawnMimic and canMimic then
                    GetNPCByID(npc):setModelId(961) -- Mimic
                    GetNPCByID(npc):setStatus(xi.status.NORMAL)
                    battlefield:setLocalVar(var, mask + 8)
                else
                    GetNPCByID(npc):setModelId(961) -- Gold
                    GetNPCByID(npc):setStatus(xi.status.NORMAL)
                    battlefield:setLocalVar(var, mask + 2)
                end
            end,

            -- Spawn bronze
            [6] = function()
                if spawnMimic and canMimic then
                    GetNPCByID(npc):setModelId(961) -- Mimic
                    GetNPCByID(npc):setStatus(xi.status.NORMAL)
                    battlefield:setLocalVar(var, mask + 8)
                else
                    GetNPCByID(npc):setModelId(960) -- Bronze
                    GetNPCByID(npc):setStatus(xi.status.NORMAL)
                    battlefield:setLocalVar(var, mask + 1)
                end
            end,

            -- Spawn mimic
            [7] = function()
                if canMimic then
                    GetNPCByID(npc):setModelId(961) -- Mimic
                    GetNPCByID(npc):setStatus(xi.status.NORMAL)
                    battlefield:setLocalVar(var, mask + 8)
                end
            end,
        }
    else
        xi.limbus.spawnRandomCrate(npc, battlefield, var, mask - 8)
        mask = battlefield:getLocalVar(var)
        battlefield:setLocalVar(var, mask + 8)

        return
    end
end
