-----------------------------------------
-- ID: 4656
-- Scroll of Shell
-- Teaches the white magic Shell
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(48)
end

function onItemUse(target)
    target:addSpell(48)
end
