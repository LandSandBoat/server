-----------------------------------
-- ID: 5494
-- Puppetmaster Die
-- Teaches the job ability Puppet Roll
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnAbility(xi.jobAbility.PUPPET_ROLL)
end

itemObject.onItemUse = function(target)
    target:addLearnedAbility(xi.jobAbility.PUPPET_ROLL)
end

return itemObject
