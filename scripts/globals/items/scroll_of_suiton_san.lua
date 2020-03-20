-----------------------------------------
-- ID: 4945
-- Scroll of Suiton: San
-- Teaches the ninjutsu Suiton: San
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(337)
end

function onItemUse(target)
    target:addSpell(337)
end
