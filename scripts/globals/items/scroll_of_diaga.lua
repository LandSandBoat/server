-----------------------------------
-- ID: 4641
-- Scroll of Diaga
-- Teaches the white magic Diaga
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(33)
end

itemObject.onItemUse = function(target)
    target:addSpell(33)
end

return itemObject
