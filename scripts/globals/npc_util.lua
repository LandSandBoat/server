--[[
    Helper functions for common NPC tasks.

    npcUtil.popFromQM(player, qm, mobId, params)
    npcUtil.pickNewPosition(npc, positionTable, allowCurrentPosition)
    npcUtil.giveCurrency(player, currency, amount)
    npcUtil.giveItem(player, items, params)
    npcUtil.giveKeyItem(player, keyitems)
    npcUtil.completeMission(player, logId, missionId, params)
    npcUtil.completeQuest(player, area, quest, params)
    npcUtil.tradeHas(trade, items)
    npcUtil.tradeHasExactly(trade, items)
    npcUtil.queueMove(npc, point, delay)
    npcUtil.UpdateNPCSpawnPoint(id, minTime, maxTime, posTable, serverVar)
    npcUtil.castingAnimation(npc, magicType, phaseDuration, func)
    npcUtil.fishingAnimation(npc, phaseDuration, func)
--]]

---@class npcUtil
npcUtil = {}

--[[
    Pop mob(s) from question mark NPC.
    If any mob is already spawned, return false.
    Params (table) can contain the following parameters:

    radius (number)
        if set, spawn mobs randomly within radius of NPC
    claim (boolean, default true)
        do spawned mobs automatically aggro the player
    hide (number, default xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
        how long to hide the QM for after mobs die
    message (number)
        if set a message will play if a entity spawns

--]]
---@param player CBaseEntity
---@param qm CBaseEntity
---@param mobId integer|integer[]
---@param params table?
---@return boolean
function npcUtil.popFromQM(player, qm, mobId, params)
    local qmId = qm:getID()

    -- default params
    if not params then
        params = {}
    end

    if params.claim == nil or type(params.claim) ~= 'boolean' then
        params.claim = true
    end

    if params.hide == nil or type(params.hide) ~= 'number' then
        params.hide = xi.settings.main.FORCE_SPAWN_QM_RESET_TIME
    end

    -- get list of mobs to pop
    local mobs = {}
    if type(mobId) == 'number' then
        table.insert(mobs, mobId)
    elseif type(mobId) == 'table' then
        for _, v in pairs(mobId) do
            if type(v) == 'number' then
                table.insert(mobs, v)
            end
        end
    end

    -- make sure none are spawned
    for k, v in pairs(mobs) do
        local mob = GetMobByID(v)
        if mob == nil or mob:isSpawned() then
            return false
        else
            mobs[k] = mob
        end
    end

    -- hide qm
    if params.hide > 0 then
        qm:setStatus(xi.status.DISAPPEAR)
    end

    -- spawn mobs and give each a listener that will show QM after they are all dead
    for _, mob in pairs(mobs) do
        -- choose random position uniformly from within radius
        if params.radius and type(params.radius) == 'number' then
            local r = params.radius * math.sqrt(math.random())
            local theta = math.random() * 2 * math.pi
            local x = r * math.cos(theta)
            local z = r * math.sin(theta)
            mob:setSpawn(qm:getXPos() + x, qm:getYPos(), qm:getZPos() + z)
        end

        -- spawn
        mob:spawn()

        -- claim
        if params.claim then
            mob:updateClaim(player)
        end

        -- look
        if params.look then
            mob:lookAt(player:getPos())
        end

        -- reappear the QM when all spawned mobs are dead, plus params.hide seconds
        if params.hide > 0 then
            local myId = mob:getID()
            mob:setLocalVar('qm', qmId)
            mob:addListener('DESPAWN', 'QM_'..myId, function(m)
                m:removeListener('QM_'..myId)

                for _, v in pairs(mobs) do
                    if v:isAlive() then
                        return false
                    end
                end

                GetNPCByID(m:getLocalVar('qm')):updateNPCHideTime(params.hide)
            end)
        end

        -- add in a spawn message if has one
        if params.message then
            player:messageSpecial(params.message)
        end
    end

    return true
end

--[[
    Queue a position change for an NPC.  We do this because if you setPos() an NPC
    immediately after you setStatus(xi.status.DISAPPEAR) it, the QM does not hide
    on the players' screens.

    point may be any of the following formats:
    { x, y, z }
    { x, y, z, rot }
    { x = x, y = y, z = z }
    { x = x, y = y, z = z, rot = r }
--]]
---@param x number
---@param y number
---@param z number
---@param r integer?
---@return function
---@overload fun(posTable: { ['x']: number, ['y']: number, ['z']: number, ['rot']: integer? }): nil
local function doMove(x, y, z, r)
    if not r then
        r = 0
    end

    ---@param entity CBaseEntity
    return function(entity)
        entity:setPos(x, y, z, r)
    end
end

---@param npc CBaseEntity
---@param point { ['x']: number, ['y']: number, ['z']: number, ['rot']: integer? }
---@param delay integer?
---@return nil
function npcUtil.queueMove(npc, point, delay)
    if not delay then
        delay = 3000
    end

    if point.rot then
        point = { point.x, point.y, point.z, point.rot }
    elseif point.x then
        point = { point.x, point.y, point.z }
    end

    local x, y, z, rot = unpack(point)
    npc:queue(delay, doMove(x, y, z, rot))
end

-- Picks a new position for an NPC and excluding the current position.
-- INPUT: npc = npcID, position = 2D table with coords: index, { x, y, z }
-- RETURN: table index
---@param npcID integer
---@param positionTable table
---@param allowCurrentPosition boolean?
---@return table
function npcUtil.pickNewPosition(npcID, positionTable, allowCurrentPosition)
    local npc = GetNPCByID(npcID)
    local positionIndex  = 1 -- Default to position one in the table if it can't be found.
    local tableSize      = 0
    local newPosition    = math.random(1, tableSize)
    allowCurrentPosition = allowCurrentPosition or false

    for i, v in ipairs(positionTable) do   -- Looking for the current position

        if not allowCurrentPosition then
            -- Finding by comparing the NPC's coords
            if
                npc and
                math.floor(v[1]) == math.floor(npc:getXPos()) and
                math.floor(v[2]) == math.floor(npc:getYPos()) and
                math.floor(v[3]) == math.floor(npc:getZPos())
            then
                positionIndex = i -- Found where the NPC is!
            end
        end

        tableSize = tableSize + 1 -- Counting the array size
    end

    if not allowCurrentPosition then
        -- Pick a new pos that isn't the current
        repeat
            newPosition = math.random(1, tableSize)
        until (newPosition ~= positionIndex)
    end

    return { ['x'] = positionTable[newPosition][1], ['y'] = positionTable[newPosition][2], ['z'] = positionTable[newPosition][3] }
end

--[[
    Give item(s) to player.
    If player has inventory space, give items, display message, and return true.
    If not, do not give items, display a message to indicate this, and return false.

    Examples of valid items parameter:
        npcUtil.giveItem(player, xi.item.CHUNK_OF_COPPER_ORE, 1)                                           -- copper ore x1
        npcUtil.giveItem(player, { xi.item.CHUNK_OF_COPPER_ORE, 1 , xi.item.CHUNK_OF_TIN_ORE, 1 })         -- copper ore x1, tin ore x1
        npcUtil.giveItem(player, { { xi.item.CHUNK_OF_COPPER_ORE, 2 } })                                   -- copper ore x2
        npcUtil.giveItem(player, { { xi.item.CHUNK_OF_COPPER_ORE, 12 }, { xi.item.CHUNK_OF_TIN_ORE, 3 } }) -- copper ore x12 tin ore x3
        npcUtil.giveItem(target, { { xi.item.CHUNK_OF_COPPER_ORE, math.random(3, 15) } })                  -- random 3-15 copper ores
        enum can be found in scripts/enum/item.lua

    params (table) can contain the following parameters:

    silent (boolean, default false)
        if set, displays no messages
    fromTrade (boolean, default false)
        if set, when player has no room for items, display
        "Try trading again after sorting your inventory"
        instead of
        "Come back again after sorting your inventory"
    multiple (boolean default false)
        if set, force message type as multiples version
        eg. You obtain 1 chunk of rock salt!
--]]

---@class itemQuantityEntry : { [xi.item]: xi.item, [integer]: integer }

---@class multipleItemList
---@field [integer] { [integer]: xi.item, [integer]: integer }|xi.item

---@param player CBaseEntity
---@param items xi.item|itemQuantityEntry|multipleItemList
---@param params { silent: boolean?, fromTrade: boolean?, multiple: boolean? }?
---@return boolean
function npcUtil.giveItem(player, items, params)
    params = params or {}
    local ID = zones[player:getZoneID()]

    -- create table of items, with key/val of itemId/itemQty
    local givenItems = {}
    if type(items) == 'number' then
        table.insert(givenItems, { items, 1 })
    elseif type(items) == 'table' then
        for _, v in pairs(items) do
            if type(v) == 'number' then
                table.insert(givenItems, { v, 1 })
            elseif
                type(v) == 'table' and
                #v == 2 and
                type(v[1]) == 'number' and
                type(v[2]) == 'number'
            then
                table.insert(givenItems, { v[1], v[2] })
            else
                print(string.format('ERROR: invalid items parameter given to npcUtil.giveItem in zone %s.', player:getZoneName()))
                return false
            end
        end
    end

    -- does player have enough inventory space?
    if player:getFreeSlotsCount() < #givenItems then
        if not params.silent then
            local messageId = params.fromTrade and (ID.text.ITEM_CANNOT_BE_OBTAINED + 4) or ID.text.ITEM_CANNOT_BE_OBTAINED
            player:messageSpecial(messageId, givenItems[1][1])
        end

        return false
    end

    -- give items to player
    local messagedItems = {}
    for _, v in pairs(givenItems) do
        if player:addItem(v[1], v[2], true) then
            if not params.silent and not messagedItems[v[1]] then
                if
                    v[2] > 1 or
                    params.multiple
                then
                    player:messageSpecial(ID.text.ITEM_OBTAINED + 9, v[1], v[2])
                else
                    player:messageSpecial(ID.text.ITEM_OBTAINED, v[1])
                end
            end

            messagedItems[v[1]] = true
        elseif #givenItems == 1 then
            if not params.silent then
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, givenItems[1][1])
            end

            return false
        end
    end

    return true
end

--[[
    Give temp item(s) to player.
    If player has inventory space, give items, display message, and return true.
    If not, do not give items, display a message to indicate this, and return false.

    Examples of valid items parameter:
        640                 -- copper ore x1
        { 640, 641 }        -- copper ore x1, tin ore x1
        { { 640, 2 } }         -- copper ore x2
        { { 640, 2 }, 641 }    -- copper ore x2, tin ore x1

    params (table) can contain the following parameters:

    silent (boolean, default false)
        if set, displays no messages
    fromTrade (boolean, default false)
        if set, when player has no room for items, display
        "Try trading again after sorting your inventory"
        instead of
        "Come back again after sorting your inventory"
--]]
---@param player CBaseEntity
---@param items xi.item|itemQuantityEntry|multipleItemList
---@param params { silent: boolean? }?
---@return boolean
function npcUtil.giveTempItem(player, items, params)
    params = params or {}
    local ID = zones[player:getZoneID()]

    -- create table of items, with key/val of itemId/itemQty
    local givenItems = {}
    if type(items) == 'number' then
        table.insert(givenItems, { items, 1 })
    elseif type(items) == 'table' then
        for _, v in pairs(items) do
            if type(v) == 'number' then
                table.insert(givenItems, { v, 1 })
            elseif
                type(v) == 'table' and
                #v == 2 and
                type(v[1]) == 'number' and
                type(v[2]) == 'number'
            then
                table.insert(givenItems, { v[1], v[2] })
            else
                print(string.format('ERROR: invalid items parameter given to npcUtil.giveTempItem in zone %s.', player:getZoneName()))
                return false
            end
        end
    end

    -- give items to player
    local messagedItems = {}
    for _, v in pairs(givenItems) do
        if player:addTempItem(v[1], v[2]) then
            if not params.silent and not messagedItems[v[1]] then
                if v[2] > 1 then
                    player:messageSpecial(ID.text.ITEM_OBTAINED + 9, v[1], v[2])
                else
                    player:messageSpecial(ID.text.ITEM_OBTAINED, v[1])
                end
            end

            messagedItems[v[1]] = true
        elseif #givenItems == 1 then
            if not params.silent then
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, givenItems[1][1])
            end

            return false
        end
    end

    return true
end

--[[
    Give currency to a player.
    Message is displayed showing currency obtained.

    Examples of valid parameters:
        gil, 500
        bayld, 1000
--]]
---@param player CBaseEntity
---@param currency string
---@param amount integer
---@return boolean
function npcUtil.giveCurrency(player, currency, amount)
    local ID = zones[player:getZoneID()]

    if type(currency) ~= 'string' or type(amount) ~= 'number' then
        print(string.format('ERROR: invalid parameter given to npcUtil.giveCurrency in zone %s.', player:getZoneName()))
        return false
    end

    currency = string.lower(currency)

    local currencyTypes =
    {
        ['gil']   = { 'GIL_OBTAINED', xi.settings.main.GIL_RATE },
        ['bayld'] = { 'BAYLD_OBTAINED', xi.settings.main.BAYLD_RATE }
    }

    local currencyType = currencyTypes[currency]

    if not currencyType then
        print(string.format('ERROR: invalid currency \'%s\' given to npcUtil.giveCurrency in zone %s.', currency, player:getZoneName()))
        return false
    end

    local messageId = ID.text[currencyType[1]]
    if not messageId then
        print(string.format('ERROR: no message ID defined for currency \'%s\' given to npcUtil.giveCurrency in zone %s.', currency, player:getZoneName()))
        return false
    end

    amount = amount * currencyType[2]

    if currency == 'gil' then
        player:addGil(amount)
    else
        player:addCurrency(currency, amount)
    end

    player:messageSpecial(messageId, amount)

    return true
end

--[[
    Give key item(s) to player.
    Message is displayed showing key items obtained.

    Examples of valid keyitems parameter:
        xi.ki.ZERUHN_REPORT
        { xi.ki.PALBOROUGH_MINES_LOGS }
        { xi.ki.BLUE_ACIDITY_TESTER, xi.ki.RED_ACIDITY_TESTER }
--]]
---@param player CBaseEntity
---@param keyitems xi.keyItem|{ [integer]: xi.keyItem }
---@param msgId integer?
function npcUtil.giveKeyItem(player, keyitems, msgId)
    local ID            = zones[player:getZoneID()]
    local givenKeyItems = type(keyitems) == 'table' and keyitems or { keyitems }

    -- give key items to player, with message

    for _, keyItemId in ipairs(givenKeyItems) do
        ---@cast keyItemId xi.keyItem
        if not player:hasKeyItem(keyItemId) then
            player:addKeyItem(keyItemId)

            if msgId then
                player:messageSpecial(msgId, keyItemId)
            else
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, keyItemId)
            end
        end
    end

    return true
end

--[[
    Give a reward (Hidden Quests)
    If hidden quest rewards items, and the player cannot carry them, return false.
    Otherwise, return true.

    Example of usage with params (all params are optional):
        npcUtil.giveReward(player, {
            item = { { 640, 2 }, 641 },   -- see npcUtil.giveItem for formats
            itemParams = {              -- see npcUtil.giveItem for formats
                fromTrade = true,
            },
            keyItem = xi.ki.ZERUHN_REPORT,           -- see npcUtil.giveKeyItem for formats
            fameArea = xi.fameArea.NORG, -- Required for Fame to be applied
            fame = 120,                         -- fame defaults to 30 if not set
            bayld = 500,
            gil = 200,
            exp = 1000,
            title = xi.title.ENTRANCE_DENIED,
            var = { 'foo1', 'foo2' }      -- variable(s) to set to 0. string or table
        })
--]]

---@class rewardParam
---@field item xi.item|itemQuantityEntry|multipleItemList?
---@field itemParams { silent: boolean?, fromTrade: boolean?, multiple: boolean? }?
---@field keyItem xi.keyItem|{ [integer]: xi.keyItem }?
---@field ki xi.keyItem|{ [integer]: xi.keyItem }?
---@field fame integer?
---@field fameArea xi.fameArea?
---@field bayld integer?
---@field gil integer?
---@field title xi.title?
---@field var string|string[]?
---@field exp integer?

---@param player CBaseEntity
---@param params rewardParam
---@return boolean
function npcUtil.giveReward(player, params)
    params = params or {}

    -- load text ids
    local ID = zones[player:getZoneID()]

    -- item(s) plus message. return false if player lacks inventory space.
    if params['item'] ~= nil then
        if not npcUtil.giveItem(player, params['item'], params['itemParams']) then
            return false
        end
    end

    -- key item(s), fame, gil, bayld, xp, and title
    if params['keyItem'] ~= nil then
        npcUtil.giveKeyItem(player, params['keyItem'])
    end

    if params['fame'] == nil then
        params['fame'] = 30
    end

    if
        params['fameArea'] ~= nil and
        params['fameArea']['fame_area'] ~= nil and
        type(params['fame']) == 'number'
    then
        player:addFame(params['fameArea'], params['fame'])
    end

    if params['gil'] ~= nil and type(params['gil']) == 'number' then
        player:addGil(params['gil'] * xi.settings.main.GIL_RATE)
        player:messageSpecial(ID.text.GIL_OBTAINED, params['gil'] * xi.settings.main.GIL_RATE)
    end

    if params['bayld'] ~= nil and type(params['bayld']) == 'number' then
        player:addCurrency('bayld', params['bayld'] * xi.settings.main.BAYLD_RATE)
        player:messageSpecial(ID.text.BAYLD_OBTAINED, params['bayld'] * xi.settings.main.BAYLD_RATE)
    end

    if params['exp'] ~= nil and type(params['exp']) == 'number' then
        player:addExp(params['exp'] * xi.settings.main.EXP_RATE)
    end

    if params['title'] ~= nil then
        player:addTitle(params['title'])
    end

    if params['var'] ~= nil then
        local playerVarsToZero = {}
        if type(params['var']) == 'table' then
            ---@cast params['var'] string[]
            playerVarsToZero = params['var']
        elseif type(params['var']) == 'string' then
            table.insert(playerVarsToZero, params['var'])
        end

        for _, v in pairs(playerVarsToZero) do
            player:setCharVar(v, 0)
        end
    end

    return true
end

--[[
    Complete a quest.
    If quest rewards items, and the player cannot carry them, return false.
    Otherwise, return true.

    Example of usage with params (all params are optional):
        npcUtil.completeQuest(player, xi.questLog.SANDORIA, xi.quest.id.sandoria.ROSEL_THE_ARMORER, {
            item = { { 640, 2 }, 641 },   -- see npcUtil.giveItem for formats
            itemParams = {              -- see npcUtil.giveItem for formats
                fromTrade = true,
            },
            keyItem = xi.ki.ZERUHN_REPORT,           -- see npcUtil.giveKeyItem for formats
            fameArea = xi.fameArea.NORG, -- Required for Fame to be applied
            fame = 120,                         -- fame defaults to 30 if not set
            bayld = 500,
            gil = 200,
            exp = 1000,
            title = xi.title.ENTRANCE_DENIED,
            var = { 'foo1', 'foo2' }      -- variable(s) to set to 0. string or table
        })
--]]

---@param player CBaseEntity
---@param area xi.questLog
---@param quest integer
---@param params rewardParam
---@return boolean
function npcUtil.completeQuest(player, area, quest, params)
    params = params or {}

    -- load text ids
    local ID = zones[player:getZoneID()]

    -- item(s) plus message. return false if player lacks inventory space.
    if params['item'] ~= nil then
        if not npcUtil.giveItem(player, params['item'], params['itemParams']) then
            return false
        end
    end

    -- key item(s), fame, gil, bayld, xp, and title
    if params['keyItem'] ~= nil then
        npcUtil.giveKeyItem(player, params['keyItem'])
    end

    -- Note: fameArea is a required numeric parameter in order for fame to be applied.  Fame areas
    -- are not a one to one mapping of log ids, and it should not be used as a fallback.
    if params['fameArea'] ~= nil and type(params['fameArea']) == 'number' then
        if params['fame'] == nil then
            params['fame'] = 30
        end

        player:addFame(params['fameArea'], params['fame'])
    end

    if params['gil'] ~= nil and type(params['gil']) == 'number' then
        player:addGil(params['gil'] * xi.settings.main.GIL_RATE)
        player:messageSpecial(ID.text.GIL_OBTAINED, params['gil'] * xi.settings.main.GIL_RATE)
    end

    if params['bayld'] ~= nil and type(params['bayld']) == 'number' then
        player:addCurrency('bayld', params['bayld'] * xi.settings.main.BAYLD_RATE)
        player:messageSpecial(ID.text.BAYLD_OBTAINED, params['bayld'] * xi.settings.main.BAYLD_RATE)
    end

    if params['exp'] ~= nil and type(params['exp']) == 'number' then
        player:addExp(params['exp'] * xi.settings.main.EXP_RATE)
    end

    if params['title'] ~= nil then
        player:addTitle(params['title'])
    end

    if params['var'] ~= nil then
        local playerVarsToZero = {}
        if type(params['var']) == 'table' then
            ---@cast params['var'] string[]
            playerVarsToZero = params['var']
        elseif type(params['var']) == 'string' then
            table.insert(playerVarsToZero, params['var'])
        end

        for _, v in ipairs(playerVarsToZero) do
            player:setCharVar(v, 0)
        end
    end

    local logId
    if type(area) == 'number' then
        logId = area
    elseif area['quest_log'] then
        logId = area['quest_log']
    end

    -- successfully complete the quest
    if logId then
        player:completeQuest(logId, quest)
    else
        print('ERROR: invalid logId encountered in npcUtil.completeQuest')
    end

    return true
end

--[[
    Complete a Mission.
    If quest rewards items, and the player cannot carry them, return false.
    Otherwise, return true.

    Example of usage with params (all params are optional):
        npcUtil.completeMission(player, xi.questLog.SANDORIA, xi.quest.id.sandoria.ROSEL_THE_ARMORER, {
            item = { { 640, 2 }, 641 },   -- see npcUtil.giveItem for formats
            itemParams = {              -- see npcUtil.giveItem for formats
                fromTrade = true,
            },
            keyItem = xi.ki.ZERUHN_REPORT,   -- see npcUtil.giveKeyItem for formats
            bayld = 500,
            gil   = 200,
            exp   = 1000,
            title = xi.title.ENTRANCE_DENIED,
        })
--]]
function npcUtil.completeMission(player, logId, missionId, params)
    params = params or {}

    -- load text ids
    local ID = zones[player:getZoneID()]

    -- item(s) plus message. return false if player lacks inventory space.
    if params['item'] ~= nil then
        if not npcUtil.giveItem(player, params['item'], params['itemParams']) then
            return false
        end
    end

    -- key item(s), fame, gil, bayld, xp, and title
    if params['keyItem'] ~= nil then
        npcUtil.giveKeyItem(player, params['keyItem'])
    end

    if params['gil'] ~= nil and type(params['gil']) == 'number' then
        player:addGil(params['gil'] * xi.settings.main.GIL_RATE)
        player:messageSpecial(ID.text.GIL_OBTAINED, params['gil'] * xi.settings.main.GIL_RATE)
    end

    if params['bayld'] ~= nil and type(params['bayld']) == 'number' then
        player:addCurrency('bayld', params['bayld'] * xi.settings.main.BAYLD_RATE)
        player:messageSpecial(ID.text.BAYLD_OBTAINED, params['bayld'] * xi.settings.main.BAYLD_RATE)
    end

    if params['exp'] ~= nil and type(params['exp']) == 'number' then
        player:addExp(params['exp'] * xi.settings.main.EXP_RATE)
    end

    if params['title'] ~= nil then
        player:addTitle(params['title'])
    end

    -- successfully complete the mission
    if logId then
        player:completeMission(logId, missionId)
    else
        print('ERROR: Invalid logId encountered in npcUtil.completeMission')
    end

    -- Set Rank points before potentially increasing rank; Allows for repeatable missions
    -- that provide rank up on the first completion to not interfere.
    if params['rankPoints'] ~= nil and type(params['rankPoints']) == 'number' then
        -- TODO: Verify 4000 cap, this was taken from missions.lua
        player:setRankPoints(math.min(player:getRankPoints() + params['rankPoints'], 4000))
    end

    -- Add some safety for rank, and only set rank if it increases
    if
        params['rank'] ~= nil and
        type(params['rank']) == 'number' and
        player:getRank(player:getNation()) < params['rank']
    then
        player:setRank(params['rank'])
        player:setRankPoints(0)
    end

    -- TODO: Do we need to support multiple missions being set?
    if
        params['nextMission'] ~= nil and
        type(params['nextMission'][1]) == 'number' and
        type(params['nextMission'][2]) == 'number'
    then
        player:addMission(params['nextMission'][1], params['nextMission'][2])
    end

    return true
end

--[[
    check whether trade has all required items
        if yes, confirm all the items and return true
        if no, return false

    valid examples of items:
        640                     -- copper ore x1
        { 640, 641 }            -- copper ore x1, tin ore x1
        { 640, 640 }            -- copper ore x2
        { { 640, 2 } }          -- copper ore x2
        { { 640, 2 }, 641 }     -- copper ore x2, tin ore x1
        { 640, { 'gil', 200 } } -- copper ore x1, gil x200
--]]
function npcUtil.tradeHas(trade, items, exact)
    if type(exact) ~= 'boolean' then
        exact = false
    end

    -- create table of traded items, with key/val of itemId/itemQty
    local tradedItems = {}
    local itemId
    local itemQty
    for i = 0, trade:getSlotCount()-1 do
        itemId = trade:getItemId(i)
        itemQty = trade:getItemQty(itemId)
        tradedItems[itemId] = itemQty
    end

    -- create table of needed items, with key/val of itemId/itemQty
    local neededItems = {}
    if type(items) == 'number' then
        neededItems[items] = 1
    elseif type(items) == 'table' then
        local itemIdNeeded
        local itemQtyNeeded
        for _, v in pairs(items) do
            if type(v) == 'number' then
                itemIdNeeded = v
                itemQtyNeeded = 1
            elseif
                type(v) == 'table' and
                #v == 2 and
                type(v[1]) == 'number' and
                type(v[2]) == 'number'
            then
                itemIdNeeded = v[1]
                itemQtyNeeded = v[2]
            elseif
                type(v) == 'table' and
                #v == 2 and
                type(v[1]) == 'string' and
                type(v[2]) == 'number' and
                string.lower(v[1]) == 'gil'
            then
                itemIdNeeded = 65535
                itemQtyNeeded = v[2]
            else
                print('ERROR: invalid value contained within items parameter given to npcUtil.tradeHas.')
                itemIdNeeded = nil
            end

            if itemIdNeeded ~= nil then
                neededItems[itemIdNeeded] = (neededItems[itemIdNeeded] == nil) and itemQtyNeeded or neededItems[itemIdNeeded] + itemQtyNeeded
            end
        end
    else
        print('ERROR: invalid items parameter given to npcUtil.tradeHas.')
        return false
    end

    -- determine whether all needed items have been traded. return false if not.
    for k, v in pairs(neededItems) do
        local tradedQty = (tradedItems[k] == nil) and 0 or tradedItems[k]
        if v > tradedQty then
            return false
        else
            tradedItems[k] = tradedQty - v
        end
    end

    -- if an exact trade was requested, check if any excess items were traded. if so, return false.
    if exact then
        for k, v in pairs(tradedItems) do
            if v > 0 then
                return false
            end
        end
    end

    -- confirm items
    for k, v in pairs(neededItems) do
        trade:confirmItem(k, v)
    end

    return true
end

--[[
    check whether trade has exactly required items
        if yes, confirm all the items and return true
        if no, return false

    valid examples of items:
        640                     -- copper ore x1
        { 640, 641 }            -- copper ore x1, tin ore x1
        { 640, 640 }            -- copper ore x2
        { { 640, 2 } }          -- copper ore x2
        { { 640, 2 }, 641 }     -- copper ore x2, tin ore x1
        { 640, { 'gil', 200 } } -- copper ore x1, gil x200
--]]
function npcUtil.tradeHasExactly(trade, items)
    return npcUtil.tradeHas(trade, items, true)
end

-- Checks to see if a trade only contains one item, but the total count can be variable
function npcUtil.tradeHasOnly(trade, itemID)
    return npcUtil.tradeHasExactly(trade, { { itemID, trade:getItemCount() } })
end

-- Checks to see if a single item in a list is contained in the trade
function npcUtil.tradeSetInList(trade, itemList)
    for k, v in ipairs(itemList) do
        if npcUtil.tradeHasExactly(trade, itemList[k]) then
            return true
        end
    end

    return false
end

-----------------------------------
-- UpdateNPCSpawnPoint
-----------------------------------

function npcUtil.UpdateNPCSpawnPoint(id, minTime, maxTime, posTable, serverVar)
    local npc = GetNPCByID(id)
    if not npc then
        return
    end

    local respawnTime = math.random(minTime, maxTime)
    local newPosition = npcUtil.pickNewPosition(npc:getID(), posTable, true)
    serverVar = serverVar or nil -- serverVar is optional

    if serverVar then
        if GetServerVariable(serverVar) <= os.time() then
            npc:hideNPC(1) -- hide so the NPC is not 'moving' through the zone
            npc:setPos(newPosition.x, newPosition.y, newPosition.z)
        end
    end

    npc:timer(respawnTime * 1000, function(npcArg)
        npcUtil.UpdateNPCSpawnPoint(id, minTime, maxTime, posTable, serverVar)
    end)
end

function npcUtil.fishingAnimation(npc, phaseDuration, func)
    func = func or function(npcArg)
        -- return true to not loop again
        return false
    end

    if func(npc) then
        return
    end

    npc:timer(phaseDuration * 1000, function(npcArg)
        local anims =
        {
            [xi.anim.FISHING_NPC] = { duration = 5, nextAnim = { xi.anim.FISHING_START } },
            [xi.anim.FISHING_START] = { duration = 10, nextAnim = { xi.anim.FISHING_FISH } },
            [xi.anim.FISHING_FISH] =
            {
                duration = 10,
                nextAnim =
                {
                    xi.anim.FISHING_CAUGHT,
                    xi.anim.FISHING_ROD_BREAK,
                    xi.anim.FISHING_LINE_BREAK,
                }
            },

            [xi.anim.FISHING_ROD_BREAK] = { duration = 3, nextAnim = { xi.anim.FISHING_NPC } },
            [xi.anim.FISHING_LINE_BREAK] = { duration = 3, nextAnim = { xi.anim.FISHING_NPC } },
            [xi.anim.FISHING_CAUGHT] = { duration = 5, nextAnim = { xi.anim.FISHING_NPC } },
            [xi.anim.FISHING_STOP] = { duration = 3, nextAnim = { xi.anim.FISHING_NPC } },
        }

        local anim = anims[npcArg:getAnimation()]
        local nextAnimationId = xi.anim.FISHING_NPC
        local nextAnimationDuration = 10
        local nextAnim = nil
        if anim then
            nextAnim = anim.nextAnim[math.random(1, #anim.nextAnim)]
        end

        if nextAnim then
            nextAnimationId = nextAnim
            if anims[nextAnimationId] then
                nextAnimationDuration = anims[nextAnimationId].duration
            end
        end

        npcArg:setAnimation(nextAnimationId)
        npcUtil.fishingAnimation(npcArg, nextAnimationDuration, func)
    end)
end

function npcUtil.castingAnimation(npc, magicType, phaseDuration, func)
    func = func or function(npcArg)
        -- return true to not loop again
        return false
    end

    if func(npc) then
        return
    end

    npc:timer(phaseDuration * 1000, function(npcArg)
        local anims =
        {
            [xi.magic.spellGroup.BLACK] = { start = 'cabk', duration = 2000, stop = 'shbk' },
            [xi.magic.spellGroup.WHITE] = { start = 'cawh', duration = 1800, stop = 'shwh' },
        }
        npcArg:entityAnimationPacket(anims[magicType].start)
        npcArg:timer(anims[magicType].duration, function(npcTimerArg)
            npcTimerArg:entityAnimationPacket(anims[magicType].stop)
        end)

        npcUtil.castingAnimation(npcArg, magicType, phaseDuration, func)
    end)
end

function npcUtil.showCrate(crate)
    crate:setStatus(xi.status.NORMAL)
    crate:setUntargetable(false)
    crate:resetLocalVars()
end

function npcUtil.disappearCrate(crate)
    if crate:isNPC() then
        crate:entityAnimationPacket(xi.animationString.STATUS_DISAPPEAR)
        crate:timer(3000, function(npc)
            npc:setUntargetable(true)
            npc:setStatus(xi.status.DISAPPEAR)
        end)
    else
        -- Some crates, such as Recover Crates in Limbus, are actually mobs that look like NPCs
        DespawnMob(crate:getID())
    end
end

-- Opens a crate and sets an 'opened' var so it cannot be opened again.
--  - crate: The npc crate to open
--  - callback: The callback function to call if crate is successfully opened. Return true to leave crate open.
function npcUtil.openCrate(crate, callback)
    if crate:getLocalVar('opened') == 0 then
        crate:setLocalVar('opened', 1)
        local shouldDisappear = not callback()
        crate:entityAnimationPacket(xi.animationString.OPEN_CRATE_GLOW)

        if shouldDisappear then
            crate:timer(7000, function(npc)
                npcUtil.disappearCrate(npc)
            end)
        end
    end
end
