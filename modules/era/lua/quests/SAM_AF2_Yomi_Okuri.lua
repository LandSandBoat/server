-----------------------------------
-- Revert the timer for the quest: "Yomi Okuri" to require a JP midnight wait in order to begin quest.
-- The date this timer changed is approx March 2014: hhttps://ffxiclopedia.fandom.com/wiki/Yomi_Okuri?oldid=1482901
--
-- **IMPORTANT**
-- Please note that this module depends on the module: "SAM_AF1_The_Sacred_Katana.lua" to function correctly.
-- Ensure that module is also enabled.
-- These files were made separate to avoid overlapping changes to the same file from potential future modules.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('SAM_AF2_Yomi_Okuri')

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/outlands/SAM_AF2_Yomi_Okuri', function(quest)
        quest.sections[1].check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.THE_SACRED_KATANA) and
                player:getMainJob() == xi.job.SAM and
                player:getMainLvl() >= xi.settings.main.AF2_QUEST_LEVEL and
                quest:getVar('Wait') <= GetSystemTime()  -- New Check for JST Midnight
        end
    end)
end)

return m
