-----------------------------------
-- ID: 5063
-- Scroll of Ice Threnody
-- Teaches the song Ice Threnody
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(455)
end

itemObject.onItemUse = function(target)
    target:addSpell(455)
end

return itemObject
