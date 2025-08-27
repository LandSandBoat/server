-----------------------------------
-- Revert the timer for the quest: "A Thief in Norg" to require a JP midnight wait in order to begin quest.
-- The date this timer changed is approx March 2014: hhttps://ffxiclopedia.fandom.com/wiki/Yomi_Okuri?oldid=1482901
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('SAM_AF3_A_Thief_in_Norg')

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/outlands/SAM_AF3_A_Thief_in_Norg', function(quest)
        quest.sections[2][xi.zone.NORG]['Jaucribaix'].onTrigger = function(player, npc)
            local questProgress = quest:getVar(player, 'Prog')

                    if questProgress <= 4 then
                        return quest:progressEvent(159)
                    elseif questProgress == 5 then
                        return quest:progressEvent(166)
                    elseif questProgress == 6 then
                        return quest:progressEvent(player:findItem(xi.item.BANISHING_CHARM) and 167 or 168)
                    elseif questProgress == 7 then
                        return quest:progressEvent(160)
                    elseif questProgress == 8 then
                        return quest:progressEvent(161)
                    elseif questProgress == 9 then
                        return quest:progressEvent(quest:getVar('Wait') <= GetSystemTime() and 163 or 164) -- New Check for JST Midnight
                    end
        end
    end)

    xi.module.modifyInteractionEntry('scripts/quests/outlands/SAM_AF3_A_Thief_in_Norg', function(quest)
        quest.sections[2][xi.zone.NORG].onEventFinish[162] = function(player, csid, option, npc)
            player:confirmTrade()
            player:delKeyItem(xi.ki.CHARRED_HELM)
            quest:setVar(player, 'Prog', 9)
            quest:setVar(player, 'Wait', JstMidnight()) -- New change for JST Midnight
        end
    end)
end)

return m
