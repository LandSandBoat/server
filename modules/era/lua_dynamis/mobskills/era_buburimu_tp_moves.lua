---------------------------------------------
--       Dynamis-Buburimu mobskills        --
---------------------------------------------
---------------------------------------------
--        Module Required Scripts          --
---------------------------------------------
require("scripts/globals/dynamis")
require("modules/module_utils")
---------------------------------------------
local m = Module:new("era_buburimu_tp_moves")

m:addOverride("xi.globals.mobskills.benediction.onMobWeaponSkill", function(target, mob, skill)
    target:eraseAllStatusEffect()
    local maxHeal = target:getMaxHP() - target:getHP()
    if mob:hasStatusEffect(xi.effect.HYSTERIA) then
        maxHeal = 0
    end

    target:addHP(maxHeal)
    target:wakeUp()
    skill:setMsg(xi.msg.basic.SELF_HEAL)
    if mob:hasStatusEffect(xi.effect.HYSTERIA) then
        skill:setMsg(xi.msg.basic.NONE)
    end

    return maxHeal
end)

return m
