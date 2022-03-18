-----------------------------------
-- xi.effect.MOUNTED
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    -- Retail sends a music change packet (packet ID 0x5F) in both cases.

    -- TODO: This isn't quite right. The IDs we use for mounts vs what we use for power etc.
    -- seem to be off-by-one.
    if effect:getPower() < 2 then
        target:ChangeMusic(4, 212)
        target:setAnimation(xi.anim.CHOCOBO)
    else
        target:ChangeMusic(4, 84)
        target:setAnimation(xi.anim.MOUNT)
    end

    -- For PM3-3 The Road Forks.  This value will be checked periodically, and break
    -- the Mimeo Jewel should a player be mounted, zone, or disconnect.
    if
        target:getZoneID() == xi.zone.ATTOHWA_CHASM and
        target:hasKeyItem(xi.ki.MIMEO_JEWEL)
    then
        target:setLocalVar('Mission[6][325]Timer', 0)
    end
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:setAnimation(xi.anim.NONE)
end

return effect_object
