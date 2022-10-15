-----------------------------------
-- ID: 5047
-- Scroll of Ice Carol
-- Teaches the song Ice Carol
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(439)
end

itemObject.onItemUse = function(target)
    target:addSpell(439)
end

return itemObject
