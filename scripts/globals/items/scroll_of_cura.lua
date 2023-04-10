-----------------------------------
-- ID: 4701
-- Scroll of Cura
-- Teaches the white magic Cura
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(93)
end

itemObject.onItemUse = function(target)
    target:addSpell(93)
end

return itemObject
