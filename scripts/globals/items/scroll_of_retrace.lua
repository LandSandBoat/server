-----------------------------------
-- ID: 4873
-- Scroll of Retrace
-- Teaches the black magic Retrace
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(241)
end

itemObject.onItemUse = function(target)
    target:addSpell(241)
end

return itemObject
