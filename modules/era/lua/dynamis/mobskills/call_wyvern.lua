---------------------------------------------
--               Call Wyvern               --
-- Used to Allow for Dynamic Wyvern Entity --
---------------------------------------------
---------------------------------------------
--        Module Required Scripts          --
---------------------------------------------
require("modules/module_utils")

local m = Module:new("era_call_wyvern")

m:addOverride("xi.globals.mobskills.call_wyvern.onMobWeaponSkill", function(target, mob, skill)
    local zoneType = mob:getZone():getType()

    if zoneType == xi.zoneType.DYNAMIS then
        xi.dynamis.spawnDynamicPet(target, mob)
    else
        mob:spawnPet()
    end

    skill:setMsg(xi.msg.basic.NONE)

    return 0

end)

return m