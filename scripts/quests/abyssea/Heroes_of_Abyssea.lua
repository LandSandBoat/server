-----------------------------------
-- Heroes of Abyssea
-----------------------------------
-- !addquest 8 179
-- Joachim : !pos -52.844 0 -9.978 246
-- Flag when any of An Ulcerous Uragnite, A Beaked Blusterer, A Man-eating Mite started.
-- Complete when all three are completed and player talks to Joachim again.
-----------------------------------

local quest = Quest:new(xi.questLog.ABYSSEA, xi.quest.id.abyssea.HEROES_OF_ABYSSEA)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                (
                    player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.AN_ULCEROUS_URAGNITE) > xi.questStatus.QUEST_AVAILABLE or
                    player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.A_BEAKED_BLUSTERER) > xi.questStatus.QUEST_AVAILABLE or
                    player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.A_MAN_EATING_MITE) > xi.questStatus.QUEST_AVAILABLE
                )
        end,

        [xi.zone.PORT_JEUNO] =
        {
            ['Joachim'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(340)
                end,
            },

            onEventFinish =
            {
                [340] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                player:hasCompletedQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.AN_ULCEROUS_URAGNITE) and
                player:hasCompletedQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.A_BEAKED_BLUSTERER) and
                player:hasCompletedQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.A_MAN_EATING_MITE)
        end,

        [xi.zone.PORT_JEUNO] =
        {
            ['Joachim'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(341)
                end,
            },

            onEventFinish =
            {
                [341] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
