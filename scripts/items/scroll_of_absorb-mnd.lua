-----------------------------------
-- ID: 4879
-- Scroll of Absorb-MND
-- Teaches the black magic Absorb-MND
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.ABSORB_MND)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ABSORB_MND)
end

return itemObject
