-----------------------------------
-- Ability: Tame
-- Makes target docile and more susceptible to charm.
-- Obtained: Beastmaster Level 30
-- Recast Time: 10:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/magic")
-----------------------------------
local abilityObject = {}

local tameSort =
{
    [75] = 12,
    [50] = 9,
    [25] = 6,
    [1] = 2,
}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    if player:getPet() ~= nil then
        ability:setMsg(xi.msg.basic.JA_NO_EFFECT)
        return 0
    end

    if target:getMobMod(xi.mobMod.CHARMABLE) == 0 then
        ability:setMsg(xi.msg.basic.JA_NO_EFFECT)
        return 0
    end

    local tameBonus   = 0
    local charmChance = xi.magic.getCharmChance(player, target, false)

    for chance, bonus in pairs(tameSort) do
        if charmChance > chance then
            tameBonus = bonus
            break
        end
    end

    local params = {}
    params.includemab = true
    params.element = xi.magic.ele.NONE
    params.maccBonus = tameBonus + player:getMod(xi.mod.TAME_SUCCESS_RATE)

    local resist = xi.magic.applyAbilityResistance(player, target, params)

    if resist <= 0.25 then
        ability:setMsg(xi.msg.basic.JA_MISS_2)
        return 0
    else
        if target:isEngaged() then
            local enmitylist = target:getEnmityList()

            for _, enmity in ipairs(enmitylist) do
                if enmity.active and enmity.entity:getID() ~= player:getID() then
                    ability:setMsg(xi.msg.basic.JA_NO_EFFECT)
                    return 0
                elseif enmity.entity:getID() == player:getID() then
                    if not enmity.tameable then
                        ability:setMsg(xi.msg.basic.JA_NO_EFFECT)
                        return 0
                    end
                end
            end

            ability:setMsg(138) -- The x seems friendlier
            target:disengage()
        else
            player:setLocalVar("Tamed_Mob", target:getID())
            ability:setMsg(138) -- The x seems friendlier
        end
    end
end

return abilityObject
