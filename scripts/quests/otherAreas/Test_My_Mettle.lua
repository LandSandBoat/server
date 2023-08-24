-----------------------------------
-- Test My Mettle
-----------------------------------
-- Log ID: 4, Quest ID: 25
-- Devean        : !pos 39.858 -14.558 40.009 248
-- power_sandals : !additem 13012
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.TEST_MY_METTLE)

local function calculateHoursRemaining(player)
    local daysPassed     = VanadielDayOfTheYear() - quest:getVar(player, 'DayStarted')
    local hoursRemaining = quest:getVar(player, 'HoursSelected') - (VanadielHour() + daysPassed * 24) + quest:getVar(player, 'HourStarted')

    return hoursRemaining
end

local function finishQuest(player, success)
    -- Set quest cooldown
    quest:setMustZone(player)
    quest:setVar(player, 'Wait', getMidnight())

    if success then
        -- Gil payout and quest completed
        npcUtil.giveCurrency(player, 'gil', quest:getVar(player, 'GilPayout'))
        quest:complete(player)
    else
        -- Remove quest from player's log
        player:delQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.TEST_MY_METTLE)
    end
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return (status == QUEST_AVAILABLE or status == QUEST_COMPLETED) and
                vars.Wait <= os.time() and
                not quest:getMustZone(player) and
                player:getMainLvl() >= 10
        end,

        [xi.zone.SELBINA] =
        {
            ['Devean'] = quest:progressEvent(120, xi.items.POWER_SANDALS, xi.items.POWER_SANDALS, 0, 0, xi.items.FLINT_STONE, xi.items.FLINT_STONE),

            onEventFinish =
            {
                [120] = function(player, csid, option, npc)
                    -- Option returns the sum of the gil option selected
                    -- and the hour option selected, anything other than
                    -- these combinations is invalid
                    local possibleOptions =
                    {
                        124, 136, 148, 160, 172,
                        274, 286, 298, 310, 322,
                        524, 536, 548, 560, 572,
                        1024, 1036, 1048, 1060, 1072,
                    }
                    local found = false
                    for _, possibleOption in ipairs(possibleOptions) do
                        if option == possibleOption then
                            found = true
                            break
                        end
                    end
                    -- Rejected the quest at some point in the dialogue
                    if found == false then
                        return
                    end

                    -- Determine gil and hour options selected
                    local gilOptions = { [1] = 100, [2] = 250, [5] = 500, [10] = 1000 }
                    local gil = gilOptions[math.floor(option / 100)]
                    local hours = option - gil

                    -- Calculate potential payout
                    local payoutRatios = { [24] = 3, [36] = 2.5, [48] = 2, [60] = 1.5, [72] = 1.2 }
                    local gilPayout = payoutRatios[hours] * gil

                    quest:setVar(player, 'GilPayout', gilPayout)
                    quest:setVar(player, 'HoursSelected', hours)
                    quest:setVar(player, 'HourStarted', VanadielHour())
                    quest:setVar(player, 'DayStarted', VanadielDayOfTheYear())
                    -- Remove quest from player's log if already completed
                    if player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.TEST_MY_METTLE) == QUEST_COMPLETED then
                        player:delQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.TEST_MY_METTLE)
                    end
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.SELBINA] =
        {
            ['Devean'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.POWER_SANDALS) then
                        player:tradeComplete()
                        local hoursRemaining = calculateHoursRemaining(player)

                        if hoursRemaining > 0 then
                            -- Quest succeeded
                            return quest:progressEvent(122)
                        else
                            -- Quest failed
                            return quest:progressEvent(123)
                        end
                    end
                end,

                onTrigger = function(player, npc)
                    local hoursRemaining = calculateHoursRemaining(player)

                    if hoursRemaining > 0 then
                        -- Remind player how much time is remaining
                        return quest:event(121, xi.items.POWER_SANDALS, hoursRemaining)
                    end

                    if player:hasItem(xi.items.POWER_SANDALS) then
                        -- Get rid of Power Sandals before reattempting
                        return quest:event(125, xi.items.POWER_SANDALS)
                    end

                    -- Quest failed
                    return quest:progressEvent(123)
                end,
            },

            onEventFinish =
            {
                [122] = function(player, csid, option, npc)
                    finishQuest(player, true)
                end,

                [123] = function(player, csid, option, npc)
                    finishQuest(player, false)
                end
            }
        }
    },
}

return quest
