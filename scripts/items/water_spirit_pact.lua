-----------------------------------
-- ID: 4901
-- Water Spirit Pact
-- Teaches the summoning magic Water Spirit
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.WATER_SPIRIT)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.WATER_SPIRIT)
end

return itemObject
