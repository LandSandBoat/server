-----------------------------------
-- ID: 4900
-- Thunder Spirit Pact
-- Teaches the summoning magic Thunder Spirit
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.THUNDER_SPIRIT)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.THUNDER_SPIRIT)
end

return itemObject
