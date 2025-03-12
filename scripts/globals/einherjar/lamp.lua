-----------------------------------
-- Einherjar: Glowing Lamp management
-----------------------------------
xi = xi or {}
xi.einherjar = xi.einherjar or {}

xi.einherjar.makeLamp = function(player, chamberId, startTime, endTime)
    player:addItem({
        id = xi.item.GLOWING_LAMP,
        exdata = {
            [0] = 0x1D + chamberId,
            [2] = 0x01,
            [8] = bit.band(endTime, 0xFF),
            [9] = bit.band(bit.rshift(endTime, 8), 0xFF),
            [10] = bit.band(bit.rshift(endTime, 16), 0xFF),
            [11] = bit.band(bit.rshift(endTime, 24), 0xFF),
            [12] = bit.band(startTime, 0xFF),
            [13] = bit.band(bit.rshift(startTime, 8), 0xFF),
            [14] = bit.band(bit.rshift(startTime, 16), 0xFF),
            [15] = bit.band(bit.rshift(startTime, 24), 0xFF),
        },
    })
end

-- Zero out all matching lamps
-- Used when chamber expels player
xi.einherjar.voidAllLamps = function(player, chamberId)
    for _, item in ipairs(player:findItems(xi.item.GLOWING_LAMP)) do
        local lampData = xi.einherjar.decypherLamp(item)
        if lampData.chamber == chamberId then
            xi.einherjar.voidLamp(player, item)
        end
    end
end

-- Drop a given glowing lamp and give a new zeroed out one to make it seem like it expired
-- The client briefly flashes a new item which is not exactly retail behavior
xi.einherjar.voidLamp = function(player, lampObj)
    player:delItemAt(xi.item.GLOWING_LAMP, 1, lampObj:getLocationID(), lampObj:getSlotID())
    player:addItem({
        id = xi.item.GLOWING_LAMP,
        exdata = {
            [0] = 0x0,
            [2] = 0x0,
            [8] = 0x0,
            [9] = 0x0,
            [10] = 0x0,
            [11] = 0x0,
            [12] = 0x0,
            [13] = 0x0,
            [14] = 0x0,
            [15] = 0x0,
        },
    })
end

-- Reads a given Glowing Lamp and returns the chamber, enter time, and exit time
xi.einherjar.decypherLamp = function(lampObj)
    local exData = lampObj and lampObj:getExData()

    if not exData or #exData < 16 or exData[0] == 0 then
        return { chamber = 0, tier = 0, enter = 0, exit = 0 }
    end

    local chamber = exData[0] - 0x1D

    local exit = bit.bor(
        exData[8] or 0,
        bit.lshift(exData[9] or 0, 8),
        bit.lshift(exData[10] or 0, 16),
        bit.lshift(exData[11] or 0, 24)
    )

    local enter = bit.bor(
        exData[12] or 0,
        bit.lshift(exData[13] or 0, 8),
        bit.lshift(exData[14] or 0, 16),
        bit.lshift(exData[15] or 0, 24)
    )

    return { chamber = chamber, enter = enter, exit = exit }
end

xi.einherjar.isLampExpired = function(lampObj)
    local lampData = xi.einherjar.decypherLamp(lampObj)
    return lampData and lampData.exit and os.time() > lampData.exit
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
    if not lampData or not lampData.chamber then
        return
    end

    -- Using the lamp consumes it, so we need to make two new ones
    -- TODO: Check if chamber is still active
    -- TODO: Figure out if lamp consumption can be blocked
    for _ = 1, 2 do
        xi.einherjar.makeLamp(player, lampData.chamber, lampData.enter, lampData.exit)
    end
end

-- Player is dropping a Glowing Lamp
-- If they're in a chamber and have no matching lamps, ensure they're kicked out
xi.einherjar.onLampDrop = function(player, lampObj)
    if player:getZone():getID() ~= xi.zone.HAZHALM_TESTING_GROUNDS then
        return
    end

    local lampData = xi.einherjar.decypherLamp(lampObj)

    if lampData.chamber == 0 then
        return
    end

    -- TODO: Check if chamber is still reserved
    -- TODO: Check if player has other matching lamps
    -- TODO: Ask Chamber to kick player out
end
