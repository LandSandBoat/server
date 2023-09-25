-----------------------------------
-- ID: 4766
-- Scroll of Aero V
-- Teaches the black magic Aero V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.AERO_V)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.AERO_V)
end

return itemObject
