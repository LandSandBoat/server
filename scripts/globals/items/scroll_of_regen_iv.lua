-----------------------------------
-- ID: 5085
-- Scroll of Regen IV
-- Teaches the white magic Regen IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(477)
end

itemObject.onItemUse = function(target)
    target:addSpell(477)
end

return itemObject
