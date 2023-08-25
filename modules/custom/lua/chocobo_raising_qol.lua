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
    xi.chocoboRaising.daysToChick      =   2 -- Down from 4
    xi.chocoboRaising.daysToAdolescent =   7 -- Down from 19
    xi.chocoboRaising.daysToAdult1     =  14 -- Down from 29
    xi.chocoboRaising.daysToAdult2     =  43
    xi.chocoboRaising.daysToAdult3     =  64
    xi.chocoboRaising.daysToAdult4     = 129 -- Retirement

    -- Make resultant ridable chocobo speed/endurance etc. more rewarding
    -- https://www.bg-wiki.com/ffxi/Category:Chocobo_Raising
    -- Rental chocobos are bred for speed and endurance, so they are automatically at the capped mount speed (+100% of base movement speed) and riding time.
    -- Personal chocobos will need the highest Speed rating and the ability Gallop in order to move at the same speed.
    -- F is the base grade (0 ranks), up through A to S to SS (+7 ranks)
    -- Max ranks is +9: with skills and relevant silks.

    -- Chocobo Speed Ratings
    xi.chocoboRaising.ridingSpeedBase    =  90
    xi.chocoboRaising.ridingSpeedPerRank =   4
    xi.chocoboRaising.ridingSpeedCap     = 120
    -- Ability: Gallop adds 1 rank
    -- Purple Race Silks add 1 rank
    -- Original: Leads to absolute max of: 80 + (2.5 * 9): 102.5 -> clamped to 100
    -- Original: Leads to absolute max of: 90 + (4 * 9): 126 -> clamped to 120

    -- Chocobo Endurance Ratings (minutes)
    xi.chocoboRaising.ridingTimeBase    = 20
    xi.chocoboRaising.ridingTimePerRank =  5
    xi.chocoboRaising.ridingTimeCap     = 60
    -- Ability: Canter adds 1 rank
    -- Red Race Silks add 1 rank
    -- Original: Leads to absolute max of: 17 + (4 * 9): 53 -> clamped to 45
    -- New: Leads to absolute max of: 20 + (5 * 9): 65 -> clamped to 60
end)

return m
