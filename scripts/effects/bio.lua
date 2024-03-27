-----------------------------------
-- xi.effect.BIO
-- Tier > 0 signals this is a bio that doesn't break sleep
-- See mobskills/nightmare.lua for full explanation
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local power = effect:getPower()
    local subpower = effect:getSubPower()
    effect:addMod(xi.mod.ATTP, -subpower)
    if effect:getTier() == 0 then
        effect:addMod(xi.mod.REGEN_DOWN, power)
    end
end

effectObject.onEffectTick = function(target, effect)
    -- bio with subpower > 0 is a signal that we don't wake up targets from this dot damage
    -- handle diabolos nightmare bio damage explicitly
    if effect:getTier() > 0 then
        -- re-using logic from helix effect processing
        local dmg = utils.stoneskin(target, effect:getPower())

        if dmg > 0 then
            target:takeDamage(dmg, nil, nil, nil, { wakeUp = false, breakBind = false })
        end
    end
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
