---------------------------------------------
-- Whispering Wind
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill)
    local base = 16 + pet:getMainLvl()*2.5

    if (target:getHP()+base > target:getMaxHP()) then
        base = target:getMaxHP() - target:getHP() --cap it
    end
    skill:setMsg(tpz.msg.basic.SELF_HEAL)
    target:addHP(base)
    return base
end
