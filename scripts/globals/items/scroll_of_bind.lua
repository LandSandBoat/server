-----------------------------------
-- ID: 4866
-- Scroll of Bind
-- Teaches the black magic Bind
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(258)
end

itemObject.onItemUse = function(target)
    target:addSpell(258)
end

return itemObject
