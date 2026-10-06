-----------------------------------
-- Kid Mithra Shops
-----------------------------------
xi = xi or {}
xi.kidMithraShop = xi.kidMithraShop or {}

-- Not fully confirmed, so harder for balance: the JST midnight reset, the locks and the ignored purchases.

-- How long the shop waits before it can rise again, by the level it just reached.
local lockAfterRising = { [2] = utils.minutes(71), [3] = utils.minutes(122) }

-- Purchases right after a level-up do not count.
local ignoreSeconds = utils.minutes(1)

-- Every player's purchases raise the shop at most one level at a time. Returns the level and whether it rose.
---@param prefix string
---@param levelUpSales integer[] Fresh takings needed to leave each level
---@param addedSales integer
---@return integer
---@return boolean
xi.kidMithraShop.settle = function(prefix, levelUpSales, addedSales)
    local salesVar  = string.format('%sSales', prefix)
    local levelVar  = string.format('%sLevel', prefix)
    local lockVar   = string.format('%sLockUntil', prefix)
    local ignoreVar = string.format('%sIgnoreUntil', prefix)

    local now    = GetSystemTime()
    local level  = math.max(GetServerVariable(levelVar), 1)
    local sales  = GetServerVariable(salesVar)
    local lock   = GetServerVariable(lockVar)
    local ignore = GetServerVariable(ignoreVar)
    local rose   = false

    if now >= ignore then
        sales = sales + addedSales
    end

    if
        now >= lock and
        level <= #levelUpSales and
        sales > levelUpSales[level]
    then
        level  = level + 1
        sales  = 0
        lock   = now + (lockAfterRising[level] or 0)
        ignore = now + ignoreSeconds
        rose   = true
    end

    -- Every shop starts each day over at level 1.
    local midnight = JstMidnight()
    SetServerVariable(salesVar, sales, midnight)
    SetServerVariable(levelVar, level, midnight)
    SetServerVariable(lockVar, lock, midnight)
    SetServerVariable(ignoreVar, ignore, midnight)

    return level, rose
end
