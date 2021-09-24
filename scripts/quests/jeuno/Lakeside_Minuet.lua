-----------------------------------
-- Lakeside Minuet
-----------------------------------
-- !addquest 3 95
-- Laila           : !pos -54.045 -1 100.996 244
-- Rhea Myuliah    : !pos -56.220 -1 101.805 244
-- Valderotaux     : !pos 97 0.1 113 230
-- Glowing Pebbles : !pos 104.2 4.1 443.6 82
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/settings/main')
require('scripts/globals/status')
require('scripts/globals/titles')
require('scripts/globals/zone')
-----------------------------------
local upperJeunoID = require('scripts/zones/Upper_Jeuno/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.LAKESIDE_MINUET)

quest.reward =
{
    fame = 30,
    title = xi.title.TROUPE_BRILIOTH_DANCER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainLvl() >= xi.settings.ADVANCED_JOB_LEVEL and
                xi.settings.ENABLE_WOTG == 1
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Laila'] = quest:progressEvent(10111),

            onEventFinish =
            {
                [10111] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Laila'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.STARDUST_PEBBLE) then
                        return quest:progressEvent(10118)
                    else
                        -- TODO: Verify CS events for Laila for other mission statuses.  Original
                        -- code had event 10113 for quest progress 3; however, that is incorrect.
                        return quest:progressEvent(10112)
                    end
                end,
            },

            ['Rhea_Myuliah'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(10113)
                    elseif questProgress == 1 then
                        return quest:progressEvent(10114)
                    elseif questProgress == 2 then
                        return quest:progressEvent(10115)
                    elseif questProgress >= 3 then
                        return quest:progressEvent(10116)
                    end
                end,
            },

            onEventFinish =
            {
                [10113] = function(player, csid, option, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [10115] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [10118] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:unlockJob(xi.job.DNC)
                        player:messageSpecial(upperJeunoID.text.UNLOCK_DANCER)
                        player:delKeyItem(xi.ki.STARDUST_PEBBLE)
                        player:needToZone(true)
                    end
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Valderotaux'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 1 then
                        return quest:progressEvent(888)
                    elseif questProgress >= 2 then
                        return quest:progressEvent(889)
                    end
                end,
            },

            onEventFinish =
            {
                [888] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.JUGNER_FOREST_S] =
        {
            ['Glowing_Pebbles'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 3 and
                        not player:hasKeyItem(xi.ki.STARDUST_PEBBLE)
                    then
                        return quest:progressEvent(100)
                    end
                end,
            },

            onEventFinish =
            {
                [100] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.STARDUST_PEBBLE)
                end,
            }
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and player:needToZone()
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Laila'] = quest:progressEvent(10119),
        },
    },
}

return quest
