-----------------------------------
-- ID: 4153
-- Item: Antacid
-- Item Effect: This medicine helps remove meal effects.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    if target:hasStatusEffect(xi.effect.FOOD) then
        target:delStatusEffect(xi.effect.FOOD)
    elseif target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD) then
        target:delStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
    end
end

return itemObject
