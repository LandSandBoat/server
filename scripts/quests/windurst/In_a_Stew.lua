-----------------------------------
-- In a Stew
-----------------------------------
-- Log ID: 2, Quest ID: 45
-- Kuoh Rhel   : !pos 131.437 -6 -102.723
-- Matata      : !pos 131 -5 -109
-- Ranpi-Monpi : !pos -116 -3 52
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.IN_A_STEW)

quest.reward =
{
    gil = 900,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return vars.Prog == 0 and
            vars.Wait < NextConquestTally() and
            player:hasCompletedQuest(xi.questLog.WINDURST, xi.quest.id.windurst.CHOCOBILIOUS) and
            player:getFameLevel(xi.fameArea.WINDURST) >= 2 and
            not xi.quest.getMustZone(player, xi.questLog.WINDURST, xi.quest.id.windurst.CHOCOBILIOUS)
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Kuoh_Rhel'] =
            {
                onTrigger = function(player, npc)
                    if player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.IN_A_STEW) == xi.questStatus.QUEST_AVAILABLE then
                        return quest:progressEvent(235)
                    else
                        return quest:progressEvent(234) -- Repeat after conquest tally
                    end
                end,
            },

            onEventFinish =
            {
                [234] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [235] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return vars.Prog >= 1
        end,

        [xi.zone.WINDURST_WOODS] =
        {
            ['Kuoh_Rhel'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(239)
                    else
                        return quest:event(236) -- Reminder
                    end
                end,
            },

            ['Matata'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(237) -- Gives the player a hint to talk to Ranpi-Monpi
                end,
            },

            onEventFinish =
            {
                [239] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        quest:setMustZone(player)
                        player:delKeyItem(xi.ki.RANPI_MONPIS_SPECIAL_STEW)
                        quest:setVar(player, 'Wait', NextConquestTally())
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ranpi-Monpi'] =
            {
                onTrigger = function(player, npc)
                    local optional = quest:getVar(player, 'Option')

                    if player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.A_CRISIS_IN_THE_MAKING) ~= xi.questStatus.QUEST_ACCEPTED then -- The player CANNOT have the quest "A Crisis in the Making" Active or Ranpi will not talk to you about this quest
                        if quest:getVar(player, 'Prog') == 2 then
                            return quest:event(557) -- Reminder to finish quest
                        elseif
                            optional == 1 or
                            player:hasCompletedQuest(xi.questLog.WINDURST, xi.quest.id.windurst.CHOCOBILIOUS)
                        then
                            return quest:event(555, 0, xi.item.WOOZYSHROOM) -- Reminder to get Woozyshrooms
                        elseif optional == 0 then
                            return quest:event(554, 0, xi.item.WOOZYSHROOM) -- Requests 3x Woozyshrooms. Only plays the first time the player does the quest
                        end
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.WOOZYSHROOM, 3 } }) then
                        return quest:progressEvent(556)
                    end
                end,
            },

            onEventFinish =
            {
                [554] = function(player, csid, option, npc)
                    quest:setVar(player, 'Option', 1)
                end,

                [556] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.RANPI_MONPIS_SPECIAL_STEW)
                    quest:setVar(player, 'Prog', 2)
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
            ['Kuoh_Rhel'] =
            {
                onTrigger = function(player, npc)
                    if quest:getMustZone(player) then
                        return quest:event(240)
                    end
                end,
            },

            ['Matata'] =
            {
                onTrigger = function(player, npc)
                    if quest:getMustZone(player) then
                        return quest:event(241)
                    end
                end,
            },
        },
    },
}

return quest
