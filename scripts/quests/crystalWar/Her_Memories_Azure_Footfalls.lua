-----------------------------------
-- Her Memories: Azure Footfalls
-----------------------------------
-- !addquest 7 70
-- Adelbrecht       : !pos -325.8 -12.6 -77.0 87
-- Gebhardt         : !pos 206.3 -20.8 669.1 88
-- Roderich         : !pos -400.0 40.0 -90.4 88
-- Barricade        : !pos -515.0 38.0 583.3 88
-----------------------------------
require('scripts/missions/wotg/helpers')
-----------------------------------

local quest = Quest:new(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.HER_MEMORIES_AZURE_FOOTFALLS)

quest.reward =
{
    keyItem = xi.ki.LARGE_MEMORY_FRAGMENT4,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getCurrentMission(xi.mission.log_id.WOTG) == xi.mission.id.wotg.HER_MEMORIES and
                player:getCampaignAllegiance() == 2
        end,

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Adelbrecht'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(359)
                    end
                end,
            },

            onZoneIn = function(player, prevZone)
                if
                    prevZone == xi.zone.NORTH_GUSTABERG_S and
                    quest:getVar(player, 'Prog') == 0
                then
                    return 358
                end
            end,

            onEventFinish =
            {
                [358] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [359] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.NORTH_GUSTABERG_S] =
        {
            ['Gebhardt'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(14)
                    end
                end,
            },

            ['Roderich'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(15)
                    end
                end,
            },

            ['Barricade'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:progressEvent(16)
                    end
                end,
            },

            onEventFinish =
            {
                [14] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [15] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,

                [16] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                end,
            },
        },

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Adelbrecht'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 5 then
                        return quest:progressEvent(360)
                    end
                end,
            },

            onEventFinish =
            {
                [360] = function(player, csid, option, npc)
                    quest:complete(player)
                    xi.wotg.helpers.checkMemoryFragments(player)
                end,
            },
        },

    },
}

return quest
