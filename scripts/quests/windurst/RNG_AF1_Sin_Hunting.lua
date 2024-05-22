-----------------------------------
-- Sin Hunting (RNG AF1)
-----------------------------------
-- Log ID: 2, Quest ID: 72
-- Perih Vashai: !pos 117 -3 92 241
-- Perchond: !pos -182.844 4 -164.948 166
-- Alexis: !pos 105 1 382 104
-- qm2: !pos -10.946 -1.000 313.810 104
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.SIN_HUNTING)

quest.reward =
{
    item     = xi.item.SNIPING_BOW,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:getMainLvl() >= xi.settings.main.AF1_QUEST_LEVEL and
            player:getMainJob() == xi.job.RNG
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Perih_Vashai'] = quest:progressEvent(523),

            onEventFinish =
            {
                [523] = function(player, csid, option, npc)
                    quest:begin(player)
                    npcUtil.giveKeyItem(player, xi.ki.CHIEFTAINNESSS_TWINSTONE_EARRING)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Perih_Vashai'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') <= 3 then
                        return quest:event(524)
                    else
                        return quest:progressEvent(527)
                    end
                end,
            },

            ['Kapeh_Myohrye'] = quest:event(526),

            ['Muhk_Johldy'] = quest:event(525),

            onEventFinish =
            {
                [527] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.PERCHONDS_ENVELOPE)
                    end
                end,
            },
        },

        [xi.zone.RANGUEMONT_PASS] =
        {
            ['Perchond'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(3, 0, xi.item.PINCH_OF_GLITTERSAND)
                    elseif quest:getVar(player, 'Prog') == 2 then
                        return quest:event(6)
                    else
                        return quest:event(4, 0, xi.item.PINCH_OF_GLITTERSAND)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.item.PINCH_OF_GLITTERSAND) and
                        quest:getVar(player, 'Prog') == 1
                    then
                        return quest:progressEvent(5)
                    end
                end,
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [5] = function(player, csid, option, npc)
                    player:tradeComplete()
                    quest:setVar(player, 'Prog', 2)
                    npcUtil.giveKeyItem(player, xi.ki.PERCHONDS_ENVELOPE)
                end,
            },
        },

        [xi.zone.JUGNER_FOREST] =
        {
            ['Alexius'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(10)
                    elseif quest:getVar(player, 'Prog') == 3 then
                        return quest:event(11)
                    elseif quest:getVar(player, 'Prog') == 4 then
                        return quest:event(12)
                    end
                end,
            },

            ['qm2'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then -- Full moon requirement removed.
                        return quest:progressEvent(13, 0, xi.item.PINCH_OF_GLITTERSAND)
                    end
                end,
            },

            onEventFinish =
            {
                [10] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [13] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Perih_Vashai'] =
            {
                onTrigger = function(player, npc)
                    if player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.FIRE_AND_BRIMSTONE) == xi.questStatus.QUEST_AVAILABLE then
                        return quest:event(528):replaceDefault()--dialog changes after each quest in the series is completed.
                    end
                end,
            },

            ['Kapeh_Myohrye'] = quest:event(530):replaceDefault(),
            ['Muhk_Johldy']   = quest:event(529):replaceDefault(),
        },
    },
}

return quest
