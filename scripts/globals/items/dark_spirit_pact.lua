-----------------------------------
-- ID: 4903
-- Dark Spirit Pact
-- Teaches the summoning magic Dark Spirit
-----------------------------------
require("scripts/globals/spell_data")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.DARK_SPIRIT)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.DARK_SPIRIT)
end

return itemObject
