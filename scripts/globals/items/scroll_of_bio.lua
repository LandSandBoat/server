-----------------------------------
-- ID: 4838
-- Scroll of Bio
-- Teaches the black magic Bio
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(230)
end

itemObject.onItemUse = function(target)
    target:addSpell(230)
end

return itemObject
