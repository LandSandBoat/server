-----------------------------------
-- xi.effect.MOUNTED
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local mountId = effect:getPower()
    -- Retail sends a music change packet (packet ID 0x5F) in both cases.

    local animation = xi.animation.NONE

    if
        mountId == xi.mount.CHOCOBO or
        mountId == xi.mount.NOBLE_CHOCOBO
    then
        target:changeMusic(4, 212)
        animation = xi.anim.CHOCOBO
    else
        target:changeMusic(4, 84)
        animation = xi.anim.MOUNT
    end

    if not target:isInEvent() then
        target:setAnimation(animation)
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    if not target:isInEvent() then -- Paranoia safety check
        target:setAnimation(xi.anim.NONE)
    end

    -- Remove CharVars from player participating in chocobo riding game
    if target:isPC() then
        xi.chocoboGame.dismountChoco(target)
    end
end

return effectObject
