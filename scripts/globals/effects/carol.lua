-----------------------------------
-- xi.effect.CAROL
-----------------------------------
require("scripts/globals/magic")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local subPower = effect:getSubPower()
    local buff     = 0

    if subPower > 8 then -- unpack and apply stat buff if present
        if subPower >= 400 then
            subPower = subPower - 400
            buff     = 4
        elseif subPower >= 300 then
            subPower = subPower - 300
            buff     = 3
        elseif subPower >= 200 then
            subPower = subPower - 200
            buff     = 2
        else
            subPower = subPower - 100
            buff     = 1
        end
    end

    target:addMod(xi.magic.resistMod[subPower], effect:getPower())

    if buff > 0 then -- xi.magic.element ids and MODS ids unfortnately don't match
        if subPower == 1 then -- fire add STR
            target:addMod(xi.mod.STR, buff)
        elseif subPower == 2 then -- ice add INT
            target:addMod(xi.mod.INT, buff)
        elseif subPower == 3 then -- wind add AGI
            target:addMod(xi.mod.AGI, buff)
        elseif subPower == 4 then -- earth add VIT
            target:addMod(xi.mod.VIT, buff)
        elseif subPower == 5 then -- thunder add DEX
            target:addMod(xi.mod.DEX, buff)
        elseif subPower == 6 then -- water add MND
            target:addMod(xi.mod.MND, buff)
        elseif subPower == 7 then -- light add CHR
            target:addMod(xi.mod.CHR, buff)
        elseif subPower == 8 then -- dark add MP
            target:addMod(xi.mod.MP, buff * 10)
        end
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local subPower = effect:getSubPower()
    local buff     = 0

    if subPower > 8 then -- unpack and apply stat buff if present
        if subPower >= 400 then
            subPower = subPower - 400
            buff     = 4
        elseif subPower >= 300 then
            subPower = subPower - 300
            buff     = 3
        elseif subPower >= 200 then
            subPower = subPower - 200
            buff     = 2
        else
            subPower = subPower - 100
            buff     = 1
        end
    end

    target:delMod(xi.magic.resistMod[subPower], effect:getPower())

    if buff > 0 then -- xi.magic.element and MODS unfortnately don't match
        if subPower == 1 then -- fire add STR
            target:delMod(xi.mod.STR, buff)
        elseif subPower == 2 then -- ice add INT
            target:delMod(xi.mod.INT, buff)
        elseif subPower == 3 then -- wind add AGI
            target:delMod(xi.mod.AGI, buff)
        elseif subPower == 4 then -- earth add VIT
            target:delMod(xi.mod.VIT, buff)
        elseif subPower == 5 then -- thunder add DEX
            target:delMod(xi.mod.DEX, buff)
        elseif subPower == 6 then -- water add MND
            target:delMod(xi.mod.MND, buff)
        elseif subPower == 7 then -- light add CHR
            target:delMod(xi.mod.CHR, buff)
        elseif subPower == 8 then -- dark add MP
            target:delMod(xi.mod.MP, buff * 10)
        end
    end
end

return effectObject
