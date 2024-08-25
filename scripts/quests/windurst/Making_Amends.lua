-----------------------------------
-- Making Amends
-----------------------------------
-- Log ID: 2, Quest ID: 3
-- Hakkuru-Rinkuru : !pos -111 -4 101 240
-- Kuroido-Moido   : !pos -112 -4 103 240
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.MAKING_AMENDS)

quest.reward =
{
    fame     = 75,
    fameArea = xi.fameArea.WINDURST,
    title    = xi.title.QUICK_FIXER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            local horutotoRuinsExperimentNotActive = player:getCurrentMission(xi.mission.log_id.WINDURST) ~= xi.mission.id.windurst.THE_HORUTOTO_RUINS_EXPERIMENT
            local saintlyInvitationBCNMNotActive = player:getCurrentMission(xi.mission.log_id.WINDURST) == xi.mission.id.windurst.SAINTLY_INVITATION and player:getMissionStatus(xi.mission.log_id.WINDURST) > 1
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.WINDURST) >= 2 and
                horutotoRuinsExperimentNotActive and -- Player cannot accept quest during Horutoto Ruins Experiment Mission
                saintlyInvitationBCNMNotActive -- Player cannot accept quest if on Saintly Invitation Mission BCNM
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Hakkuru-Rinkuru'] = quest:progressEvent(274, 0, xi.item.BLOCK_OF_ANIMAL_GLUE),

            onEventFinish =
            {
                [274] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Hakkuru-Rinkuru'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.BLOCK_OF_ANIMAL_GLUE) then
                        return quest:event(277, 1500 * xi.settings.main.GIL_RATE)
                    else
                        return quest:event(275, 0, xi.item.BLOCK_OF_ANIMAL_GLUE)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(275, 0, xi.item.BLOCK_OF_ANIMAL_GLUE)
                end,
            },

            ['Kuroido-Moido'] = quest:event(276),

            onEventFinish =
            {
                [277] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:needToZone(true)
                        player:confirmTrade()
                        player:addGil(1500 * xi.settings.main.GIL_RATE) -- CS includes gil message so we add here instead of through reward
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Kuroido-Moido'] = quest:event(279):importantOnce(),
        },
    },
}

return quest
