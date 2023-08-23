-----------------------------------
-- Test My Mettle
-----------------------------------
-- Log ID: 4, Quest ID: 25
-- Devean : !pos -58 -10 6 248
-- Jar    : !gotoname Jar
-----------------------------------
require('scripts/quests/otherAreas/helpers')
-----------------------------------
local selbinaID = zones[xi.zone.SELBINA]
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.TEST_MY_METTLE)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.SELBINA_RABAO,
}

local betAmounts =
{
    [1] = 1000,
    [2] = 500,
    [3] = 250,
    [4] = 100,
}

local rewardMultiplier =
{
    [24] = 3.0,
    [36] = 2.5,
    [48] = 2.0,
    [60] = 1.5,
    [72] = 1.2,
}

-- Event option return is the sum of bet amount and timeframe chosen.
local function getSelectedOption(option)
    for selectedBet = 1, 4 do
        if option > betAmounts[selectedBet] then
            return betAmounts[selectedBet], option - betAmounts[selectedBet]
        end
    end
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status ~= QUEST_ACCEPTED and
                player:getMainLvl() >= 10 and
                player:getRank(player:getNation()) >= 2 and
                player:getFameLevel(xi.quest.fame_area.SELBINA_RABAO) >= 2 and
                quest:getVar(player, 'Repeat') <= os.time()
        end,

        [xi.zone.SELBINA] =
        {
            ['Devean'] = quest:progressEvent(120, 0, xi.item.POWER_SANDALS, 0, 0, 0, xi.item.FLINT_STONE),

            onEventFinish =
            {
                [120] = function(player, csid, option, npc)
                    local eventCancelled = bit.rshift(option, 31) == 1 and true or false

                    if not eventCancelled then
                        local betAmount, vanaHoursRemaining = getSelectedOption(option)

                        if player:getGil() >= betAmount then
                            player:delGil(betAmount)

                            -- One Vana'diel Hour is equal to 2m24s (144s)
                            quest:setVar(player, 'Timer', os.time() + vanaHoursRemaining * 144)
                            quest:setVar(player, 'Reward', betAmount * rewardMultiplier[vanaHoursRemaining])
                            quest:begin(player)
                        else
                            return quest:messageSpecial(selbinaID.text.DONT_HAVE_ENOUGH_GIL)
                        end
                    end
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
                    if npcUtil.tradeHasExactly(trade, xi.item.POWER_SANDALS) then
                        local timeRemaining = quest:getVar(player, 'Timer') - os.time()

                        if timeRemaining > 0 then
                            return quest:progressEvent(122)
                        else
                            return quest:progressEvent(123)
                        end
                    end
                end,

                onTrigger = function(player, npc)
                    local timeRemaining = quest:getVar(player, 'Timer') - os.time()

                    if timeRemaining > 0 then
                        local hoursRemaining = math.floor(timeRemaining / 144)

                        return quest:event(121, xi.item.POWER_SANDALS, hoursRemaining)
                    else
                        if
                            player:hasItem(xi.item.POWER_SANDALS) and
                            quest:getVar(player, 'Option') == 0
                        then
                            return quest:progressEvent(125)
                        else
                            return quest:progressEvent(123)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [122] = function(player, csid, option, npc)
                    local rewardedGil = quest:getVar(player, 'Reward')

                    if quest:complete(player) then
                        player:confirmTrade()
                        npcUtil.giveCurrency(player, 'gil', rewardedGil)
                        quest:setVar(player, 'Repeat', JstMidnight())
                    end
                end,

                [123] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:delCurrentQuest(quest.areaId, quest.questId)
                    quest:setVar(player, 'Repeat', JstMidnight())
                end,

                [125] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 1)
                end,
            },
        },

        [xi.zone.DAVOI] =
        {
            ['Jar'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: Find the Jar's default action

                    if not player:hasItem(xi.item.POWER_SANDALS) then
                        if npcUtil.giveItem(player, xi.item.POWER_SANDALS) then
                            xi.otherAreas.helpers.TestMyMettle.moveJar(npc)
                        end

                        return quest:noAction()
                    end
                end,
            },
        },
    },
}

return quest
