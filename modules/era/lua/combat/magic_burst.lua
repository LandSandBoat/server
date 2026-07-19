-----------------------------------
-- Pre-SoA Magic Burst Module
-- Restores the pre-2015 magic burst multiplier: 1.25 + 0.05 per skillchain step.
-- https://forum.square-enix.com/ffxi/threads/46531
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'era_magic_burst'

if xi.module.isContentEnabled('SOA') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

m:addOverride('xi.spells.damage.calculateIfMagicBurst', function(caster, target, spellElement, magicBurstTier)
    if spellElement <= xi.element.NONE then
        return 1
    end

    return 1.25 + 0.05 * utils.clamp(magicBurstTier, 1, 5)
end)

return m
