-----------------------------------
--  A Knights Test
--  NPC: Balasiel
--  !pos -136 -11 64 230
--  !addquest 0 29
--  Cahaurme !pos 55.749 -8.601 -29.354 230
--  Baunise !pos -55 -8 -32 230
--  Disused Well !pos -221 2 -293 149
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
local DavoiID = require("scripts/zones/Davoi/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_KNIGHT_S_TEST)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    item     = xi.items.KITE_SHIELD,
    title    = xi.title.TRIED_AND_TESTED_KNIGHT,

}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_SQUIRE_S_TEST_II) == QUEST_COMPLETED and
                player:getMainLvl() >= 30
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Balasiel'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(627)
                end,
            },

            onEventFinish =
            {
                [627] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                        npcUtil.giveKeyItem(player, xi.ki.BOOK_OF_TASKS)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Balasiel'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem (xi.ki.KNIGHTS_SOUL) then
                        return quest:progressEvent (669)
                    elseif player:hasKeyItem (xi.ki.KNIGHTS_SOUL) then
                        return quest:progressEvent (628)
                    end
                end,
            },

            ['Baunise'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem (xi.ki.BOOK_OF_THE_WEST) then
                        return quest:progressEvent(634)
                    elseif player:hasKeyItem (xi.ki.BOOK_OF_THE_WEST) then
                        return quest:messageSpecial(ID.text.TRIAL_IS_DIFFICULT)
                    end
                end,
            },

            ['Cahaurme'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem (xi.ki.BOOK_OF_THE_EAST) then
                        return quest:progressEvent(633)
                    elseif player:hasKeyItem (xi.ki.BOOK_OF_THE_EAST) then
                        return quest:messageSpecial(ID.text.WAY_OF_THE_SWORD)
                    end
                end,
            },

            onEventFinish =
            {
                [628] = function(player, csid, option, npc)
                    quest:complete(player)
                    player:delKeyItem(xi.ki.KNIGHTS_SOUL)
                    player:delKeyItem(xi.ki.BOOK_OF_TASKS)
                    player:delKeyItem(xi.ki.BOOK_OF_THE_WEST)
                    player:delKeyItem(xi.ki.BOOK_OF_THE_EAST)
                    player:unlockJob(xi.job.PLD)
                    player:messageSpecial(ID.text.UNLOCK_PALADIN)
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
                        not player:hasKeyItem(xi.ki.KNIGHTS_SOUL) and
                        player:hasKeyItem(xi.ki.BOOK_OF_TASKS) and
                        player:hasKeyItem(xi.ki.BOOK_OF_THE_WEST) and
                        player:hasKeyItem(xi.ki.BOOK_OF_THE_EAST)
                    then
                        npcUtil.giveKeyItem(player, xi.ki.KNIGHTS_SOUL)
                    else
                        return quest:messageSpecial(DavoiID.text.A_WELL)
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
            ['Balasiel'] = quest:event(667):replaceDefault(),
        },

    },
}

return quest
