-----------------------------------
-- ID: 6044
-- Cryohelix Schema
-- Teaches the black magic Cryohelix
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.CRYOHELIX)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.CRYOHELIX)
end

return itemObject
