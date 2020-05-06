-----------------------------------------
-- ID: 5191
-- Summoner Die
-- Teaches the job ability Evoker's Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(96)
end

function onItemUse(target)
    target:addLearnedAbility(96)
end
