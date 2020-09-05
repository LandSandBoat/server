--------------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/status")
require("scripts/globals/zone")
--------------------------------------

tpz = tpz or {}
tpz.limbus = tpz.limbus or {}

function tpz.limbus.enter(player, entrance)
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

function tpz.limbus.setupArmouryCrates(bfid, hide)
    local ID
    if bfid == 1290 or bfid == 1291 or bfid == 1292 or bfid == 1293 or
        bfid == 1294 or bfid == 1296
    then
        ID = zones[tpz.zone.APOLLYON]
    else
        ID = zones[tpz.zone.TEMENOS]
    end
    
    switch (bfid): caseof
    {
        [1290] = function() -- NW_Apollyon
            for i = 1, 4 do
                GetNPCByID(ID.npc.APOLLYON_NW_CRATE[i][1]):setStatus(tpz.status.DISAPPEAR)
                for j = 2, 5 do
                    GetNPCByID(ID.npc.APOLLYON_NW_CRATE[i][j]):setStatus(tpz.status.NORMAL)
                end
            end
            GetNPCByID(ID.npc.APOLLYON_NW_CRATE[5]):setStatus(tpz.status.DISAPPEAR)
        end,
        [1291] = function() -- SW_Apollyon
            for i = 1, 2 do
                    for j = 0, 2 do
                        GetNPCByID(ID.npc.APOLLYON_SW_CRATE[i]+j):setStatus(tpz.status.DISAPPEAR)
                    end
            end
            for i = 0, 9 do
                GetNPCByID(ID.npc.APOLLYON_SW_CRATE[3]+i):untargetable(false)
                GetNPCByID(ID.npc.APOLLYON_SW_CRATE[3]+i):setStatus(tpz.status.NORMAL)
            end
            GetNPCByID(ID.npc.APOLLYON_SW_CRATE[4]):setStatus(tpz.status.DISAPPEAR)
        end,
        [1292] = function() -- NE_Apollyon
            for i = 1, 4 do
                GetNPCByID(ID.npc.APOLLYON_NE_CRATE[i][1]):setStatus(tpz.status.DISAPPEAR)
                for j = 2, 5 do
                    GetNPCByID(ID.npc.APOLLYON_NE_CRATE[i][j]):setStatus(tpz.status.NORMAL)
                end
            end
            GetNPCByID(ID.npc.APOLLYON_NE_CRATE[5]):setStatus(tpz.status.DISAPPEAR)
        end,
        [1293] = function() -- SE_Apollyon
            for i = 1, 3 do
                for j = 0, 2 do
                    GetNPCByID(ID.npc.APOLLYON_SE_CRATE[i]+j):setStatus(tpz.status.DISAPPEAR)
                end
            end
            GetNPCByID(ID.mob.APOLLYON_SE_MOB[4]):setStatus(tpz.status.NORMAL)
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[4]):setStatus(tpz.status.DISAPPEAR)
        end,
        [1294] = function() -- CS_Apollyon
            for i = 0, 2 do
                GetNPCByID(ID.npc.APOLLYON_CS_CRATE+i):setStatus(tpz.status.DISAPPEAR)
            end
        end,
        [1296] = function() -- Central_Apollyon
            GetNPCByID(ID.npc.APOLLYON_CENTRAL_CRATE):setStatus(tpz.status.DISAPPEAR)
        end,
        [1298] = function() -- Temenos_Western_Tower
            for i = 1, #ID.npc.TEMENOS_W_CRATE-1 do
                for j = 0, 2 do
                    GetNPCByID(ID.npc.TEMENOS_W_CRATE[i]+j):setStatus(tpz.status.DISAPPEAR)
                end
            end
            GetNPCByID(ID.npc.TEMENOS_W_CRATE[7]):setStatus(tpz.status.DISAPPEAR)
        end,
        [1299] = function() -- Temenos_Northern_Tower
            for i = 1, #ID.npc.TEMENOS_N_CRATE-1 do
                for j = 0, 2 do
                    GetNPCByID(ID.npc.TEMENOS_N_CRATE[i]+j):setStatus(tpz.status.DISAPPEAR)
                end
            end
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[7]):setStatus(tpz.status.DISAPPEAR)
        end,
        [1300] = function() -- Temenos_Eastern_Tower
            for i = 1, #ID.npc.TEMENOS_E_CRATE-1 do
                for j = 0, 3 do
                    GetNPCByID(ID.npc.TEMENOS_E_CRATE[i]+j):setStatus(tpz.status.DISAPPEAR)
                end
            end
            GetNPCByID(ID.npc.TEMENOS_E_CRATE[7]):setStatus(tpz.status.DISAPPEAR)
            GetNPCByID(ID.npc.TEMENOS_E_CRATE[7]+1):setStatus(tpz.status.DISAPPEAR)
        end,
        [1301] = function() -- Central_Temenos_Basement
            GetNPCByID(ID.npc.TEMENOS_C_CRATE[5]):setStatus(tpz.status.DISAPPEAR)
        end,
        [1303] = function() -- Central_Temenos_1st_Floor
            GetNPCByID(ID.npc.TEMENOS_C_CRATE[1]):setStatus(tpz.status.DISAPPEAR)
        end,
        [1304] = function() -- Central_Temenos_2nd_Floor
            GetNPCByID(ID.npc.TEMENOS_C_CRATE[2]):setStatus(tpz.status.DISAPPEAR)
        end,
        [1305] = function() -- Central_Temenos_3rd_Floor
            GetNPCByID(ID.npc.TEMENOS_C_CRATE[3]):setStatus(tpz.status.DISAPPEAR)
        end,
        [1306] = function() -- Central_Temenos_4th_Floor
            GetNPCByID(ID.npc.TEMENOS_C_CRATE[4][1]):setStatus(tpz.status.DISAPPEAR)
            for i = ID.npc.TEMENOS_C_CRATE[4][1]+2, ID.npc.TEMENOS_C_CRATE[4][1]+20 do
                if hide then
                    GetNPCByID(i):setStatus(tpz.status.DISAPPEAR)
                else
                    GetNPCByID(i):setStatus(tpz.status.NORMAL)
                end
            end
        end,
    }
end

function tpz.limbus.handleDoors(battlefield, open, door)
    local bfid = battlefield:getID()
    local animation = tpz.animation.CLOSE_DOOR
    if open then animation = tpz.animation.OPEN_DOOR end
    local ID
    if bfid == 1290 or bfid == 1291 or bfid == 1292 or bfid == 1293 then
        ID = zones[tpz.zone.APOLLYON]
    else
        ID = zones[tpz.zone.TEMENOS]
    end

    if door then
        if open then
            local players = battlefield:getPlayers()
            for i, member in pairs(players) do
                member:messageSpecial(ID.text.GATE_OPEN)
                member:messageSpecial(ID.text.TIME_LEFT, battlefield:getRemainingTime()/60)
            end
        end
        GetNPCByID(door):setAnimation(animation)
        return
    end

    switch (bfid): caseof
    {
        [1290] = function() -- NW_Apollyon
            for i = 1, 5 do
                GetNPCByID(ID.npc.APOLLYON_NW_PORTAL[i]):setAnimation(animation)
            end
        end,
        [1291] = function() -- SW_Apollyon
            for i = 1, 4 do
                GetNPCByID(ID.npc.APOLLYON_SW_PORTAL[i]):setAnimation(animation)
            end
        end,
        [1292] = function() -- NE_Apollyon
            for i = 1, 5 do
                GetNPCByID(ID.npc.APOLLYON_NE_PORTAL[i]):setAnimation(animation)
            end
        end,
        [1293] = function() -- SE_Apollyon
            for i = 1, 4 do
                GetNPCByID(ID.npc.APOLLYON_SE_PORTAL[i]):setAnimation(animation)
            end
        end,
        [1299] = function() -- Temenos_Northern_Tower
            for i = 1, 7 do
                GetNPCByID(ID.npc.TEMENOS_N_GATE[i]):setAnimation(animation)
            end
        end,
        [1300] = function() -- Temenos_Eastern_Tower
            for i = 1, 7 do
                GetNPCByID(ID.npc.TEMENOS_E_GATE[i]):setAnimation(animation)
            end
        end,
        [1298] = function() -- Temenos_Western_Tower
            for i = 1, 7 do
                GetNPCByID(ID.npc.TEMENOS_W_GATE[i]):setAnimation(animation)
            end
        end,
        [1303] = function() -- Central_Temenos_1st_Floor
            GetNPCByID(ID.npc.TEMENOS_C_GATE[1]):setAnimation(animation)
        end,
        [1304] = function() -- Central_Temenos_2nd_Floor
            GetNPCByID(ID.npc.TEMENOS_C_GATE[2]):setAnimation(animation)
        end,
        [1305] = function() -- Central_Temenos_3rd_Floor
            GetNPCByID(ID.npc.TEMENOS_C_GATE[3]):setAnimation(animation)
        end,
        [1306] = function() -- Central_Temenos_4th_Floor
            GetNPCByID(ID.npc.TEMENOS_C_GATE[4]):setAnimation(animation)
        end,
        [1301] = function() -- Central_Temenos_Basement
            GetNPCByID(ID.npc.TEMENOS_C_GATE[5]):setAnimation(animation)
        end,
    }
end

function tpz.limbus.handleLootRolls(battlefield, lootTable, players, npc)
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

function tpz.limbus.extendTimeLimit(battlefield, minutes, zone, npc)
    local timeLimit = battlefield:getTimeLimit()
    local extension = minutes * 60
    battlefield:setTimeLimit(timeLimit + extension)
    local ID = zones[zone]

    players = battlefield:getPlayers()
    for _, player in pairs(players) do
        player:messageSpecial(ID.text.TIME_EXTENDED, minutes)
        player:messageSpecial(ID.text.TIME_LEFT, battlefield:getRemainingTime()/60)
    end
end

function tpz.limbus.spawnRandomCrate(npc, battlefield, var, mask, canMimic)
    if mask < 8 then
        local spawnMimic = math.random(0,1) == 1
        switch (mask): caseof
        {
            [0] = function() -- spawn anything
                if spawnMimic and canMimic then
                    GetNPCByID(npc):setModelId(961) --mimic
                    GetNPCByID(npc):setStatus(tpz.status.NORMAL)
                    battlefield:setLocalVar(var, mask+8)
                else
                    local random = math.random(0,2)
                    switch (random): caseof
                    {
                        [0] = function() GetNPCByID(npc):setModelId(960) end, --bronze
                        [1] = function() GetNPCByID(npc):setModelId(961) end, --gold
                        [2] = function() GetNPCByID(npc):setModelId(962) end, --blue
                    }
                    GetNPCByID(npc):setStatus(tpz.status.NORMAL)
                    battlefield:setLocalVar(var, bit.bor(math.pow(2,random), mask))
                end
            end,
            [1] = function() -- spawn gold or blue
                if spawnMimic and canMimic then
                    GetNPCByID(npc):setModelId(961) --mimic
                    GetNPCByID(npc):setStatus(tpz.status.NORMAL)
                    battlefield:setLocalVar(var, mask+8)
                else
                    local random = math.random(1,2)
                    switch (random): caseof
                    {
                        [1] = function() GetNPCByID(npc):setModelId(961) end, --gold
                        [2] = function() GetNPCByID(npc):setModelId(962) end, --blue
                    }
                    GetNPCByID(npc):setStatus(tpz.status.NORMAL)
                    battlefield:setLocalVar(var, bit.bor(math.pow(2,random), mask))
                end
            end,
            [2] = function() -- spawn bronze or blue
                if spawnMimic and canMimic then
                    GetNPCByID(npc):setModelId(961) --mimic
                    GetNPCByID(npc):setStatus(tpz.status.NORMAL)
                    battlefield:setLocalVar(var, mask+8)
                else
                    local random = math.random(0,1)
                    if random == 1 then random = 2 end
                    switch (random): caseof
                    {
                        [0] = function() GetNPCByID(npc):setModelId(960) end, --bronze
                        [2] = function() GetNPCByID(npc):setModelId(962) end, --blue
                    }
                    GetNPCByID(npc):setStatus(tpz.status.NORMAL)
                    battlefield:setLocalVar(var, bit.bor(math.pow(2,random), mask))
                end
            end,
            [3] = function() -- spawn blue
                if spawnMimic and canMimic then
                    GetNPCByID(npc):setModelId(961) --mimic
                    GetNPCByID(npc):setStatus(tpz.status.NORMAL)
                    battlefield:setLocalVar(var, mask+8)
                else
                    GetNPCByID(npc):setModelId(962) --blue
                    GetNPCByID(npc):setStatus(tpz.status.NORMAL)
                    battlefield:setLocalVar(var, mask+4)
                end
            end,
            [4] = function() -- spawn bronze or gold
                if spawnMimic and canMimic then
                    GetNPCByID(npc):setModelId(961) --mimic
                    GetNPCByID(npc):setStatus(tpz.status.NORMAL)
                    battlefield:setLocalVar(var, mask+8)
                else
                    local random = math.random(0,1)
                    switch (random): caseof
                    {
                        [0] = function() GetNPCByID(npc):setModelId(960) end, --bronze
                        [1] = function() GetNPCByID(npc):setModelId(961) end, --gold
                    }
                    GetNPCByID(npc):setStatus(tpz.status.NORMAL)
                    battlefield:setLocalVar(var, bit.bor(math.pow(2,random), mask))
                end
            end,
            [5] = function() -- spawn gold
                if spawnMimic and canMimic then
                    GetNPCByID(npc):setModelId(961) --mimic
                    GetNPCByID(npc):setStatus(tpz.status.NORMAL)
                    battlefield:setLocalVar(var, mask+8)
                else
                    GetNPCByID(npc):setModelId(961) --gold
                    GetNPCByID(npc):setStatus(tpz.status.NORMAL)
                    battlefield:setLocalVar(var, mask+2)
                end
            end,
            [6] = function() -- spawn bronze
                if spawnMimic and canMimic then
                    GetNPCByID(npc):setModelId(961) --mimic
                    GetNPCByID(npc):setStatus(tpz.status.NORMAL)
                    battlefield:setLocalVar(var, mask+8)
                else
                    GetNPCByID(npc):setModelId(960) --bronze
                    GetNPCByID(npc):setStatus(tpz.status.NORMAL)
                    battlefield:setLocalVar(var, mask+1)
                end
            end,
            [7] = function() -- spawn mimic
                if canMimic then
                    GetNPCByID(npc):setModelId(961) --mimic
                    GetNPCByID(npc):setStatus(tpz.status.NORMAL)
                    battlefield:setLocalVar(var, mask+8)
                end
            end,
        }
    else
        tpz.limbus.spawnRandomCrate(npc, battlefield, var, mask-8)
        mask = battlefield:getLocalVar(var)
        battlefield:setLocalVar(var, mask+8)
        return
    end
end

function tpz.limbus.elementalsDead()
    local ID = zones[tpz.zone.APOLLYON]
    local day = VanadielDayElement()
    local daykill = false
    if day == 0 then  --  fire
        if GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+3):isDead() and GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+11):isDead()
            and GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+19):isDead()
        then
            daykill = true
        end
    elseif day == 1 then --  earth
        if GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+2):isDead() and GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+10):isDead()
        and GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+18):isDead()
        then
            daykill = true
        end
    elseif day == 2 then --  water
        if GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+6):isDead() and GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+14):isDead()
        and GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+22):isDead()
        then
            daykill = true
        end
    elseif day == 3 then --  wind
        if GetMobByID(ID.mob.APOLLYON_SW_MOB[4]):isDead() and GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+8):isDead()
        and GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+16):isDead()
        then
            daykill = true
        end
    elseif day == 4 then --  ice
        if GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+4):isDead() and GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+12):isDead()
        and GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+20):isDead()
        then
            daykill = true
        end
    elseif day == 5 then --  lightning
        if GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+7):isDead() and GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+15):isDead()
        and GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+23):isDead()
        then
            daykill = true
        end
    elseif day == 6 then --  ligth
        if GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+5):isDead() and GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+13):isDead()
        and GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+21):isDead()
        then
            daykill = true
        end
    elseif day == 7 then  --  dark
        if GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+1):isDead() and GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+9):isDead()
        and GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+17):isDead()
        then
            daykill = true
        end
    end

    return daykill
end
