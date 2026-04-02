-----------------------------------
-- Legacies Lost and Found
-- RUN AF Quest 4
-- !addquest 9 24
-- Octavien : !pos 100.580 -40.150 -63.830 257
-- Reward: Runeist Trousers
-- NOTE: Simplified from retail. Retail requires visiting Strange Apparatuses
--       and answering trivia. This version just requires visiting Ohruru in
--       Port Windurst and returning.
-----------------------------------

local quest = Quest:new(xi.questLog.ADOULIN, xi.quest.id.adoulin.LEGACIES_LOST_AND_FOUND)

quest.reward =
{
    fameArea = xi.fameArea.ADOULIN,
    item     = xi.item.RUNEIST_TROUSERS,
    fame     = 30,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.FORGING_NEW_BONDS) == xi.questStatus.QUEST_COMPLETED and
                player:getMainJob() == xi.job.RUN
        end,

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Octavien'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Octavien: I need you to research the history of runic enhancement.', xi.msg.channel.NS_SAY)
                    player:printToPlayer('Octavien: Visit Ohruru at the Orastery in Port Windurst.', xi.msg.channel.NS_SAY)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                vars.Prog == 0
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Ohruru'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Ohruru: Runic enhancement, you say? I have ancient texts on the subject.', xi.msg.channel.NS_SAY)
                    player:printToPlayer('Ohruru: Take this knowledge back to Octavien.', xi.msg.channel.NS_SAY)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Octavien'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Octavien: Visit Ohruru at the Orastery in Port Windurst.', xi.msg.channel.NS_SAY)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                vars.Prog == 1
        end,

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Octavien'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Octavien: Excellent research! The secrets of runic enhancement are becoming clearer.', xi.msg.channel.NS_SAY)
                    player:printToPlayer('Octavien: Take these Runeist Trousers. They were forged using this knowledge.', xi.msg.channel.NS_SAY)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
