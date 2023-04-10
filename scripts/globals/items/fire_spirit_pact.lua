-----------------------------------
-- ID: 4896
-- Fire Spirit Pact
-- Teaches the summoning magicFire Spirit
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(288)
end

itemObject.onItemUse = function(target)
    target:addSpell(288)
end

return itemObject
