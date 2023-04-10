-----------------------------------
-- ID: 4720
-- Scroll of Flash
-- Teaches the white magic Flash
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(112)
end

itemObject.onItemUse = function(target)
    target:addSpell(112)
end

return itemObject
