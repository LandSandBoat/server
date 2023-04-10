-----------------------------------
-- ID: 4890
-- Scroll of Firaja
-- Teaches the black magic Firaja
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(496)
end

itemObject.onItemUse = function(target)
    target:addSpell(496)
end

return itemObject
