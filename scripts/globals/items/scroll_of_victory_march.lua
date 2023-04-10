-----------------------------------
-- ID: 5028
-- Scroll of Victory March
-- Teaches the song Victory March
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(420)
end

itemObject.onItemUse = function(target)
    target:addSpell(420)
end

return itemObject
