-----------------------------------------
-- ID: 4733
-- Scroll of Protectra
-- Teaches the white magic Protectra
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(125)
end

function onItemUse(target)
    target:addSpell(125)
end
