-----------------------------------
-- ID: 5494
-- Puppetmaster Die
-- Teaches the job ability Puppet Roll
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnAbility(xi.jobAbility.PUPPET_ROLL)
end

item_object.onItemUse = function(target)
    target:addLearnedAbility(xi.jobAbility.PUPPET_ROLL)
end

return item_object
