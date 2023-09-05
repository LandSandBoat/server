-----------------------------------
-- ID: 4755
-- Scroll of Fire IV
-- Teaches the black magic Fire IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FIRE_IV)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FIRE_IV)
end

return itemObject
