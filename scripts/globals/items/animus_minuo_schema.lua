-----------------------------------
-- ID: 6060
-- Item: Animus Minuo Schema
-- Teaches the white magic Animus Minuo
-----------------------------------
require("scripts/globals/spell_data")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ANIMUS_MINUO)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ANIMUS_MINUO)
end

return itemObject
