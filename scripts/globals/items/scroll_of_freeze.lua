-----------------------------------------
-- ID: 4814
-- Scroll of Freeze
-- Teaches the black magic Freeze
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(206)
end

function onItemUse(target)
    target:addSpell(206)
end
