-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target,effect)
    --TODO: add magic def for fire
    local dmg = target:calculateRuneDamage()
    printf("Rune DMG = %s", tostring(dmg))
    if target:getMod(tpz.mod.RUNE3) ~= 0 then
        if target:getMod(tpz.mod.RUNE1) ~= 0 then
           target:setMod(tpz.mod.RUNE1,1)


    else if target:getMod(tpz.mod.RUNE3)
    end


    target:addMod(tpz.mod.ENSPELL_DMG,dmg)
end

function onEffectTick(target,effect)
    target:setMod(tpz.mod.RUNE_DMG,0)
end

function onEffectLose(target,effect)
    target:setMod(tpz.mod.ENSPELL_DMG,0)
    target:setMod(tpz.mod.ENSPELL,0)
end 
