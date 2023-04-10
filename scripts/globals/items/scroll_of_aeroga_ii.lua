-----------------------------------
-- ID: 4793
-- Scroll of Aeroga II
-- Teaches the black magic Aeroga II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(185)
end

itemObject.onItemUse = function(target)
    target:addSpell(185)
end

return itemObject
