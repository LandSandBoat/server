-----------------------------------
-- ID: 5064
-- Scroll of Wind Threnody
-- Teaches the song Wind Threnody
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(456)
end

itemObject.onItemUse = function(target)
    target:addSpell(456)
end

return itemObject
