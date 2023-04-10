-----------------------------------
-- ID: 4846
-- Scroll of Rasp
-- Teaches the black magic Rasp
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(238)
end

itemObject.onItemUse = function(target)
    target:addSpell(238)
end

return itemObject
