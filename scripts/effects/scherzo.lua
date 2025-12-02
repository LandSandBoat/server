-----------------------------------
-- xi.effect.SCHERZO
-- TODO: MOD_CRITICAL_DAMAGE_REDUCTION - Name pending. Will be used for gear that enhances reduction potency.
-- TODO: Will also need a mod that enhances Scherzo duration.
-- TODO: This will be handled in battleutils::HandleSevereDamage
-- https://www.bg-wiki.com/ffxi/Category:Scherzo
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, effect:getSubPower()) -- Apply Stat Buff from AUGMENT_SONG_STAT
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, effect:getSubPower()) -- Remove Stat Buff from AUGMENT_SONG_STAT
end

return effectObject
