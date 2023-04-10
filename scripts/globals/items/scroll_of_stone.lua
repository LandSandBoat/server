-----------------------------------
-- ID: 4607, 4767
-- Scroll of Stone
-- Teaches the black magic Stone
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(159)
end

itemObject.onItemUse = function(target)
    target:addSpell(159)
end

return itemObject
