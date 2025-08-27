-----------------------------------
-- Revert the timer for the quest: "Yomi Okuri" to require a JP midnight wait in order to begin quest.
-- The date this timer changed is approx March 2014: hhttps://ffxiclopedia.fandom.com/wiki/Yomi_Okuri?oldid=1482901
--
-- **IMPORTANT**
-- Please note that this module depends on the module: "SAM_AF2_Yomi_Okuri.lua" to function correctly.
-- Ensure that module is also enabled.
-- These files were made separate to avoid overlapping changes to the same file from potential future modules.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('SAM_AF1_The_Sacred_Katana')

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/outlands/SAM_AF1_The_Sacred_Katana', function(quest)
        quest.sections[2][xi.zone.NORG].onEventFinish[141] = function(player, csid, option, npc)
            if quest:complete(player) then
                player:messageSpecial(zones[xi.zone.NORG].text.YOU_CAN_NOW_BECOME_A_SAMURAI, xi.item.MUMEITO)
                player:unlockJob(xi.job.SAM)

                -- Player must zone before being able to flag the next quest
                player:setLocalVar('Quest[5][141]mustZone', 1)
                player:setCharVar('Quest[5][141]Wait', JstMidnight()) -- New change for JST Midnight
            end
        end
    end)
end)

return m
