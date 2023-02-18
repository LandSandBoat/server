-----------------------------------
-- ID: 15320
-- Powder Boots
--  Enchantment: "Flee"
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.FLEE)
    if effect ~= nil and effect:getItemSourceID() == 15320 then
        target:delStatusEffect(xi.effect.FLEE)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:delStatusEffect(xi.effect.FLEE)
    target:addStatusEffect(xi.effect.FLEE, 100, 0, 30, 0, 0, 0, 15320)
end

return itemObject
