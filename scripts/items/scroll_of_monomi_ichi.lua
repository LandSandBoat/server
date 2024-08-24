-----------------------------------
-- ID: 4964
-- Scroll of Monomi: Ichi
-- Teaches the ninjutsu Monomi: Ichi
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.MONOMI_ICHI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.MONOMI_ICHI)
end

return itemObject
