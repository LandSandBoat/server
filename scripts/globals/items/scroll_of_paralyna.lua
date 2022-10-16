-----------------------------------
-- ID: 4623
-- Scroll of Paralyna
-- Teaches the white magic Paralyna
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(15)
end

itemObject.onItemUse = function(target)
    target:addSpell(15)
end

return itemObject
