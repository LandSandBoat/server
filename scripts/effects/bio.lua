-----------------------------------
-- xi.effect.BIO
-- Tier >= 5 signals this is a bio that doesn't break sleep
-- See mobskills/nightmare.lua for full explanation
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if effect:getTier() < 5 then -- Regular bio application.
        effect:addMod(xi.mod.REGEN_DOWN, effect:getPower())
    end

    effect:addMod(xi.mod.ATTP, -effect:getSubPower())
end

effectObject.onEffectTick = function(target, effect)
    -- Bio with Tier >= 5 is a signal that we don't wake up targets from this dot damage
    -- handle diabolos nightmare bio damage explicitly
    if effect:getTier() >= 5 then
        -- re-using logic from helix effect processing
        local dmg = utils.handleStoneskin(target, effect:getPower())

        if dmg > 0 then
            target:takeDamage(dmg, nil, nil, nil, { wakeUp = false, breakBind = false })
        end
    end
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
