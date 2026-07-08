-----------------------------------
-- Original EXP curve for the base game
-- Date : 2011-02-14
-- https://www.bg-wiki.com/ffxi/Version_Update_(02/14/2011)
-- Use in tandem with 2007_exp_tables.sql
-----------------------------------
require('modules/module_utils')
-----------------------------------

local moduleName = 'original_exp_curve'

if xi.module.isContentEnabled('WOTG') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

m:addOverride('xi.expDifficultyCurve.loadExpDifficultyCurve', function()
    local incrediblyEasyPreyLevel  = 255
    local incrediblyEasyPreyMinExp = 65535

    -- exp value >= returns X difficulty
    -- [exp] = xi.mobDifficulty
    local expToDifficultyTable =
    {
        [400] = xi.mobDifficulty.INCREDIBLY_TOUGH,
        [200] = xi.mobDifficulty.VERY_TOUGH,
        [120] = xi.mobDifficulty.TOUGH,
        [100] = xi.mobDifficulty.EVEN_MATCH,
        [50]  = xi.mobDifficulty.DECENT_CHALLENGE,
        [15]  = xi.mobDifficulty.EASY_PREY,
        -- Nothing below 15 so that is too weak
    }

    -- Load into C++
    LoadExpDifficultyCurves(expToDifficultyTable, incrediblyEasyPreyLevel, incrediblyEasyPreyMinExp)
end)

return m
