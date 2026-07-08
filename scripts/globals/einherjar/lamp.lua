-----------------------------------
-- Einherjar: Glowing Lamp management
-----------------------------------
xi = xi or {}
xi.einherjar = xi.einherjar or {}

xi.einherjar.makeLamp = function(player, chamberId, startTime, endTime)
    player:addItem({
        id = xi.item.GLOWING_LAMP,
        exdata =
        {
            chamberId = chamberId,
            flags     = 1,
            startTime = startTime,
            endTime   = endTime,
        },
    })
end

-- Zero out all matching lamps
-- Used when chamber expels player
xi.einherjar.voidAllLamps = function(player, chamberId)
    for _, item in ipairs(player:findItems(xi.item.GLOWING_LAMP)) do
        local lampData = xi.einherjar.decypherLamp(item)
        if lampData.chamberId == chamberId then
            xi.einherjar.voidLamp(player, item)
        end
    end
end

-- Zero out a given glowing lamp so the client shows it as expired
xi.einherjar.voidLamp = function(player, lampObj)
    lampObj:setExData({ chamberId = 0, flags = 0, startTime = 0, endTime = 0 })
end

-- Reads a given Glowing Lamp and returns the chamber, enter time, and exit time
xi.einherjar.decypherLamp = function(lampObj)
    local ex = lampObj and lampObj:getExData()
    if not ex or ex.chamberId == 0 then
        return { chamberId = 0, startTime = 0, endTime = 0 }
    end

    return { chamberId = ex.chamberId, startTime = ex.startTime, endTime = ex.endTime }
end

xi.einherjar.isLampExpired = function(lampObj)
    local lampData = xi.einherjar.decypherLamp(lampObj)

    return lampData and lampData.endTime and GetSystemTime() > lampData.endTime
end

xi.einherjar.getMatchingLamps = function(player, chamberId, startTime)
    local matchingLamps = { }

    for _, item in ipairs(player:findItems(xi.item.GLOWING_LAMP)) do
        local lampData = xi.einherjar.decypherLamp(item)
        if
            lampData.chamberId == chamberId and
            lampData.startTime == startTime
        then
            table.insert(matchingLamps, item)
        end
    end

    return matchingLamps
end

xi.einherjar.onLampCheck = function(player, lampObj)
    if not lampObj then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    if player:getZone():getID() ~= xi.zone.HAZHALM_TESTING_GROUNDS then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    if xi.einherjar.isLampExpired(lampObj) then
        xi.einherjar.voidLamp(player, lampObj)
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    if player:getFreeSlotsCount() <= 1 then -- <= 1 is not a typo -- see onLampUse
        return xi.msg.basic.ITEM_NO_USE_INVENTORY
    end

    return 0
end

-- Player is using a Glowing Lamp
-- Make a duplicate of the lamp
xi.einherjar.onLampUse = function(player, lampObj)
    if not lampObj then
        return
    end

    local lampData = xi.einherjar.decypherLamp(lampObj)
    if not lampData or not lampData.chamberId then
        return
    end

    local chamberInstance = xi.einherjar.getChamber(lampData.chamberId)
    if not chamberInstance then
        xi.einherjar.voidLamp(player, lampObj)
        return
    end

    -- Using the lamp consumes it, so we need to make two new ones
    -- TODO: Figure out if lamp consumption can be blocked
    for _ = 1, 2 do
        xi.einherjar.makeLamp(player, lampData.chamberId, lampData.startTime, lampData.endTime)
    end
end

-- Player is dropping a Glowing Lamp
-- If they're in a chamber and have no matching lamps, ensure they're kicked out
xi.einherjar.onLampDrop = function(player, lampObj)
    if player:getZone():getID() ~= xi.zone.HAZHALM_TESTING_GROUNDS then
        return
    end

    local lampData = xi.einherjar.decypherLamp(lampObj)
    if lampData.chamberId == 0 then
        return
    end

    local chamberData = xi.einherjar.getChamber(lampData.chamberId)
    if not chamberData then
        return
    end

    if lampData.startTime ~= chamberData.startTime then
        return
    end

    if #xi.einherjar.getMatchingLamps(player, lampData.chamberId, lampData.startTime) == 0 then
        xi.einherjar.onChamberExit(chamberData, player, false)
    end
end
