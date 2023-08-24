-----------------------------------
-- A New Dawn
-----------------------------------
-- Log ID: 3, Quest ID: 62
-- Merchants Door: !gotoid 17780840
-- Oskar: !gotoid 17776653
-- Sarcophagus !gotoid 17576394
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local eldiemeID = require("scripts/zones/The_Eldieme_Necropolis/IDs")
-----------------------------------
local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_NEW_DAWN)

quest.reward =
{
    item     = xi.items.BEAST_TROUSERS,
    title    = xi.title.PARAGON_OF_BEASTMASTER_EXCELLENCE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SCATTERED_INTO_SHADOW) and
            player:getMainLvl() >= xi.settings.main.AF3_QUEST_LEVEL and
            player:getMainJob() == xi.job.BST
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['_6t2'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(4) -- (Short dialog)
                    else
                        return quest:progressEvent(5) -- (Long dialog)
                    end
                end,

            },
            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 2)
                    end
                end,

                [5] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 2)
                    else
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['_6t2'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:event(2)
                    elseif quest:getVar(player, 'Prog') >= 4 then
                        return quest:event(3)
                    end
                end,
            },
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['Osker'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 2 or
                        quest:getVar(player, 'Prog') == 3
                    then
                        return quest:progressEvent(146)
                    elseif quest:getVar(player, 'Prog') >= 4 then
                        return quest:event(147)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.PIECE_OF_MAHOGANY_LUMBER) then
                        player:tradeComplete()
                        return quest:progressEvent(148)
                    end
                end,
            },

            onEventFinish =
            {
                [146] = function(player, csid, option, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        quest:setVar(player, 'Prog', 3)
                    end
                end,

                [148] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.TAMERS_WHISTLE)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },

        [xi.zone.THE_ELDIEME_NECROPOLIS] =
        {
            ['Sarcophagus'] =
            {
                onTrigger = function(player, npc)
                    if npc:getID() == eldiemeID.npc.SARCOPHAGUS_OFFSET then
                        if quest:getVar(player, 'Prog') == 4 then
                            npcUtil.popFromQM(player, npc, { eldiemeID.mob.STURM, eldiemeID.mob.TAIFUN, eldiemeID.mob.TROMBE }, { claim = false, hide = 0 })
                            return quest:noAction()
                        elseif quest:getVar(player, 'Prog') == 5 then
                            return quest:progressEvent(45)
                        end
                    end
                end,
            },

            ['Sturm'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 4 then
                        quest:setVar(player, 'Prog', 5)
                    end

                    for i = eldiemeID.mob.STURM + 1, eldiemeID.mob.STURM + 2 do
                        DespawnMob(i)
                    end
                end,
            },

            onEventFinish =
            {
                [45] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.TAMERS_WHISTLE)
                        quest:setVar(player, 'Prog', 6)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['_6t2'] =
            {
                onTrigger = function(player, npc)
                    if player:getCharVar("Quest[3][62]Prog") == 6 then
                        return quest:progressEvent(0)
                    end
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    player:setCharVar("Quest[3][62]Prog", 0)
                end,
            },
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['Brutus'] = quest:event(140):importantOnce(),
        },
    },
}

return quest
