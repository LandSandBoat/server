-----------------------------------
-- ID: 4695
-- Scroll of Barpoisonra
-- Teaches the white magic Barpoisonra
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.BARPOISONRA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BARPOISONRA)
end

return itemObject
