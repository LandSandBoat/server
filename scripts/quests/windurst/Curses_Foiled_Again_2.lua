-----------------------------------
-- Curses, Foiled...Again!?
--
-- Shantotto : !pos 122 -2 112 239
--
-- NOTE: You must wait one game day and zone after completing the previous quest before you can activate this quest.
--     : If you have started the quest Making Headlines there may be complications with trying to start this quest.
--     : This quest has been completed with Making Headlines active, however Hiwon-Biwon's scoop is taken before this quest is started.
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CURSES_FOILED_AGAIN_2)

quest.reward =
{
    fame     = 10,
    fameArea = xi.quest.fame_area.WINDURST,
    item = xi.items.MISERY_STAFF,
}

quest.sections =
{
    -- Speak to Hiwon-Biwon (K-8).
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CURSES_FOILED_AGAIN_2) and
                -- not quest:getMustZone(player) and -- TODO
                VanadielUniqueDay() >= quest:getVar(player, 'Timer') and
                player:getFameLevel(xi.quest.fame_area.WINDURST) >= 2 and
                vars.Prog == 0
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Hiwon-Biwon'] = quest:progressEvent(171),

            onEventFinish =
            {
                [171] = function(player, csid, option, npc)
                    if quest:begin(player) then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },
    },

    -- Speak to Shantotto (K-8).
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and
            vars.Prog == 1
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Shantotto'] = quest:progressEvent(171),

            onEventFinish =
            {
                [171] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                    quest:setMustZone(player)
                end,
            },
        },
    },

    -- Speak to Shantotto again after zoning (K-8).
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and
            vars.Prog == 2 and
            not quest:getMustZone(player)
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Shantotto'] = quest:progressEvent(171),

            onEventFinish =
            {
                [171] = function(player, csid, option, npc)
                    if option == 3 then
                        quest:setVar(player, 'Prog', 3)
                        player:setTitle(xi.title.TARUTARU_MURDER_SUSPECT)
                    end
                end,
            },
        },
    },


    -- Shantotto asks you to bring her 2x Bomb Arms, Revival Tree Root, and Hiwon's Hair.
    -- To obtain Hiwon's Hair, speak to Hiwon-Biwon again.
        -- Speak to Shantotto again after zoning (K-8).
        {
            check = function(player, status, vars)
                return status == QUEST_ACCEPTED and
                vars.Prog == 2 and
                not quest:getMustZone(player)
            end,

            [xi.zone.WINDURST_WALLS] =
            {
                ['Shantotto'] = quest:progressEvent(171),

                onEventFinish =
                {
                    [171] = function(player, csid, option, npc)
                        if option == 3 then
                            quest:setVar(player, 'Prog', 3)
                            player:setTitle(xi.title.TARUTARU_MURDER_SUSPECT)
                        end
                    end,
                },
            },
        },


    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and
            vars.Prog == 3
        end,

        [xi.zone.WINDURST_WALLS] =
        {
            ['Hiwon-Biwon'] = quest:event(185):replaceDefault(),
        },
    },
}

return quest
