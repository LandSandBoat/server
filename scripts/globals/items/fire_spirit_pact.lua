-----------------------------------
-- ID: 4896
-- Fire Spirit Pact
-- Teaches the summoning magicFire Spirit
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(288)
end

item_object.onItemUse = function(target)
    target:addSpell(288)
end

return item_object
