-----------------------------------
-- ID: 4737
-- Scroll of Protectra V
-- Teaches the white magic Protectra V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(129)
end

itemObject.onItemUse = function(target)
    target:addSpell(129)
end

return itemObject
