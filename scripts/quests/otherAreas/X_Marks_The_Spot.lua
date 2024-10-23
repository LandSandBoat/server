-----------------------------------
-- X Marks the Spot
-----------------------------------
-- Log ID: 4, Quest ID: 65
-----------------------------------
-- CoP Mission 2-5 Ancient Vows Completed
-- !addmission 6 258
-----------------------------------
-- Tavnazian Safehold       !zone 26
-- Despachiaire             !pos 111.2090 -40.0148 -85.4810
-- Parelbriaux              !pos 113.701 -41 42.3653
-- Odeya                    !pos 83.3227 -34.25 -70.0384
-- Phomiuna Aqueducts       !zone 27
-- Hidden Hallway 2nd Gate  !pos 138.1027 -24 60.3209
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.X_MARKS_THE_SPOT)

quest.reward =
{
    gil = 4000,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
            player:getCurrentMission(xi.mission.log_id.COP) > xi.mission.id.cop.ANCIENT_VOWS
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Despachiaire'] = quest:progressEvent(144),

            onEventFinish =
            {
                [144] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            -- Will repeat until the quest is completed.
            ['Despachiaire'] = quest:progressEvent(144),

            ['Parelbriaux'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') <= 1 then
                        return quest:progressEvent(145)
                    end
                end,
            },

            ['Odeya'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(141, 0, xi.item.TAVNAZIAN_LIVER)
                    elseif quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(146, 0, xi.item.TAVNAZIAN_LIVER)
                    elseif quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(147)
                    elseif quest:getVar(player, 'Prog') == 4 then
                        return quest:progressEvent(143)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        npcUtil.tradeHasExactly(trade, { { xi.item.TAVNAZIAN_LIVER, 1 } })
                    then
                        return quest:progressEvent(142)
                    end
                end,
            },

            onEventFinish =
            {
                [145] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [141] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [142] = function(player, csid, option, npc)
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 3)
                end,

                [143] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.PHOMIUNA_AQUEDUCTS] =
        {
            ['_0r9'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(37)
                end,
            },

            onEventFinish =
            {
                [37] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },
    },
}

return quest
