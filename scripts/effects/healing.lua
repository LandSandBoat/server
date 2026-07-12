-----------------------------------
-- xi.effect.HEALING
-- Activated through the /heal command
-----------------------------------
require('scripts/quests/adoulin/Dances_with_Luopans')
-----------------------------------

---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:setAnimation(xi.animation.HEALING)

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

    -- Dances with Luopans: charge the luopan while resting at an Ergon Locus
    xi.dancesWithLuopans.onHealing(target)

    if target:getObjType() == xi.objType.PC then
        xi.voidwalker.onHealing(target)
    end
end

effectObject.onEffectTick = function(target, effect)
    local healtime = effect:getTickCount()

    if healtime > 1 then
        -- Summoned avatars and spirits cancel healing on first healing tick if summoned
        local pet = target:getPet()
        if pet ~= nil then
            local petId = pet:getPetID()
            if
                pet:isAvatar() or
                (not pet:isCharmed() and petId >= xi.petId.FIRE_SPIRIT and petId <= xi.petId.DARK_SPIRIT)
            then
                target:messageBasic(xi.msg.basic.CANT_HEAL_WITH_AVATAR)
                target:delStatusEffect(xi.effect.HEALING)
                return
            end
        end

        -- curse II also known as "zombie"
        if
            not target:hasStatusEffect(xi.effect.DISEASE) and
            not target:hasStatusEffect(xi.effect.PLAGUE) and
            not target:hasStatusEffect(xi.effect.CURSE_II)
        then
            local healHP = 0
            local healMP = 12 + ((healtime - 2) * (1 + target:getMod(xi.mod.CLEAR_MIND))) + target:getMod(xi.mod.MPHEAL)

            if target:isAutomaton() then
                -- TODO: Check lower level Automatons
                local mainLevel = target:getMainLvl()
                local hpBase    = 10 + 3 * math.floor((mainLevel - 1) / 10)
                local mpBase    = math.min(33, 9 + 3 * math.floor(mainLevel / 10))
                local hpRate    = math.min(5, 1 + math.floor(target:getMaxHP() / 300))
                local mpRate    = math.min(4, 1 + math.floor(target:getMaxMP() / 300))

                target:addTP(xi.settings.main.HEALING_TP_CHANGE)
                healHP = hpBase + (healtime - 2) * hpRate
                healMP = mpBase + (healtime - 2) * mpRate
            elseif
                target:getContinentID() == 1 and
                target:hasStatusEffect(xi.effect.SIGNET)
            then
                healHP = 10 + (3 * math.floor(target:getMainLvl() / 10)) +
                    (healtime - 2) * (1 + math.floor(target:getMaxHP() / 300)) + target:getMod(xi.mod.HPHEAL)
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
            target:addMP(healMP)
        end
    end
end

effectObject.onEffectLose = function(target, effect)
    target:setAnimation(xi.animation.NONE)
    target:delStatusEffectSilent(xi.effect.LEAVEGAME)

    -- Dances with Luopans: stopping the rest cancels the luopan charge
    xi.dancesWithLuopans.onEffectLose(target)
end

return effectObject
