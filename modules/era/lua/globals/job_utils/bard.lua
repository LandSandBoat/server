-----------------------------------
-- Module: Bard Job Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_job_utils_bard', xi.pre(xi.expansion.ABYSSEA))

-- Pianissimo: Remove halved song cast time
m:addOverride('xi.job_utils.bard.usePianissimo', function(player, target, ability)
    player:addStatusEffect(xi.effect.PIANISSIMO, { duration = 60, origin = player })

    return xi.effect.PIANISSIMO
end)

-- Nightingale: Revert to merit-based recast reduction and remove instant song cast chance
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(03/26/2012)
m:addOverride('xi.job_utils.bard.useNightingale', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.NIGHTINGALE) - 150
    action:setRecast(action:getRecast() - recastReduction)

    player:addStatusEffect(xi.effect.NIGHTINGALE, { duration = 60, origin = player })

    return xi.effect.NIGHTINGALE
end)

-- Troubadour: Revert to merit-based recast reduction and remove song magic accuracy
m:addOverride('xi.job_utils.bard.useTroubadour', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.TROUBADOUR) - 150
    action:setRecast(action:getRecast() - recastReduction)

    player:addStatusEffect(xi.effect.TROUBADOUR, { duration = 60, origin = player })

    return xi.effect.TROUBADOUR
end)
