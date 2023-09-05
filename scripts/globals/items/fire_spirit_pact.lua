-----------------------------------
-- ID: 4896
-- Fire Spirit Pact
-- Teaches the summoning magicFire Spirit
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FIRE_SPIRIT)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FIRE_SPIRIT)
end

return itemObject
