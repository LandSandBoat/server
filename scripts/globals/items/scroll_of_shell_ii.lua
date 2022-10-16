-----------------------------------
-- ID: 4657
-- Scroll of Shell II
-- Teaches the white magic Shell II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(49)
end

itemObject.onItemUse = function(target)
    target:addSpell(49)
end

return itemObject
