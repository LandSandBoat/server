-----------------------------------
-- ID: 4834
-- Scroll of Poisonga II
-- Teaches the black magic Poisonga II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(226)
end

itemObject.onItemUse = function(target)
    target:addSpell(226)
end

return itemObject
