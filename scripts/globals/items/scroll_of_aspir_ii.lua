-----------------------------------
-- ID: 4856
-- Scroll of Aspir II
-- Teaches the black magic Aspir II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ASPIR_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ASPIR_II)
end

return itemObject
