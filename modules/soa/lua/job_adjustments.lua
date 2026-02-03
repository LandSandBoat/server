-----------------------------------
-- Module: Job Adjustments (Seekers of Adoulin era)
-- Desc: Removes traits/abilities/effects that were added to jobs during the SoA era
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('soa_job_adjustments')

-----------------------------------
-- Dark Knight
-----------------------------------

-- Last Resort: Reduces attack bonus from 25% to 15%
-- Source: https://forum.square-enix.com/ffxi/threads/46976-May-14-2015-%28JST%29-Version-Update
m:addOverride('xi.effects.last_resort.onEffectGain', function(target, effect)
    local targetMerit     = target:getMerit(xi.merit.LAST_RESORT_EFFECT)

    -- Merit effect
    effect:addMod(xi.mod.ATTP, 15 + targetMerit)
    effect:addMod(xi.mod.RATTP, 15 + targetMerit)
    effect:addMod(xi.mod.DEFP, -15 - targetMerit)

    effect:addMod(xi.mod.TWOHAND_HASTE_ABILITY, target:getMod(xi.mod.DESPERATE_BLOWS) + target:getMerit(xi.merit.DESPERATE_BLOWS))
end)

return m
