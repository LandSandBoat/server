-----------------------------------
-- ID: 4666
-- Scroll of Paralyze
-- Teaches the white magic Paralyze
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(58)
end

itemObject.onItemUse = function(target)
    target:addSpell(58)
end

return itemObject
