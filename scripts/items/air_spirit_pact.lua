-----------------------------------
-- ID: 4898
-- Air Spirit Pact
-- Teaches the summoning magic Air Spirit
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.AIR_SPIRIT)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.AIR_SPIRIT)
end

return itemObject
