-----------------------------------
-- ID: 4899
-- Earth Spirit Pact
-- Teaches the summoning magic Earth Spirit
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.EARTH_SPIRIT)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.EARTH_SPIRIT)
end

return itemObject
