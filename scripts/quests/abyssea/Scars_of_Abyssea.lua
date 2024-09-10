-----------------------------------
-- Scars of Abyssea
-----------------------------------
-- !addquest 8 175
-- Joachim : !pos -52.844 0 -9.978 246
-----------------------------------

local quest = Quest:new(xi.questLog.ABYSSEA, xi.quest.id.abyssea.SCARS_OF_ABYSSEA)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                (
                    player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.THE_BEAST_OF_BASTORE) > xi.questStatus.QUEST_AVAILABLE or
                    player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.A_DELECTABLE_DEMON) > xi.questStatus.QUEST_AVAILABLE or
                    player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.A_FLUTTERY_FIEND) > xi.questStatus.QUEST_AVAILABLE
                )
        end,

        [xi.zone.PORT_JEUNO] =
        {
            ['Joachim'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(337)
                end,
            },

            onEventFinish =
            {
                [337] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                player:hasCompletedQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.THE_BEAST_OF_BASTORE) and
                player:hasCompletedQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.A_DELECTABLE_DEMON) and
                player:hasCompletedQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.A_FLUTTERY_FIEND)
        end,

        [xi.zone.PORT_JEUNO] =
        {
            ['Joachim'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(338)
                end,
            },

            onEventFinish =
            {
                [338] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
