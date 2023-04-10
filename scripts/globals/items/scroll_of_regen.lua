-----------------------------------
-- ID: 4716
-- Scroll of Regen
-- Teaches the white magic Regen
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(108)
end

itemObject.onItemUse = function(target)
    target:addSpell(108)
end

return itemObject
