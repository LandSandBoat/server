-----------------------------------
-- ID: 4758
-- Scroll of Blizzard II
-- Teaches the black magic Blizzard II
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BLIZZARD_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BLIZZARD_II)
end

return itemObject
