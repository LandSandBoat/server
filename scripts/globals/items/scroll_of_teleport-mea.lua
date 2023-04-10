-----------------------------------
-- ID: 4732
-- Scroll of Teleport-Mea
-- Teaches the white magic Teleport-Mea
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(124)
end

itemObject.onItemUse = function(target)
    target:addSpell(124)
end

return itemObject
