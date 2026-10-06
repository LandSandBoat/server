-----------------------------------
-- Chocobo Raising QOL: a finished chocobo that can beat a rental
-----------------------------------
require('modules/module_utils')
require('scripts/globals/hobbies/chocobo_raising/chocobo_raising')
-----------------------------------
local m = Module:new('chocobo_raising_qol')

-- When the server has started and everything is ready, apply changes to global settings in Chocobo Raising
m:addOverride('xi.server.onServerStart', function()
    super()

    -- Room for SS/SS/S.
    xi.chocoboRaising.statGrowthCap = 640

    -- S matches a rental. SS, Gallop and Purple Racing Silks each add a rank.
    xi.chocoboRaising.ridingSpeedBase    = 100 - xi.chocoboRaising.skillRanks.S_OUTSTANDING * xi.chocoboRaising.ridingSpeedPerRank
    xi.chocoboRaising.ridingSpeedMaxRank = xi.chocoboRaising.skillRanks.S_OUTSTANDING + 3

    -- SS and Canter each add time past S.
    xi.chocoboRaising.ridingTimeMaxRank = xi.chocoboRaising.skillRanks.S_OUTSTANDING + 2
end)
