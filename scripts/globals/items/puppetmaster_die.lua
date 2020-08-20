-----------------------------------------
-- ID: 5494
-- Puppetmaster Die
-- Teaches the job ability Puppet Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(tpz.jobAbility.PUPPET_ROLL)
end

function onItemUse(target)
    target:addLearnedAbility(tpz.jobAbility.PUPPET_ROLL)
end
