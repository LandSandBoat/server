-----------------------------------
-- Altana's Favor
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    local level = player:getMainLvl() * 2

    if player:getMP() < level then
        return xi.msg.basic.UNABLE_TO_USE_JA, 0
    end

    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill, master, action)
    if not target:isPC() then
        skill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
        return 0
    end

    master:setMP(0)

    if target:isDead() then
        target:sendRaise(4) -- arise
    elseif target:addStatusEffect(xi.effect.RERAISE, 3, 0, 0) then -- Infinite duration http://wiki.ffo.jp/html/30976.html
        skill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
        return xi.effect.RERAISE
    else
        skill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
        return 0
    end
end

return abilityObject
