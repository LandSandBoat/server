-----------------------------------
-- ID: 4153
-- Item: Antacid
-- Item Effect: This medicine helps remove meal effects.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if (target:hasStatusEffect(tpz.effect.FOOD) == true) then
        target:delStatusEffect(tpz.effect.FOOD)
    elseif (target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) == true) then
        target:delStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD)
    end
end

return item_object
