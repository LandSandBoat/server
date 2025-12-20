-----------------------------------
-- Ability: Provoke
-- Job: Warrior
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilitySetup = function()
    return
    {
        requirements =
        {
            job   = xi.job.WAR,
            level = 5,
        },
        recast       =
        {
            time = 30,
        },
        animation    = 3,
        message      = 119,
        enmity       =
        {
            ce = 1,
            ve = 1800,
        },
        range        = 16,
        target       = { xi.target.HOSTILE },
    }
end

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(user, target, ability)
    --Leave blank.
end

return abilityObject
