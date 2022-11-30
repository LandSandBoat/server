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

local removableStatus =
{
    xi.effect.SILENCE,
    xi.effect.BLINDNESS,
    xi.effect.POISON,
    xi.effect.PARALYSIS,
}

itemObject.onItemUse = function(target)
    for _, effectId in ipairs(removableStatus) do
        if target:hasStatusEffect(effectId) then
            target:delStatusEffect(effectId)
        end
    end

    local rDisease = math.random(1, 2) -- Disease is not guaranteed to be cured, 1 means removed 2 means fail. 50% chance
    if rDisease == 1 and target:hasStatusEffect(xi.effect.DISEASE) then
        target:delStatusEffect(xi.effect.DISEASE)
    end
end

return itemObject
