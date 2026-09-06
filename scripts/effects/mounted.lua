-----------------------------------
-- xi.effect.MOUNTED
-----------------------------------
---@type TEffect
local effectObject = {}
local attohwaChasmGlobal = require('scripts/zones/Attohwa_Chasm/globals')

effectObject.onEffectGain = function(target, effect)
    local mountId = effect:getPower()
    -- Retail sends a music change packet (packet ID 0x5F) in both cases.

    local music     = 0
    local animation = xi.animation.NONE

    if
        mountId == xi.mount.CHOCOBO or
        mountId == xi.mount.NOBLE_CHOCOBO
    then
        music     = 212
        animation = xi.animation.CHOCOBO
    else
        music     = 84
        animation = xi.animation.MOUNT
    end

    if not target:isInEvent() then
        local musicEnd = target:getCharVar('[CHOCOBO]MusicEnd')
        if musicEnd == 0 or GetSystemTime() < musicEnd then
            target:changeMusic(xi.musicSlot.MOUNT, music)
        end

        target:setAnimation(animation)
    end

    -- Chocobo and mounts uncharm current pet
    local pet = target:getPet()
    if pet ~= nil and pet:isCharmed() then
        target:despawnPet()
    end

    attohwaChasmGlobal.removeMimeoKIs(target)
end

-- Tick timer is reset on zone
effectObject.onEffectTick = function(target, effect)
    local musicEnd = target:getCharVar('[CHOCOBO]MusicEnd')

    if GetSystemTime() >= musicEnd then
        target:changeMusic(xi.musicSlot.MOUNT, 0)
        target:setCharVar('[CHOCOBO]MusicEnd', -1) -- Song played and finished.
        effect:setTick(0)
    end
end

effectObject.onEffectLose = function(target, effect)
    target:setCharVar('[CHOCOBO]MusicEnd', 0)

    if not target:isInEvent() then -- Paranoia safety check
        target:setAnimation(xi.animation.NONE)
    end

    -- Remove CharVars from player participating in chocobo riding game
    if target:isPC() then
        xi.chocoboGame.dismountChoco(target)
    end
end

return effectObject
