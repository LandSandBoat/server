-----------------------------------------
-- ID: 4881
-- Scroll of Sleepga
-- Teaches the black magic Sleepga
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(273)
end

function onItemUse(target)
    target:delSpell(363)
    target:addSpell(273)
end
