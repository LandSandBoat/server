-----------------------------------
-- ID: 15320
-- Powder Boots
--  Enchantment: "Flee"
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.FLEE)
    if effect ~= nil and effect:getSubType() == 15320 then
        target:delStatusEffect(xi.effect.FLEE)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:delStatusEffect(xi.effect.FLEE)
    target:addStatusEffect(xi.effect.FLEE, 100, 0, 30, 15320)
end

return item_object
