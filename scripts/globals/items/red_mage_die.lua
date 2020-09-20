-----------------------------------------
-- ID: 5481
-- Red Mage Die
-- Teaches the job ability Warlock's Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.WARLOCKS_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.WARLOCKS_ROLL)
end
