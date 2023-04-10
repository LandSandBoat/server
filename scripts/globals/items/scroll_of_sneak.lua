-----------------------------------
-- ID: 4745
-- Scroll of Sneak
-- Teaches the white magic Sneak
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(137)
end

itemObject.onItemUse = function(target)
    target:addSpell(137)
end

return itemObject
