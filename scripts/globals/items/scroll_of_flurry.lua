-----------------------------------
-- ID: 5104
-- Scroll of Flurry
-- Teaches the white magic Flurry
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(845)
end

itemObject.onItemUse = function(target)
    target:addSpell(845)
end

return itemObject
