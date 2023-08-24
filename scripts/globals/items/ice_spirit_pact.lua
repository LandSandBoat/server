-----------------------------------
-- ID: 4897
-- Ice Spirit Pact
-- Teaches the summoning magic ice Spirit
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ICE_SPIRIT)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ICE_SPIRIT)
end

return itemObject
