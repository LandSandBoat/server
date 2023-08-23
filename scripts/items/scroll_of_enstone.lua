-----------------------------------
-- ID: 4711
-- Scroll of Enstone
-- Teaches the white magic Enstone
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ENSTONE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ENSTONE)
end

return itemObject
