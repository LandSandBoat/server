-----------------------------------
-- General developer packet utilities
--
-- These are *NOT* intended to be used in a live environment or to be used
-- to finish content, but rather for helping with development and debugging.
-- Use at your own risk!
-----------------------------------
xi = xi or {}
xi.packet = xi.packet or {}

-- Will parse a string of the form:
-- [2021-05-10 22:05:57] Incoming packet 0x069:
--         |  0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F      | 0123456789ABCDEF
--     -----------------------------------------------------  ----------------------
--       0 | 69 64 37 04 01 00 08 01 C8 00 00 00 01 00 00 80    0 | id7.............
--       1 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    1 | ................
--       2 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    2 | ................
--       3 | 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    3 | ................
--       4 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    4 | ................
--       5 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    5 | ................
--       6 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    6 | ................
--       7 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    7 | ................
--       8 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    8 | ................
--       9 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    9 | ................
--       A | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    A | ................
--       B | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    B | ................
--       C | 00 00 00 00 00 00 00 00 -- -- -- -- -- -- -- --    C | ........--------
--
-- as a table: { 0x69, 0x64, 0x37, ... }
xi.packet.parseFromCaptureString = function(input)
    local data = {}
    for line in input:gmatch('[^\r\n]+') do
        -- Match lines containing hex data
        local hexLine = line:match('%|%s+([%x%s]+)%s+%|')
        if hexLine then
            -- Split the matched hex string and insert into the table
            for hex in hexLine:gmatch('%x%x') do
                table.insert(data, tonumber(hex, 16))
            end
        end
    end

    return data
end

-- Split and parse packets (splitting at date sections)
function xi.packet.parseMultiplePackets(combinedData)
    local function splitByDate(text)
        local result   = {}
        local pattern  = '%[(%d%d%d%d%-%d%d%-%d%d %d%d:%d%d:%d%d)%]' -- Pattern to match date/time
        local startIdx = 1

        while true do
            local dateStart, dateEnd = text:find(pattern, startIdx)
            if not dateStart then
                break
            end

            table.insert(result, text:sub(startIdx, dateStart - 1))

            startIdx = dateEnd + 1
        end

        table.insert(result, text:sub(startIdx))

        return result
    end

    local splitData = splitByDate(combinedData)
    local parsedData = {}

    for _, data in ipairs(splitData) do
        table.insert(parsedData, xi.packet.parseFromCaptureString(data))
    end

    return parsedData
end
