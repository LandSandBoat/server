-----------------------------------
-- Ability: Warcry
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
            level = 35,
        },
        recast       =
        {
            time    = 300,
            meritId = xi.merit.WARCRY_RECAST,
        },
        animation    = 28,
        message      = 116,
        enmity       =
        {
            ce = 1,
            ve = 300,
        },
        target       = { xi.target.SELF },
        aoe          =
        {
            affects = { xi.target.PARTY },
            sphere  =
            {
                origin = xi.aoe.sphere.CASTER,
                radius = 14,
            },
        },
    }
end

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.warrior.useWarcry(player, target, ability)
end

return abilityObject
