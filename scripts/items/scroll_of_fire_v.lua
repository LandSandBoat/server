-----------------------------------
-- ID: 4756
-- Scroll of Fire V
-- Teaches the Black magic Fire V
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.FIRE_V)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FIRE_V)
end

return itemObject
