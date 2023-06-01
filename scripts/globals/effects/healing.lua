-----------------------------------
-- xi.effect.HEALING
-- Activated through the /heal command
-----------------------------------
require("scripts/globals/abyssea")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/zone")
require("scripts/globals/roe")
require("scripts/globals/voidwalker")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:setAnimation(33)

    -- Abyssea Lights and time remaining check
    if
        target:isPC() and
        xi.abyssea.isInAbysseaZone(target)
    then
        local visitantEffect = target:getStatusEffect(xi.effect.VISITANT)

        if visitantEffect and visitantEffect:getIcon() == xi.effect.VISITANT then
            xi.abyssea.displayTimeRemaining(target)
            xi.abyssea.displayAbysseaLights(target)
        end
    end

    -- Dances with Luopans
    if
        target:getLocalVar("GEO_DWL_Locus_Area") == 1 and
        target:getCharVar("GEO_DWL_Luopan") == 0
    then
        local ID = zones[target:getZoneID()]
        target:messageSpecial(ID.text.ENERGIES_COURSE)

        local maxWaitTime = 480  -- Max wait of 8 minutes
        local secondsPerTick = xi.settings.map.HEALING_TICK_DELAY
        local minWaitTime = math.min(3 * secondsPerTick, maxWaitTime)
        local waitTimeInSeconds = math.random(minWaitTime, maxWaitTime)
        target:setLocalVar("GEO_DWL_Resting", os.time() + waitTimeInSeconds)
        target:timer(waitTimeInSeconds * 1000, function(targetArg)
            local finishTime = targetArg:getLocalVar("GEO_DWL_Resting")
            if finishTime > 0 and os.time() >= finishTime then
                local ID = zones[targetArg:getZoneID()]
                targetArg:messageSpecial(ID.text.MYSTICAL_WARMTH)  -- You feel a mystical warmth welling up inside you!
                targetArg:setLocalVar("GEO_DWL_Resting", 0)
                targetArg:setCharVar("GEO_DWL_Luopan", 1)
            end
        end)
    end

    if target:getObjType() == xi.objType.PC then
        xi.voidwalker.onHealing(target)
    end
end

effectObject.onEffectTick = function(target, effect)
    local healtime = effect:getTickCount()

    if healtime > 2 then
        -- curse II also known as "zombie"
        if
            not target:hasStatusEffect(xi.effect.DISEASE) and
            not target:hasStatusEffect(xi.effect.PLAGUE) and
            not target:hasStatusEffect(xi.effect.CURSE_II)
        then
            local healHP = 0
            if
                target:getContinentID() == 1 and
                target:hasStatusEffect(xi.effect.SIGNET)
            then
                healHP = 10 + (3 * math.floor(target:getMainLvl() / 10)) + (healtime - 2) * (1 + math.floor(target:getMaxHP() / 300)) + target:getMod(xi.mod.HPHEAL)
            else
                target:addTP(xi.settings.main.HEALING_TP_CHANGE)
                healHP = 10 + (healtime - 2) + target:getMod(xi.mod.HPHEAL)
            end

            -- Records of Eminence: Heal Without Using Magic
            if
                target:getObjType() == xi.objType.PC and
                target:getEminenceProgress(4) and
                healHP > 0 and
                target:getHPP() < 100
            then
                xi.roe.onRecordTrigger(target, 4)
            end

            target:addHPLeaveSleeping(healHP)
            target:updateEnmityFromCure(target, healHP)
            target:addMP(12 + ((healtime - 2) * (1 + target:getMod(xi.mod.CLEAR_MIND))) + target:getMod(xi.mod.MPHEAL))
        end
    end
end

effectObject.onEffectLose = function(target, effect)
    target:setAnimation(0)
    target:delStatusEffect(xi.effect.LEAVEGAME)

    -- Dances with Luopans
    target:setLocalVar("GEO_DWL_Resting", 0)
end

return effectObject
