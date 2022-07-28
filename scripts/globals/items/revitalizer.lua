-----------------------------------
-- ID: 4157
-- Item: Revitalizer
-- Item Effect: Resets all Job Ability Timers
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    target:resetRecasts()
    target:messageBasic(xi.msg.basic.ALL_ABILITIES_RECHARGED, 0)
end

return item_object
