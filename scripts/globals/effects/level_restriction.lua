-----------------------------------
--
--     tpz.effect.LEVEL_RESTRICTION
--
-----------------------------------

function onEffectGain(target, effect)
    target:levelRestriction(effect:getPower())
    target:messageBasic(314, effect:getPower()) -- <target>'s level is restricted to <param>
end


function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:levelRestriction(0)
end
