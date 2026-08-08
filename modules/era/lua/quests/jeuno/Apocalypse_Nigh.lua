-----------------------------------
-- Apocalypse Nigh
-- Restores the JST midnight waits before this quest can be started and after the Empyreal Paradox battlefield is cleared.
-- The wait for Gilgamesh's reward cutscene in Norg is not tied to Aldo's cutscene.
-- The wait after the battlefield was left alone until the November 10, 2021 version update shortened it to one Vana'diel day.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/58770
-- Source: https://wiki.ffo.jp/html/7291.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'era_quest_apocalypse_nigh'

if xi.module.isContentEnabled('TVR') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/jeuno/Apocalypse_Nigh', function(quest)
        local empyrealParadox = quest.sections[2][xi.zone.EMPYREAL_PARADOX]
        local norg            = quest.sections[2][xi.zone.NORG]

        -- Copy of the base check with the timer compared as a timestamp.
        quest.sections[1].check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED) and
                GetSystemTime() >= vars.Timer and -- Module change: this quest opens at JST midnight.
                not quest:getMustZone(player)
        end

        -- Copy of the base handler with the one Vana'diel day wait extended to JST midnight.
        empyrealParadox.onEventFinish[32001] = function(player, csid, option, npc)
            if
                player:getLocalVar('battlefieldWin') == xi.battlefield.id.APOCALYPSE_NIGH and
                quest:getVar(player, 'Prog') == 3
            then
                quest:setVar(player, 'Prog', 4)
                quest:setVar(player, 'Timer', JstMidnight()) -- Module change: the wait runs to JST midnight.
            end
        end

        -- Copy of the base handler with the timer compared as a timestamp.
        norg['_700'].onTrigger = function(player, npc)
            if
                quest:getVar(player, 'Prog') == 5 and
                GetSystemTime() < quest:getVar(player, 'Timer') -- Module change: Gilgamesh is unavailable until JST midnight.
            then
                return quest:progressEvent(235)
            end
        end

        -- Copy of the base handler with the timer compared as a timestamp.
        norg['Gilgamesh'].onTrigger = function(player, npc)
            if
                GetSystemTime() >= quest:getVar(player, 'Timer') and -- Module change: Gilgamesh waits until JST midnight.
                not quest:getMustZone(player)
            then
                local questProgress = quest:getVar(player, 'Prog')

                if questProgress == 5 then
                    return quest:progressEvent(232, 252, 6)
                elseif questProgress == 6 then
                    return quest:progressEvent(234, 252)
                end
            end
        end
    end)
end)

return m
