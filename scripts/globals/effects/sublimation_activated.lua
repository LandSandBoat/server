-----------------------------------
-- xi.effect.SUBLIMATION_ACTIVATED
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
end

effect_object.onEffectTick = function(target, effect)
    local complete = false
    local level = 0
    if (target:getMainJob() == xi.job.SCH) then
        level = target:getMainLvl()
    else
        level = target:getSubLvl()
    end
    local basemp = math.floor((level - 15)/10)
    local bonus = target:getMod(xi.mod.SUBLIMATION_BONUS)

    local dmg = 2 + bonus

    local store = effect:getPower() + basemp + bonus

    local limit = math.floor((target:getBaseHP() + target:getMod(xi.mod.HP) + target:getMerit(xi.merit.MAX_HP)) / 4) +
        target:getMerit(xi.merit.MAX_SUBLIMATION)

    if not (target:getHPP() < 51 ) then
        if (target:hasStatusEffect(xi.effect.STONESKIN)) then
            local skin = target:getMod(xi.mod.STONESKIN)
            if (skin >= dmg) then --absorb all damage
                target:delMod(xi.mod.STONESKIN, dmg)
            else
                target:delStatusEffect(xi.effect.STONESKIN)
                target:takeDamage(dmg - skin)
                if (target:getHPP() < 51 ) then
                    complete = true
                end
            end
        else
            target:takeDamage(dmg)
            if (target:getHPP() < 51 ) then
                complete = true
            end
        end
    else
        complete = true
    end

    if store > limit then
        store = limit
        complete = true
    end

    if (complete) then
        target:delStatusEffectSilent(xi.effect.SUBLIMATION_ACTIVATED)
        target:addStatusEffect(xi.effect.SUBLIMATION_COMPLETE, store, 0, 7200)
    else
        effect:setPower(store)
    end

end

effect_object.onEffectLose = function(target, effect)
end

return effect_object
