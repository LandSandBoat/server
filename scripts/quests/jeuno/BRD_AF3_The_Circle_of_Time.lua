-----------------------------------
-- THE_REQUIEM
-----------------------------------
-- Log ID: 3, Quest ID: 65
-- Imasuke : !gotoid 17784840
-- Perennial Snow: !gotoid
-- Chalvatot: !gotoid 17731598
-- Altar: !gotoid 17391836
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------
local xarcabardID = require("scripts/zones/Xarcabard/IDs")
local monasticID = require("scripts/zones/Monastic_Cavern/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_CIRCLE_OF_TIME)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.JEUNO,
    item  = xi.items.CHORAL_JUSTAUCORPS,
    title = xi.title.PARAGON_OF_BARD_EXCELLENCE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getMainLvl() >= xi.settings.main.AF3_QUEST_LEVEL and
            player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_REQUIEM) == QUEST_COMPLETED
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Mertaire'] = quest:progressEvent(139),

            onEventFinish =
            {
                [139] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.PORT_JEUNO] =
        {
            ['Imasuke'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then -- intial dialog
                        return quest:progressEvent(30)
                    end
                end,
            },

            onEventFinish =
            {
                [30] = function(player, csid, option, npc)
                    quest:begin(player)
                    quest:setVar(player, 'Prog', 2)
                end,

            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.PORT_JEUNO] =
        {
            ['Imasuke'] =
            {
                onTrigger = function(player, npc)
                    local circleProgress = quest:getVar(player, 'Prog')

                    if circleProgress == 1 then
                        return quest:progressEvent(30)
                    elseif circleProgress == 2 then
                        return quest:progressEvent(29)
                    elseif circleProgress == 3 then
                        return quest:event(32)
                    elseif circleProgress == 4 then
                        return quest:progressEvent(33)
                    elseif circleProgress == 5 then
                        return quest:event(31)
                    end
                end,
            },

            onEventFinish =
            {
                [29] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'Prog', 3)
                    end
                end,

                [30] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'Prog', 3)
                    else
                        quest:setVar(player, 'Prog', 2)
                    end
                end,

                [33] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 5)
                end,
            },
        },

        [xi.zone.XARCABARD] =
        {
            ['Perennial_Snow'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'ringBuried') == 0 and
                        quest:getVar(player, 'Prog') == 2
                    then
                        return quest:progressEvent(3)
                    elseif os.time() > quest:getVar(player, 'ringBuried') then
                        return quest:progressEvent(2)
                    else
                        return quest:messageSpecial(xarcabardID.text.PERENNIAL_SNOW_WAIT, 225)
                    end
                end,
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    quest:setVar(player, 'ringBuried', getMidnight()) -- Midnight sucka https://ffxiclopedia.fandom.com/wiki/The_Circle_of_Time?oldid=202117
                    quest:setVar(player, 'Prog', 3)
                end,

                [2] = function(player, csid, option, npc)
                    quest:setVar(player, 'ringBuried', 0)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Chalvatot'] =
            {
                onTrigger = function(player, npc)
                    local circleProgress = quest:getVar(player, 'Prog')

                    if circleProgress == 5 then
                        return quest:progressEvent(99)
                    elseif circleProgress == 6 then
                        return quest:progressEvent(98)
                    elseif circleProgress == 7 then
                        return quest:event(97)
                    elseif circleProgress == 9 then
                        return quest:progressEvent(96)
                    end
                end,
            },

            onEventFinish =
            {
                [99] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 6)
                    elseif option == 1 then
                        quest:setVar(player, 'Prog', 7)
                        npcUtil.giveKeyItem(player, xi.ki.MOON_RING)
                    end
                end,

                [98] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'Prog', 7)
                        npcUtil.giveKeyItem(player, xi.ki.MOON_RING)
                    end
                end,

                [96] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.MONASTIC_CAVERN] =
        {
            ['Altar'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.STAR_RING1) and
                        player:hasKeyItem(xi.ki.MOON_RING)
                    then
                        if
                            quest:getVar(player, 'Prog') == 7 and
                            npcUtil.popFromQM(player, npc, monasticID.mob.BUGABOO, { hide = 0 })
                        then
                            return quest:noAction()
                        elseif  quest:getVar(player, 'Prog') == 8 then
                            return quest:progressEvent(3)
                        end
                    end
                end,
            },

            ['Bugaboo'] =
            {
                onMobDeath = function(mob, player, optParams)
                    if quest:getVar(player, 'Prog') == 7 then
                        quest:setVar(player, 'Prog', 8)
                    end
                end,
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 9)
                    player:delKeyItem(xi.ki.MOON_RING)
                    player:delKeyItem(xi.ki.STAR_RING1)
                end,
            },
        },
    },
}

return quest
