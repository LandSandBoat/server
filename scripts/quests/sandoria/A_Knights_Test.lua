-----------------------------------
-- A Knight's Test
-----------------------------------
-- Log ID: 0, Quest ID: 29
-- Balasiel     : !pos -136 -11 64 230
-- Cahaurme     : !pos 55.749 -8.601 -29.354 230
-- Baunise      : !pos -55 -8 -32 230
-- Disused Well : !pos -221 2 -293 149
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local davoiID            = require('scripts/zones/Davoi/IDs')
local southernSandoriaID = require('scripts/zones/Southern_San_dOria/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_KNIGHTS_TEST)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    item     = xi.items.KITE_SHIELD,
    keyItem  = xi.ki.JOB_GESTURE_PALADIN,
    title    = xi.title.TRIED_AND_TESTED_KNIGHT,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_SQUIRES_TEST_II)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Balasiel'] =
            {
                onTrigger = function(player, npc)
                    if player:getMainLvl() >= xi.settings.main.ADVANCED_JOB_LEVEL then
                        if quest:getVar(player, 'Option') == 0 then
                            return quest:progressEvent(627)
                        else
                            return quest:progressEvent(635)
                        end
                    else
                        return quest:event(670)
                    end
                end,
            },

            onEventFinish =
            {
                [627] = function(player, csid, option, npc)
                    if option == 0 then
                        npcUtil.giveKeyItem(player, xi.ki.BOOK_OF_TASKS)
                        quest:begin(player)
                    else
                        quest:setVar(player, 'Option', 1)
                    end
                end,

                [635] = function(player, csid, option, npc)
                    if option == 0 then
                        npcUtil.giveKeyItem(player, xi.ki.BOOK_OF_TASKS)
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

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Balasiel'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.KNIGHTS_SOUL) then
                        return quest:progressEvent(628)
                    else
                        return quest:event(669)
                    end
                end,
            },

            ['Baunise'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.BOOK_OF_THE_WEST) then
                        return quest:progressEvent(634)
                    else
                        return quest:messageName(southernSandoriaID.text.DO_NOT_FRET)
                    end
                end,
            },

            ['Cahaurme'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.BOOK_OF_THE_EAST) then
                        return quest:progressEvent(633)
                    else
                        return quest:messageName(southernSandoriaID.text.TRIAL_IS_DIFFICULT)
                    end
                end,
            },

            onEventFinish =
            {
                [628] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:unlockJob(xi.job.PLD)
                        player:messageSpecial(southernSandoriaID.text.UNLOCK_PALADIN)

                        player:delKeyItem(xi.ki.KNIGHTS_SOUL)
                        player:delKeyItem(xi.ki.BOOK_OF_TASKS)
                        player:delKeyItem(xi.ki.BOOK_OF_THE_WEST)
                        player:delKeyItem(xi.ki.BOOK_OF_THE_EAST)
                    end
                end,

                [633] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.BOOK_OF_THE_EAST)
                end,

                [634] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.BOOK_OF_THE_WEST)
                end,
            },
        },

        [xi.zone.DAVOI] =
        {
            ['Disused_Well'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.BOOK_OF_THE_EAST) and
                        player:hasKeyItem(xi.ki.BOOK_OF_THE_WEST)
                    then
                        if not player:hasKeyItem(xi.ki.KNIGHTS_SOUL) then
                            return quest:keyItem(xi.ki.KNIGHTS_SOUL)
                        else
                            return quest:messageSpecial(davoiID.text.YOU_FIND_NOTHING)
                        end
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Baunise']  = quest:messageName(southernSandoriaID.text.YOUVE_DONE_WELL):replaceDefault(),
            ['Cahaurme'] = quest:messageName(southernSandoriaID.text.MAKE_EXCELLENT_KNIGHT):replaceDefault(),
        },
    },
}

return quest
