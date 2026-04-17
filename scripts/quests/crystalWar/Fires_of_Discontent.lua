-----------------------------------
-- Fires of Discontent
-----------------------------------
-- !addquest 7 13
-- Engelhart    : !pos -80.085 -4.425 -125.327 87
-- Pagdako      : !pos -202.080 -6.000 -93.928 87
-- Iron Eater   : !pos 92.936 -19.532 1.814 237
-- qm5          : !pos 259.793 33.192 515.257 89
-- Gentle Tiger : !pos -203.932 -9.998 2.237 87
-----------------------------------

local quest = Quest:new(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.FIRES_OF_DISCONTENT)

quest.reward =
{
    gil = 10000,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.BETTER_PART_OF_VALOR)
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Engelhart'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(120)
                end,
            },

            onEventFinish =
            {
                [120] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Engelhart'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress < 2 then
                        return quest:event(121)
                    elseif questProgress == 2 then
                        return quest:progressEvent(124)
                    elseif questProgress == 3 then
                        return quest:event(125)
                    elseif questProgress == 4 then
                        return quest:progressEvent(126)
                    elseif questProgress == 5 then
                        return quest:event(127)
                    elseif questProgress == 6 then
                        return quest:progressEvent(164)
                    end
                end,
            },

            ['Pagdako'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(122)
                    else
                        return quest:event(123)
                    end
                end,
            },

            ['Gentle_Tiger'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 5 then
                        return quest:progressEvent(160)
                    else
                        return quest:event(161)
                    end
                end,
            },

            onEventFinish =
            {
                [122] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [124] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [126] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                end,

                [160] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 6)
                end,

                [164] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Iron_Eater'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(956)
                    else
                        return quest:event(957)
                    end
                end,
            },

            onEventFinish =
            {
                [956] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.GRAUBERG_S] =
        {
            ['qm5'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(11)
                    end
                end,
            },

            onEventFinish =
            {
                [11] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Engelhart'] = quest:event(165):replaceDefault(),
        },
    },
}

return quest
