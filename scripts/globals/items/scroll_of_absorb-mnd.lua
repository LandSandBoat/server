-----------------------------------
-- ID: 4879
-- Scroll of Absorb-MND
-- Teaches the black magic Absorb-MND
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(271)
end

itemObject.onItemUse = function(target)
    target:addSpell(271)
end

return itemObject
