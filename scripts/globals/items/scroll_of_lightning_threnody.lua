-----------------------------------
-- ID: 5066
-- Scroll of Lightning Threnody
-- Teaches the song Lightning Threnody
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(458)
end

itemObject.onItemUse = function(target)
    target:addSpell(458)
end

return itemObject
