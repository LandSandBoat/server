-----------------------------------
-- Module: Job Adjustments (Wings of the Goddess Era)
-- Desc: Removes traits/abilities/effects that were added to jobs during the WotG era
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('wotg_job_adjustments')

-----------------------------------
-- Dark Knight
-----------------------------------

-- Arcane Circle: Removes WotG resist/defense/attack circle mods
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(07/20/2009)
m:addOverride('xi.effects.arcane_circle.onEffectGain', function(target, effect)
    effect:addMod(xi.mod.ARCANA_KILLER, effect:getPower())
end)

return m
