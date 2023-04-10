-----------------------------------
-- ID: 5048
-- Scroll of Wind Carol
-- Teaches the song Wind Carol
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(440)
end

itemObject.onItemUse = function(target)
    target:addSpell(440)
end

return itemObject
