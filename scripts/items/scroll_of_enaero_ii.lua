-----------------------------------
-- ID: 4724
-- Scroll of Enaero II
-- Teaches the white magic Enaero II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ENAERO_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ENAERO_II)
end

return itemObject
