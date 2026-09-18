-----------------------------------
-- Healing Ruby
-- Family: Avatar (Carbuncle)
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local params = {}

    params.primaryMessage = xi.msg.basic.JA_RECOVERS_HP_2
    params.baseHeal       = 3 * (pet:getMainLvl() - 30)
    params.additiveHeal   = 44
    params.fTP =
    {
        { tp = 0,    modifier = 256 / 256 },
        { tp = 1500, modifier = 351 / 256 },
        { tp = 3000, modifier = 446 / 256 },
    }

    if pet:getMainLvl() <= 30 then
        params.baseHeal     = pet:getMainLvl()
        params.additiveHeal = 14
    end

    -- https://wiki.ffo.jp/html/4079.html
    -- TODO: verify retail fomula
    -- TODO: Capture retail TP scaling
    -- Level 82 - 302 Summoning Skill - LightningDay

    -- TP: 0000  - 301 Healed
    -- TP: 1087  - 337 Healed
    -- TP: 2009  - 397
    -- TP: 3000  - 482

    return xi.mobskills.mobHealMove(pet, target, petskill, action, params)
end

return abilityObject
