-----------------------------------
-- Abyssea Sturdy Pyxis Red Chest
-----------------------------------
xi = xi or {}
xi.pyxis = xi.pyxis or {}

xi.pyxis.redChest = {}

local pressureChoice =
{
    [ 2] = 10,
    [ 4] = 20,
    [ 8] = 30,
    [16] = 10,
    [32] = 20,
    [64] = 30,
}

local lockwear =
{
    [1] = 5,
    [2] = 10,
    [3] = 15,
    [4] = 30
}

local function GetLockwearMessage(npc)
    local lockwearmessage  = npc:getLocalVar('LOCKWEARMESSAGE')

    if lockwearmessage == 0 or lockwearmessage == nil then
        lockwearmessage = math.random(1, 4)
    end

    return lockwearmessage
end

local function SetLockwearAdd(npc, lockwearmessage)
    local lockwearmax = lockwear[lockwearmessage]

    npc:setLocalVar('LOCKWEARADD', math.random(0, lockwearmax))
end

xi.pyxis.redChest.startEvent = function(player, npc, event, contentMessage, timeleft)
    local targetnumber    = npc:getLocalVar('RAND_NUM')
    local currentpressure = npc:getLocalVar('CURRENTPRESSURE')
    local currentAttempts = npc:getLocalVar('CURRENT_ATTEMPTS')
    local pressurerange   = 10
    local targetlow       = 0
    local targethigh      = 0
    local attemptsallowed = 5

    if currentpressure <= 0 then
        currentpressure = math.random(90, 100)
        npc:setLocalVar('CURRENTPRESSURE', currentpressure)
    end

    targetlow  = targetnumber - pressurerange
    targethigh = targetnumber + pressurerange

    local goodPressure = bit.bor(targetlow, bit.lshift(targethigh, 16))

    local lockwearmessage = GetLockwearMessage(npc)

    SetLockwearAdd(npc, lockwearmessage)

    player:startEvent(event, contentMessage, currentpressure, goodPressure, lockwearmessage -1, attemptsallowed, currentAttempts, 3, timeleft) -- Red
end

xi.pyxis.redChest.unlock = function(player, csid, option, npc)
    local lockedchoice     = bit.lshift(1, option)

    if lockedchoice == 1 then
        return
    end

    local ID               = zones[player:getZoneID()]
    local currentAttempts  = npc:getLocalVar('CURRENT_ATTEMPTS')
    local attemptsallowed  = 5
    local lastrand         = npc:getLocalVar('RAND_NUM')
    local lockwearadd      = npc:getLocalVar('LOCKWEARADD')
    local targetpressure   = lastrand
    local currentpressure  = npc:getLocalVar('CURRENTPRESSURE')
    local pressurerange    = 10
    local pressurechange   = pressureChoice[lockedchoice] + lockwearadd
    local targetlow        = targetpressure - pressurerange
    local targethigh       = targetpressure + pressurerange
    local newPressure      = 0

    if lockedchoice < 16 then
        newPressure = currentpressure - pressurechange
    else
        newPressure = currentpressure + pressurechange
    end

    currentAttempts = currentAttempts + 1
    npc:setLocalVar('CURRENT_ATTEMPTS', currentAttempts)

    if
        newPressure >= targetlow and
        newPressure <= targethigh
    then
        xi.pyxis.messageChest(player, ID.text.AIR_PRESSURE_CHANGE, pressurechange, 0, nil, newPressure, npc)
        xi.pyxis.messageChest(player, ID.text.PLAYER_OPENED_LOCK, 0, 0, 0, 0, npc)
        xi.pyxis.openChest(player, npc)
    elseif currentAttempts >= attemptsallowed then
        xi.pyxis.removeChest(player, npc, 0, 1)
        xi.pyxis.messageChest(player, ID.text.PLAYER_FAILED_LOCK, 0, 0, 0, 0, npc)
        player:messageSpecial(ID.text.CHEST_DISAPPEARED)
    else
        npc:setLocalVar('LOCKWEARMESSAGE', math.random(1, 4))

        if newPressure > 0 then
            npc:setLocalVar('CURRENTPRESSURE', newPressure)
            xi.pyxis.messageChest(player, ID.text.AIR_PRESSURE_CHANGE, pressurechange, 0, nil, newPressure, npc)
        else
            npc:setLocalVar('CURRENTPRESSURE', 0)
            xi.pyxis.messageChest(player, ID.text.AIR_PRESSURE_CHANGE, pressurechange, 0, nil, 0, npc)
        end
    end
end
