-----------------------------------
-- ID: 4668
-- Scroll of Barfire
-- Teaches the white magic Barfire
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(60)
end

itemObject.onItemUse = function(target)
    target:addSpell(60)
end

return itemObject
