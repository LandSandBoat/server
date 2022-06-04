---------------------------------------------
--               Call Wyvern               --
-- Used to Allow for Dynamic Wyvern Entity --
---------------------------------------------
---------------------------------------------
--        Module Required Scripts          --
---------------------------------------------
require("scripts/globals/dynamis")
require("modules/era/lua/dynamis/globals/era_dynamis")
require("modules/era/lua/dynamis/globals/era_dynamis_spawning")
require("modules/module_utils")
require("scripts/globals/mobskills/call_wyvern")

local m = Module:new("era_call_wyvern")

m:addOverride("xi.globals.mobskills.call_wyvern.onMobWeaponSkill", function(target, mob, skill)
    local zoneType = mob:getZone():getType()

    if zoneType == xi.zoneType.DYNAMIS then
        if mob:getName() == "Apocalyptic_Beast" then
            for i = 5, 1, -1 do
                xi.dynamis.spawnDynamicPet(target, mob, xi.job.DRG)
            end
        else
            xi.dynamis.spawnDynamicPet(target, mob, xi.job.DRG)
        end
    else
        mob:spawnPet()
    end

    skill:setMsg(xi.msg.basic.NONE)

    return 0

end)

return m