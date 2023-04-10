-----------------------------------
-- ID: 4764
-- Scroll of Aero III
-- Teaches the black magic Aero III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(156)
end

itemObject.onItemUse = function(target)
    target:addSpell(156)
end

return itemObject
