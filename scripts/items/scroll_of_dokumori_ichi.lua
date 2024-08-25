-----------------------------------
-- ID: 4958
-- Scroll of Dokumori: Ichi
-- Teaches the ninjutsu Dokumori: Ichi
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.DOKUMORI_ICHI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.DOKUMORI_ICHI)
end

return itemObject
