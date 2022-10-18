-----------------------------------
-- ID: 4719
-- Scroll of Regen III
-- Teaches the white magic Regen III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(111)
end

itemObject.onItemUse = function(target)
    target:addSpell(111)
end

return itemObject
