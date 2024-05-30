-----------------------------------
-- ID: 6048
-- Noctohelix Schema
-- Teaches the black magic Noctohelix
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.NOCTOHELIX)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.NOCTOHELIX)
end

return itemObject
