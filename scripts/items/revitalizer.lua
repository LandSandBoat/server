-----------------------------------
-- ID: 4157
-- Item: Revitalizer
-- Item Effect: Resets all Job Ability Timers
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    target:resetRecasts()
    target:messageBasic(xi.msg.basic.ALL_ABILITIES_RECHARGED, 0)
end

return itemObject
