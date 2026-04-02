-----------------------------------
-- The Bloodline of Zacariah
-- GEO AF Quest 4
-- !addquest 9 37
-- Sylvie          : !pos 78.094 32.000 135.725 256
-- Overgrown_Grave : !pos 455.093 9.880 102.513 270
-- Reward: Geomancy Mitaines
-----------------------------------

local quest = Quest:new(xi.questLog.ADOULIN, xi.quest.id.adoulin.THE_BLOODLINE_OF_ZACARIAH)

quest.reward =
{
    fameArea = xi.fameArea.ADOULIN,
    item     = xi.item.GEOMANCY_MITAINES,
    fame     = 30,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.FOR_WHOM_THE_BELL_TOLLS) == xi.questStatus.QUEST_COMPLETED and
                player:getMainJob() == xi.job.GEO
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Sylvie'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Sylvie: I have been researching the geomantic bloodlines of Ulbuka.', xi.msg.channel.NS_SAY)
                    player:printToPlayer('Sylvie: Could you bring me 3 Acuex Ore? I need them for my research.', xi.msg.channel.NS_SAY)
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

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Sylvie'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.item.ACUEX_ORE, 3 } }) then
                        player:confirmTrade()
                        player:printToPlayer('Sylvie: Thank you! Now please visit the Overgrown Grave in Cirdas Caverns.', xi.msg.channel.NS_SAY)
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                onTrigger = function(player, npc)
                    player:printToPlayer('Sylvie: Please bring me 3 Acuex Ore.', xi.msg.channel.NS_SAY)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                vars.Prog == 1
        end,

        [xi.zone.CIRDAS_CAVERNS] =
        {
            ['Overgrown_Grave'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('You examine the overgrown grave... Ancient geomantic inscriptions are carved into the stone.', xi.msg.channel.NS_SAY)
                    player:printToPlayer('The inscriptions describe the bloodline of Zacariah, a master geomancer.', xi.msg.channel.NS_SAY)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Sylvie'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Sylvie: Visit the Overgrown Grave in Cirdas Caverns (M-8).', xi.msg.channel.NS_SAY)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                vars.Prog == 2
        end,

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Sylvie'] =
            {
                onTrigger = function(player, npc)
                    player:printToPlayer('Sylvie: You found the inscriptions! This confirms the ancient geomantic traditions.', xi.msg.channel.NS_SAY)
                    player:printToPlayer('Sylvie: Please take these Geomancy Mitaines as thanks.', xi.msg.channel.NS_SAY)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
