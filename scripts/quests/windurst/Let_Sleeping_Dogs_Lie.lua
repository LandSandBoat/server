-----------------------------------
-- Let Sleeping Dogs Lie
-----------------------------------
-- !addquest 2 46
-- Mashuu-Ajuu     !gotoid 17752125
-- Paku-Nakku      !gotoid 17752127
-- Maabu-Sonbu     !gotoid 17760275
-- ??? QM 1        !gotoid 17224342
-- Pechiru-Mashiru !gotoid 17752116
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.LET_SLEEPING_DOGS_LIE)

quest.reward =
{
    item = xi.item.HYPNO_STAFF,
    fame = 75,
    fameArea = xi.fameArea.WINDURST,
    title = xi.title.SPOILSPORT,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.WINDURST) >= 4 and
                player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.REAP_WHAT_YOU_SOW) ~= xi.questStatus.QUEST_ACCEPTED and
                player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.MAKING_THE_GRADE) ~= xi.questStatus.QUEST_ACCEPTED and
                player:getCurrentMission(xi.mission.log_id.WINDURST) ~= xi.mission.id.windurst.VAIN
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Mashuu-Ajuu'] = quest:event(483),

            ['Paku-Nakku'] = quest:progressEvent(481),

            onEventFinish =
            {
                [481] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Mashuu-Ajuu'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:event(501)
                    else
                        return quest:event(483)
                    end
                end,
            },

            ['Akkeke'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:event(502)
                    else
                        return quest:event(484)
                    end
                end,
            },

            ['Kirarara'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:event(503)
                    else
                        return quest:event(485)
                    end
                end,
            },

            ['Foi-Mui'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:event(504)
                    else
                        return quest:event(486)
                    end
                end,
            },

            ['Rukuku'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:event(505)
                    else
                        return quest:event(487)
                    end
                end,
            },

            ['Koko_Lihzeh'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:event(506)
                    else
                        return quest:event(488)
                    end
                end,
            },

            ['Chomoro-Kyotoro'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:event(501)
                    else
                        return quest:event(489)
                    end
                end,
            },

            ['Paku-Nakku'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.item.BUNCH_OF_BLAZING_PEPPERS) and
                        quest:getVar(player, 'Prog') == 1
                    then
                        return quest:progressEvent(494)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(499)
                    elseif quest:getVar(player, 'Prog') == 4 then
                        return quest:event(500)
                    else
                        return quest:event(482)
                    end
                end,
            },

            ['Pechiru-Mashiru'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(495, 0, xi.item.REMEDY, xi.item.BUNCH_OF_BLAZING_PEPPERS, 1)
                    elseif quest:getVar(player, 'Prog') == 3 then
                        return quest:event(496)
                    elseif quest:getVar(player, 'Prog') == 4 then
                        return quest:progressEvent(497)
                    end
                end,
            },

            onEventFinish =
            {
                [494] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [495] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [497] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        quest.setMustZone(player)
                    end
                end,

                [499] = function(player, csid, option, npc)
                    if option == 2 then
                        quest:setVar(player, 'Prog', 4)
                    end
                end,
            },
        },

        [xi.zone.PORT_WINDURST] =
        {
            ['Maabu-Sonbu'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(319, 0, xi.item.REMEDY, xi.item.BUNCH_OF_BLAZING_PEPPERS, xi.item.SICKLE)
                    elseif quest:getVar(player, 'Prog') == 2 then
                        return quest:event(321, 0, xi.item.BUNCH_OF_BLAZING_PEPPERS)
                    else
                        return quest:event(320, 0, xi.item.REMEDY, xi.item.BUNCH_OF_BLAZING_PEPPERS, xi.item.SICKLE)
                    end
                end,
            },

            onEventFinish =
            {
                [319] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.PASHHOW_MARSHLANDS] =
        {
            ['qm1'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.SICKLE) then
                        local chance = math.random(1, 5)
                        if chance <= 2 then
                            player:addItem(xi.item.BUNCH_OF_BLAZING_PEPPERS)
                            return player:startEvent(12, xi.item.BUNCH_OF_BLAZING_PEPPERS, 0, 0, xi.item.BUNCH_OF_BLAZING_PEPPERS)-- successful no break
                        elseif chance == 3 then
                            player:addItem(xi.item.BUNCH_OF_BLAZING_PEPPERS)
                            player:confirmTrade()
                            return player:startEvent(12, xi.item.BUNCH_OF_BLAZING_PEPPERS, 1, 0, xi.item.BUNCH_OF_BLAZING_PEPPERS) -- successful but breaks
                        elseif chance == 4 then
                            player:confirmTrade()
                            return player:startEvent(12, 0, 1, 0) -- unsuccessful and breaks
                        elseif chance == 5 then
                            return player:startEvent(12, 0, 0, 0) -- unsuccessful and no break
                        end
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Chomoro-Kyotoro'] =
            {
                onTrigger = function(player, npc)
                    if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.HAT_IN_HAND) ~= xi.questStatus.QUEST_ACCEPTED then
                        quest:event(498)
                    end
                end,
            },

            ['Mashuu-Ajuu'] = {
                onTrigger = function(player, npc)
                    if quest.getMustZone(player) then
                        quest:event(501)
                    end
                end,
            },

            ['Paku-Nakku'] = {
                onTrigger = function(player, npc)
                    if quest.getMustZone(player) then
                        quest:event(500)
                    end
                end,
            }
        }
    },
}

return quest
