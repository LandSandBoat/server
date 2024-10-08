-----------------------------------
-- ID: 4882
-- Scroll of Sleepga II
-- Teaches the black magic Sleepga II
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.SLEEPGA_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SLEEPGA_II)
end

return itemObject
