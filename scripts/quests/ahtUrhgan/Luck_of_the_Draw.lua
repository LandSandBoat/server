-----------------------------------
-- Luck of the Draw
-- Corsair Job Flag Quest
-----------------------------------
-- Log ID: 6, Quest ID: 6
-- Ratihb           : !pos 75.225 -6.000 -137.203 50
-- Mafwahb          : !pos 149.11 -2.000 -2.7127 50
-- qm6 (H-10 / Boat): !pos 468.767 -12.292 111.817 54
-- qm1              : !pos 490.819 -2.370 167.028 54
-- _1l0 (Rock Slab) : !pos -99 -7 -91 57
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/quests")
require("scripts/globals/settings")
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.LUCK_OF_THE_DRAW)

quest.reward =
{
    item  = xi.items.CORSAIR_DIE,
    title = SEAGULL_PHRATRIE_CREW_MEMBER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and player:getMainLvl() >= ADVANCED_JOB_LEVEL
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Ratihb'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(547)
                end,
            },

            onEventFinish =
            {
                [547] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Mafwahb'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(548)
                    end
                end,
            },

            onEventFinish =
            {
                [548] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.ARRAPAGO_REEF] =
        {
            ['qm6'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(211)
                    end
                end,
            },

            ['qm1'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(2)
                    end
                end,
            },

            onEventFinish =
            {
                [211] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 3)
                end,

                [2] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                    npcUtil.giveKeyItem(player, xi.ki.FORGOTTEN_HEXAGUN)
                end,
            },
        },

        [xi.zone.TALACCA_COVE] =
        {
            ['_1l0'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:progressEvent(3)
                    end
                end,
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    if player:getFreeSlotsCount() == 0 then
                        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.items.CORSAIR_DIE)
                    else
                        player:delKeyItem(xi.ki.FORGOTTEN_HEXAGUN)
                        player:unlockJob(xi.job.COR)
                        quest:complete(player)
                        player:messageSpecial(ID.text.YOU_CAN_NOW_BECOME_A_CORSAIR)
                    end
                end,
            },
        }
    },

    {
        check = function(player, status, vars)
            -- Event 552 is a once event that can occur after completing "Luck of the Draw"
            -- but before finishing Equipped for all Occasions.  This charvar is cleaned up
            -- on complete of Equipped for all Occassions when quest:complete() is called.
            return status == QUEST_COMPLETED and
                not player:getCharVar("Quest[6][24]HasSeenDialog") and
                not player:hasCompletedQuest(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.EQUIPPED_FOR_ALL_OCCASIONS)
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Ratihb'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(552)
                end,
            },

            onEventFinish =
            {
                [547] = function(player, csid, option, npc)
                    player:setCharVar("Quest[6][24]HasSeenDialog", 1)
                end,
            },
        },
    }
}

return quest
