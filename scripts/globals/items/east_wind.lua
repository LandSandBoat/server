-----------------------------------
-- ID: 18162
-- Item: East Wind
-- Additional Effect: Removes Byakko's Light Damage
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    if (target:getFamily() == 279) then
        target:setMobMod(xi.mobMod.ADD_EFFECT, 0)
    end
    return 0, 0, 0
end

return item_object
