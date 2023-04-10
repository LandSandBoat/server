-----------------------------------
-- ID: 4667
-- Scroll of Silence
-- Teaches the white magic Silence
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(59)
end

itemObject.onItemUse = function(target)
    target:addSpell(59)
end

return itemObject
