-----------------------------------
-- Wild Card
--
-- Honoi-Gumoi: !pos -195 -11 -120 238
-----------------------------------
require('scripts/globals/items')
require("scripts/globals/keyitems")
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/interaction/quest')

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WILD_CARD)

quest.reward =
{
    fame     = 10,
    fameArea = xi.quest.fame_area.WINDURST,
    title    = xi.title.DREAM_DWELLER,
}

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CRYING_OVER_ONIONS)
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Honoi-Gomoi'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getMainLvl() >= 5 and
                        player:getFameLevel(xi.quest.fame_area.WINDURST) >= 5 and
                        not quest:getMustZone(player)
                    then
                        return quest:progressEvent(780) -- Quest starting event.
                    else
                        return quest:event(779) -- Default text.
                    end
                end,
            },

            onEventFinish =
            {
                [780] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Section: Quest accepeted.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Kohlo-Lakolo'] = quest:progressEvent(545),
            ['Papo-Hopo']    = quest:event(509),

            onEventFinish =
            {
                [545] = function(player, csid, option, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['_6n2'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then -- First meeting at house of hero.
                        if player:getRank(xi.nation.WINDURST) < 9 then
                            return quest:progressEvent(386) -- Meet Joker.
                        else
                            return quest:progressEvent(388) -- Meet Apururu.
                        end
                    elseif player:hasKeyItem(xi.ki.JOKER_CARD) then -- Second meeting at house of hero.
                        if player:getRank(xi.nation.WINDURST) < 9 then
                            return quest:progressEvent(387, 0, xi.ki.JOKER_CARD) -- Meet Joker after meeting Joker first.
                        else
                            return quest:progressEvent(389) -- Meet Apururu after meeting Joker first.
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [386] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3) -- 3 = Met Joker. Sets 2nd CS in Windurst Walls with either Joker or Apururu.
                end,

                [387] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.JOKER_CARD)
                    npcUtil.giveCurrency(player, 'gil', 8000)
                    quest:setVar(player, 'Prog', 5)
                end,

                [388] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4) -- 4 = Met Apururu. Sets 2nd CS in Windurst Woods with Apururu.
                end,

                [389] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.JOKER_CARD)
                    npcUtil.giveCurrency(player, 'gil', 8000)
                    quest:setVar(player, 'Prog', 5)
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Honoi-Gomoi'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 5 then
                        return quest:progressEvent(782) -- Quest Complete.
                    else
                        return quest:event(781) -- Reminder text.
                    end
                end,
            },

            onEventFinish =
            {
                [782] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:setLocalVar('[2][78]mustZone', 1)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Apururu'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:progressEvent(600) -- 2nd meeting with Apururu after meeting him in Hero's hause.
                    end
                end,
            },

            onEventFinish =
            {
                [600] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.JOKER_CARD)
                    npcUtil.giveCurrency(player, 'gil', 8000)
                    quest:setVar(player, 'Prog', 5)
                end,
            },
        },
    },

    -- Section: Quest completed.
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Honoi-Gomoi'] = quest:event(783):replaceDefault(),
        },
    },
}

return quest
