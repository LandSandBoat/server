-----------------------------------
-- ID: 4690
-- Scroll of Baramnesia
-- Teaches the white magic Baramnesia
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(84)
end

itemObject.onItemUse = function(target)
    target:addSpell(84)
end

return itemObject
