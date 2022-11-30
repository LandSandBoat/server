-----------------------------------
-- ID: 4819
-- Scroll of Quake II
-- Teaches the black magic Quake II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(211)
end

itemObject.onItemUse = function(target)
    target:addSpell(211)
end

return itemObject
