-----------------------------------
-- xi.effect.MOUNTED
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local mountId    = effect:getPower()
    -- Retail sends a music change packet (packet ID 0x5F) in both cases.

    if
    mountId == xi.mount.CHOCOBO or
    mountId == xi.mount.NOBLE_CHOCOBO
    then
        target:changeMusic(4, 212)
        target:setAnimation(xi.anim.CHOCOBO)
    else
        target:changeMusic(4, 84)
        target:setAnimation(xi.anim.MOUNT)
    end

    -- XISP Changes ------------------------------------------
    local hasChocobo = target:getCharVar('[XISP]chocoID')

    if hasChocobo > 0 then
        local choco = GetMobByID(hasChocobo)
        if choco then
            target:setLocalVar('ridingOwnChoco', 1)
            choco:setBehavior(bit.band(choco:getBehavior(), bit.bnot(xi.behavior.NO_DESPAWN)))
            DespawnMob(hasChocobo)
        end

        if target:getLocalVar('ownChoco') == 1 then
            target:changeMusic(4, 177) -- Special XISP mount music
        end
    end
    -- Reset chocobo ID
    target:setCharVar('[XISP]chocoID', 0)
    ---------------------------------------------------------
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:setAnimation(xi.anim.NONE)

    -- Remove CharVars from player participating in chocobo riding game
    if target:isPC() then
        xi.chocoboGame.dismountChoco(target)

        -- XISP Changes ------------------------------------------
        if target:getLocalVar('ridingOwnChoco') == 1 then
            target:setLocalVar('ridingOwnChoco', 0)
            target:setCharVar('[XISP]chocoboTimer', os.time() + 300) -- 5 minutes
        end

        target:timer(3000, function(targetArg)
            if targetArg:getCharVar('[XISP]hasChocobo') == 1 then
                xi.xispchocobo.spawnChocobo(targetArg, targetArg:getZone())
            end
        end)
        ---------------------------------------------------------
    end
end

return effectObject
