-----------------------------------
-- ID: 4818
-- Scroll of Quake
-- Teaches the black magic Quake
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.QUAKE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.QUAKE)
end

return itemObject
