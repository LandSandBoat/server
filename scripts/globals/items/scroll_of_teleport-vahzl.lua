-----------------------------------
-- ID: 4747
-- Scroll of Teleport-Vahzl
-- Teaches the white magic Teleport-Vahzl
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(139)
end

itemObject.onItemUse = function(target)
    target:addSpell(139)
end

return itemObject
