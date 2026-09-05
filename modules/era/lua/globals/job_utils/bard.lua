-----------------------------------
-- Module: Bard Job Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'era_job_utils_bard'

if xi.module.isContentEnabled('ABYSSEA') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

-- Nightingale: Revert to merit-based recast reduction
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(03/26/2012)
m:addOverride('xi.job_utils.bard.useNightingale', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.NIGHTINGALE) - 150
    action:setRecast(action:getRecast() - recastReduction)

    player:addStatusEffect(xi.effect.NIGHTINGALE, { duration = 60, origin = player })

    return xi.effect.NIGHTINGALE
end)

-- Troubadour: Revert to merit-based recast reduction
m:addOverride('xi.job_utils.bard.useTroubadour', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.TROUBADOUR) - 150
    action:setRecast(action:getRecast() - recastReduction)

    player:addStatusEffect(xi.effect.TROUBADOUR, { duration = 60, origin = player })

    return xi.effect.TROUBADOUR
end)

return m
