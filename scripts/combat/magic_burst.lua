-----------------------------------
-- Magic burst file. Returns the skillchain count on target.
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.magicBurst = xi.combat.magicBurst or {}
-----------------------------------

---@param target CBaseEntity
---@param actionElement number
---@return number
xi.combat.magicBurst.getMagicBurstTier = function(target, actionElement)
    if not target then
        return 0
    end

    if not actionElement then
        return 0
    end

    if actionElement < xi.element.FIRE or actionElement > xi.element.DARK then
        return 0
    end

    local resonance = target:getStatusEffect(xi.effect.SKILLCHAIN)
    if not resonance then
        return 0
    end

    local resonanceTier = resonance:getTier()
    if resonanceTier <= 0 then
        return 0
    end

    local isMatch = xi.data.element.skillchainElementTable[actionElement][resonance:getPower()] > 0 and true or false
    if not isMatch then
        return 0
    end

    return resonance:getSubPower()
end
