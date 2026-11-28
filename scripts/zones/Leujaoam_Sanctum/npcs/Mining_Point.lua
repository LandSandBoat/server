-----------------------------------
-- Area: Leujaoam Sanctum
-- Mining Point
-----------------------------------
local ID = zones[xi.zone.LEUJAOAM_SANCTUM]
-----------------------------------
local miningPointSpawnOptions =
{
    [17060016] =
    {
        { x = -549.027, y = -51.000, z = 199.134, rot = 0 },
        { x = -513.640, y = -52.000, z = 204.103, rot = 0 },
        { x = -528.246, y = -51.504, z = 203.002, rot = 0 },
        { x = -525.456, y = -51.000, z = 216.318, rot = 0 },
        { x = -520.596, y = -51.525, z = 243.901, rot = 0 },
    },

    [17060017] =
    {
        { x = -495.485, y = -32.000, z = 337.122, rot = 0 },
        { x = -500.969, y = -35.000, z = 322.946, rot = 0 },
        { x = -540.252, y = -51.534, z = 272.440, rot = 0 },
        { x = -540.609, y = -51.350, z = 286.021, rot = 0 },
        { x = -538.240, y = -48.901, z = 293.693, rot = 0 },
    },

    [17060018] =
    {
        { x = -398.561, y = -23.000, z = 248.782, rot = 0 },
        { x = -408.464, y = -23.000, z = 230.004, rot = 0 },
        { x = -442.548, y = -23.568, z = 226.753, rot = 0 },
        { x = -447.546, y = -23.446, z = 227.051, rot = 0 },
        { x = -419.918, y = -24.169, z = 249.661, rot = 0 },
    },

    [17060019] =
    {
        { x = -367.485, y = 4.000,   z = 151.937, rot = 0 },
        { x = -351.443, y = 3.000,   z = 147.359, rot = 0 },
        { x = -331.361, y = 4.289,   z = 178.428, rot = 0 },
        { x = -312.000, y = 5.130,   z = 155.979, rot = 0 },
        { x = -310.905, y = 4.5,     z = 160.516, rot = 0 },
    },

    [17060020] =
    {
        { x = -322.529, y = 0.000,   z = 195.094, rot = 0 },
        { x = -326.596, y = -0.034,  z = 249.966, rot = 0 },
        { x = -319.922, y = 0.000,   z = 239.955, rot = 0 },
        { x = -311.480, y = 0.697,   z = 247.904, rot = 0 },
        { x = -310.441, y = 0.433,   z = 224.163, rot = 0 },
    },

    [17060021] =
    {
        { x = -490.164, y = -28.000, z = 100.872, rot = 0 },
        { x = -420.692, y = -11.000, z = 83.443,  rot = 0 },
        { x = -396.473, y = -3.385,  z = 99.225,  rot = 0 },
        { x = -461.404, y = -27.615, z = 93.306,  rot = 0 },
        { x = -416.124, y = -8.031,  z = 96.842,  rot = 0 },
    },

    [17060022] =
    {
        { x = -381.492, y = -28.000, z = 183.591, rot = 0 },
        { x = -390.760, y = -28.030, z = 180.265, rot = 0 },
        { x = -376.461, y = -27.573, z = 217.242, rot = 0 },
        { x = -379.159, y = -28.457, z = 177.491, rot = 0 },
        { x = -379.200, y = -28.000, z = 200.480, rot = 0 },
        { x = -403.751, y = -27.500, z = 179.859, rot = 0 },
    },

    [17060023] =
    {
        { x = -419.408, y = -31.000, z = 334.733, rot = 0 },
        { x = -420.536, y = -32.000, z = 310.364, rot = 0 },
        { x = -425.876, y = -32.087, z = 331.704, rot = 0 },
        { x = -414.012, y = -32.064, z = 308.767, rot = 0 },
        { x = -414.728, y = -31.796, z = 304.956, rot = 0 },
    },

    [17060024] =
    {
        { x = -446.034, y = -52.121, z = 248.996, rot = 0 },
        { x = -435.199, y = -55.000, z = 159.421, rot = 0 },
        { x = -436.735, y = -51.728, z = 250.734, rot = 0 },
        { x = -459.998, y = -27.506, z = 87.984,  rot = 0 },
        { x = -437.327, y = -55.535, z = 154.233, rot = 0 },
    },

    [17060025] =
    {
        { x = -325.807, y = -28.000, z = 229.322, rot = 0 },
        { x = -317.824, y = -28.000, z = 170.400, rot = 0 },
        { x = -322.858, y = -28.289, z = 231.136, rot = 0 },
        { x = -317.708, y = -27.929, z = 241.236, rot = 0 },
        { x = -316.305, y = -27.520, z = 162.845, rot = 0 },
    },
}

---@type TNpcEntity
local entity = {}

local function initializeMiningPoint(npc)
    npc:setLocalVar('hitsRemaining', 7)
    npc:setLocalVar('wormActive', 0)
    npc:setLocalVar('wormMobId', 0)
    npc:setLocalVar('miningLockUntil', 0)
    npc:setLocalVar('initialized', 1)
end

local function respawnMiningPoint(npc)
    local options = miningPointSpawnOptions[npc:getID()]
    if options then
        local spawn = utils.randomEntry(options)
        if spawn then
            npc:setPos(spawn.x, spawn.y, spawn.z, spawn.rot)
        end
    end

    npc:setStatus(xi.status.NORMAL)
    initializeMiningPoint(npc)
end

local function despawnMiningPoint(npc)
    npc:setStatus(xi.status.DISAPPEAR)
    npc:timer(180000, function(npcArg)
        respawnMiningPoint(npcArg)
    end)
end

local function activateQiqirnMiners(instance, player)
    for i = 0, 7 do
        local mobID = ID.mob.QIQIRN_MINER + i
        local miner = GetMobByID(mobID, instance)

        if miner then
            miner:triggerListener('ORICHALCUM_WAKE', miner, player)
        end
    end
end

local function spawnLinkedWorm(player, npc, instance)
    for i = 0, 9 do
        local mobID = ID.mob.MINERAL_EATER + i
        local worm  = GetMobByID(mobID, instance)

        if worm and not worm:isSpawned() then
            local angle   = math.randomFloat(0, 2 * math.pi)
            local spawnX  = npc:getXPos() + math.cos(angle) * 0.15
            local spawnZ  = npc:getZPos() + math.sin(angle) * 0.15
            worm:setLocalVar('pointId', npc:getID())
            worm:setSpawn(spawnX, npc:getYPos(), spawnZ, npc:getRotPos())
            local spawnedWorm = SpawnMob(mobID, instance)
            if spawnedWorm then
                spawnedWorm:setLocalVar('pointId', npc:getID())
                spawnedWorm:updateEnmity(player)
            else
                worm:setLocalVar('pointId', npc:getID())
                worm:updateEnmity(player)
            end

            npc:setLocalVar('wormActive', 1)
            npc:setLocalVar('wormMobId', mobID)
            return true
        end
    end

    return false
end

entity.onSpawn = function(npc)
    respawnMiningPoint(npc)
end

entity.onTrigger = function(player, npc)
    local instance = npc:getInstance()

    if not instance then
        return
    end

    if npc:getLocalVar('initialized') == 0 then
        initializeMiningPoint(npc)
    end

    if player:checkDistance(npc) > 3 then
        player:messageText(player, ID.text.MOVE_CLOSER, false)
        return
    end

    if not player:hasItem(xi.item.PICKAXE, xi.inv.TEMPITEMS) then
        player:messageSpecial(ID.text.NO_PICKAXE, xi.item.PICKAXE)
        return
    end

    if npc:getLocalVar('wormActive') == 1 then
        local wormID = npc:getLocalVar('wormMobId')
        if wormID ~= 0 then
            local worm = GetMobByID(wormID, instance)
            if not worm or not worm:isSpawned() then
                npc:setLocalVar('wormActive', 0)
                npc:setLocalVar('wormMobId', 0)
            end
        end

        if npc:getLocalVar('wormActive') == 1 then
            player:messageText(player, ID.text.CANT_MINE_RIGHT_NOW, false)
            return
        end
    end

    if npc:getLocalVar('miningLockUntil') > GetSystemTime() then
        return
    end

    local hitsRemaining = npc:getLocalVar('hitsRemaining')
    if hitsRemaining <= 0 then
        player:messageText(player, ID.text.FIND_NOTHING, false)
        return
    end

    -- 10% chance to spawn a worm
    if math.random(1, 100) <= 10 then
        if spawnLinkedWorm(player, npc, instance) then
            player:messageText(player, ID.text.CANT_MINE_RIGHT_NOW, false)
            return
        end
    end

    -- Setting a 4 sec lock between mining attempts to prevent spamming
    npc:setLocalVar('miningLockUntil', GetSystemTime() + 4)
    player:lookAt(npc:getXPos(), npc:getYPos(), npc:getZPos())
    player:positionSpecial(
        {
            x = player:getXPos(),
            y = player:getYPos(),
            z = player:getZPos(),
            rot = player:getRotPos(),
        },
        0x0A
    )
    player:timer(100, function(playerArg)
        local point = GetNPCByID(npc:getID(), instance)
        if playerArg and point then
            playerArg:sendEmote(point, xi.emote.EXCAVATION, xi.emoteMode.MOTION, false)
        end
    end)

    local hitsAfter = hitsRemaining - 1
    npc:setLocalVar('hitsRemaining', hitsAfter)

    local outcomeRoll = math.random(1, 200)
    if outcomeRoll <= 180 then
        player:messageText(player, ID.text.FIND_NOTHING, false)
    elseif outcomeRoll <= 199 then
        if player:addItem(xi.item.PEBBLE) then
            player:messageSpecial(ID.text.OBTAIN_PEBBLE, xi.item.PEBBLE)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.PEBBLE)
        end
    else  -- 0.5% chance to find a chunk of orichalcum ore
        if player:addTempItem(xi.item.CHUNK_OF_ORICHALCUM_ORE) then
            player:messageSpecial(ID.text.OBTAIN_ORICHALCUM_ORE, xi.item.CHUNK_OF_ORICHALCUM_ORE)
            activateQiqirnMiners(instance, player)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.CHUNK_OF_ORICHALCUM_ORE)
        end
    end

    -- 8% chance to break the pickaxe
    if math.random(1, 100) <= 8 then
        if player:delItem(xi.item.PICKAXE, 1, xi.inv.TEMPITEMS) then
            player:messageSpecial(ID.text.PICKAXE_BREAKS, xi.item.PICKAXE)
        end
    end

    if hitsAfter <= 0 then
        despawnMiningPoint(npc)
    end
end

return entity
