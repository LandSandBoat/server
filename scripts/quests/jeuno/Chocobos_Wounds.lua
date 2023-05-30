-----------------------------------
-- Chocobo's Wounds
-----------------------------------
-- Log ID: 3, Quest ID: 4
-- Brutus  : !pos -55 8 95 244
-- Chocobo : !pos -61.42 8.2 93 244
-- Osker   : !pos -61.42 8.2 94.2 244
-- _6t2    : !pos -88.2 -7.65 -168.8 245
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.CHOCOBOS_WOUNDS)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.JEUNO,
    keyItem = xi.ki.CHOCOBO_LICENSE,
    title = xi.title.CHOCOBO_TRAINER,
}

-- The following tables are based on the stage variable for feeding
-- the chocobo.
local oskerFeedTriggers =
{
    103, 51, 52, 59, 46, 55,
}

local chocoboFeedTriggers =
{
    103, 51, 52, 61, 46, 55,
}

local chocoboFeedTrades =
{
    57, 58, 59, 60, 63, 64,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and player:getMainLvl() >= 20
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['_6t2'] = quest:event(64),
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['Brutus'] =
            {
                onTrigger = function(player, npc)
                    local declinedOption = quest:getVar(player, 'Declined') == 1 and 0 or 1
                    return quest:progressEvent(71, declinedOption)
                end,
            },

            -- TODO: Need to verify these aren't a default action that gets replaced.
            ['Chocobo'] =
            {
                onTrigger = quest:progressEvent(62),
                onTrade   = quest:progressEvent(62),
            },

            ['Osker'] = quest:progressEvent(62),

            onEventFinish =
            {
                [71] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 1)
                        -- This quest is automatically flagged during this interaction.
                        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.CHOCOBO_ON_THE_LOOSE)
                    else
                        -- Dialogue changes if the player fails to choose the correct option.
                        quest:setVar(player, 'Declined', 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['_6t2'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') > 3 then
                        return quest:event(63)
                    end
                end,
            },
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['Brutus'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 1 then
                        return quest:progressEvent(65)
                    elseif questProgress == 2 then
                        return quest:progressEvent(66)
                    else
                        return quest:event(102)
                    end
                end,
            },

            ['Chocobo'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.BUNCH_OF_GYSAHL_GREENS) then
                        return quest:progressEvent(76)
                    elseif npcUtil.tradeHasExactly(trade, xi.items.CLUMP_OF_GAUSEBIT_WILDGRASS) then
                        if quest:getVar(player, 'Timer') <= os.time() then
                            return quest:progressEvent(chocoboFeedTrades[quest:getVar(player, 'Prog')])
                        else
                            return quest:progressEvent(73)
                        end
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:progressEvent(chocoboFeedTriggers[quest:getVar(player, 'Prog')])
                end,
            },

            ['Osker'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(oskerFeedTriggers[quest:getVar(player, 'Prog')])
                end,
            },

            onEventFinish =
            {
                [57] = function(player, csid, option, npc)
                    quest:setVar(player, 'Timer', os.time() + 45)
                    quest:setVar(player, 'Prog', 2)
                end,

                [58] = function(player, csid, option, npc)
                    quest:setVar(player, 'Timer', os.time() + 45)
                    quest:setVar(player, 'Prog', 3)
                end,

                [59] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Timer', os.time() + 45)
                    quest:setVar(player, 'Prog', 4)

                    return quest:event(99)
                end,

                [60] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Timer', os.time() + 45)
                    quest:setVar(player, 'Prog', 5)
                end,

                [63] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Timer', os.time() + 45)
                    quest:setVar(player, 'Prog', 6)
                end,

                [64] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and
                not player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SAVE_MY_SON)
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Brutus']  = quest:event(22), -- Always used except for importantOnce() for Chocobo on the Loose (10094)
            ['Chocobo'] = quest:event(55),
            ['Osker']   = quest:event(55),
        },
    },
}

return quest
