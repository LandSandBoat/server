-----------------------------------
-- Sharpening The Sword PLD AF 1
-- !addquest 0 90
-----------------------------------
-- Ailbeche: !gotoid 17723401
-- Sobane: !gotoid 17719322
-- Stalagmite: !gotoid 17568175
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------
local ordellesID = require("scripts/zones/Ordelles_Caves/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SHARPENING_THE_SWORD)

quest.reward =
{
    item     = xi.items.HONOR_SWORD,
    fame     = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainJob() == xi.job.PLD and
                player:getMainLvl() >= xi.settings.main.AF1_QUEST_LEVEL and
                player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.FATHER_AND_SON) == QUEST_COMPLETED and
                player:getCharVar("Quest[0][4]Prog") == 0 -- must have turned the willow fishing rod back
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Ailbeche'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(45) -- Starts Quest.
                    elseif quest:getVar(player, 'Prog') == 1 then --declined first
                        return quest:progressEvent(43)
                    end
                end,
            },

            onEventFinish =
            {
                [45] = function(player, csid, option, npc)
                    if option == 1 then -- Accept quest.
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 2)
                    else
                        quest:setVar(player, 'Prog', 1) -- Declined First offering.
                    end
                end,

                [43] = function(player, csid, option, npc)
                    if option == 1 then -- Accept quest.
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 2)
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

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Ailbeche'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.ORDELLE_WHETSTONE) then
                        return quest:progressEvent(44)
                    else
                        return quest:event(42)
                    end
                end,
            },

            onEventFinish =
            {
                [44] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.ORDELLE_WHETSTONE)
                    end
                end,
            },

        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Sobane'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(52)
                    end
                end,
            },

            onEventFinish =
            {
                [52] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
            },
        },

        [xi.zone.ORDELLES_CAVES] =
        {
            ['Stalagmite'] =
            {
                onTrigger = function(player, npc)
                    local questProgress = quest:getVar(player, 'Prog')

                    if
                        questProgress == 3 and
                        quest:getVar(player, 'PolevikKilled') == 0
                    then
                        if npcUtil.popFromQM(player, npc, ordellesID.mob.POLEVIK, { claim = true, hide = 0 }) then
                            return player:messageSpecial(ordellesID.text.SENSE_OF_FOREBODING)
                        end
                    elseif
                        questProgress == 3 and
                        quest:getVar(player, 'PolevikKilled') == 1
                    then
                        npcUtil.giveKeyItem(player, xi.ki.ORDELLE_WHETSTONE)
                        quest:setVar(player, 'PolevikKilled', 0)
                        quest:setVar(player, 'Prog', 4)
                        return quest:noAction()
                    end
                end,
            },

            ['Polevik'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 3 then
                        quest:setVar(player, 'PolevikKilled', 1)
                    end
                end,
            },
        },
    },
}

return quest
