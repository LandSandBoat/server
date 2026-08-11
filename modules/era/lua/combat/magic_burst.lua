-----------------------------------
-- Pre-SoA Magic Burst Module
-- Restores the pre-2015 magic burst multiplier: 1.25 + 0.05 per skillchain step.
-- https://forum.square-enix.com/ffxi/threads/46531
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_magic_burst', xi.pre(xi.expansion.SOA))

m:addOverride('xi.spells.damage.calculateIfMagicBurst', function(caster, target, spellElement, magicBurstTier)
    if spellElement <= xi.element.NONE then
        return 1
    end

    return 1.25 + 0.05 * utils.clamp(magicBurstTier, 1, 5)
end)
