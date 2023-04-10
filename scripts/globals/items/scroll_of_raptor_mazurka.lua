-----------------------------------
-- ID: 5075
-- Scroll of Raptor Mazurka
-- Teaches the song Raptor Mazurka
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(467)
end

itemObject.onItemUse = function(target)
    target:addSpell(467)
end

return itemObject
