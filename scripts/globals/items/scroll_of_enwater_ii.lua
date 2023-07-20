-----------------------------------
-- ID: 4727
-- Scroll of Enwater II
-- Teaches the white magic Enwater II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ENWATER_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ENWATER_II)
end

return itemObject
