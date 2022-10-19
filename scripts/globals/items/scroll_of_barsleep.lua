-----------------------------------
-- ID: 4680
-- Scroll of Barsleep
-- Teaches the white magic Barsleep
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(72)
end

itemObject.onItemUse = function(target)
    target:addSpell(72)
end

return itemObject
