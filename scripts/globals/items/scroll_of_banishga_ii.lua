-----------------------------------
-- ID: 4647
-- Scroll of Banishga II
-- Teaches the white magic Banishga II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BANISHGA_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BANISHGA_II)
end

return itemObject
