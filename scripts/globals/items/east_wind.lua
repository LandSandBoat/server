-----------------------------------------
-- ID: 18162
-- Item: East Wind
-- Additional Effect: Removes Byakko's Light Damage
-----------------------------------------
require("scripts/globals/status")
-----------------------------------

function onAdditionalEffect(player, target, damage)
    if (target:getFamily() == 279) then
        target:setMobMod(tpz.mobMod.ADD_EFFECT, 0)
    end
    return 0, 0, 0
end
