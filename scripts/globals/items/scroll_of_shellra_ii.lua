-----------------------------------
-- ID: 4739
-- Scroll of Shellra II
-- Teaches the white magic Shellra II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.SHELLRA_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SHELLRA_II)
end

return itemObject
