-----------------------------------
-- ID: 18164
-- Item: Antarctic Wind
-- Additional Effect: Removes Genbu's Water Damage
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    if (target:getFamily() == 277) then
        target:setMobMod(tpz.mobMod.ADD_EFFECT, 0)
    end
    return 0, 0, 0
end

return item_object
