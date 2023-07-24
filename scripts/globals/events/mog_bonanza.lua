------------------------------------
-- Mog Bonanza
-- http://www.playonline.com/ff11us/guide/nomadmogbon/index.html
-- https://www.bg-wiki.com/ffxi/Category:Mog_Bonanza
------------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/zone')
------------------------------------
xi = xi or {}
xi.events = xi.events or {}
xi.events.mogBonanza = xi.events.mogBonanza or {}
xi.events.mogBonanza.data = xi.events.mogBonanza.data or {}
xi.events.mogBonanza.entities = xi.events.mogBonanza.entities or {}

local localSettings =
{
    PEARL_COST = 200000,
    MAX_PEARLS = 1,

    -- 0x55: New Year's Nomad Mog Bonanza 2021
    -- 0x5A: 20th Vana'versary Nomad Mog Bonanza
    -- 0x5C: 21st Vana'versary Nomad Mog Bonanza
    -- 0x5E: <number>
    EVENT = 0x5E,

    COLLECTION_SERVER_MESSAGE =
        'Announcing the winning numbers for the 21st Vana\'versary Nomad Mog Bonanza!\n' ..
        '\n' ..
        'Rank 3 prize: "7" (last digit)-- 13,298 winners.\n' ..
        'Rank 2 prize: "71" (last two digits)-- 1,299 winners.\n' ..
        'Rank 1 prize: "800" (all three digits)-- 62 winners.\n' ..
        '*The number of winners for each prize is a combined total from all worlds.\n' ..
        '\n' ..
        'Collection period: On July 11, 2023 at 1:00 (PDT) / 8:00 (GMT) to July 31, at 7:59 (PDT) / 14:59 (GMT)\n' ..
        'Details on the prize can be confirmed by speaking to a Bonanza Moogle at one of the following locations:\n' ..
        'Port San d\'Oria (I-9) / Port Bastok (L-8) / Port Windurst (F-6) / Chocobo Circuit (H-8)\n',

    -- When WINNING_NUMBER is nil, false, or anything that isn't a type() == 'number', the whole system will be in
    -- the buying period. Once WINNING_NUMBER is set, everything will be in the collection period until the event ends.
    WINNING_NUMBER = nil,
}

local event = SeasonalEvent:new('MogBonanza')

-- Start Date (Buying Period)
-- Prize Collection Period
-- End Date
xi.events.mogBonanza.enabledCheck = function()
    return true
end

event:setEnableCheck(xi.events.mogBonanza.enabledCheck)

local csidLookup =
{
    [xi.zone.PORT_SAN_DORIA] =
    {
        baseCs = 824,
    },
    [xi.zone.PORT_BASTOK] =
    {
        baseCs = 467,
    },
    [xi.zone.PORT_WINDURST] =
    {
        baseCs = 912,
    },
    [xi.zone.CHOCOBO_CIRCUIT] =
    {
        baseCs = 503,
    },
}

--[[
    Will return the rank of the prize given winningNumber and guessNumber.
    1: 3 matching numbers
    2: 2 matchiung numbers
    3: 1 matching number
    4: 0 matching numbers

    Tested:
    print('Prize', getPrizeRank(123, 123))
    print('Prize', getPrizeRank(123, 124))
    print('Prize', getPrizeRank(123, 234))
    print('Prize', getPrizeRank(123, 199))
    print('Prize', getPrizeRank(123, 919))
    print('Prize', getPrizeRank(123, 991))
    print('Prize', getPrizeRank(123, 999))
    print('Prize', getPrizeRank(nil, nil))
    print('Prize', getPrizeRank(1, 1))

    Prize 1
    Prize 2
    Prize 2
    Prize 3
    Prize 3
    Prize 3
    Prize 4
    Prize 4
    Prize 4
]]--
local getPrizeRank = function(player, winningNumber, guessNumber)
    local winningNumberStr = tostring(winningNumber)
    local guessNumberStr   = tostring(guessNumber)

    -- TODO: guessNumber has to be zero padded on the left once it's a string

    if
        type(winningNumber) ~= 'number' or
        type(guessNumber) ~= 'number' or
        #winningNumberStr ~= #guessNumberStr or
        #winningNumberStr ~= 3 or
        #guessNumberStr ~= 3
    then
        print(string.format('getPrizeRank: %s tried to get prize rank with invalid number: %d', player:getName(), tonumber(guessNumber)))
        return 4
    end

    -- This assumes the strings are the same length, and that the length arg is less than their length
    -- TODO: Refactor to be baseStr and guessStr, and do 2 passes:
    local getMatchOfLength = function(str1, str2, length)
        local strLength = #str1
        for strIdx1 = 1, strLength - length + 1 do
            for strIdx2 = 1, strLength - length + 1 do
                local part1 = string.sub(str1, strIdx1, strIdx1 + length - 1)
                local part2 = string.sub(str2, strIdx2, strIdx2 + length - 1)
                if
                    #part1 == length and
                    #part2 == length and
                    part1 == part2
                then
                    return true
                end
            end
        end
        return false
    end

    -- Rank 1
    if getMatchOfLength(winningNumberStr, guessNumberStr, 3) then
        return 1
    end

    -- Rank 2
    if getMatchOfLength(winningNumberStr, guessNumberStr, 2) then
        return 2
    end

    -- Rank 3
    if getMatchOfLength(winningNumberStr, guessNumberStr, 1) then
        return 3
    end

    -- Rank 4
    return 4
end

local giveBonanzaPearl = function(player, number)
    -- MAX: 16777215
    number = tonumber(number)
    if
        number == nil or
        number > 16777215 or
        number < 0
    then
        print(string.format('giveBonanzaPearl: %s tried to create a pear with invalid number: %d', player:getName(), number))
        return nil
    end

    player:addItem({ id = xi.items.BONANZA_PEARL,
        exdata = {
            [0] = bit.band(number, 0xFF),
            [1] = bit.band(bit.rshift(number,  8), 0xFF),
            [2] = bit.band(bit.rshift(number, 16), 0xFF),
            [3] = bit.band(localSettings.EVENT, 0xFF),
            [4] = 0, -- 0xCE, -- These might not be needed
            [5] = 0, -- 0x62, -- These might not be needed
            [6] = 0, -- 0x95, -- These might not be needed
            [7] = 0, -- 0x23, -- These might not be needed
        }
    })
end

local isInPurchasingPeriod = function()
    return xi.events.mogBonanza.enabledCheck() and type(localSettings.WINNING_NUMBER) ~= 'number'
end

local isInCollectionPeriod = function()
    return xi.events.mogBonanza.enabledCheck() and type(localSettings.WINNING_NUMBER) == 'number'
end

xi.events.mogBonanza.onBonanzaMoogleTrade = function(player, npc, trade)

    -- TODO: Empty?

    if not xi.events.mogBonanza.enabledCheck() then
        return
    end
end

xi.events.mogBonanza.onBonanzaMoogleTrigger = function(player, npc)

    if not xi.events.mogBonanza.enabledCheck() then
        return
    end

    local baseCs = csidLookup[player:getZoneID()].baseCs

    local disablePrimevalBrew = 1

    -- Args 5,6,7 might be garbage
    --player:startEvent(912, 1, disablePrimevalBrew, 0, 0, 67108863, 148230686, 4095, 3)

    -- 912: Buying phase
    -- 913: Priza phase

    -- 914: What is this?

    player:startEvent(baseCs, 397, 79, 1, 0, 65830911, 2632028, 4095, 131096)
end

xi.events.mogBonanza.onBonanzaMoogleEventUpdate = function(player, csid, option, npc)

    if not xi.events.mogBonanza.enabledCheck() then
        return
    end

    local baseCs = csidLookup[player:getZoneID()].baseCs

    -- option: 62722
    -- option: 771
    -- option: 44034

    -- Rank 1
    if csid == baseCs and option == 0 then
        player:updateEvent(0, 1410879680, 1418220610, 1426347229, 1440503094, 1451316821, 1725585129, 241189491)
    elseif csid == baseCs and option == 1 then
        player:updateEvent(601184012, 0, 0, 0, 0, 0, 0, 0)
    elseif csid == baseCs and option == 4 then
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)

    -- Rank 2
    elseif csid == baseCs and option == 256 then
        player:updateEvent(0, 601564113, 601301970, 595534370, 595665792, 576463449, 576393087, 95290801)
    elseif csid == baseCs and option == 257 then
        player:updateEvent(576652715, 225649458, 0, 0, 0, 0, 0, 0)

    -- Rank 3
    elseif csid == baseCs and option == 512 then
        player:updateEvent(0, 260383709, 600187870, 1680876502, 1555194930, 1371890737, 428103434, 428153222)
    elseif csid == baseCs and option == 513 then
        player:updateEvent(416028875, 0, 0, 0, 0, 0, 0, 0)
    elseif csid == baseCs and option == 516 then
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)

    -- Purchase
    elseif csid == baseCs and option == 44290 then
        player:updateEvent(459877491, 137258278, 0, 0, 35929248, 54166282, 4095, 0)
    end

    player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
end

xi.events.mogBonanza.onBonanzaMoogleEventFinish = function(player, csid, option, npc)

    if not xi.events.mogBonanza.enabledCheck() then
        return
    end

    local baseCs = csidLookup[player:getZoneID()].baseCs

    -- Give Pearl
    if csid == baseCs and option == 3 then
        -- Already have a pearl
    elseif csid == baseCs and option == 771 then
        -- TODO
    end
end

event:setStartFunction(function()
    -- TODO: Show/Hide Bonanza Moogles
    -- TODO: Append onto xi.settings.main.SERVER_MESSAGE
end)

event:setEndFunction(function()
    -- TODO: Show/Hide Bonanza Moogles
end)

return event
