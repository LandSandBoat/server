-----------------------------------------
-- ID: 4942
-- Scroll of Raiton: San
-- Teaches the ninjutsu Raiton: San
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(334)
end

function onItemUse(target)
    target:addSpell(334)
end
