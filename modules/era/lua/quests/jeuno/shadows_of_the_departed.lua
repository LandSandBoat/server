-----------------------------------
-- Shadows of the Departed
-- Restores the JST midnight waits before this quest can be started and before Apocalypse Nigh can be started.
-- Prishe's trust was added on February 18, 2014, and the follow-up patch on February 20 changed both waits to a Vana'diel date change.
-- That patch was never documented; the date comes from the JP quest wiki.
-----------------------------------
-- Source: https://wiki.ffo.jp/html/5557.html
-- Source: https://wiki.ffo.jp/html/7291.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_shadows_of_the_departed', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/jeuno/Shadows_of_the_Departed', function(quest)
        local ruludeGardens = quest.sections[2][xi.zone.RULUDE_GARDENS]

        -- Copy of the base check with the timer compared as a timestamp.
        quest.sections[1].check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE) and
                player:getCurrentMission(xi.mission.log_id.ZILART) == xi.mission.id.zilart.AWAKENING and
                player:getMissionStatus(xi.mission.log_id.ZILART) == 3 and
                GetSystemTime() >= vars.Timer -- Module change: this quest opens at JST midnight.
        end

        -- Copy of the base handler with the one Vana'diel day wait extended to JST midnight.
        ruludeGardens.onEventFinish[162] = function(player, csid, option, npc)
            if quest:complete(player) then
                for keyItemId = xi.ki.PROMYVION_HOLLA_SLIVER, xi.ki.PROMYVION_HOLLA_SLIVER + 2 do
                    player:delKeyItem(keyItemId)
                end

                player:messageSpecial(zones[xi.zone.RULUDE_GARDENS].text.YOU_HAND_THE_THREE_SLIVERS)

                xi.quest.setVar(player, xi.questLog.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH, 'Timer', JstMidnight()) -- Module change: Apocalypse Nigh opens at JST midnight.
                xi.quest.setMustZone(player, xi.questLog.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH)
            end
        end
    end)
end)
