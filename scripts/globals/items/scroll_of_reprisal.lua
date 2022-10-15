-----------------------------------
-- ID: 4715
-- Scroll of Reprisal
-- Teaches the white magic Reprisal
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(97)
end

itemObject.onItemUse = function(target)
    target:addSpell(97)
end

return itemObject
