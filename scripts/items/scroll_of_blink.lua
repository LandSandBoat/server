-----------------------------------
-- ID: 4661
-- Scroll of Blink
-- Teaches the white magic Blink
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BLINK)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BLINK)
end

return itemObject
