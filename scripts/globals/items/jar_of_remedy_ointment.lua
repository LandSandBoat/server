-----------------------------------
-- ID: 5356
-- Item: Remedy Ointment
-- Item Effect: This potion remedies status ailments.
-- Works on paralysis, silence, blindness, poison, and disease.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    if
        target:hasStatusEffect(xi.effect.SILENCE) or
        target:hasStatusEffect(xi.effect.BLINDNESS) or
        target:hasStatusEffect(xi.effect.POISON) or
        target:hasStatusEffect(xi.effect.PARALYSIS) or
        target:hasStatusEffect(xi.effect.DISEASE)
    then
        local effectRemoved = 0
        while effectRemoved == 0 do
            local num = math.random(1, 5)
            if num == 1 and target:hasStatusEffect(xi.effect.SILENCE) then
                effectRemoved = effectRemoved + 1
                target:delStatusEffect(xi.effect.SILENCE)

            elseif num == 2 and target:hasStatusEffect(xi.effect.BLINDNESS) then
                effectRemoved = effectRemoved + 1
                target:delStatusEffect(xi.effect.BLINDNESS)

            elseif num == 3 and target:hasStatusEffect(xi.effect.POISON) then
                effectRemoved = effectRemoved + 1
                target:delStatusEffect(xi.effect.POISON)

            elseif num == 4 and target:hasStatusEffect(xi.effect.PARALYSIS) then
                effectRemoved = effectRemoved + 1
                target:delStatusEffect(xi.effect.PARALYSIS)

            elseif num == 5 and target:hasStatusEffect(xi.effect.DISEASE) then
                effectRemoved = effectRemoved + 1
                target:delStatusEffect(xi.effect.DISEASE)
            end
        end
    end
end

return itemObject
