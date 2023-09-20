
------------------------------------
-- Mog Bonanza
-- http://www.playonline.com/ff11us/guide/nomadmogbon/index.html
-- https://www.bg-wiki.com/ffxi/Category:Mog_Bonanza
------------------------------------
xi = xi or {}
xi.events = xi.events or {}
xi.events.mogBonanza = xi.events.mogBonanza or {}
xi.events.mogBonanza.data = xi.events.mogBonanza.data or {}
xi.events.mogBonanza.entities = xi.events.mogBonanza.entities or {}

local localSettings =
{
    PEARL_COST            = 300000, -- NOTE: This number is hardcoded in the event
    MAX_PEARLS            = 3,
    DISABLE_PRIMEVAL_BREW = 1,      -- 0 will turn on the prank the moogle shows when purchasing

    -- 0x55: New Year's Nomad Mog Bonanza 2021
    -- 0x5A: 20th Vana'versary Nomad Mog Bonanza
    -- 0x5C: 21st Vana'versary Nomad Mog Bonanza
    -- 0x5E: <number>
    BONANZA_ID = 0x5C,

    -- These are local times, and should be tweaked based on your time zone
    BUYING_PERIOD_START     = os.time({ year = 2023, month = 8, day = 20, hour = 11, min =  0 }),
    BUYING_PERIOD_END       = os.time({ year = 2023, month = 9, day =  2, hour = 11, min =  0 }),
    COLLECTION_PERIOD_START = os.time({ year = 2023, month = 9, day =  2, hour = 18, min = 30 }),
    COLLECTION_PERIOD_END   = os.time({ year = 2023, month = 9, day = 30, hour = 23, min = 59 }),

    COLLECTION_SERVER_MESSAGE =
        'Announcing the winning numbers for the 21st Vana\'versary Nomad Mog Bonanza!\n' ..
        '\n' ..
        'Rank 3 prize: \'7\' (last digit)-- 13,298 winners.\n' ..
        'Rank 2 prize: \'71\' (last two digits)-- 1,299 winners.\n' ..
        'Rank 1 prize: \'800\' (all three digits)-- 62 winners.\n' ..
        '*The number of winners for each prize is a combined total from all worlds.\n' ..
        '\n' ..
        'Collection period: On July 11, 2023 at 1:00 (PDT) / 8:00 (GMT) to July 31, at 7:59 (PDT) / 14:59 (GMT)\n' ..
        'Details on the prize can be confirmed by speaking to a Bonanza Moogle at one of the following locations:\n' ..
        'Port San d\'Oria (I-9) / Port Bastok (L-8) / Port Windurst (F-6) / Chocobo Circuit (H-8)\n',

    -- Winning Numbers are three independent values for each rank prize:
    WINNING_NUMBERS =
    {
        [1] = 819,
        [2] = 12, -- 212
        [3] = 3, -- 563
    },
}

local event = SeasonalEvent:new('MogBonanza')

xi.events.mogBonanza.enabledCheck = function()
    local currentTime = os.time()

    return currentTime >= localSettings.BUYING_PERIOD_START and
        currentTime <= localSettings.COLLECTION_PERIOD_END
end

local isInPurchasingPeriod = function()
    local currentTime = os.time()

    return xi.events.mogBonanza.enabledCheck() and
        currentTime >= localSettings.BUYING_PERIOD_START and
        currentTime <= localSettings.BUYING_PERIOD_END
end

local isInCollectionPeriod = function()
    local currentTime = os.time()

    return xi.events.mogBonanza.enabledCheck() and
        currentTime >= localSettings.COLLECTION_PERIOD_START and
        currentTime <= localSettings.COLLECTION_PERIOD_END
end

event:setEnableCheck(xi.events.mogBonanza.enabledCheck)

local csidLookup =
{
    [xi.zone.PORT_SAN_DORIA ] = 823,
    [xi.zone.PORT_BASTOK    ] = 467,
    [xi.zone.PORT_WINDURST  ] = 912,
    [xi.zone.CHOCOBO_CIRCUIT] = 503,
}

-- NOTE: Each Reward Rank can support up to 46 items along with a gil reward.  This is bit-packed
-- where param0 in the event update is the gil reward, and each following parameter contains two items
-- (upper and lower 16 bits).  There are 3 event update requests per rank.  Any 0-value parameter
-- will stop the event from processing further values.
local rewardList =
{
    -- Rank 1 Prizes
    [1] =
    {
        gilReward = 0,

        rewardItems =
        {
            [ 0] = xi.item.CATS_EYE,
            [ 1] = xi.item.TEN_THOUSAND_BYNE_BILL,
            [ 2] = xi.item.RIMILALA_STRIPESHELL,
            [ 3] = xi.item.RANPERRE_GOLDPIECE,
            [ 4] = xi.item.OCTAVE_CLUB,
            [ 5] = xi.item.EBISU_FISHING_ROD,
            [ 6] = xi.item.BOREALIS,
            [ 7] = xi.item.DREPANUM,
            [ 8] = xi.item.IKARIGIRI,
            [ 9] = xi.item.XOANON,
            [10] = xi.item.KARAMBIT,
            [11] = xi.item.HIMTHIGE,
            [12] = xi.item.EPHEMERON,
            [13] = xi.item.ULLR,
            [14] = xi.item.SAGASINGER,
        },
    },

    -- Rank 2 Prizes
    [2] =
    {
        gilReward = 8246250,

        rewardItems =
        {
            [ 0] = 16275, -- ancient_torque
            [ 1] = 13566, -- defending_ring
            [ 2] = 16555, -- ridill
            [ 3] = 17738, -- hauteclaire
            [ 4] = 14808, -- novio_earring
            [ 5] = 16117, -- valhalla_helm
            [ 6] = 14577, -- valhalla_breastplate
            [ 7] = 11285, -- morganas_cotehardie
            [ 8] = 19212, -- black_tathlum
            [ 9] = 19213, -- white_tathlum
            [10] = 15458, -- ninurtas_sash
            [11] =  9178, -- mog_kupon_a-ab
        },
    },

    -- Rank 3 Prizes
    [3] =
    {
        gilReward = 756536,

        rewardItems =
        {
            [ 0] = 17857, -- animator_+1
            [ 1] = 15617, -- barbarossas_zerehs
            [ 2] = 16242, -- ixion_cape
            [ 3] = 16267, -- ritter_gorget
            [ 4] = 15899, -- velocious_belt
            [ 5] = 18847, -- seveneyes
            [ 6] = 11289, -- ixion_cloak
            [ 7] =  2330, -- yoichis_sash
            [ 8] = 11288, -- zahaks_mail
            [ 9] =  2573, -- jug_of_monkey_wine
            [10] =  2583, -- buffalo_corpse
            [11] =  2593, -- chunk_of_singed_buffalo
        },
    },
}

-- NOTE: The observed offset indices are 0, 1, and 4 for event updates.  All events seem to be heavily
-- reliant on base 2; however, there is no use of bit1 (2 value).  The below function implements the above
-- logic, but there may be something else that was deprecated in the past.
local function getRewardEventUpdate(option)
    local prizeRank    = bit.rshift(option, 8) + 1
    local updateOffset = math.min(bit.band(option, 0xF), 2)
    local maxItems     = updateOffset == 0 and 13 or 15
    local startIndex   = updateOffset * 14
    local updateTable  = { 0, 0, 0, 0, 0, 0, 0, 0 }

    if updateOffset == 0 then
        updateTable[1] = rewardList[prizeRank].gilReward
    end

    local updateParameter = 0
    for indexVal = startIndex, startIndex + maxItems do
        local updateIndex = math.floor((indexVal - startIndex) / 2) + 1
        if updateOffset == 0 then
            updateIndex = updateIndex + 1
        end

        if not rewardList[prizeRank].rewardItems[indexVal] then
            if updateParameter > 0 then
                updateTable[updateIndex] = updateParameter
            end

            break
        end

        if updateParameter > 0 then
            updateParameter = updateParameter + bit.lshift(rewardList[prizeRank].rewardItems[indexVal], 16)
            updateTable[updateIndex] = updateParameter
            updateParameter = 0
        else
            updateParameter = rewardList[prizeRank].rewardItems[indexVal]
        end
    end

    return updateTable
end

local prizeRankOptions =
{
    [1] = { 0, 1 },
    [2] = { 1, 0 },
    [3] = { 2, 0 },
    [4] = { 3, 0 },
}

-- Will return the rank of prize when compared to the winning number table.
local getPrizeRank = function(player, fullNumber)
    for prizeRank, winningNumber in pairs(localSettings.WINNING_NUMBERS) do
        local matchingNumber = tonumber(string.sub(fullNumber, -1 * string.len(winningNumber)))

        if matchingNumber == winningNumber then
            return prizeRank
        end
    end

    return 4
end

local giveBonanzaPearl = function(player, number)
    -- Absolute Max: 16777215
    -- Current events only allow for a 3-digit number, so this is restricted here.
    number = tonumber(number)
    if
        number == nil or
        number > 999 or
        number < 0
    then
        print(string.format('giveBonanzaPearl: %s tried to create a pear with invalid number: %d', player:getName(), number))
        return nil
    end

    player:addItem({ id = xi.item.BONANZA_PEARL,
        exdata =
        {
            [0] = bit.band(number, 0xFF),
            [1] = bit.band(bit.rshift(number,  8), 0xFF),
            [2] = bit.band(bit.rshift(number, 16), 0xFF),
            [3] = bit.band(localSettings.BONANZA_ID, 0xFF),
            [4] = 0, -- 0xCE, -- These might not be needed
            [5] = 0, -- 0x62, -- These might not be needed
            [6] = 0, -- 0x95, -- These might not be needed
            [7] = 0, -- 0x23, -- These might not be needed
        }
    })
end

xi.events.mogBonanza.onBonanzaMoogleTrade = function(player, npc, trade)
    if
        xi.events.mogBonanza.enabledCheck() and
        isInCollectionPeriod() and
        npcUtil.tradeHasExactly(trade, xi.item.BONANZA_PEARL)
    then
        local bonanzaPearl = trade:getItem(0)
        local exData       = bonanzaPearl:getExData()
        local eventId      = exData[3]

        if eventId == localSettings.BONANZA_ID then
            local baseCs      = csidLookup[player:getZoneID()]
            local pearlNumber = 0

            for exIndex = 0, 2 do
                pearlNumber = pearlNumber + bit.lshift(exData[exIndex], 8 * exIndex)
            end

            player:setLocalVar('prizeRank', getPrizeRank(player, pearlNumber))
            player:startEvent(baseCs + 2, 0, 0, 0, 0, 0, 0, 0, localSettings.BONANZA_ID)
        end
    end
end

xi.events.mogBonanza.onBonanzaMoogleTrigger = function(player, npc)
    if xi.events.mogBonanza.enabledCheck() then
        local baseCs = csidLookup[player:getZoneID()]

        -- Alert player to price of pearl
        player:PrintToPlayer("NOTICE: Bonazna pearls are 300,000g for QoL, and 30,000 for Crystal Warriors!")

        if isInPurchasingPeriod() then
            player:startEvent(baseCs,
                localSettings.MAX_PEARLS,
                localSettings.DISABLE_PRIMEVAL_BREW,
                0,
                0,
                0,
                0,
                0,
                localSettings.BONANZA_ID
            )
        elseif isInCollectionPeriod() then
            player:startEvent(baseCs + 1,
                localSettings.WINNING_NUMBERS[1],
                localSettings.WINNING_NUMBERS[2],
                localSettings.WINNING_NUMBERS[3],
                0,
                0,
                0,
                0,
                localSettings.BONANZA_ID
            )
        end
    end
end

xi.events.mogBonanza.onBonanzaMoogleEventUpdate = function(player, csid, option, npc)
    if xi.events.mogBonanza.enabledCheck() then
        local baseCs = csidLookup[player:getZoneID()]

        if
            csid == baseCs + 2 and
            option == 8
        then
            local prizeRank = player:getLocalVar('prizeRank')

            if prizeRankOptions[prizeRank] then
                player:updateEvent(unpack(prizeRankOptions[prizeRank]))
            else
                print('ERROR: Bonanza event update received without valid prizeRank.')
                return
            end

        -- Purchase
        elseif
            csid == baseCs and
            bit.band(option, 0xFF) == 2
        then
            local selectedNumber = bit.rshift(option, 8)

            if
                player:isCrystalWarrior() and
                player:getGil() < 30000 or
                not player:isCrystalWarrior() and
                player:getGil() < localSettings.PEARL_COST or
                player:getFreeSlotsCount() == 0
            then
                -- TODO: This is a generic I cannot serve you at this time.  There may be a specific message
                -- for lack of gil.

                player:updateEvent(0, 0, 0, 0, 0, 0, 0, 1)
            elseif player:getItemCount(xi.item.BONANZA_PEARL) >= localSettings.MAX_PEARLS then
                player:updateEvent(0, localSettings.MAX_PEARLS, 0, 0, 0, 0, 0, 3)
            else
                player:setLocalVar('selectedNumber', selectedNumber)
                player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
            end
        else
            player:updateEvent(unpack(getRewardEventUpdate(option)))
        end
    end
end

xi.events.mogBonanza.onBonanzaMoogleEventFinish = function(player, csid, option, npc)
    if xi.events.mogBonanza.enabledCheck() then
        local zoneId = player:getZoneID()
        local baseCs = csidLookup[player:getZoneID()]

        if csid == baseCs then
            if option == 3 then
                local selectedNumber = player:getLocalVar('selectedNumber')
                local ID             = zones[zoneId]

                if player:isCrystalWarrior() then
                    player:delGil(30000)
                else
                    player:delGil(localSettings.PEARL_COST)
                end

                giveBonanzaPearl(player, selectedNumber)
                player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.BONANZA_PEARL)
            end
        elseif csid == baseCs + 2 then
            local optionType = bit.band(option, 0xFF)

            if optionType == 4 then
                local prizeRank    = player:getLocalVar('prizeRank')
                local selectedItem = bit.rshift(option, 16) - 1

                if
                    rewardList[prizeRank] and
                    rewardList[prizeRank].rewardItems[selectedItem] and
                    npcUtil.giveItem(player, rewardList[prizeRank].rewardItems[selectedItem])
                then
                    player:confirmTrade()
                elseif selectedItem == -1 then
                    npcUtil.giveCurrency(player, 'gil', rewardList[prizeRank].gilReward)
                    player:confirmTrade()
                end
            elseif
                optionType == 6 and
                npcUtil.giveItem(player, xi.item.BONANZA_BISCUIT)
            then
                player:confirmTrade()
            end
        end
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
