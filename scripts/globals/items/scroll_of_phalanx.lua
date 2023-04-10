-----------------------------------
-- ID: 4714
-- Scroll of Phalanx
-- Teaches the white magic Phalanx
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(106)
end

itemObject.onItemUse = function(target)
    target:addSpell(106)
end

return itemObject
