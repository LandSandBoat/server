---------------------------------------------
-- Slowga
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onPetAbility(target, pet, skill, summoner)
    local duration = 180 + summoner:getMod(tpz.mod.SUMMONING)
    if duration > 350 then
        duration = 350
    end

    if target:addStatusEffect(tpz.effect.SLOW, 3000, 0, duration) then
        skill:setMsg(tpz.msg.basic.SKILL_ENFEEB_IS)
    else
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
    end
    return tpz.effect.SLOW
end
