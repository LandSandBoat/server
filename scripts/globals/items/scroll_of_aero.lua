-----------------------------------
-- ID: 4762
-- Scroll of Aero
-- Teaches the black magic Aero
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.AERO)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.AERO)
end

return itemObject
