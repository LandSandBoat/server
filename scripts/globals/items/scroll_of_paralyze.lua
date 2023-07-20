-----------------------------------
-- ID: 4666
-- Scroll of Paralyze
-- Teaches the white magic Paralyze
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.PARALYZE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.PARALYZE)
end

return itemObject
