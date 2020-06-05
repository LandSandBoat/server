-----------------------------------------
-- ID: 4947
-- Scroll of Utsusemi: Ni
-- Teaches the ninjutsu Utsusemi: Ni
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(339)
end

function onItemUse(target)
    target:addSpell(339)
end
