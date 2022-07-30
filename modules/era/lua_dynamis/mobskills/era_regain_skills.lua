--------------------------------------------
--         Dynamis 75 Era Module          --
--------------------------------------------
--------------------------------------------
--       Module Required Scripts          --
--------------------------------------------
require("scripts/globals/dynamis")
require("modules/module_utils")
--------------------------------------------

local m = Module:new("era_regain_skills")

m:addOverride("xi.globals.mobskills.regain_hp.onMobWeaponSkill", function(target, mob, skill)

    local hp = target:getMaxHP() - target:getHP()

    skill:setMsg(xi.msg.basic.AOE_REGAIN_HP)

    target:addHP(hp)
    target:wakeUp()

    if mob:getFamily() >= 92 and mob:getFamily() <= 95 then -- Dynamis Statue
        mob:setUntargetable(false)
        mob:SetAutoAttackEnabled(true)
        mob:setUnkillable(false)
        mob:setHP(0)
    end

    return hp

end)

m:addOverride("xi.globals.mobskills.regain_mp.onMobWeaponSkill", function(target, mob, skill)

    local mp = target:getMaxMP() - target:getMP()

    skill:setMsg(xi.msg.basic.AOE_REGAIN_MP)

    target:addMP(mp)

    if mob:getFamily() >= 92 and mob:getFamily() <= 95 then -- Dynamis Statue
        mob:setUntargetable(false)
        mob:SetAutoAttackEnabled(true)
        mob:setUnkillable(false)
        mob:setHP(0)
    end

    return mp

end)

return m