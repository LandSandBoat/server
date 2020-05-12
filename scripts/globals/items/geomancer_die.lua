-----------------------------------------
-- ID: 6368
-- Geomancer Die
-- Teaches the job ability Naturalists Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(374)
end

function onItemUse(target)
    target:addLearnedAbility(374)
end
