-----------------------------------
-- Pre TOAU Signet effect
-- Pre 8 March 2007
-- https://www.bg-wiki.com/ffxi/The_History_of_Final_Fantasy_XI/2007
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('cop_signet')

m:addOverride('xi.effects.signet.onEffectGain', function(target, effect)
    target:addLatent(xi.latent.SIGNET_BONUS, 0, xi.mod.DEF, 0)
    target:addLatent(xi.latent.SIGNET_BONUS, 0, xi.mod.EVA, 0)
end)

m:addOverride('xi.effects.healing.onEffectTick', function(target, effect)
    local healtime = effect:getTickCount()

    if healtime > 2 then
        -- curse II also known as "zombie"
        if
            not target:hasStatusEffect(xi.effect.DISEASE) and
            not target:hasStatusEffect(xi.effect.PLAGUE) and
            not target:hasStatusEffect(xi.effect.CURSE_II)
        then
            local healHP = 0

            target:addTP(xi.settings.main.HEALING_TP_CHANGE)
            healHP = 10 + (healtime - 2) + target:getMod(xi.mod.HPHEAL)

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
end)

return m
