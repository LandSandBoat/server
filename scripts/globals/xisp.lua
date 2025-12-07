xi = xi or {}
xi.xisp = xi.xisp or {}

-- Augmenting an item
xi.xisp.createExData = function(val)
    local exData = {}
    if val ~= nil then
        exData[0    ] = bit.band(val, 0x00FF)
        exData[0 + 1] = bit.rshift(bit.band(val, 0xFF00), 8)
    end

    return exData
end

xi.xisp.getExData = function(item)
    local data = item:getExData()
    return (bit.lshift(data[0 + 1], 8) + data[0]) or 0
end

xi.xisp.setExData = function(item, val)
    if item ~= nil then
        local newData = xi.xisp.createExData(val)

        if newData then
            item:setExData(newData)
        end
    end
end

-- Custom GM Menus
xi.xisp.sendMenu = function(player, menuID)
    player:timer(50, function(playerArg)
        playerArg:customMenu(menuID)
    end)
end

xi.xisp.onZone = function(player)
    -- Respawn Followers
    player:timer(200, function(playerArg)
        local zone = player:getZone()
        xi.xispchocobo.despawnChocobo(playerArg)
        xi.xispchocobo.spawnChocobo(playerArg, zone)
    end)
end

-- Get random point around a location
xi.xisp.getPointAroundLoc = function(pos, min, max)
    local random = math.random(1, 4)
    local posX
    local posZ

    if random == 1 then
        posX = pos.x + math.random(min, max)
        posZ = pos.z + math.random(min, max)
    elseif random == 2 then
        posX = pos.x + math.random(min, max)
        posZ = pos.z - math.random(min, max)
    elseif random == 3 then
        posX = pos.x - math.random(min, max)
        posZ = pos.z + math.random(min, max)
    else
        posX = pos.x - math.random(min, max)
        posZ = pos.z - math.random(min, max)
    end

    return posX, posZ
end
