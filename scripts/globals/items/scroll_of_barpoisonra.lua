-----------------------------------
-- ID: 4695
-- Scroll of Barpoisonra
-- Teaches the white magic Barpoisonra
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(87)
end

itemObject.onItemUse = function(target)
    target:addSpell(87)
end

return itemObject
