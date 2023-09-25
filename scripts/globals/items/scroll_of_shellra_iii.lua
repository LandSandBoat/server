-----------------------------------
-- ID: 4740
-- Scroll of Shellra III
-- Teaches the white magic Shellra III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.SHELLRA_III)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SHELLRA_III)
end

return itemObject
