-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    --TODO: add magic def for fire
    local dmg = target:calculateRuneDamage()
    printf("Rune DMG = %s", tostring(dmg))
    if target:getMod(xi.mod.RUNE3) ~= 0 then
        if target:getMod(xi.mod.RUNE1) ~= 0 then
           target:setMod(xi.mod.RUNE1,1)


    else if target:getMod(xi.mod.RUNE3)
    end

    target:addMod(xi.mod.ENSPELL_DMG,dmg)
end

effect_object.onEffectTick = function(target, effect)
    target:setMod(xi.mod.RUNE_DMG, 0)
end

effect_object.onEffectLose = function(target, effect)
    target:setMod(xi.mod.ENSPELL_DMG, 0)
    target:setMod(xi.mod.ENSPELL, 0)
end 

return effect_object

