-----------------------------------
-- ID: 4834
-- Scroll of Poisonga II
-- Teaches the black magic Poisonga II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.POISONGA_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.POISONGA_II)
end

return itemObject
