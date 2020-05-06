-----------------------------------------
-- ID: 5494
-- Puppetmaster Die
-- Teaches the job ability Puppet Roll
-----------------------------------------

function onItemCheck(target)
    return target:canLearnAbility(99)
end

function onItemUse(target)
    target:addLearnedAbility(99)
end
