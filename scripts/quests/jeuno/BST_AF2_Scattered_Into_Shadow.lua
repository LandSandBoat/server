-----------------------------------
-- Scattered into the Shadow
-----------------------------------
-- Log ID: 3, Quest ID: 61
-- Brutus: !gotoid 17776652
-- Underground Pool: Offset = !gotoid 17613246 +2
-- Castle_Oztroja Chest !gotoid 17396210
-- Tebhi: !pos -136 24 -21 151
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local feiyinID = require("scripts/zones/FeiYin/IDs")
local castleOzID = require("scripts/zones/Castle_Oztroja/IDs")
-----------------------------------
local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SCATTERED_INTO_SHADOW)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.JEUNO,
    item     = xi.items.BEAST_GAITERS,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.WINGS_OF_GOLD) and
            player:getMainLvl() >= xi.settings.main.AF2_QUEST_LEVEL and
            player:getMainJob() == xi.job.BST
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Brutus'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'cs') == 1 then
                        return quest:progressEvent(143) -- (Short dialog)
                    else
                        return quest:progressEvent(141) -- (Long dialog)
                    end
                end,

            },
            onEventFinish =
            {
                [143] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'cs', 0)
                        npcUtil.giveKeyItem(player, { xi.ki.AQUAFLORA1, xi.ki.AQUAFLORA2, xi.ki.AQUAFLORA3 })
                    end
                end,

                [141] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'cs', 0)
                        npcUtil.giveKeyItem(player, { xi.ki.AQUAFLORA1, xi.ki.AQUAFLORA2, xi.ki.AQUAFLORA3 })
                    else
                        quest:setVar(player, 'cs', 1)
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.FEIYIN] =
        {
            ['Underground_Pool'] =
            {
                onTrigger = function(player, npc)
                    local offset = npc:getID() - feiyinID.npc.UNDERGROUND_POOL_OFFSET

                    if
                        offset == 0 and
                        player:hasKeyItem(xi.ki.AQUAFLORA2)
                    then
                        return quest:progressEvent(20)
                    elseif
                        offset == 1 and
                        quest:getVar(player, 'nmKilled') == 1
                    then
                        return quest:progressEvent(18)
                    elseif
                        offset == 1 and
                        player:hasKeyItem(xi.ki.AQUAFLORA3) and
                        npcUtil.popFromQM(player, npc, feiyinID.mob.DABOTZS_GHOST, { claim = true, hide = 0 })
                    then
                        return quest:noAction()
                    elseif
                        offset == 2 and
                        player:hasKeyItem(xi.ki.AQUAFLORA1)
                    then
                        return quest:progressEvent(21)
                    end
                end,
            },

            ['Dabotzs_Ghost'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if player:hasKeyItem(xi.ki.AQUAFLORA3) then
                        quest:setVar(player, 'nmKilled', 1)
                    end
                end,
            },

            onEventFinish =
            {
                [18] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.AQUAFLORA3)
                    quest:setVar(player, 'nmKilled', 0)
                end,

                [20] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.AQUAFLORA2)
                end,

                [21] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.AQUAFLORA1)
                end,
            },
        },

        [xi.zone.CASTLE_OZTROJA] =
        {
            ['Tebhi'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npc:getStatus() == xi.status.NORMAL and
                        npcUtil.tradeHasExactly(trade, xi.items.BEAST_COLLAR)
                    then
                        player:tradeComplete()
                        quest:setVar(player, 'Prog', 2)
                        npc:setStatus(xi.status.DISAPPEAR)
                        npc:updateNPCHideTime(900) -- 15 mins
                        return quest:messageSpecial(castleOzID.text.TEBHI_ACCEPTS, xi.items.BEAST_COLLAR)
                    end
                end,
            },
        },

        [xi.zone.UPPER_JEUNO] =
        {
            ['Brutus'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.AQUAFLORA1) or
                        player:hasKeyItem(xi.ki.AQUAFLORA2) or
                        player:hasKeyItem(xi.ki.AQUAFLORA3)
                    then
                        return quest:event(142)
                    elseif quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(144)
                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:event(149)
                    elseif quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(135)
                    end
                end,
            },

            ['Osker'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:event(145)
                    end
                end,
            },

            onEventFinish =
            {
                [135] = function(player, csid, option, npc)
                    quest:complete(player)
                end,

                [144] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.UPPER_JEUNO] =
        {
            ['Brutus'] = quest:event(151):importantOnce(),
        },
    },
}

return quest
