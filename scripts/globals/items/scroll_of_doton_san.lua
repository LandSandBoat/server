-----------------------------------------
-- ID: 4939
-- Scroll of Doton: San
-- Teaches the ninjutsu Doton: San
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(331)
end

function onItemUse(target)
    target:addSpell(331)
end
