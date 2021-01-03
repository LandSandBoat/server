require("scripts/globals/msg")

tpz = tpz or {}

local MaxAreas =
{
    -- temenos
    {Max = 8, Zones = {37}},

    -- apollyon
    {Max = 6, Zones = {38}},

    -- dynamis
    {Max = 1, Zones = {39, 40, 41, 42, 134, 135, 185, 186, 187, 188,
                                29, 140}}, -- riverneb, ghelsba
}

function onBattlefieldHandlerInitialise(zone)
    local id = zone:getID()
    local default = 3
    for _, battlefield in pairs(MaxAreas) do
        for _, zoneid in pairs(battlefield.Zones) do
            if id == zoneid then
                return battlefield.Max
             end
        end
    end
    return default
end



tpz.battlefield = {}

tpz.battlefield.status =
{
    OPEN     = 0,
    LOCKED   = 1,
    WON      = 2,
    LOST     = 3,
}

tpz.battlefield.returnCode =
{
    WAIT              = 1,
    CUTSCENE          = 2,
    INCREMENT_REQUEST = 3,
    LOCKED            = 4,
    REQS_NOT_MET      = 5,
    BATTLEFIELD_FULL  = 6
}

tpz.battlefield.leaveCode =
{
    EXIT = 1,
    WON = 2,
    WARPDC = 3,
    LOST = 4
}

function tpz.battlefield.onBattlefieldTick(battlefield, timeinside, players)
    local killedallmobs = true
    local mobs = battlefield:getMobs(true, false)
    local status = battlefield:getStatus()
    local leavecode = -1
    local players = battlefield:getPlayers()
    local cutsceneTimer = battlefield:getLocalVar("cutsceneTimer")
    local phaseChange = battlefield:getLocalVar("phaseChange")

    if status == tpz.battlefield.status.LOST then
        leavecode = 4
    elseif status == tpz.battlefield.status.WON then
        leavecode = 2
    end

    if leavecode ~= -1 then
        battlefield:setLocalVar("cutsceneTimer", cutsceneTimer + 1)

        local canLeave = battlefield:getLocalVar("loot") == 0
        if status == tpz.battlefield.status.WON and not canLeave then
            if battlefield:getLocalVar("lootSpawned") == 0 and battlefield:spawnLoot() then
                canLeave = false
            elseif battlefield:getLocalVar("lootSeen") == 1 then
                canLeave = true
            end
        end
        if canLeave and cutsceneTimer >= 15 then
            battlefield:cleanup(true)
        end
    end

    for _, mob in pairs(mobs) do
        if mob:isAlive() then
            killedallmobs = false
            break
        end
    end
    tpz.battlefield.HandleWipe(battlefield, players)

    -- if we cant send anymore time prompts theyre out of time
    if not tpz.battlefield.SendTimePrompts(battlefield, players) then
        battlefield:cleanup(true)
    end

    if killedallmobs and phaseChange == 0 then
        battlefield:setStatus(tpz.battlefield.status.WON)
    end
end

-- returns false if out of time
function tpz.battlefield.SendTimePrompts(battlefield, players)
    local tick = battlefield:getTimeInside()
    local status = battlefield:getStatus()
    local remainingTime = battlefield:getRemainingTime()
    local message = 0
    local lastTimeUpdate = battlefield:getLastTimeUpdate()

    players = players or battlefield:getPlayers()

    if lastTimeUpdate == 0 and remainingTime < 600 then
        message = 600
    elseif lastTimeUpdate == 600 and remainingTime < 300 then
        message = 300
    elseif lastTimeUpdate == 300 and remainingTime < 60 then
        message = 60
    elseif lastTimeUpdate == 60 and remainingTime < 30 then
        message = 30
    elseif lastTimeUpdate == 30 and remainingTime < 10 then
        message = 10
    end

    if message ~= 0 then
        for i, player in pairs(players) do
            player:messageBasic(tpz.msg.basic.TIME_LEFT, remainingTime)
        end
        battlefield:setLastTimeUpdate(message)
    end

    return remainingTime >= 0
end

function tpz.battlefield.HandleWipe(battlefield, players)
    local rekt = true
    local wipeTime = battlefield:getWipeTime()
    local elapsed = battlefield:getTimeInside()

    players = players or battlefield:getPlayers()

    -- pure stolen from instance.lua
    if wipeTime <= 0 then
        for _, player in pairs(players) do
            if player:getHP() ~= 0 then
                rekt = false
                break
            end
        end
        if rekt then
            for _, player in pairs(players) do
                -- v:messageSpecial(ID, 3)
            end
            battlefield:setWipeTime(elapsed)
        end
    else
        if (elapsed - wipeTime) > 180 then
            battlefield:setStatus(tpz.battlefield.status.LOST)
        else
            for _, player in pairs(players) do
                if player:getHP() ~= 0 then
                    battlefield:setWipeTime(0)
                    rekt = false
                    break
                end
            end

            if rekt then
                battlefield:setStatus(tpz.battlefield.status.LOST)
            end
        end
    end
end


function tpz.battlefield.onBattlefieldStatusChange(battlefield, players, status)

end

function tpz.battlefield.HandleLootRolls(battlefield, lootTable, players, npc)
    players = players or battlefield:getPlayers()
    if battlefield:getStatus() == tpz.battlefield.status.WON and battlefield:getLocalVar("lootSeen") == 0 then
        if npc then
            npc:setAnimation(90)
        end
        for i = 1, #lootTable, 1 do
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
                            if entry.itemid == 65535 then
                                local gil = entry.amount/#players
                                for i = 1, #players, 1 do
                                    players[i]:addGil(gil)
                                    players[i]:messageSpecial(zones[players[1]:getZoneID()].text.GIL_OBTAINED, gil)
                                end
                                break
                            end
                            players[1]:addTreasure(entry.itemid, npc)
                        end
                        break
                    end
                end
            end
        end
        battlefield:setLocalVar("cutsceneTimer", 10)
        battlefield:setLocalVar("lootSeen", 1)
    end
end

function tpz.battlefield.ExtendTimeLimit(battlefield, minutes, message, param, players)
    local timeLimit = battlefield:getTimeLimit()
    local extension = minutes * 60
    battlefield:setTimeLimit(timeLimit + extension)

    if message then
        players = players or battlefield:getPlayers()
        for _, player in pairs(players) do
            player:messageBasic(message, param or minutes)
        end
    end
end

function tpz.battlefield.HealPlayers(battlefield, players)
    players = players or battlefield:getPlayers()
    for _, player in pairs(players) do
        local recoverHP = player:getMaxHP() - player:getHP()
        local recoverMP = player:getMaxMP() - player:getMP()
        player:addHP(recoverHP)
        player:addMP(recoverMP)
        player:resetRecasts()
        player:messageBasic(tpz.msg.basic.RECOVERS_HP_AND_MP, recoverHP, recoverMP)
        player:messageBasic(tpz.msg.basic.ALL_ABILITIES_RECHARGED)
    end
end
