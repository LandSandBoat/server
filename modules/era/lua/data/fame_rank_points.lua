-----------------------------------
-- Era fame rank thresholds
-- Points required per fame rank before the February 18th 2014 relaxation, at the 10x retail scale used by this server (fame cap 2500).
-- https://wiki.ffo.jp/html/2683.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'old_fame_rank_points'

if xi.module.isContentEnabled('ROV') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.data.fame.rankPoints =
    {
        [1] = 0,
        [2] = 200,
        [3] = 500,
        [4] = 900,
        [5] = 1300,
        [6] = 1700,
        [7] = 1950,
        [8] = 2200,
        [9] = 2450,
    }
end)

return m
