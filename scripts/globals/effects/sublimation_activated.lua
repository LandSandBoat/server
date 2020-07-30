-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
end

function onEffectTick(target, effect)
    local complete = false
    local level = 0
    if (target:getMainJob() == tpz.job.SCH) then
        level = target:getMainLvl()
    else
        level = target:getSubLvl()
    end
    local basemp = math.floor((level - 15)/10)
    local bonus = target:getMod(tpz.mod.SUBLIMATION_BONUS)

    local dmg = 2 + bonus

    local store = effect:getPower() + basemp + bonus

    local limit = math.floor((target:getBaseHP() + target:getMod(tpz.mod.HP) + target:getMerit(tpz.merit.MAX_HP)) / 4) +
        target:getMerit(tpz.merit.MAX_SUBLIMATION)

    if not (target:getHPP() < 51 ) then
        if (target:hasStatusEffect(tpz.effect.STONESKIN)) then
            local skin = target:getMod(tpz.mod.STONESKIN)
            if (skin >= dmg) then --absorb all damage
                target:delMod(tpz.mod.STONESKIN, dmg)
            else
                target:delStatusEffect(tpz.effect.STONESKIN)
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
        target:delStatusEffectSilent(tpz.effect.SUBLIMATION_ACTIVATED)
        target:addStatusEffect(tpz.effect.SUBLIMATION_COMPLETE, store, 0, 7200)
    else
        effect:setPower(store)
    end

end

function onEffectLose(target, effect)
end
