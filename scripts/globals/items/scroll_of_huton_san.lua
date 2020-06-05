-----------------------------------------
-- ID: 4936
-- Scroll of Huton: San
-- Teaches the ninjutsu Huton: San
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(328)
end

function onItemUse(target)
    target:addSpell(328)
end
