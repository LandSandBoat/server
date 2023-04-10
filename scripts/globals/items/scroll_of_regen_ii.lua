-----------------------------------
-- ID: 4718
-- Scroll of Regen II
-- Teaches the white magic Regen II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(110)
end

itemObject.onItemUse = function(target)
    target:addSpell(110)
end

return itemObject
