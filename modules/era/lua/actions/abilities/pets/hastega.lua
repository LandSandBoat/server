-----------------------------------
-- Reverts Hastega to no longer have a duration based on summoning magic and reduces haste power
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(04/08/2009)
-----------------------------------
require('modules/module_utils')
-----------------------------------

local moduleName = 'hastega'

if xi.module.isContentEnabled('WOTG') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

m:addOverride('xi.actions.abilities.pets.hastega.onPetAbility', function(target, pet, petskill, summoner, action)
    local duration = 180

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    -- Reverts Garuda's Hastega to use 102/1024 or 9.96%
    local typeEffect = xi.effect.HASTE
    if target:addStatusEffect(typeEffect, { power = 996, duration = duration, origin = pet }) then
        if target:getID() == action:getPrimaryTargetID() then
            petskill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT_2)
        else
            petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
        end
    else
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
        return
    end

    return typeEffect
end)

return m
