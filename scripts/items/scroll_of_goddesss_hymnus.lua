-----------------------------------
-- ID: 5072
-- Scroll of Goddess's Hymnus
-- Teaches the song Goddess's Hymnus
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.GODDESSS_HYMNUS)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.GODDESSS_HYMNUS)
end

return itemObject
