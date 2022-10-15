-----------------------------------
-- ID: 4762
-- Scroll of Aero
-- Teaches the black magic Aero
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(154)
end

itemObject.onItemUse = function(target)
    target:addSpell(154)
end

return itemObject
