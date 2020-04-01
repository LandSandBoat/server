-----------------------------------------
-- ID: 4721
-- Scroll of Repose
-- Teaches the white magic Repose
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(98)
end

function onItemUse(target)
    target:addSpell(98)
end
