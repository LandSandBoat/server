-----------------------------------
-- ID: 4155
-- Item: Remedy
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

    if target:hasStatusEffect(xi.effect.SILENCE) then
        target:delStatusEffect(xi.effect.SILENCE)
    end
    if target:hasStatusEffect(xi.effect.BLINDNESS) then
        target:delStatusEffect(xi.effect.BLINDNESS)
    end
    if target:hasStatusEffect(xi.effect.POISON) then
        target:delStatusEffect(xi.effect.POISON)
    end
    if target:hasStatusEffect(xi.effect.PARALYSIS) then
        target:delStatusEffect(xi.effect.PARALYSIS)
    end

    local rDisease = math.random(1, 2) -- Disease is not garunteed to be cured, 1 means removed 2 means fail. 50% chance
    if rDisease == 1 and target:hasStatusEffect(xi.effect.DISEASE) then
        target:delStatusEffect(xi.effect.DISEASE)
    end
end

return itemObject
