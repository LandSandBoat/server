-----------------------------------
-- ID: 5000
-- Scroll of Knights Minne IV
-- Teaches the song Mages Ballad IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(392)
end

itemObject.onItemUse = function(target)
    target:addSpell(392)
end

return itemObject
