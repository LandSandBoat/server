-----------------------------------
-- ID: 4949
-- Scroll of Jubaku: Ichi
-- Teaches the ninjutsu Jubaku: Ichi
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.JUBAKU_ICHI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.JUBAKU_ICHI)
end

return itemObject
