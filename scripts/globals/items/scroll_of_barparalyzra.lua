-----------------------------------
-- ID: 4696
-- Scroll of Barparalyzra
-- Teaches the white magic Barparalyzra
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(88)
end

itemObject.onItemUse = function(target)
    target:addSpell(88)
end

return itemObject
