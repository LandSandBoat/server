---@class utils
utils = utils or {}

-- For use alongside GetSystemTime()
---@nodiscard
---@param minutes integer
---@return integer
utils.minutes = function(minutes)
    return minutes * 60
end

---@nodiscard
---@param hours integer
---@return integer
-- For use alongside GetSystemTime()
utils.hours = function(hours)
    return hours * 60 * 60
end

-- For use alongside GetSystemTime()
---@nodiscard
---@param days integer
---@return integer
utils.days = function(days)
    return days * 60 * 60 * 24
end

---@nodiscard
---@param current table
---@param target table
---@return boolean
utils.timeIsAfterOrEqual = function(current, target)
    if current.year ~= target.year then
        return current.year > target.year
    end

    if current.month ~= target.month then
        return current.month > target.month
    end

    if current.day ~= target.day then
        return current.day > target.day
    end

    return current.hour >= target.hour
end

---@nodiscard
---@param current table
---@param target table
---@return boolean
utils.timeIsBefore = function(current, target)
    if current.year ~= target.year then
        return current.year < target.year
    end

    if current.month ~= target.month then
        return current.month < target.month
    end

    if current.day ~= target.day then
        return current.day < target.day
    end

    return current.hour < target.hour
end

-- Returns 24h Clock Time (example: 04:30 = 430, 21:30 = 2130)
---@nodiscard
---@return number?
utils.vanadielClockTime = function()
    local clockTime = tonumber(VanadielHour() .. string.format('%02d', VanadielMinute()))

    if not clockTime then
        print('ERROR: clockTime was nil.')
    end

    return clockTime
end

-- Returns an integer number of minutes since midnight from a time string like "HH:MM"
---@nodiscard
---@param timeString string
---@return integer
function utils.timeStringToMinutes(timeString)
    local convertedTime  = -1
    local hours, minutes = timeString:match('^(%d%d?):(%d%d)$')
    hours   = tonumber(hours)
    minutes = tonumber(minutes)

    -- Validate time.
    local validMinutes = minutes and minutes >= 0 and minutes < 60
    local validHours   = hours and hours >= 0 and (hours < 24 or (hours == 24 and minutes == 0))

    if not validHours or not validMinutes then
        print(fmt('[ERROR] Invalid time string: ({}). Expected HH:MM', timeString))

        return convertedTime
    end

    convertedTime = hours * 60 + minutes

    return utils.clamp(convertedTime, 0, 1440)
end
