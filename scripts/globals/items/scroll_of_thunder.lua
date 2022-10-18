-----------------------------------
-- ID: 4772
-- Scroll of Thunder
-- Teaches the black magic Thunder
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(164)
end

itemObject.onItemUse = function(target)
    target:addSpell(164)
end

return itemObject
