-----------------------------------
-- ID: 5062
-- Scroll of Fire Threnody
-- Teaches the song Fire Threnody
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(454)
end

itemObject.onItemUse = function(target)
    target:addSpell(454)
end

return itemObject
