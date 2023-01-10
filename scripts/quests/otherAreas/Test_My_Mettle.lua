-----------------------------------
-- Test My Mettle
-----------------------------------
-- Log ID: 4, Quest ID: 25
-- Devean : !pos -58 -10 6 248
-- Jar    : !gotoname Jar
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/settings')
require('scripts/globals/status')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
require('scripts/quests/otherAreas/helpers')
-----------------------------------
local selbinaID = require('scripts/zones/Selbina/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.TEST_MY_METTLE)

quest.reward =
{
    gil = 0,
    fame = 30,
    fameArea = xi.quest.fame_area.SELBINA_RABAO,
}

local npcEventID =
{
    devean =
    {
        OFFER_QUEST = 120,
        GAME_HOURS_REMAINING = 121,
        SUCCESS = 122,
        FAILURE = 123,
        DEFAULT = 124,
        TOSS_OR_TRADE = 125,
    },
}

-- option values are not bit fields, so use less than operator to compare
local function getBet(option)
    local bet = 1000

    if option < 250 then
        bet = 100
    elseif option < 500 then
        bet = 250
    elseif option < 1000 then
        bet = 500
    end

    return bet
end

local function getMultipler(hours)
    local multiplierTable =
    {
        [24] = 3.0,
        [36] = 2.5,
        [48] = 2.0,
        [60] = 1.5,
        [72] = 1.2,
    }

    return multiplierTable[hours]
end

local function getExpiry(hours)
    local osTime = os.time()
    local secondsInOneHour = 3600

    return osTime + (hours / 24) * secondsInOneHour
end

local function canRepeat(player)
    local repeatableAfter = quest:getVar(player, 'repeatableAfter')

    return repeatableAfter == 0 or repeatableAfter <= os.time()
end

local function recordOption(player, option)
    -- option = 0x40000000 for first, second, third, and fourth cancel/decline
    if option < 0x40000000 then
        -- examples:
        -- option = 124  (100  gil + 24 hours)
        -- option = 286  (250  gil + 36 hours)
        -- option = 322  (250  gil + 72 hours)
        -- option = 548  (500  gil + 48 hours)
        -- option = 1060 (1000 gil + 60 hours)
        -- option = 1072 (1000 gil + 72 hours)

        local bet = getBet(option)
        local hours = option - bet
        local multiplier = getMultipler(hours)
        local expiry = getExpiry(hours)

        quest:setVar(player, 'bet', bet * multiplier)
        quest:setVar(player, 'expiry', expiry)

        return true
    end

    return false
end

local function setRepeatableAfter(player, failed)
    quest:setVar(player, 'repeatableAfter', getMidnight())

    if failed then
        -- must clear expiry to prevent a player from trading the sandals after the
        -- repeat period elapses
        quest:setVar(player, 'expiry', 0)

        -- must clear bet to prevent a player from being penalized more than once
        quest:setVar(player, 'bet', 0)
    end
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainLvl() >= 10 and
                player:getRank(player:getNation()) >= 2 and
                player:getFameLevel(xi.quest.fame_area.SELBINA_RABAO) >= 2
        end,

        [xi.zone.SELBINA] =
        {
            ['Devean'] =
            {
                onTrigger = function(player, npc)
                    -- before this quest was implemented, the Jar would give
                    -- the sandals regardless of quest being flagged, so in
                    -- order to start the quest players must throw away the
                    -- sandals first
                    -- note: must zone after throwing away
                    if player:hasItem(xi.items.POWER_SANDALS) then
                        return quest:event(npcEventID.devean.TOSS_OR_TRADE, xi.items.POWER_SANDALS)
                    end

                    return quest:progressEvent(npcEventID.devean.OFFER_QUEST, 0, xi.items.POWER_SANDALS)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasOnly(trade, xi.items.POWER_SANDALS) then
                        player:confirmTrade()
                    end
                end,
            },

            onEventFinish =
            {
                [npcEventID.devean.OFFER_QUEST] = function(player, csid, option, npc)
                    if recordOption(player, option) then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED or status == QUEST_COMPLETED
        end,

        [xi.zone.SELBINA] =
        {
            ['Devean'] =
            {
                onTrigger = function(player, npc)
                    -- scenarios:
                    -- 1) time remaining is positive and player has sandels in
                    --    inventory, but not equipped
                    -- 2) time remaining is positive and player has sandels in
                    --    storage or are equipped (untrabeable)
                    -- 3) time is up and player has sandels in inventory, but
                    --    not equipped
                    -- 4) time is up and player has sandels in storage or are
                    --    equipped (untrabeable)
                    -- 5) time is up and player does not have sandals
                    -- 6) time is not up and player does not have sandals

                    local expiry = quest:getVar(player, 'expiry')
                    local hasSandals = player:hasItem(xi.items.POWER_SANDALS)

                    -- expiry of 0 indicates either the quest has never been started,
                    -- previously successful, or a previous failure, not ignorance
                    if expiry == 0 then
                        if canRepeat(player) then
                            if hasSandals then
                                return quest:event(npcEventID.devean.TOSS_OR_TRADE, xi.items.POWER_SANDALS)
                            end

                            return quest:progressEvent(npcEventID.devean.OFFER_QUEST, 0, xi.items.POWER_SANDALS)
                        end

                        return quest:event(npcEventID.devean.DEFAULT)
                    end

                    local timeRemaining = expiry - os.time()

                    if timeRemaining < 0 then
                        timeRemaining = 0
                    end

                    if timeRemaining > 0 then
                        local gameHours = math.floor(timeRemaining / 150)

                        -- don't report 0 game hours remaining, we have already
                        -- established that the time remaining is greater than
                        -- zero
                        if gameHours == 0 then
                            gameHours = 1
                        end

                        return quest:event(npcEventID.devean.GAME_HOURS_REMAINING, xi.items.POWER_SANDALS, gameHours)
                    end

                    if hasSandals then
                        return quest:event(npcEventID.devean.TOSS_OR_TRADE, xi.items.POWER_SANDALS)
                    end

                    -- can only reach this if the expiry is set, the time
                    -- remaining is 0, and the player does not have the sandals
                    -- collect the penalty, reset the bet, and set repeat time
                    return quest:progressEvent(npcEventID.devean.FAILURE)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasOnly(trade, xi.items.POWER_SANDALS) then
                        local expiry = quest:getVar(player, 'expiry')
                        local timeRemaining = expiry - os.time()

                        if timeRemaining > 0 then
                            return quest:progressEvent(npcEventID.devean.SUCCESS)
                        end

                        return quest:progressEvent(npcEventID.devean.FAILURE)
                    end

                    return quest:noAction()
                end,
            },

            onEventFinish =
            {
                [npcEventID.devean.OFFER_QUEST] = function(player, csid, option, npc)
                    recordOption(player, option)
                end,

                [npcEventID.devean.SUCCESS] = function(player, csid, option, npc)
                    quest.reward.gil = quest:getVar(player, 'bet')

                    player:confirmTrade()
                    quest:complete(player)

                    setRepeatableAfter(player, false)
                end,

                [npcEventID.devean.FAILURE] = function(player, csid, option, npc)
                    local penalty = quest:getVar(player, 'bet')

                    if player:getGil() >= penalty then
                        player:confirmTrade()
                        player:delGil(penalty)

                        setRepeatableAfter(player, true)
                    else
                        player:messageSpecial(selbinaID.text.NOT_HAVE_ENOUGH_GIL)
                    end
                end,
            },
        },

        [xi.zone.DAVOI] =
        {
            ['Jar'] =
            {
                onTrigger = function(player, npc)
                    if player:hasItem(xi.items.POWER_SANDALS) or not canRepeat(player) then
                        return -- use default action
                    end

                    local clockIsTicking = quest:getVar(player, 'expiry') > 0

                    if clockIsTicking then
                        if npcUtil.giveItem(player, xi.items.POWER_SANDALS) then
                            local osTime = os.time()

                            xi.otherAreas.helpers.TestMyMettle.moveJar(npc, osTime)

                            return quest:noAction()
                        end

                        if player:getFreeSlotsCount() < 1 then
                            return quest:noAction() -- prevent default action
                        end

                        -- could not obtain, but not because of full inventory
                        -- use default action, not noAction
                    end
                end,
            },
        },
    },
}

return quest
