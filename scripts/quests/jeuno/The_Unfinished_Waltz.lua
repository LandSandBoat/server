-----------------------------------
-- The Unfinished Waltz
-----------------------------------
-- !addquest 3 96
-- Laila : !pos -54.045 -1 100.996 244
-- qm1   : !pos -157.16 -8 596.9 89
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/status')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/settings')
-----------------------------------
local graubergID = require("scripts/zones/Grauberg_[S]/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_UNFINISHED_WALTZ)

quest.reward =
{
    item  = xi.items.WAR_HOOP,
    title = xi.title.PROMISING_DANCER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainJob() == xi.job.DNC and
                player:getMainLvl() >= xi.settings.main.AF1_QUEST_LEVEL
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Laila'] = quest:progressEvent(10129),

            onEventFinish =
            {
                [10129] = function(player, csid, option, npc)
                    quest:begin(player)
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
                    if player:seenKeyItem(xi.ki.THE_ESSENCE_OF_DANCE) then
                        return quest:progressEvent(10133)
                    else
                        return quest:progressEvent(10130)
                    end
                end,
            },

            ['Rhea_Myuliah'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(10131)
                    else
                        return quest:progressEvent(10132)
                    end
                end,
            },

            onEventFinish =
            {
                [10131] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [10133] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        -- Set mustZone and Timer for "The Road to Divadom" Quest

                        player:setCharVar('Quest[3][97]Timer', VanadielUniqueDay() + 1)
                        player:setLocalVar('Quest[3][97]mustZone', 1)
                    end
                end,
            },
        },

        [xi.zone.GRAUBERG_S] =
        {
            ['qm1'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasKeyItem(xi.ki.THE_ESSENCE_OF_DANCE) and
                        quest:getVar(player, 'Prog') == 1
                    then
                        local hippoEvent = quest:getLocalVar(player, 'hippoEvent')

                        if
                            hippoEvent == 0 and
                            player:getMainJob() == xi.job.DNC
                        then
                            return quest:progressEvent(12)
                        elseif
                            hippoEvent == 1 and
                            not GetMobByID(graubergID.mob.MIGRATORY_HIPPOGRYPH):isSpawned()
                        then
                            SpawnMob(graubergID.mob.MIGRATORY_HIPPOGRYPH):updateEnmity(player)
                            return quest:messageSpecial(graubergID.text.A_SHIVER_RUNS_DOWN)
                        elseif hippoEvent == 2 then
                            return quest:progressEvent(13)
                        else
                            return quest:messageSpecial(graubergID.text.ATTEND_TO_MORE_PRESSING)
                        end
                    end
                end,
            },

            ['Migratory_Hippogryph'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if
                        quest:getLocalVar(player, 'hippoEvent') == 1
                    then
                        quest:setLocalVar(player, 'hippoEvent', 2)
                    end
                end,
            },

            onEventFinish =
            {
                [12] = function(player, csid, option, npc)
                    quest:setLocalVar(player, 'hippoEvent', 1)
                end,

                [13] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.THE_ESSENCE_OF_DANCE)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and
                not player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_ROAD_TO_DIVADOM)
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Laila']        = quest:event(10134):replaceDefault(),
            ['Rhea_Myuliah'] = quest:event(10135):replaceDefault(),
        },
    },
}

return quest
