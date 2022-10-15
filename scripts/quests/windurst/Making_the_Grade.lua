-----------------------------------
-- Making the Grade
-----------------------------------
-- Log ID: 2, Quest ID: 4
-- Fuepepe         : !pos 161 -2 161 238
-- Koru-Moru       : !pos -120 -6 124 239
-- Chomoro-Kyotoro : !pos 133 -5 167 238
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MAKING_THE_GRADE)

quest.reward =
{
    fame     = 75,
    fameArea = xi.quest.fame_area.WINDURST,
    item     = xi.items.SCROLL_OF_ASPIR,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TEACHERS_PET) and
                player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.LET_SLEEPING_DOGS_LIE) ~= QUEST_ACCEPTED and
                player:getFameLevel(xi.quest.fame_area.WINDURST) >= 3
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Fuepepe'] = quest:progressEvent(442),

            onEventFinish =
            {
                [442] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Chomoro-Kyotoro'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:event(454)
                    elseif questProgress == 1 then
                        return quest:event(457)
                    elseif questProgress == 2 then
                        return quest:progressEvent(460)
                    else
                        return quest:event(461)
                    end
                end,
            },

            ['Fuepepe'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.PILE_OF_ANSWER_SHEETS) and
                        quest:getVar(player, 'Prog') == 0
                    then
                        return quest:progressEvent(455)
                    end
                end,

                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:event(443)
                    elseif questProgress == 1 then
                        return quest:event(456)
                    elseif questProgress >= 2 then
                        return quest:event(458)
                    end
                end,
            },

            ['Akkeke']          = quest:event(453),
            ['Foi-Mui']         = quest:event(449),
            ['Kirarara']        = quest:event(447),
            ['Koko_Lihzeh']     = quest:event(451),
            ['Mashuu-Ajuu']     = quest:event(448),
            ['Moreno-Toeno']    = quest:event(444),
            ['Paku-Nakku']      = quest:event(452),
            ['Pechiru-Mashiru'] = quest:event(445),
            ['Rukuku']          = quest:event(450),
            ['Tauwawa']         = quest:event(446),

            onEventFinish =
            {
                [455] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [458] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        quest:setMustZone(player)
                    end
                end,

                [460] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.TATTERED_TEST_SHEET)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Koru-Moru'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.PILE_OF_ANSWER_SHEETS) then
                        if quest:getVar(player, 'Prog') == 1 then
                            return quest:progressEvent(285)
                        else
                            return quest:event(287)
                        end
                    end
                end,

                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if
                        questProgress == 0 and
                        player:hasItem(xi.items.PILE_OF_ANSWER_SHEETS)
                    then
                        return quest:event(287)
                    elseif questProgress >= 2 then
                        return quest:event(286)
                    end
                end,
            },

            onEventFinish =
            {
                [285] = function(player, csid, option, npc)
                    player:confirmTrade()

                    npcUtil.giveKeyItem(player, xi.ki.TATTERED_TEST_SHEET)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and
                not quest:getMustZone(player)
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Fuepepe'] = quest:event(459):importantEvent(),
        },
    },
}

return quest
