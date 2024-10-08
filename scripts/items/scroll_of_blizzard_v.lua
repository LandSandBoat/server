-----------------------------------
-- ID: 4761
-- Scroll of Blizzard V
-- Teaches the black magic Blizzard V
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BLIZZARD_V)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BLIZZARD_V)
end

return itemObject
