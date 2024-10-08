-----------------------------------
-- ID: 4921
-- Scroll of Aerora II
-- Teaches the black magic Aerora II
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.AERA_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.AERA_II)
end

return itemObject
