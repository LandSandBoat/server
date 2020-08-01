-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
    effect:setSubPower(effect:getPower()*(256/100))
    target:addMod(tpz.mod.UDMGPHYS, -effect:getPower())
    target:addMod(tpz.mod.UDMGBREATH, -effect:getPower())
    target:addMod(tpz.mod.UDMGMAGIC, -effect:getSubPower())
    target:addMod(tpz.mod.UDMGRANGE, -effect:getPower())
    target:addMod(tpz.mod.SLEEPRES, effect:getPower())
    target:addMod(tpz.mod.POISONRES, effect:getPower())
    target:addMod(tpz.mod.PARALYZERES, effect:getPower())
    target:addMod(tpz.mod.BLINDRES, effect:getPower())
    target:addMod(tpz.mod.SILENCERES, effect:getPower())
    target:addMod(tpz.mod.BINDRES, effect:getPower())
    target:addMod(tpz.mod.CURSERES, effect:getPower())
    target:addMod(tpz.mod.SLOWRES, effect:getPower())
    target:addMod(tpz.mod.STUNRES, effect:getPower())
    target:addMod(tpz.mod.CHARMRES, effect:getPower())
end

function onEffectTick(target, effect)
    if (effect:getTickCount() > ((effect:getDuration() / effect:getTick())/2)) then
        if (effect:getPower() > 2) then
            effect:setPower(effect:getPower() - 2)
            effect:setSubPower(effect:getSubPower() - 3)
            target:delMod(tpz.mod.UDMGPHYS, -2)
            target:delMod(tpz.mod.UDMGBREATH, -2)
            target:delMod(tpz.mod.UDMGMAGIC, -3)
            target:delMod(tpz.mod.UDMGRANGE, -2)
            target:delMod(tpz.mod.SLEEPRES, 2)
            target:delMod(tpz.mod.POISONRES, 2)
            target:delMod(tpz.mod.PARALYZERES, 2)
            target:delMod(tpz.mod.BLINDRES, 2)
            target:delMod(tpz.mod.SILENCERES, 2)
            target:delMod(tpz.mod.BINDRES, 2)
            target:delMod(tpz.mod.CURSERES, 2)
            target:delMod(tpz.mod.SLOWRES, 2)
            target:delMod(tpz.mod.STUNRES, 2)
            target:delMod(tpz.mod.CHARMRES, 2)
        end
    end
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.UDMGPHYS, -effect:getPower())
    target:delMod(tpz.mod.UDMGBREATH, -effect:getPower())
    target:delMod(tpz.mod.UDMGMAGIC, -effect:getSubPower())
    target:delMod(tpz.mod.UDMGRANGE, -effect:getPower())
    target:delMod(tpz.mod.SLEEPRES, effect:getPower())
    target:delMod(tpz.mod.POISONRES, effect:getPower())
    target:delMod(tpz.mod.PARALYZERES, effect:getPower())
    target:delMod(tpz.mod.BLINDRES, effect:getPower())
    target:delMod(tpz.mod.SILENCERES, effect:getPower())
    target:delMod(tpz.mod.BINDRES, effect:getPower())
    target:delMod(tpz.mod.CURSERES, effect:getPower())
    target:delMod(tpz.mod.SLOWRES, effect:getPower())
    target:delMod(tpz.mod.STUNRES, effect:getPower())
    target:delMod(tpz.mod.CHARMRES, effect:getPower())
end
