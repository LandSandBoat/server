-----------------------------------
-- ID: 5104
-- Scroll of Flurry
-- Teaches the white magic Flurry
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.FLURRY)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FLURRY)
end

return itemObject
