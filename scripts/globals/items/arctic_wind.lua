-----------------------------------
-- ID: 18161
-- Item: Arctic Wind
-- Additional Effect: Removes Suzaku's Fire Damage
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    if (target:getFamily() == 280) then
        target:setMobMod(xi.mobMod.ADD_EFFECT, 0)
    end
    return 0, 0, 0
end

return item_object
