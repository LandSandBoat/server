-----------------------------------
-- ID: 4736
-- Scroll of Protectra IV
-- Teaches the white magic Protectra IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(128)
end

itemObject.onItemUse = function(target)
    target:addSpell(128)
end

return itemObject
