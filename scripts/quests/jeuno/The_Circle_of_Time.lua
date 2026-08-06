-----------------------------------
-- The Circle of Time
-----------------------------------
-- Log ID: 3, Quest ID: 65
-- !addquest 3 65
-- Mertaire       : !pos -17 0 -61 245
-- Imasuke        : !pos -165 11 96 246
-- Perennial Snow : !pos 339 0 -379 112
-- Chalvatot      : !pos -105 0.1 72 233
-- Altar          : !pos 109 -3 -145 150
-----------------------------------
-- Mertaire's hint (event 139) repeats and plays regardless of job; the quest is only granted by Imasuke's appraisal.
-----------------------------------
local monasticID  = zones[xi.zone.MONASTIC_CAVERN]
local xarcabardID = zones[xi.zone.XARCABARD]
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_CIRCLE_OF_TIME)

quest.reward =
{
    item  = xi.item.CHORAL_JUSTAUCORPS,
    title = xi.title.PARAGON_OF_BARD_EXCELLENCE,
}

quest.sections =
{
    -- Section: Quest is available.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_REQUIEM)
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Mertaire'] = quest:progressEvent(139),

            onEventFinish =
            {
                [139] = function(player, csid, option, npc)
                    if
                        option == 0 and
                        quest:getVar(player, 'Prog') == 0
                    then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },

        [xi.zone.PORT_JEUNO] =
        {
            ['Imasuke'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getMainJob() ~= xi.job.BRD or
                        player:getMainLvl() < xi.settings.main.AF3_QUEST_LEVEL
                    then
                        return
                    end

                    local progress = quest:getVar(player, 'Prog')

                    if progress == 1 then
                        return quest:progressEvent(30)
                    elseif progress == 2 then
                        return quest:progressEvent(29) -- Short offer after the player declined once.
                    end
                end,
            },

            onEventFinish =
            {
                [29] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 3)
                    end
                end,

                [30] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 3)
                    elseif option == 0 then
                        quest:setVar(player, 'Prog', 2) -- Player declined.
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted.
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Chalvatot'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 5 then
                        return quest:progressEvent(99)
                    elseif progress == 6 then
                        return quest:progressEvent(98)
                    elseif progress == 7 then
                        return quest:event(97) -- Reminder: place the rings upon the altar.
                    elseif progress == 9 then
                        return quest:progressEvent(96)
                    end
                end,
            },

            onEventFinish =
            {
                [96] = function(player, csid, option, npc)
                    if
                        option == 0 and
                        quest:complete(player)
                    then
                        player:addFame(xi.fameArea.SANDORIA, 7)
                        player:addFame(xi.fameArea.BASTOK, 7)
                        player:addFame(xi.fameArea.WINDURST, 7)
                    end
                end,

                [98] = function(player, csid, option, npc)
                    if option == 1 then
                        npcUtil.giveKeyItem(player, xi.ki.MOON_RING)
                        quest:setVar(player, 'Prog', 7)
                    end
                end,

                [99] = function(player, csid, option, npc)
                    if option == 1 then
                        npcUtil.giveKeyItem(player, xi.ki.MOON_RING)
                        quest:setVar(player, 'Prog', 7)
                    elseif option == 0 then
                        quest:setVar(player, 'Prog', 6)
                    end
                end,
            },
        },

        [xi.zone.MONASTIC_CAVERN] =
        {
            ['Altar'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if
                        progress == 7 and
                        npcUtil.popFromQM(player, npc, monasticID.mob.BUGABOO, { hide = 0 })
                    then
                        return quest:noAction() -- No message. Bugaboo spawns and immediately aggroes.
                    elseif progress == 8 then
                        return quest:progressEvent(3)
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
                    if option == 0 then
                        player:delKeyItem(xi.ki.STAR_RING1)
                        player:delKeyItem(xi.ki.MOON_RING)
                        quest:setVar(player, 'Prog', 9)
                    end
                end,
            },
        },

        [xi.zone.PORT_JEUNO] =
        {
            ['Imasuke'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 3 then
                        return quest:event(32) -- Reminder: bury the ring in Xarcabard.
                    elseif progress == 4 then
                        return quest:progressEvent(33)
                    elseif progress == 5 then
                        return quest:event(31) -- Reminder: take the ring to Chateau d'Oraguille.
                    end
                end,
            },

            onEventFinish =
            {
                [33] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 5)
                    end
                end,
            },
        },

        [xi.zone.XARCABARD] =
        {
            ['Perennial_Snow'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') ~= 3 then
                        return
                    end

                    local purifiedTime = quest:getVar(player, 'Buried')

                    if purifiedTime == 0 then
                        return quest:progressEvent(3)
                    elseif GetSystemTime() >= purifiedTime then
                        return quest:progressEvent(2)
                    else
                        return quest:messageSpecial(xarcabardID.text.PERENNIAL_SNOW_WAIT, xi.ki.STAR_RING1)
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 4)
                    end
                end,

                [3] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Buried', GetSystemTime() + 30) -- Capture: the buried ring was purified within 35 seconds.
                    end
                end,
            },
        },
    },
}

return quest
