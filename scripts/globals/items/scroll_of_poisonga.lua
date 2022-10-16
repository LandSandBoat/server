-----------------------------------
-- ID: 4833
-- Scroll of Poisonga
-- Teaches the black magic Poisonga
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(225)
end

itemObject.onItemUse = function(target)
    target:addSpell(225)
end

return itemObject
