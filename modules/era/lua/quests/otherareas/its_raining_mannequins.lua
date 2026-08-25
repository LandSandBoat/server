-----------------------------------
-- It's Raining Mannequins!
-- Restores the JST midnight wait while Fyi Chalmwoh assembles the mannequin.
-- The June 17, 2014 version update shortened the wait to one minute.
-- The update notes give no values; the JST midnight condition comes from the Japanese wiki.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/42614-Jun-17-2014-(JST)-Version-Update
-- Source: https://wiki.ffo.jp/html/7101.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_its_raining_mannequins', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/otherAreas/Its_Raining_Mannequins', function(quest)
        local mhauraTrade  = quest.sections[4][xi.zone.MHAURA]
        local mhauraReward = quest.sections[5][xi.zone.MHAURA]
        local basePartsCS  = mhauraTrade.onEventFinish[309]

        -- The parts are assembled overnight. The mannequin is collected at JST midnight.
        mhauraTrade.onEventFinish[309] = function(player, csid, option, npc)
            basePartsCS(player, csid, option, npc)
            quest:setVar(player, 'Wait', JstMidnight()) -- Module change
        end

        -- Copy of the base handler. 'Wait' now holds the due time rather than the time of the trade.
        mhauraReward['Fyi_Chalmwoh'].onTrigger = function(player, npc)
            if GetSystemTime() >= quest:getVar(player, 'Wait') then -- Module change
                return quest:progressEvent(311)
            else
                return quest:event(310) -- Please wait
            end
        end
    end)
end)
