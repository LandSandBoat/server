-----------------------------------
-- ID: 4765
-- Scroll of Aero IV
-- Teaches the black magic Aero IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.AERO_IV)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.AERO_IV)
end

return itemObject
