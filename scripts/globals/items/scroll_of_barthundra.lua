-----------------------------------
-- ID: 4678
-- Scroll of Barthundra
-- Teaches the white magic Barthundra
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(70)
end

itemObject.onItemUse = function(target)
    target:addSpell(70)
end

return itemObject
