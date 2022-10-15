-----------------------------------
-- ID: 5027
-- Scroll of Advancing March
-- Teaches the song Advancing March
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(419)
end

itemObject.onItemUse = function(target)
    target:addSpell(419)
end

return itemObject
