-----------------------------------
-- ID: 5068
-- Scroll of Light Threnody
-- Teaches the song Light Threnody
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(460)
end

itemObject.onItemUse = function(target)
    target:addSpell(460)
end

return itemObject
