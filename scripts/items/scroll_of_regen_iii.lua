-----------------------------------
-- ID: 4719
-- Scroll of Regen III
-- Teaches the white magic Regen III
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.REGEN_III)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.REGEN_III)
end

return itemObject
