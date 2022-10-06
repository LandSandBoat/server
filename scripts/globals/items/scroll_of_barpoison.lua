-----------------------------------
-- ID: 4681
-- Scroll of Barpoison
-- Teaches the white magic Barpoison
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(73)
end

itemObject.onItemUse = function(target)
    target:addSpell(73)
end

return itemObject
