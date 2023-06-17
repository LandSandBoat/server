-----------------------------------
-- Seekers of Adoulin Helpers
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/zone')
-----------------------------------

xi = xi or {}
xi.soa = xi.soa or {}
xi.soa.helpers = xi.soa.helpers or {}

xi.soa.helpers.imprimaturGate = function(player, gateAmount)
    -- TODO: All of this
    local imprimatursSpent = 0 -- TODO: Pull from DB
    local fame = player:getFameLevel(xi.quest.fame_area.ADOULIN)
    local gate = 100 - (fame * gateAmount)
    return imprimatursSpent >= gate
end

-- Helper Functions for Mission 3-4 and 3-5 Minigame
local function getShotHistory(player, varName)
    local shotField   = player:getLocalVar(varName)
    local shotHistory = {}
    local bitOffset   = 0
    local shotData    = bit.band(shotField, 0x7)

    while shotData ~= 0 do
        table.insert(shotHistory, #shotHistory + 1, shotData)

        bitOffset = bitOffset + 3
        shotData  = bit.band(bit.rshift(shotField, bitOffset), 0x7)
    end

    return shotHistory
end

local function addShot(player, varName, shotValue)
    local shotHistory = getShotHistory(player, varName)
    local resultField = 0

    table.insert(shotHistory, #shotHistory + 1, shotValue)

    for shotNum, shotAmt in ipairs(shotHistory) do
        resultField = resultField + bit.lshift(shotAmt, (shotNum - 1) * 3)
    end

    player:setLocalVar(varName, resultField)
end

local function replaceShot(player, varName, shotValue, slot)
    local shotHistory = getShotHistory(player, varName)
    local resultField = 0

    shotHistory[slot] = shotValue
    for shotNum, shotAmt in ipairs(shotHistory) do
        resultField = resultField + bit.lshift(shotAmt, (shotNum - 1) * 3)
    end

    player:setLocalVar(varName, resultField)
end

local function getShotTotal(player, varName)
    local shotField = player:getLocalVar(varName)
    local shotTotal = 0
    local bitOffset = 0
    local shotData  = bit.band(shotField, 0x7)

    while shotData ~= 0 do
        shotTotal = shotTotal + shotData

        bitOffset = bitOffset + 3
        shotData  = bit.band(bit.rshift(shotField, bitOffset), 0x7)
    end

    if shotTotal > 11 then
        shotTotal = 0
    end

    return shotTotal
end

local function updateSessionScore(player, gameResult)
    local packedSessionScore = player:getLocalVar('sessionScore')
    local sessionTable = {} -- { Win, Lose, Tie }

    for offset = 0, 2 do
        sessionTable[offset + 1] = bit.band(bit.rshift(packedSessionScore, offset * 2), 0x3)
    end

    sessionTable[gameResult] = sessionTable[gameResult] + 1

    packedSessionScore = 0
    for offset = 0, 2 do
        packedSessionScore = packedSessionScore + bit.lshift(sessionTable[offset + 1], offset * 2)
    end

    player:setLocalVar('sessionScore', packedSessionScore)
end

local function chooseTeodorAction(player)
    local teodorScore     = getShotTotal(player, 'teodorShots')
    local teodorAction    = 1
    local teodorShotValue = 0
    local teodorSpecial   = 0
    local rollThreshold   = 100 - (math.max(teodorScore - 5, 0) * 20)

    if
        player:getLocalVar('turnNumber') > 1 and
        player:getLocalVar('teodorSpecial') == 0 and
        teodorScore == 0
    then
        -- Teodor Busted, try to Switcharoo
        teodorAction = 3

        local playerShotData = getShotHistory(player, 'playerShots')
        local teodorShotData = getShotHistory(player, 'teodorShots')

        local playerCardSlot = math.random(1, #playerShotData)
        local teodorCardSlot = math.random(1, #teodorShotData)

        teodorSpecial = bit.lshift(teodorShotData[teodorCardSlot], 5) + playerShotData[playerCardSlot]

        replaceShot(player, 'playerShots', teodorShotData[teodorCardSlot], playerCardSlot)
        replaceShot(player, 'teodorShots', playerShotData[playerCardSlot], teodorCardSlot)
        player:setLocalVar('teodorSpecial', 1)

    elseif
        player:getLocalVar('turnNumber') > 1 and
        player:getLocalVar('teodorSpecial') == 0 and
        math.random(1, 100) <= 20
    then
        -- Crooked Die
        teodorAction = 4
        local chosenSlot      = math.random(1, #getShotHistory(player, 'playerShots')) - 1
        local newRollValue    = math.random(1, 6)

        teodorSpecial         = bit.lshift(newRollValue, 5) + chosenSlot

        replaceShot(player, 'playerShots', newRollValue, chosenSlot)
        player:setLocalVar('teodorSpecial', 1)

    elseif
        math.random(1, 100) <= rollThreshold and
        player:getLocalVar('teodorStayed') == 0 and
        ((teodorScore > 0 and teodorScore <= 11) or
        player:getLocalVar('turnNumber') == 1)
    then
        -- Shoot
        teodorAction = 0
        teodorShotValue = math.random(1, 6)
        addShot(player, 'teodorShots', teodorShotValue)

    else
        -- Stay
        player:setLocalVar('teodorStayed', 1)
    end

    return teodorAction, teodorShotValue, teodorSpecial
end

xi.soa.helpers.initGameRound = function(player)
    player:setLocalVar('turnNumber', 1)
    player:setLocalVar('playerShots', 0)
    player:setLocalVar('teodorShots', 0)
    player:setLocalVar('teodorStayed', 0)
    player:setLocalVar('playerSpecial', 0)
    player:setLocalVar('teodorSpecial', 0)
end

xi.soa.helpers.updateMinigameEvent = function(player, csid, option, npc)
    local turnNumber = player:getLocalVar('turnNumber')
    local trickMask  = player:getLocalVar('playerSpecial') == 0 and 128 or 4

    -- Shoot
    if option == 0 then
        local playerShotValue = math.random(1, 6)
        addShot(player, 'playerShots', playerShotValue)

        local teodorAction, teodorShotValue, teodorSpecial = chooseTeodorAction(player)

        player:updateEvent(0, turnNumber, playerShotValue, 0, teodorSpecial, teodorShotValue, teodorAction, trickMask)
        player:setLocalVar('turnNumber', turnNumber + 1)

    -- Stay
    elseif option == 1 then
        local gameStatus = 0 -- 1 = Win, 2 = Lose, 3 = Tie, 0 = Teodor keeps playing
        local teodorAction, teodorShotValue, teodorSpecial = chooseTeodorAction(player)

        -- Both players have stayed, set game status and update session score
        if teodorAction == 1 then
            local playerScore = getShotTotal(player, 'playerShots')
            local teodorScore = getShotTotal(player, 'teodorShots')

            if playerScore > teodorScore then
                gameStatus = 1
            elseif playerScore == teodorScore then
                gameStatus = 3
            else
                gameStatus = 2
            end

            updateSessionScore(player, gameStatus)
        else
            player:setLocalVar('turnNumber', turnNumber + 1)
        end

        player:updateEvent(gameStatus, turnNumber, 0, 1, teodorSpecial, teodorShotValue, teodorAction, player:getLocalVar('sessionScore'))

        if gameStatus > 0 then
            xi.soa.helpers.initGameRound(player)
        end

    -- Peek
    elseif option == 2 then
        player:updateEvent(0, turnNumber, 0, 2, 1, 0, 0, 4)
        player:setLocalVar('playerSpecial', 1)

    -- Switcharoo
    elseif bit.band(option, 0x7) == 3 then
        local playerCardSlot = bit.band(bit.rshift(option, 3), 0xF) + 1
        local teodorCardSlot = bit.band(bit.rshift(option, 7), 0xF) + 1
        local playerShotData = getShotHistory(player, 'playerShots')
        local teodorShotData = getShotHistory(player, 'teodorShots')
        local swapData       = bit.lshift(teodorShotData[teodorCardSlot], 5) + playerShotData[playerCardSlot]

        replaceShot(player, 'playerShots', teodorShotData[teodorCardSlot], playerCardSlot)
        replaceShot(player, 'teodorShots', playerShotData[playerCardSlot], teodorCardSlot)

        player:setLocalVar('playerSpecial', 1)
        player:updateEvent(0, turnNumber, 0, 3, 1, 0, 0, swapData)

    -- Crooked Die
    elseif bit.band(option, 0x7) == 4 then
        local chosenSlot   = bit.rshift(option, 7)
        local newRollValue = math.random(1, 6)
        local rerollData   = bit.lshift(newRollValue, 5) + bit.lshift(chosenSlot, 1)

        replaceShot(player, 'teodorShots', newRollValue, chosenSlot + 1)
        player:setLocalVar('playerSpecial', 1)
        player:updateEvent(0, turnNumber, 0, 4, rerollData, 0, 0, 0)
    end
end
