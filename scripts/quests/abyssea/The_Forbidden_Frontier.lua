-----------------------------------
-- The Forbidden Frontier
-----------------------------------
-- !addquest 8 166
-- Joachim : !pos -52.844 0 -9.978 246
-- Flag when any of A Goldstruck Gigas, To Paste a Peiste, Megadrile Menace started.
-- Complete when all three are completed and player talks to Joachim again.
-----------------------------------

local quest = Quest:new(xi.questLog.ABYSSEA, xi.quest.id.abyssea.THE_FORBIDDEN_FRONTIER)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                (
                    player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.A_GOLDSTRUCK_GIGAS) > xi.questStatus.QUEST_AVAILABLE or
                    player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.TO_PASTE_A_PEISTE) > xi.questStatus.QUEST_AVAILABLE or
                    player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.MEGADRILE_MENACE) > xi.questStatus.QUEST_AVAILABLE
                )
        end,

        [xi.zone.PORT_JEUNO] =
        {
            ['Joachim'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(331)
                end,
            },

            onEventFinish =
            {
                [331] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                player:hasCompletedQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.A_GOLDSTRUCK_GIGAS) and
                player:hasCompletedQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.TO_PASTE_A_PEISTE) and
                player:hasCompletedQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.MEGADRILE_MENACE)
        end,

        [xi.zone.PORT_JEUNO] =
        {
            ['Joachim'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(332)
                end,
            },

            onEventFinish =
            {
                [332] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
