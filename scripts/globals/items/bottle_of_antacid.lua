-----------------------------------------
-- ID: 4153
-- Item: Antacid
-- Item Effect: This medicine helps remove meal effects.
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    if (target:hasStatusEffect(tpz.effect.FOOD) == true) then
        target:delStatusEffect(tpz.effect.FOOD)
    elseif (target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) == true) then
        target:delStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD)
    end
end
