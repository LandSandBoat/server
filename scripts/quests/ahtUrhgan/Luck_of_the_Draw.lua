-----------------------------------
-- Luck of the Draw
-- Corsair Job Flag Quest
-----------------------------------
-- Log ID: 6, Quest ID: 6
-- Ratihb           : !pos 75.225 -6.000 -137.203 50
-- Mafwahb          : !pos 149.11 -2.000 -2.7127 50
-- qm6 (H-10 / Boat): !pos 468.767 -12.292 111.817 54
-- qm1              : !pos -62.239 -7.9619 -137.1251
-- _1l0 (Rock Slab) : !pos -99 -7 -91 57
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/quests')
require('scripts/globals/settings')
require('scripts/globals/titles')
require('scripts/globals/interaction/quest')
-----------------------------------
local talaccaCoveID = require('scripts/zones/Talacca_Cove/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.LUCK_OF_THE_DRAW)

quest.reward =
{
    item    = xi.items.CORSAIR_DIE,
    keyItem = xi.ki.JOB_GESTURE_CORSAIR,
    title   = xi.title.SEAGULL_PHRATRIE_CREW_MEMBER,
}

quest.sections =
{
    -- Section: Quest available
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and player:getMainLvl() >= xi.settings.main.ADVANCED_JOB_LEVEL
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

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Mafwahb'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 1 then
                        return quest:progressEvent(548)
                    elseif questProgress == 2 then
                        return quest:event(647)
                    end
                end,
            },

            onEventFinish =
            {
                [548] = function(player, csid, option, npc)
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

            onEventFinish =
            {
                [211] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },

        [xi.zone.TALACCA_COVE] =
        {
            ['qm1'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(2)
                    end
                end,
            },

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
                [2] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                    npcUtil.giveKeyItem(player, xi.ki.FORGOTTEN_HEXAGUN)
                end,

                [3] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.FORGOTTEN_HEXAGUN)
                        player:unlockJob(xi.job.COR)
                        player:messageSpecial(talaccaCoveID.text.YOU_CAN_NOW_BECOME_A_CORSAIR)
                    end
                end,
            },
        }
    },

    -- Section: Quest complete.
    {
        check = function(player, status, vars)
            -- Event 552 is a one-time-only event that can occur after completing "Luck of the Draw"
            -- but before finishing Equipped for all Occasions.
            -- This charvar is cleaned up on complete of 'Equipped for all Occasions' when quest:complete() is called.

            return status == QUEST_COMPLETED and
                xi.quest.getVar(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.EQUIPPED_FOR_ALL_OCCASIONS, 'Stage') == 0 and
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
                [552] = function(player, csid, option, npc)
                    xi.quest.setVar(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.EQUIPPED_FOR_ALL_OCCASIONS, 'Stage', 1)
                end,
            },
        },
    }
}

return quest
