-----------------------------------
-- ID: 5008
-- Scroll of Blade Madrigal
-- Teaches the song Blade Madrigal
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(400)
end

itemObject.onItemUse = function(target)
    target:addSpell(400)
end

return itemObject
