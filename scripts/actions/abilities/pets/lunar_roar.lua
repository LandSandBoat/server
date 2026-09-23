-----------------------------------
-- Lunar Roar
-- Family: Avatar (Fenrir)
-- Note: Ability range was increased in Sept. 6, 2016 update:
-- https://wiki.ffo.jp/html/35741.html
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, pet, petskill, summoner, action)

    -- TODO: Can this dispel be resisted?
    local effect = target:dispelStatusEffect()
    if effect == xi.effect.NONE then
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
    else
        for i = 1, 2 do
            if not target:dispelStatusEffect(xi.effectFlag.DISPELABLE) then
                break
            end
        end

        petskill:setMsg(xi.msg.basic.NONE)
    end

    return 0
end

return abilityObject
