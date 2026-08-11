-----------------------------------
-- Storms of Fate
-- Restores the JST midnight wait before Shadows of the Departed can be started.
-- Prishe's trust was added on February 18, 2014, and the follow-up patch on February 20 changed the wait to a Vana'diel date change.
-- That patch was never documented; the date comes from the JP quest wiki.
-----------------------------------
-- Source: https://wiki.ffo.jp/html/5557.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_storms_of_fate', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/jeuno/Storms_of_Fate', function(quest)
        local ruludeGardens = quest.sections[2][xi.zone.RULUDE_GARDENS]

        -- Copy of the base handler with the one Vana'diel day wait extended to JST midnight.
        ruludeGardens.onEventFinish[143] = function(player, csid, option, npc)
            if quest:complete(player) then
                xi.quest.setVar(player, xi.questLog.JEUNO, xi.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED, 'Timer', JstMidnight()) -- Module change: Shadows of the Departed opens at JST midnight.
            end
        end
    end)
end)
