-----------------------------------
-- ID: 4808
-- Scroll of Waterga II
-- Teaches the black magic Waterga II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.WATERGA_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WATERGA_II)
end

return itemObject
