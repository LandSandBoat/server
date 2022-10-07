-----------------------------------
-- ID: 5069
-- Scroll of Dark Threnody
-- Teaches the song Dark Threnody
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(461)
end

itemObject.onItemUse = function(target)
    target:addSpell(461)
end

return itemObject
