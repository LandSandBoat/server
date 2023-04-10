-----------------------------------
-- ID: 5073
-- Scroll of Chocobo Mazurka
-- Teaches the song Chocobo Mazurka
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(465)
end

itemObject.onItemUse = function(target)
    target:addSpell(465)
end

return itemObject
