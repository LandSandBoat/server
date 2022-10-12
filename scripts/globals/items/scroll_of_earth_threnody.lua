-----------------------------------
-- ID: 5065
-- Scroll of Earth Threnody
-- Teaches the song Earth Threnody
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(457)
end

itemObject.onItemUse = function(target)
    target:addSpell(457)
end

return itemObject
