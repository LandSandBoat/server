-----------------------------------
-- Module: Dia III: DoT duration scales directly with merit rank, 30s per rank.
-- Source: https://forum.square-enix.com/ffxi/threads/55751-August.-6-2019-%28JST%29-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('dia_effect_adjustments', xi.pre(xi.expansion.ROV))

m:addOverride('xi.effects.dia.onEffectGain', function(target, effect)
    super(target, effect)

    if effect:getTier() == 5 then
        local caster        = GetPlayerByID(effect:getOriginID())
        local meritDuration = caster and caster:getMerit(xi.merit.DIA_III) or 0

        -- A duration of 0 never expires.
        if meritDuration > 0 then
            effect:setDuration(meritDuration * 1000)
        end
    end
end)

return m
