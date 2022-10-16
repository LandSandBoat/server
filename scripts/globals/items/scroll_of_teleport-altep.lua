-----------------------------------
-- ID: 4729
-- Scroll of Teleport-Altep
-- Teaches the white magic Teleport-Altep
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(121)
end

itemObject.onItemUse = function(target)
    target:addSpell(121)
end

return itemObject
