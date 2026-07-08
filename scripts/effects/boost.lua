-----------------------------------
-- xi.effect.BOOST
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    -- There are at least two forms of boost
    -- Normal boost (attp)
    -- Fantod boost (base weapon damage)

    -- subPower of 1 == Fantod base damage boost
    if effect:getSubPower() == 1 and target:isMob() then -- TODO: what happens if a player steals this boost? It has been observed that Yovra boost does nothing on retail but unknown if that is a bug or not.
        local baseDamage = target:getWeaponDmg()
        local power      = math.max(0, (baseDamage * effect:getPower() / 100) - baseDamage)
        -- if effect power is 400 (Fantod), add enough damage to quadruple it.
        -- 100 * 4.0 = 400, but we need to subtract baseDamage because that is inherent to the mob
        -- TODO: if the mob already has xi.mod.MAIN_DMG_RATING from another buff, this could compound
        -- Those buffs are extremely rare (only Fantod?) and we may need another accessor to get the true base dmg without mods/mobmods

        effect:addMod(xi.mod.MAIN_DMG_RATING, power)
    else
        effect:addMod(xi.mod.ATTP, effect:getPower())
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
