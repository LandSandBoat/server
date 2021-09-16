-----------------------------------
-- xi.effect.CAROL
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local spower = effect:getSubPower()
    local buff = 0
    if spower > 8 then -- unpack and apply stat buff if present
        if spower > 399 then
            buff = 4
            spower = spower - 400
        elseif spower > 299 then
            buff = 3
            spower = spower - 300
        elseif spower > 199 then
            buff = 2
            spower = spower - 200
        else
            buff = 1
            spower = spower - 100
        end
    end

    target:addMod(xi.magic.resistMod[spower], effect:getPower())

    if buff > 0 then -- xi.magic.element ids and MODS ids unfortnately don't match
        if spower == 1 then -- fire add STR
            target:addMod(xi.mod.STR, buff)
        elseif spower == 2 then -- ice add INT
            target:addMod(xi.mod.INT, buff)
        elseif spower == 3 then -- wind add AGI
            target:addMod(xi.mod.AGI, buff)
        elseif spower == 4 then -- earth add VIT
            target:addMod(xi.mod.VIT, buff)
        elseif spower == 5 then -- thunder add DEX
            target:addMod(xi.mod.DEX, buff)
        elseif spower == 6 then -- water add MND
            target:addMod(xi.mod.MND, buff)
        elseif spower == 7 then -- light add CHR
            target:addMod(xi.mod.CHR, buff)
        elseif spower == 8 then -- dark add MP
            target:addMod(xi.mod.MP, buff * 10)
        end
    end
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local spower = effect:getSubPower()
    local buff = 0
    if spower > 8 then -- unpack and apply stat buff if present
        if spower > 399 then
            buff = 4
            spower = spower - 400
        elseif spower > 299 then
            buff = 3
            spower = spower - 300
        elseif spower > 199 then
            buff = 2
            spower = spower - 200
        else
            buff = 1
            spower = spower - 100
        end
    end

    target:delMod(xi.magic.resistMod[spower], effect:getPower())

    if buff > 0 then -- xi.magic.element and MODS unfortnately don't match
        if spower == 1 then -- fire add STR
            target:delMod(xi.mod.STR, buff)
        elseif spower == 2 then -- ice add INT
            target:delMod(xi.mod.INT, buff)
        elseif spower == 3 then -- wind add AGI
            target:delMod(xi.mod.AGI, buff)
        elseif spower == 4 then -- earth add VIT
            target:delMod(xi.mod.VIT, buff)
        elseif spower == 5 then -- thunder add DEX
            target:delMod(xi.mod.DEX, buff)
        elseif spower == 6 then -- water add MND
            target:delMod(xi.mod.MND, buff)
        elseif spower == 7 then -- light add CHR
            target:delMod(xi.mod.CHR, buff)
        elseif spower == 8 then -- dark add MP
            target:delMod(xi.mod.MP, buff * 10)
        end
    end
end

return effect_object
