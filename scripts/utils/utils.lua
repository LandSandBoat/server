require('scripts/globals/interaction/quest')

---@class utils
utils = utils or {}

-- Event cancelled constant, replaces the hardcoded value of 1073741824 in many
-- scripts.
utils.EVENT_CANCELLED_OPTION = bit.lshift(1, 30)

-- Max uint32 constant, replaces negative values in event parameters
-- Note: If correcting a negative value, this is *already* -1, adjust accordingly!
utils.MAX_UINT32 = 4294967295
utils.MAX_INT32  = 2147483647

-- Used to keep the linter quiet
---@param ... any
---@return nil
function utils.unused(...)
end

-- bind and related functions are from https://stackoverflow.com/a/18229720
local unpack = unpack or table.unpack

local function packn(...)
    return { n = select('#', ...), ... }
end

local function unpackn(t)
    return unpack(t, 1, t.n)
end

local function mergen(...)
    local res = { n = 0 }
    for i = 1, select('#', ...) do
        local t = select(i, ...)
        for j = 1, t.n do
            res.n = res.n + 1
            res[res.n] = t[j]
        end
    end

    return res
end

-- https://stackoverflow.com/questions/49979017/how-to-get-current-function-call-stack-depth-in-lua
-- NOTE: Supposedly this is slow. Only use this during debugging and not for live!
function utils.getStackDepth()
    local depth = 0
    while true do
        if not debug.getinfo(3 + depth) then
            break
        end

        depth = depth + 1
    end

    return depth
end

-- https://www.lua.org/pil/23.1.1.html
function utils.getObjectFromScope(objName, depth)
    local idx = 1
    while true do
        local name, value = debug.getlocal(depth, idx)
        if not name then
            break
        end

        if name == objName then
            return value
        end

        idx = idx + 1
    end

    return nil
end

function utils.getDebugPrinter(printEntityName, settingOrCondition, prefix)
    return function(...)
        if settingOrCondition then
            local t = { ... }
            if prefix then
                t = { prefix, ... }
            end

            local str = tostring(unpack(t))

            print(str)

            local depth  = utils.getStackDepth()
            local player = utils.getObjectFromScope(printEntityName, depth + 1)
            if player then
                player:printToPlayer(str, xi.msg.channel.SYSTEM_3, '')
            end
        end
    end
end

function utils.getDebugPlayerPrinter(settingOrCondition, prefix)
    return utils.getDebugPrinter('player', settingOrCondition, prefix)
end

---@param func function
---@param ... any
---@return function
function utils.bind(func, ...)
    local args = packn(...)
    return function(...)
        return func(unpackn(mergen(args, packn(...))))
    end
end

-- Appends two array-style tables into a new one
-- Creates and returns a new iterable table containing all elements from both input arrays `a` and `b`,
---@nodiscard
---@param a table
---@param b table
---@return table
function utils.appendArrays(a, b)
    local result = {}
    for i = 1, #a do
        result[#result + 1] = a[i]
    end

    for i = 1, #b do
        result[#result + 1] = b[i]
    end

    return result
end

-- Creates a slice of an input table and returns a new table
---@nodiscard
---@param inputTable table
---@param first integer?
---@param last integer?
---@param step integer?
---@return table
function utils.slice(inputTable, first, last, step)
    local slicedTable = {}
    first = first or 1
    last = last or #inputTable
    step = step or 1
    local position = 1

    for i = first, last, step do
        slicedTable[position] = inputTable[i]
        position = position + 1
    end

    return slicedTable
end

-- Shuffles a table and returns a new table containing the randomized result.
---@nodiscard
---@param inputTable table
---@return table
function utils.shuffle(inputTable)
    local shuffledTable = {}

    for _, v in ipairs(inputTable) do
        local pos = math.random(1, #shuffledTable + 1)
        table.insert(shuffledTable, pos, v)
    end

    return shuffledTable
end

utils.append = nil

-- Recursively appends the input table into the provided base table.
-- Non-table keys are overwritten by input.
---@param base table
---@param input table
---@return table
function utils.append(base, input)
    for k, v in pairs(input) do
        local baseValue = base[k]
        if baseValue ~= nil and type(baseValue) == 'table' and type(v) == 'table' then
            utils.append(baseValue, v)
        else
            base[k] = v
        end
    end

    return base
end

-- Returns a new table with the two input tables joined together.
-- Values from second input have higher priority.
---@nodiscard
---@param input1 table
---@param input2 table
---@return table
function utils.join(input1, input2)
    local result = {}
    utils.append(result, input1)
    utils.append(result, input2)
    return result
end

-- Generates a random permutation of integers >= min_val and <= max_val
-- If a min_val isn't given, 1 is used (assumes permutation of lua indices)
---@nodiscard
---@param max_val integer
---@param min_val integer?
---@return table
function utils.permgen(max_val, min_val)
    local indices = {}
    min_val = min_val or 1

    if min_val >= max_val then
        for iter = min_val, max_val, -1 do
            indices[iter] = iter
        end
    else
        for iter = min_val, max_val, 1 do
            indices[iter] = iter
        end
    end

    return utils.shuffle(indices)
end

-- Generates a table of unique values given a range and number of entries. This should
-- only be used when you need unique random values smaller than the input range.  Use
-- utils.shuffle() or utils.permgen() directly if length of array is equal to the input
-- list.
-- Examples:
-- Input: (1, 3, 2)  Sample Output: { 3, 1 }    (randomized)
-- Input: (1, 10, 3) Sample Output: { 4, 9, 2 } (randomized)
---@nodiscard
---@param minVal integer
---@param maxVal integer
---@param numEntries integer
---@return table
function utils.uniqueRandomTable(minVal, maxVal, numEntries)
    local resultTable = {}
    local shuffledTable = utils.permgen(maxVal, minVal)

    if numEntries > #shuffledTable then
        print('utils.uniqueRandomTable(): numEntries exceeds length of shuffledTable!')
        return resultTable
    end

    for i = 1, numEntries do
        resultTable[i] = shuffledTable[i]
    end

    return resultTable
end

---@nodiscard
---@param input number
---@param min_val number?
---@param max_val number?
---@return number
function utils.clamp(input, min_val, max_val)
    if min_val ~= nil and input < min_val then
        input = min_val
    elseif max_val ~= nil and input > max_val then
        input = max_val
    end

    return input
end

--  Returns a table containing all the elements in the specified range.
--  Source: https://github.com/mebens/range
---@nodiscard
---@param from number
---@param to number
---@param step integer?
---@return table
---@overload fun(from: string, to: string, step: integer?): table
---@overload fun(from: table, to: table, step: integer?): table
function utils.range(from, to, step)
    local t = {}
    local argType = type(from)
    step = step or 1

    if argType == 'number' then
        for i = from, to, step do t[#t + 1] = i end
    elseif argType == 'string' then
        local e = string.byte(to)
        for i = string.byte(from), e, step do t[#t + 1] = string.char(i) end
    elseif argType == 'table' then
        local metaNext = getmetatable(from).__next

        if metaNext then
            local i = from

            while i < to do
                t[#t + 1] = i
                i = metaNext(i, step)
            end

            t[#t + 1] = to
        end
    end

    return t
end

-----------------------------------
--
-- Functional
--
-- Functional methods provide a means to simplify logic that consists in
-- simple operations when iterating a table.
-- In general, they can make code much more concise and readable, but they
-- can also end up making it a cluttered mess, so use your judgement
-- when deciding if you want to use these methods
-----------------------------------

-- Given a table and a mapping function, returns a new table created by
-- applying the given mapping function to the given table elements
---@nodiscard
---@param tbl table
---@param func function
---@return table
function utils.map(tbl, func)
    local t = {}

    for k, v in pairs(tbl) do
        t[k] = func(k, v)
    end

    return t
end

-- Iterates through the table and calls the callback on each key, value pair.
---@param tbl table
---@param func function
function utils.each(tbl, func)
    for k, v in pairs(tbl) do
        func(k, v)
    end
end

-- Given a table and a filter function, returns a new table composed of the
-- elements that pass the given filter.
-- e.g: utils.filter({ 'a', 'b', 'c', 'd' }, function(k, v) return v >= 'c' end)  --> { 'c', 'd }
---@nodiscard
---@param tbl table
---@param func function
---@return table
function utils.filter(tbl, func)
    local out = {}

    for k, v in pairs(tbl) do
        if func(k, v) then
            out[k] = v
        end
    end

    return out
end

-- Given a table and a filter function, returns a new table composed of the
-- elements that pass the given filter.
-- Unlike utils.filter, this method will return an iterable table.
-- e.g utils.filterArray({ 'a', 'b', 'c', 'd' }, function(k, v) return v >= 'c' end)  --> { 1 => 'c', 2 => 'd' }
---@nodiscard
---@param tbl table
---@param func function
---@return table
function utils.filterArray(tbl, func)
    local out = {}

    for k, v in pairs(tbl) do
        if func(k, v) then
            table.insert(out, v)
        end
    end

    return out
end

-- Returns true if any member of the given table passes the given
-- predicate function
---@nodiscard
---@param tbl table
---@param predicate function
---@return boolean
function utils.any(tbl, predicate)
    for k, v in pairs(tbl) do
        if predicate(k, v) then
            return true
        end
    end

    return false
end

-- Returns true if all members of the given table pass the given
-- predicate function
---@nodiscard
---@param tbl table
---@param predicate function
---@return boolean
function utils.all(tbl, predicate)
    for k, v in pairs(tbl) do
        if not predicate(k, v) then
            return false
        end
    end

    return true
end

-- Returns the sum of applying the given function to each element of the given table
-- e.g: utils.sum({ 1, 2, 3 }, function(k, v) return v end)  --> 6
---@nodiscard
---@param tbl table
---@param func function
---@return number
function utils.sum(tbl, func)
    local sum = 0

    for k, v in pairs(tbl) do
        sum = sum + func(k, v)
    end

    return sum
end

-- To be used with utils.sum.
-- Used to count the number of times an element in a table
-- matches the given predicate
-- e.g: utils.sum({ 'a, 'a', 'b' }, utils.counter(function (k, v) return v == 'a' end)) --> 2
function utils.counter(predicate)
    return function(k, v)
        if predicate(k, v) then
            return 1
        else
            return 0
        end
    end
end

---@nodiscard
---@param attacker CBaseEntity
---@param target CBaseEntity
---@param skill any TODO: This is currently unused
---@param maxDamage any
---@param minimumPercentage any
---@return integer
function utils.conalDamageAdjustment(attacker, target, skill, maxDamage, minimumPercentage)
    -- #TODO: Currently all cone attacks use static 45 degree (360 scale) angles in core, when cone attacks
    -- have different angles and there's a method to fetch the angle, use a line like the below
    -- local coneAngle = skill:getConalAngle()
    local coneAngle = 32 -- 256-degree based, equivalent to '45 degrees' on 360 degree scale

    -- #TODO: Conal attacks hit targets in a cone with a center line of the 'primary' target (the mob's
    -- highest enmity target). These primary targets can be within 128 degrees of the mob's front. However,
    -- there's currently no way for a conal skill to store (and later check) the primary target a mob skill
    -- was trying to hit. Therefore the 'damage drop off' here is based from an origin of the mob's rotation
    -- instead. Should conal skills become capable of identifying their primary target, this should be changed
    -- to be based on the degree difference from the primary target instead.
    local conalAnglePower = coneAngle - math.abs(attacker:getFacingAngle(target))

    if conalAnglePower < 0 then
        -- #TODO The below print will be a valid print upon fixing to-do above relating to beam center orgin
        conalAnglePower = 0
    end

    -- Calculate the amount of damage to add above the minimum percentage based on how close
    -- the target is to the center of the conal (0 degrees from the attacker's facing)
    local minimumDamage    = maxDamage * minimumPercentage
    local damagePerAngle   = (maxDamage - minimumDamage) / coneAngle
    local additionalDamage = damagePerAngle * conalAnglePower

    local finalDamage = math.max(1, math.ceil(minimumDamage + additionalDamage))

    return finalDamage
end

---@nodiscard
---@param actor CBaseEntity
---@param job xi.job
function utils.getActiveJobLevel(actor, job)
    local jobLevel = 0

    if actor:getMainJob() == job then
        jobLevel = actor:getMainLvl()
    elseif actor:getSubJob() == job then
        jobLevel = actor:getSubLvl()
    end

    return jobLevel
end

-- System Strength Bonus table.  This is used by xi.mobskills.mobBreathMove, but determines weakness of
-- a defending system, vs the attacking system.  This table is indexed by the attacker.
-- This table can scale beyond two values, but at this time, no data has been recorded.
-- Values: 1 == Bonus, -1 == Weakness, 0 == Default (No Weakness or Bonus)
local systemStrengthTable =
{
    [xi.eco.BEAST   ] = { [xi.eco.LIZARD  ] = 1, [xi.eco.PLANTOID] = -1, },
    [xi.eco.LIZARD  ] = { [xi.eco.VERMIN  ] = 1, [xi.eco.BEAST   ] = -1, },
    [xi.eco.VERMIN  ] = { [xi.eco.PLANTOID] = 1, [xi.eco.LIZARD  ] = -1, },
    [xi.eco.PLANTOID] = { [xi.eco.BEAST   ] = 1, [xi.eco.VERMIN  ] = -1, },
    [xi.eco.AQUAN   ] = { [xi.eco.AMORPH  ] = 1, [xi.eco.BIRD    ] = -1, },
    [xi.eco.AMORPH  ] = { [xi.eco.BIRD    ] = 1, [xi.eco.AQUAN   ] = -1, },
    [xi.eco.BIRD    ] = { [xi.eco.AQUAN   ] = 1, [xi.eco.AMORPH  ] = -1, },
    [xi.eco.UNDEAD  ] = { [xi.eco.ARCANA  ] = 1, },
    [xi.eco.ARCANA  ] = { [xi.eco.UNDEAD  ] = 1, },
    [xi.eco.DRAGON  ] = { [xi.eco.DEMON   ] = 1, },
    [xi.eco.DEMON   ] = { [xi.eco.DRAGON  ] = 1, },
    [xi.eco.LUMINIAN] = { [xi.eco.LUMINION] = 1, },
    [xi.eco.LUMINION] = { [xi.eco.LUMINIAN] = 1, },
}

---@nodiscard
---@param attackerSystem xi.eco
---@param defenderSystem xi.eco
---@return integer
function utils.getEcosystemStrengthBonus(attackerSystem, defenderSystem)
    for k, v in pairs(systemStrengthTable) do
        if k == attackerSystem then
            for defId, weakValue in pairs(systemStrengthTable[k]) do
                if defId == defenderSystem then
                    return weakValue
                end
            end
        end
    end

    return 0
end

-- utils.mask contains functions for bitmask variables
utils.mask =
{
    -- return mask's pos-th bit as bool
    ---@nodiscard
    ---@param mask integer
    ---@param pos integer
    ---@return boolean
    getBit = function(mask, pos)
        return bit.band(mask, bit.lshift(1, pos)) ~= 0
    end,

    -- return value of mask after setting its pos-th bit
    -- val can be bool or number.  if number, any non-zero value will be treated as true.
    ---@param mask integer
    ---@param pos integer
    ---@param val number|boolean
    ---@return integer
    setBit = function(mask, pos, val)
        local state = false

        if type(val) == 'boolean' then
            state = val
        elseif type(val) == 'number' then
            state = (val ~= 0)
        end

        if state then
            -- turn bit on
            return bit.bor(mask, bit.lshift(1, pos))
        else
            -- turn bit off
            return bit.band(mask, bit.bnot(bit.lshift(1, pos)))
        end
    end,

    -- return number of true bits in mask of length len
    -- if len is omitted, assume 32
    ---@nodiscard
    ---@param mask integer
    ---@param len integer?
    ---@return integer
    countBits = function(mask, len)
        if not len then
            len = 32
        end

        local count = 0

        for i = 0, len - 1 do
            count = count + bit.band(bit.rshift(mask, i), 1)
        end

        return count
    end,

    -- are all bits true in mask of length len?
    -- if len is omitted, assume 32
    ---@nodiscard
    ---@param mask integer
    ---@param len integer?
    ---@return boolean
    isFull = function(mask, len)
        if not len then
            len = 32
        end

        local fullMask = (2 ^ len) - 1

        return bit.band(mask, fullMask) == fullMask
    end,

    splitBits = function(bits, size)
        local result = {}
        local mask = bit.lshift(1, size) - 1

        while bits > 0 do
            result[#result + 1] = bit.band(bits, mask)
            bits = bit.rshift(bits, size)
        end

        return result
    end,

    varSplit = function(option, splitBit)
        splitBit = splitBit or 16
        local mask = bit.lshift(1, splitBit) - 1

        return bit.band(option, mask), bit.rshift(option, splitBit)
    end,
}

function utils.prequire(...)
    local ok, result = pcall(require, ...)
    if ok then
        return result
    else
        local vars = { ... }
        print(string.format('Error while trying to load \'%s\': %s', vars[1], result))
    end
end

-- Checks to see if a specific value is contained in a table.  This is often
-- used for tables that do not define specific indices.
-- See: Sigil NPCs
---@nodiscard
---@param value any
---@param collection table?
---@return boolean
function utils.contains(value, collection)
    if collection == nil then
        return false
    end

    for _, v in pairs(collection) do
        if value == v then
            return true
        end
    end

    return false
end

-- Checks to see if a specific key is contained in the table.  This is used by
-- tables that contain specific indices that may be non-sequential.
-- See: xi.teleport.escape
---@nodiscard
---@param keyVal string|integer
---@param collection table
---@return boolean
function utils.hasKey(keyVal, collection)
    for k, _ in pairs(collection) do
        if k == keyVal then
            return true
        end
    end

    return false
end

-- Selects a random entry from a table, returns the index and the entry
-- https://gist.github.com/jdev6/1e7ff30671edf88d03d4
---@nodiscard
---@param t table
---@return integer|string, any
function utils.randomEntryIdx(t)
    local keys = {}

    for key, _ in pairs(t) do
        keys[#keys + 1] = key
    end

    local index = keys[math.random(1, #keys)]
    return index, t[index]
end

---@nodiscard
---@param t table
---@return any
function utils.randomEntry(t)
    local _, item = utils.randomEntryIdx(t)
    return item
end

-- Helper functions for Interaction Framework Quests
-- These should only be used when working between quests, or outside
-- of the quest script itself.  Quest vars will be deleted automatically
-- when that quest:complete(player) is called!
---@deprecated Use xi.quest or xi.mission functions
---@nodiscard
---@param player CBaseEntity
---@param logId xi.questLog
---@param questId integer
---@param varName string
---@return integer
function utils.getQuestVar(player, logId, questId, varName)
    local charVarName = Quest.getVarPrefix(logId, questId) .. varName
    return player:getCharVar(charVarName)
end

---@deprecated Use xi.quest or xi.mission functions
---@param player CBaseEntity
---@param logId xi.questLog
---@param questId integer
---@param varName string
---@param value integer
---@return nil
function utils.setQuestVar(player, logId, questId, varName, value)
    local charVarName = Quest.getVarPrefix(logId, questId) .. varName
    player:setCharVar(charVarName, value)
end

-- utils.splitStr('a.b.c', '.') => { 'a', 'b', 'c' }
---@nodiscard
---@param s string
---@param sep string
---@return table
function utils.splitStr(s, sep)
    local fields = {}
    local pattern = string.format('([^%s]+)', sep)
    local _ = string.gsub(s, pattern, function(c)
        fields[#fields + 1] = c
    end)

    return fields
end

-- Remove whitespace from the beginning and end of a string
---@nodiscard
---@param s string
---@return string, integer
function utils.trimStr(s)
    local s1 = string.gsub(s, '^s%+', '')
    return string.gsub(s1, '%s+$', '')
end

-- Split a single string argument into multiple arguments
---@nodiscard
---@param s string
---@return table
function utils.splitArg(s)
    local comma   = string.gsub(s, ',', ' ')
    local spaces  = string.gsub(comma, '%s+', ' ')
    local trimmed = utils.trimStr(spaces)

    return utils.splitStr(trimmed, ' ')
end

---@param mob CBaseEntity
---@param hideDuration integer
---@param pos table?
---@param disAnim xi.animationString?
---@param reapAnim xi.animationString?
---@return nil
function utils.mobTeleport(mob, hideDuration, pos, disAnim, reapAnim)
    if hideDuration == nil then
        hideDuration = 5000
    end

    if disAnim == nil then
        disAnim = xi.animationString.STATUS_DISAPPEAR
    end

    if reapAnim == nil then
        reapAnim = xi.animationString.STATUS_VISIBLE
    end

    if pos == nil then
        pos = mob:getPos()
    end

    local mobSpeed = mob:getSpeed()

    if hideDuration < 1000 then
        hideDuration = 1000
    end

    if mob:isDead() then
        return
    end

    -- TODO: Temporary workaround
    ---@diagnostic disable: param-type-mismatch

    mob:entityAnimationPacket(disAnim)
    mob:hideName(true)
    mob:setUntargetable(true)
    mob:setAutoAttackEnabled(false)
    mob:setMagicCastingEnabled(false)
    mob:setMobAbilityEnabled(false)
    mob:setPos(pos, 0)
    mob:setBaseSpeed(0)

    -- TODO: Temporary workaround
    ---@diagnostic enable: param-type-mismatch

    mob:timer(hideDuration, function(mobArg)
        mobArg:setPos(pos, 0)
        mobArg:hideName(false)
        mobArg:setUntargetable(false)
        mobArg:setAutoAttackEnabled(true)
        mobArg:setMagicCastingEnabled(true)
        mobArg:setMobAbilityEnabled(true)
        mobArg:setBaseSpeed(mobSpeed)
        mobArg:entityAnimationPacket(reapAnim)

        if mobArg:isDead() then
            return
        end
    end)
end

-----------------------------------
-- Spatial position utilities
-----------------------------------
---@type number
local ffxiRotConversionFactor = 360.0 / 255.0

---@nodiscard
---@param ffxiRot number
---@return number
function utils.ffxiRotToDegrees(ffxiRot)
    return ffxiRotConversionFactor * ffxiRot
end

---@nodiscard
---@param origin table
---@param translation table
---@return table
function utils.lateralTranslateWithOriginRotation(origin, translation)
    local degrees = utils.ffxiRotToDegrees(origin.rot)
    local rads = math.rad(degrees)
    local newCoords = {}

    newCoords.x = origin.x + ((math.cos(rads) * translation.x) + (math.sin(rads) * translation.z))
    newCoords.z = origin.z + ((math.cos(rads) * translation.z) - (math.sin(rads) * translation.x))
    newCoords.y = origin.y
    newCoords.rot = origin.rot

    return newCoords
end

---@nodiscard
---@param origin table
---@param offset number
---@param radians number
---@return table
function utils.getNearPosition(origin, offset, radians)
    local destination =
    {
        x = origin.x + math.cos(2 * math.pi - radians) * offset,
        y = origin.y,
        z = origin.z + math.sin(2 * math.pi - radians) * offset
    }

    return destination
end

---@nodiscard
---@param A table
---@param B table
---@param ignoreVertical boolean?
---@return number
function utils.distance(A, B, ignoreVertical)
    return math.sqrt(utils.distanceSquared(A, B, ignoreVertical))
end

---@nodiscard
---@param A table
---@param B table
---@param ignoreVertical boolean?
---@return number
function utils.distanceSquared(A, B, ignoreVertical)
    local dX = B.x - A.x
    local dY = (ignoreVertical and 0.0) or B.y - A.y
    local dZ = B.z - A.z

    return dX * dX + dY * dY + dZ * dZ
end

---@nodiscard
---@param A table
---@param B table
---@param within number
---@param ignoreVertical boolean
---@return boolean
function utils.distanceWithin(A, B, within, ignoreVertical)
    return utils.distanceSquared(A, B, ignoreVertical) <= within * within
end

---@nodiscard
---@param A table
---@param B table
---@return number
function utils.getWorldAngle(A, B)
    -- lua math.atan functions like cpp atan2. On top of this, all ffxi world angles are positive.
    -- So we have to adjust the range of lua's math.atan from [-pi, pi] to [0, 2pi]
    -- Similarly, cpp's atanf gets its range adjusted from [-pi/2, pi/2] to [0, 2pi]
    -- It does this by checking the quadrant, which math.atan does automatically.
    -- Finally, ffxi rotations go in the opposite direction from standard rotations.
    local radians = math.atan((B.z - A.z) / (B.x - A.x)) * -1.0

    if B.x > A.x and B.z > A.z then
        -- Quadrant 1
        radians = radians + 2 * math.pi
    elseif B.x > A.x then
        -- Quadrant 4
        radians = radians + 0
    elseif B.z > A.z then
        -- Quadrant 2
        radians = radians + math.pi
    else
        -- Quadrant 3
        radians = radians + math.pi
    end

    return radians
end

---@nodiscard
---@param A table
---@param B table
---@return number
function utils.getWorldRotation(A, B)
    return utils.angleToRotation(utils.getWorldAngle(A, B))
end

---@nodiscard
---@param a number
---@param b number
---@return number
function utils.getAngleDifference(a, b)
    local diff = math.abs(b - a)
    if diff > math.pi then
        diff = 2 * math.pi - diff
    end

    return diff
end

-- Returns whether the angle formed between A and B with origin is <= within radians.
---@nodiscard
---@param origin table
---@param A table
---@param B table
---@param within number
---@return boolean
function utils.angleWithin(origin, A, B, within)
    return utils.getAngleDifference(utils.getWorldAngle(origin, A), utils.getWorldAngle(origin, B)) <= within
end

local ffxiRotationToAngleFactor = 2.0 * math.pi / 256.0
local ffxiAngleToRotationFactor = 256.0 / (2.0 * math.pi)

---@nodiscard
---@param ffxiRotation number
---@return number
function utils.rotationToAngle(ffxiRotation)
    return ffxiRotation * ffxiRotationToAngleFactor
end

---@nodiscard
---@param radians number
---@return number
function utils.angleToRotation(radians)
    return radians * ffxiAngleToRotationFactor
end

-- Function to calculate the cross product
local function crossProduct(x1, y1, x2, y2)
    return x1 * y2 - y1 * x2
end

-- Function to check if two points are on the same side of a line
---@nodiscard
---@param line table
---@param pos1 table
---@param pos2 table
---@return boolean
function utils.sameSideOfLine(line, pos1, pos2)
    -- Calculate vectors
    local v1x, v1y = pos1.x - line[1][1], pos1.z - line[1][2]
    local v2x, v2y = pos2.x - line[1][1], pos2.z - line[1][2]
    local lx, ly = line[2][1] - line[1][1], line[2][2] - line[1][2]

    -- Calculate cross products
    local cross1 = crossProduct(lx, ly, v1x, v1y)
    local cross2 = crossProduct(lx, ly, v2x, v2y)

    -- Check if cross products have the same sign
    return cross1 * cross2 >= 0
end

-- Converts a number to a binary string
---@nodiscard
---@param x integer
---@return string
function utils.intToBinary(x)
    local bin = ''

    while x > 1 do
        bin = tostring(x % 2) .. bin
        x = math.floor(x / 2)
    end

    bin = tostring(x) .. bin

    return bin
end

---@nodiscard
---@param value integer
---@return integer, integer, integer, integer
function utils.toBytes(value)
    local byte0 = bit.rshift(bit.band(value, 0x000000FF), 0)
    local byte1 = bit.rshift(bit.band(value, 0x0000FF00), 8)
    local byte2 = bit.rshift(bit.band(value, 0x00FF0000), 16)
    local byte3 = bit.rshift(bit.band(value, 0xFF000000), 24)
    return byte0, byte1, byte2, byte3
end

---@nodiscard
---@param value integer
---@return integer, integer
function utils.toWords(value)
    local word0 = bit.rshift(bit.band(value, 0x0000FFFF), 0)
    local word1 = bit.rshift(bit.band(value, 0xFFFF0000), 16)
    return word0, word1
end

-- Draws in target to position if any conditions are met.
-- Conditions must be met for "wait" seconds.
-- Can set offset from and degrees around position to place target.
--[[
table =
{
    conditions = { boolean, ... },
    position =
    {
        x = number,
        y = number,
        z = number,
        rot = integer,
    },
    offset = number,
    degrees = number,
    wait = integer,
}
--]]
---@param target CBaseEntity
---@param table table
---@return boolean
function utils.drawIn(target, table)
    if table.position then
        local nextDrawIn = target:getLocalVar('[Draw-In]WaitTime')
        local conditions = table.conditions and table.conditions or { true }
        for _, condition in ipairs(conditions) do
            if condition then
                if nextDrawIn > 0 then
                    if GetSystemTime() > nextDrawIn then
                        local position = {}
                        if table.position then
                            position.x   = table.position.x and table.position.x or table.position[1]
                            position.y   = table.position.y and table.position.y or table.position[2]
                            position.z   = table.position.z and table.position.z or table.position[3]
                            position.rot = table.position.rot and table.position.rot or table.position[4]
                        end

                        local offset  = table.offset and table.offset or 0
                        local degrees = table.degrees and table.degrees or 0

                        DrawIn(target, position, offset, degrees)
                        target:setLocalVar('[Draw-In]WaitTime', 0)
                        return true
                    end

                    return false
                else
                    local wait = table.wait and table.wait or 1
                    target:setLocalVar('[Draw-In]WaitTime', GetSystemTime() + wait)
                    return false
                end
            end
        end
    end

    target:setLocalVar('[Draw-In]WaitTime', 0)
    return false
end

function utils.defaultIfNil(inputValue, defaultValue)
    if inputValue == nil then
        local info = debug.getinfo(2, 'Sl')
        print(string.format('nil value encounted at %s:%i, defaulting to %i', info.source, info.currentline, defaultValue))

        return defaultValue
    end

    return inputValue
end

-- Selects loot from a structured table of loot groups
-- loot is chosen by randomly assigning based on weights from loot groups within lootTable. Example:
--[[
lootTable =
{
    {
        { itemId = xi.item.GIL, amount = 10000, weight = 1000 },
    },

    {
        quantity = 2,
        { itemId = xi.item.REMEDY, weight = 900 },
        { itemId = 0,              weight = 100 },
    },

    {
        { itemId = xi.item.REMEDY, weight = 200 },
        { itemId = 0,              weight = 800 },
    },

--]]

---@param actor CBaseEntity
---@param lootTable table<table>
---@return table
function utils.selectFromLootGroups(actor, lootTable)
    local selectedLoot = {}
    if not actor or not actor:getName() then
        return selectedLoot
    end

    for i, lootGroup in ipairs(lootTable) do
        local max = 0

        -- not ipairs because we might have string keys alongside the individual items in each lootGroup
        for j, entry in pairs(lootGroup) do
            if type(entry) == 'table' then
                max = max + entry.weight

                if entry.itemId == nil then
                    print(fmt('[ERROR] Player ({}) has encountered nil item at index {} of lootGroup with index {}', actor:getName(), j, i))
                end
            end
        end

        local quantity = lootGroup.quantity or 1

        for j = 1, quantity do
            local roll    = math.random(max)
            local current = 0

            for _, entry in pairs(lootGroup) do
                if type(entry) == 'table' then
                    current = current + entry.weight

                    if current >= roll then
                        -- xi.item.NONE gives a chance to drop nothing from a group
                        if entry.itemId == 0 or entry.itemId == nil then
                            break
                        end

                        table.insert(selectedLoot, entry)

                        break
                    end
                end
            end
        end
    end

    return selectedLoot
end
