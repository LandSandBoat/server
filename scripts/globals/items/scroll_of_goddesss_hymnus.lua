-----------------------------------------
-- ID: 5072
-- Scroll of Goddess's Hymnus
-- Teaches the song Goddess's Hymnus
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(464)
end

function onItemUse(target)
    target:addSpell(464)
end
