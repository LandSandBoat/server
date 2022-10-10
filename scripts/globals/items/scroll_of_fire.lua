-----------------------------------
-- ID: 4752
-- Scroll of Fire
-- Teaches the black magic Fire
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(144)
end

itemObject.onItemUse = function(target)
    target:addSpell(144)
end

return itemObject
