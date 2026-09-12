-----------------------------------
-- Healing Ruby II
-- Family: Avatar (Carbuncle)
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    -- https://wiki.ffo.jp/html/4080.html
    -- TODO: Capture retail TP scaling
    -- Level 82 - 302 Summoning Skill - IceDay - 0 TP: 733 Healed
    -- TP: 1042 - 843 Healed
    -- TP 2000~ - 964
    -- TP 2900~ - 1072

    local params = {}

    params.primaryMessage = xi.msg.basic.JA_RECOVERS_HP_2
    params.baseHeal       = pet:getMainLvl() * 4
    params.additiveHeal   = 30
    params.fTP =
    {
        { tp = 0,    modifier = 256 / 256 },
        { tp = 1500, modifier = 299 / 256 }, -- TODO: Unconfirmed for 75 era.
        { tp = 3000, modifier = 342 / 256 },
    }

    return xi.mobskills.mobHealMove(pet, target, petskill, action, params)
end

return abilityObject
