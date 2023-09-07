-----------------------------------
-- Mog Bonanza
-- http://www.playonline.com/ff11us/guide/nomadmogbon/index.html
-- https://www.bg-wiki.com/ffxi/Category:Mog_Bonanza
-----------------------------------
xi = xi or {}
xi.events = xi.events or {}
xi.events.mogBonanza = xi.events.mogBonanza or {}
xi.events.mogBonanza.data = xi.events.mogBonanza.data or {}
xi.events.mogBonanza.entities = xi.events.mogBonanza.entities or {}

local localSettings =
{
    PEARL_COST            = 200000, -- NOTE: This number is hardcoded in the event
    MAX_PEARLS            = 1,
    DISABLE_PRIMEVAL_BREW = 1,      -- 0 will turn on the prank the moogle shows when purchasing

    -- 0x55: New Year's Nomad Mog Bonanza 2021
    -- 0x5A: 20th Vana'versary Nomad Mog Bonanza
    -- 0x5C: 21st Vana'versary Nomad Mog Bonanza
    -- 0x5E: <number>
    BONANZA_ID = 0x5C,

    -- These are local times, and should be tweaked based on your time zone
    BUYING_PERIOD_START     = os.time({ year = 2023, month = 5, day = 17, hour = 1, min =  0 }),
    BUYING_PERIOD_END       = os.time({ year = 2023, month = 6, day = 15, hour = 7, min = 59 }),
    COLLECTION_PERIOD_START = os.time({ year = 2023, month = 7, day = 11, hour = 1, min =  0 }),
    COLLECTION_PERIOD_END   = os.time({ year = 2023, month = 7, day = 31, hour = 7, min = 59 }),

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
        [1] = 800,
        [2] = 71,
        [3] = 7,
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
    [xi.zone.PORT_SAN_DORIA ] = 824,
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
            [ 0] = xi.item.ICE_BRAND,
            [ 1] = xi.item.ONION_SWORD_III,
            [ 2] = xi.item.AIR_KNIFE,
            [ 3] = xi.item.ZANMATO_P2,
            [ 4] = xi.item.DRAGON_FANGS,
            [ 5] = xi.item.MALEFIC_AXE,
            [ 6] = xi.item.DRASTIC_AXE,
            [ 7] = xi.item.ARTEMISS_BOW_P2,
            [ 8] = xi.item.MIRACLE_CHEER,
            [ 9] = xi.item.FINAL_SICKLE,
            [10] = xi.item.PANDITS_STAFF,
            [11] = xi.item.CHOCOBO_KNIFE,
            [12] = xi.item.DIAMOND_ASPIS,
            [13] = xi.item.FLAMETONGUE,
            [14] = xi.item.MUTSU_NO_KAMI_YOSHIYUKI,
            [15] = xi.item.HEBOS_SPEAR,
            [16] = xi.item.PREMIUM_HEART,
            [17] = xi.item.SAVE_THE_QUEEN_III,
            [18] = xi.item.YAGYU_DARKBLADE,
            [19] = xi.item.BRAVE_BLADE_III,
            [20] = xi.item.WIZARDS_ROD,
            [21] = xi.item.EXETER,
            [22] = xi.item.COPY_OF_JUDGMENT_DAY,
            [23] = xi.item.EBISU_FISHING_ROD,
            [24] = xi.item.MOG_KUPON_AW_KUPO,
            [25] = xi.item.ABDHALJS_TOME,
        },
    },

    -- Rank 2 Prizes
    [2] =
    {
        gilReward = 0,

        rewardItems =
        {
            [ 0] = xi.item.MOG_KUPON_A_OMII,
            [ 1] = xi.item.MOG_KUPON_AW_UWIII,
            [ 2] = xi.item.MOG_KUPON_I_AF119,
            [ 3] = xi.item.MOG_KUPON_AW_VGR,
            [ 4] = xi.item.MOG_KUPON_I_RME,
            [ 5] = xi.item.MOG_KUPON_W_PULSE,
            [ 6] = xi.item.MOG_KUPON_AW_VGRII,
            [ 7] = xi.item.MOG_KUPON_W_JOB,
            [ 8] = xi.item.MOG_KUPON_A_DEII,
            [ 9] = xi.item.MOG_KUPON_W_DEIII,
            [10] = xi.item.WAILING_BELT,
            [11] = xi.item.SHAPERS_SHAWL,
            [12] = xi.item.TEN_THOUSAND_BYNE_BILL,
            [13] = xi.item.RANPERRE_GOLDPIECE,
            [14] = xi.item.RIMILALA_STRIPESHELL,
            [15] = xi.item.BAYLD_CRYSTAL,
            [16] = xi.item.DENSE_CLUSTER,
            [17] = xi.item.CATS_EYE,
            [18] = xi.item.MOG_KUPON_AW_GFIII,
            [19] = xi.item.LU_SHANGS_FISHING_ROD,
        },
    },

    -- Rank 3 Prizes
    [3] =
    {
        gilReward = 0,

        rewardItems =
        {
            [ 0] = xi.item.MOG_KUPON_AW_UW,
            [ 1] = xi.item.MOG_KUPON_AW_COS,
            [ 2] = xi.item.AUCUBA_CROWN,
            [ 3] = xi.item.CURMUDGEONS_HELMET,
            [ 4] = xi.item.GAZERS_HELMET,
            [ 5] = xi.item.RETCHING_HELMET,
            [ 6] = xi.item.KARAKUL_CAP,
            [ 7] = xi.item.HOTENGEKI,
            [ 8] = xi.item.GRUDGE,
            [ 9] = xi.item.PLUTON_COFFER,
            [10] = xi.item.BEITETSU_COFFER,
            [11] = xi.item.RIFT_BOULDER_COFFER,
            [12] = xi.item.MARBLE_MOG_PELL,
            [13] = xi.item.OCHRE_MOG_PELL,
            [14] = xi.item.MARS_ORB,
            [15] = xi.item.CHOCOBO_ROPE,
            [16] = xi.item.CHOCOBO_TORQUE,
            [17] = xi.item.MOG_KUPON_A_SAP,
            [18] = xi.item.MOG_KUPON_A_JAD,
            [19] = xi.item.MOG_KUPON_A_RUB,
            [20] = xi.item.DEMONIC_AXE,
            [21] = xi.item.BRAVE_BLADE_II,
            [22] = xi.item.ONION_SWORD_II,
            [23] = xi.item.MOG_KUPON_I_ORCHE,
            [24] = xi.item.SHEET_OF_PROMATHIAN_TUNES,
            [25] = xi.item.SHEET_OF_ADOULINIAN_TUNES,
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

                player:delGil(localSettings.PEARL_COST)
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
