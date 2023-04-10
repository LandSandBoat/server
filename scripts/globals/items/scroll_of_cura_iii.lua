-----------------------------------
-- ID: 5083
-- Scroll of Cura III
-- Teaches the white magic Cura III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(475)
end

itemObject.onItemUse = function(target)
    target:addSpell(475)
end

return itemObject
