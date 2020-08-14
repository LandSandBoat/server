-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
    local pet = target:getPet()
    if (pet) then
        pet:addMod(tpz.mod.MND, effect:getPower())
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local pet = target:getPet()
    if (pet) then
        pet:delMod(tpz.mod.MND, effect:getPower())
    end
end
