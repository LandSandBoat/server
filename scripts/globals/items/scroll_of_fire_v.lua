-----------------------------------------
-- ID: 4756
-- Scroll of Fire V
-- Teaches the Black magic Fire V
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(148)
end

function onItemUse(target)
    target:addSpell(148)
end
