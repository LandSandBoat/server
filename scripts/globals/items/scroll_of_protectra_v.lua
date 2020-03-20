-----------------------------------------
-- ID: 4737
-- Scroll of Protectra V
-- Teaches the white magic Protectra V
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(129)
end

function onItemUse(target)
    target:addSpell(129)
end
