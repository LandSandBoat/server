-----------------------------------
-- ID: 4815
-- Scroll of Freeze II
-- Teaches the black magic Freeze II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FREEZE_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FREEZE_II)
end

return itemObject
