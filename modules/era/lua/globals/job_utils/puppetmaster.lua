-----------------------------------
-- Module: Puppetmaster Job Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'era_job_utils_puppetmaster'

local m = Module:new(moduleName)

if xi.module.isContentEnabled('ABYSSEA') then
    return { name = moduleName }
end

-- Overdrive: Revert duration from 180 to 60 seconds : https://wiki.ffo.jp/html/954.html
m:addOverride('xi.job_utils.puppetmaster.onAbilityUseOverdrive', function(player, target, ability, action)
    local pet = player:getPet()

    player:addStatusEffect(xi.effect.OVERDRIVE, { duration = 60 + player:getMod(xi.mod.OVERDRIVE_BONUS_DURATION), origin = player })

    if pet then
        pet:addStatusEffect(xi.effect.OVERDRIVE, { duration = 60 + player:getMod(xi.mod.OVERDRIVE_BONUS_DURATION), origin = pet })
        action:ID(player:getID(), pet:getID())
    end

    return xi.effect.OVERDRIVE
end)

-- Repair: Revert recast to a flat 180 seconds : https://wiki.ffo.jp/html/954.html
m:addOverride('xi.job_utils.puppetmaster.onAbilityCheckRepair', function(player, target, ability)
    local msg, param = super(player, target, ability)

    if msg == 0 then
        ability:setRecast(180)
    end

    return msg, param
end)

-- Oils: Remove the initial burst heal, leaving only the Regen effect
for _, oilData in pairs(xi.job_utils.puppetmaster.oilData) do
    oilData.initialHealPercent = 0
end

return m
