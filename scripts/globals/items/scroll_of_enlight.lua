-----------------------------------
-- ID: 4706
-- Scroll of Enlight
-- Teaches the white magic Enlight
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(310)
end

itemObject.onItemUse = function(target)
    target:addSpell(310)
end

return itemObject
