-----------------------------------
-- ID: 4622
-- Scroll of Poisona
-- Teaches the white magic Poisona
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.POISONA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.POISONA)
end

return itemObject
