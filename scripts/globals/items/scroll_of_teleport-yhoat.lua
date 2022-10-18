-----------------------------------
-- ID: 4728
-- Scroll of Teleport-Yhoat
-- Teaches the white magic Teleport-Yhoat
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(120)
end

itemObject.onItemUse = function(target)
    target:addSpell(120)
end

return itemObject
