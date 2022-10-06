-----------------------------------
-- ID: 4760
-- Scroll of Blizzard IV
-- Teaches the black magic Blizzard IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(152)
end

itemObject.onItemUse = function(target)
    target:addSpell(152)
end

return itemObject
