-----------------------------------
-- ID: 4765
-- Scroll of Aero IV
-- Teaches the black magic Aero IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(157)
end

itemObject.onItemUse = function(target)
    target:addSpell(157)
end

return itemObject
