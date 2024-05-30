-----------------------------------
-- ID: 6052
-- Hailstorm Schema
-- Teaches the white magic Hailstorm
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.HAILSTORM)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.HAILSTORM)
end

return itemObject
