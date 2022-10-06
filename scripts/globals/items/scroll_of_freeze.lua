-----------------------------------
-- ID: 4814
-- Scroll of Freeze
-- Teaches the black magic Freeze
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(206)
end

itemObject.onItemUse = function(target)
    target:addSpell(206)
end

return itemObject
