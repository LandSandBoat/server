-----------------------------------
-- Make Chocobo Raising more reasonable for modern times
-- - Make growth boundaries more reasonable
-- - Make resultant ridable chocobo speed/endurance etc. more rewarding
-----------------------------------
require('modules/module_utils')
require('scripts/globals/utils')
require('scripts/globals/chocobo_raising')
-----------------------------------
local m = Module:new('chocobo_raising_qol')

-- When the server has started and everything is ready, apply changes to global settings in Chocobo Raising
m:addOverride('xi.server.onServerStart', function()
    -- Call super!
    super()

    -- Speed up growth boundaries
    xi.chocoboRaising.daysToChick      = 2
    xi.chocoboRaising.daysToAdolescent = 7
    xi.chocoboRaising.daysToAdult1     = 14
    xi.chocoboRaising.daysToAdult2     = 43 -- "You've done a great job raising this chocobo. Now is the best time to improve its attributes."
    xi.chocoboRaising.daysToAdult3     = 64 -- "Chocobo's growth seems to have stabilized. The animal has developed quite a distinguished air."
    xi.chocoboRaising.daysToAdult4     = 129 -- Retirement

    -- TODO: Make resultant ridable chocobo speed/endurance etc. more rewarding
end)

return m
