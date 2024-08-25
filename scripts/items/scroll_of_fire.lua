-----------------------------------
-- ID: 4752
-- Scroll of Fire
-- Teaches the black magic Fire
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.FIRE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FIRE)
end

return itemObject
