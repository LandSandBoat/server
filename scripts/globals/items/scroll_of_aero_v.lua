-----------------------------------
-- ID: 4766
-- Scroll of Aero V
-- Teaches the black magic Aero V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(158)
end

itemObject.onItemUse = function(target)
    target:addSpell(158)
end

return itemObject
