-----------------------------------
-- The Circle of Time (BRD AF3)
-- Restores the JST midnight wait for the star ring buried in the perennial snow.
-- The June 17, 2014 version update shortened the wait to about one minute.
-- The quest appears in the Japanese notes only; the English notes omit it from the list.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/42611
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'era_quest_the_circle_of_time'

if xi.module.isContentEnabled('SOA') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/jeuno/The_Circle_of_Time', function(quest)
        local xarcabard = quest.sections[2][xi.zone.XARCABARD]

        -- Copy of the base handler with the 30 second wait extended to JST midnight.
        xarcabard.onEventFinish[3] = function(player, csid, option, npc)
            if option == 0 then
                quest:setVar(player, 'Buried', JstMidnight()) -- Module change: the ring is purified at JST midnight.
            end
        end
    end)
end)

return m
