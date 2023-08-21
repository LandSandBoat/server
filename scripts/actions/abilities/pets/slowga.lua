-----------------------------------
-- Slowga
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill, summoner)
    local duration = 180 + summoner:getMod(xi.mod.SUMMONING)
    if duration > 350 then
        duration = 350
    end

    if target:addStatusEffect(xi.effect.SLOW, 3000, 0, duration) then
        skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end

    return xi.effect.SLOW
end

return abilityObject
