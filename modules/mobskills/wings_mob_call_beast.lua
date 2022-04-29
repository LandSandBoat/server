-----------------------------------
-- Add some npcs for testers in starter cities.
-----------------------------------
require("scripts/globals/dynamis")
require("modules/module_utils")
-----------------------------------
local m = Module:new("wings_mob_call_beast")
m:setEnabled(true)

m:addOverride("mobskill_object.onMobWeaponSkill", function(target, mob, skill)
    if mob:isInDynamis() == true then
        xi.dynamis.spawnDynamicBSTPet(target, mob)
    else
        mob:spawnPet()

        skill:setMsg(xi.msg.basic.NONE)
    end

    return 0

end)

return m