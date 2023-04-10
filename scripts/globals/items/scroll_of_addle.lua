-----------------------------------
-- ID: Unknown
-- Scroll of Addle
-- Teaches the magic Addle
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(286)
end

itemObject.onItemUse = function(target)
    target:addSpell(286)
end

return itemObject
