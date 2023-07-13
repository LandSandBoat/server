-----------------------------------
-- ID: 4902
-- Light Spirit Pact
-- Teaches the summoning magic Air Spirit
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.LIGHT_SPIRIT)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.LIGHT_SPIRIT)
end

return itemObject
