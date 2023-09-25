-----------------------------------
-- ID: 4819
-- Scroll of Quake II
-- Teaches the black magic Quake II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.QUAKE_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.QUAKE_II)
end

return itemObject
