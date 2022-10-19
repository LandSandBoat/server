-----------------------------------
-- ID: 4878
-- Scroll of Absorb-INT
-- Teaches the black magic Absorb-INT
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(270)
end

itemObject.onItemUse = function(target)
    target:addSpell(270)
end

return itemObject
