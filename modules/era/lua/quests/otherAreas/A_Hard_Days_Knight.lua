-----------------------------------
-- A Hard Day's Knight
-- Removes the ability to obtain the Temple Knight Key.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/40059
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'era_quest_a_hard_days_knight'

if xi.module.isContentEnabled('SOA') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/otherAreas/A_Hard_Days_Knight', function(quest)
        table.remove(quest.sections, 3)
    end)
end)

return m
