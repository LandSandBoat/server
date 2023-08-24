-----------------------------------
-- Under Oath
-- !addquest 0 92
-----------------------------------
-- Prince Trion Room: !pos -38 -3 73 233
-- Exoroche: !gotoid 17719356
-- Vemalpeau : !gotoid 17719505
-- Najjar: !gotoid 17719508
-- Coffer: !gotoid 17436998
-- Village Well: !pos -34 3 -219 149
-- Ailbeche: !gotoid 17723401
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------
local southSandyID = require("scripts/zones/Southern_San_dOria/IDs")
local davoiID = require("scripts/zones/Davoi/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.UNDER_OATH)

local spawnedMobs =
{
    davoiID.mob.ONE_EYED_GWAJBOJ,
    davoiID.mob.THREE_EYED_PROZPUZ,
}

quest.reward =
{
    item     = xi.items.GALLANT_SURCOAT,
    fame     = 60,
    fameArea = xi.quest.fame_area.SANDORIA,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainJob() == xi.job.PLD and
                player:getMainLvl() >= xi.settings.main.AF3_QUEST_LEVEL and
                player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_BOY_S_DREAM) == QUEST_COMPLETED
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['_6h0'] = quest:progressEvent(90),

            onEventFinish =
            {
                [90] = function(player, csid, option, npc)
                    if option == 1 then -- Accept quest.
                        quest:begin(player)
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

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['_6h0'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 8 then
                        return quest:progressEvent(89)
                    end
                end,
            },

            onEventFinish =
            {
                [89] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        quest:setVar(player, 'Prog', 9)
                    end
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Vemalpeau'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(7) --Under Oath - mentions the boy missing
                    elseif
                        questProgress == 3 and
                        player:hasKeyItem(xi.ki.MIQUES_PAINTBRUSH)
                    then
                        return quest:progressEvent(5) --Under Oath - upset about the paintbrush
                    elseif
                        questProgress == 4 and
                        player:hasKeyItem(xi.ki.STRANGE_SHEET_OF_PAPER)
                    then
                        return quest:progressEvent(3) -- Under Oath - mentions commanding officer
                    end
                end,
            },

            ['Exoroche'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if
                        questProgress == 4 and
                        player:hasKeyItem(xi.ki.STRANGE_SHEET_OF_PAPER)
                    then
                        return quest:progressEvent(77)
                    elseif questProgress == 5 then
                        return quest:progressEvent(79)
                    elseif
                        player:hasKeyItem(xi.ki.KNIGHTS_CONFESSION) and
                        questProgress == 6
                    then
                        return quest:progressEvent(51)
                    elseif questProgress == 8 then
                        return quest:progressEvent(19)
                    end
                end,
            },

            ['Najjar'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then  -- Quest: Under Oath - PLD AF3
                        return quest:progressEvent(16)
                    end
                end,
            },

            ['Ullasa'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then  -- Quest: Under Oath - PLD AF3
                        return quest:progressEvent(40)
                    end
                end,
            },

            ['qm3'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 4 then
                        return quest:event(41)
                    else
                        player:messageSpecial(southSandyID.text.NOTHING_OUT_OF_ORDINARY)
                    end
                end,
            },

            onEventFinish =
            {
                [7] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [5] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                    player:delKeyItem(xi.ki.MIQUES_PAINTBRUSH)
                end,

                [16] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [40] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,

                [41] = function(player, csid, option, npc)
                    if option == 1 then
                        npcUtil.giveKeyItem(player, xi.ki.STRANGE_SHEET_OF_PAPER)
                    end
                end,

                [77] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                end,
            },
        },

        [xi.zone.DAVOI] =
        {
            ['Village_Well'] =
            {
                onTrade = function(player, npc, trade)
                    local questProgress = quest:getVar(player, 'Prog')

                    if
                        npcUtil.tradeHasExactly(trade, xi.items.WELL_WEIGHT) and
                        questProgress == 5
                    then
                        return quest:progressEvent(113)
                    end
                end,

                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if
                        questProgress == 5 and
                        player:hasKeyItem(xi.ki.STRANGE_SHEET_OF_PAPER) and
                        not player:hasItem(xi.items.WELL_WEIGHT)
                    then
                        npcUtil.popFromQM(player, npc, spawnedMobs, { claim = true, hide = 0 })
                    elseif
                        questProgress == 6 and
                        player:hasKeyItem(xi.ki.KNIGHTS_CONFESSION)
                    then
                        return quest:event(112)
                    end
                end,

            },

            onEventFinish =
            {
                [113] = function(player, csid, option, npc)
                        player:confirmTrade()
                        npcUtil.giveKeyItem(player, xi.ki.KNIGHTS_CONFESSION)
                        quest:setVar(player, 'Prog', 6)
                        player:delKeyItem(xi.ki.STRANGE_SHEET_OF_PAPER)
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Ailbeche'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if
                        questProgress == 6 and
                        player:hasKeyItem(xi.ki.KNIGHTS_CONFESSION)
                    then
                        return quest:progressEvent(59)
                    elseif questProgress == 8 then
                        return quest:event(13)
                    end
                end,
            },

            onEventFinish =
            {
                [59] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 7)
                end,
            },
        },
    },

    -- Section: Completed quest
    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Vemalpeau'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getVar("Quest[0][92]Prog") == 9 and
                        player:hasKeyItem(xi.ki.KNIGHTS_CONFESSION)
                    then
                        return quest:progressEvent(2)
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 0)
                    player:delKeyItem(xi.ki.KNIGHTS_CONFESSION)
                end,
            },
        },
    },
}

return quest
