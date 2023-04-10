-----------------------------------
-- ID: 6570
-- Scroll of Paralyze II
-- Teaches the white magic Paralyze II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(80)
end

itemObject.onItemUse = function(target)
    target:addSpell(80)
end

return itemObject
