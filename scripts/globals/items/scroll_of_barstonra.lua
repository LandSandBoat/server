-----------------------------------
-- ID: 4677
-- Scroll of Barstonra
-- Teaches the white magic Barstonra
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(69)
end

itemObject.onItemUse = function(target)
    target:addSpell(69)
end

return itemObject
