-----------------------------------
-- ID: 4672
-- Scroll of Barthunder
-- Teaches the white magic Barthunder
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(64)
end

itemObject.onItemUse = function(target)
    target:addSpell(64)
end

return itemObject
