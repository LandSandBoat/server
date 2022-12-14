-----------------------------------
-- Spell: Pollen
-- Restores HP
-- Spell cost: 8 MP
-- Monster Type: Vermin
-- Spell Type: Magical (Light)
-- Blue Magic Points: 1
-- Stat Bonus: CHR+1, HP+5
-- Level: 1
-- Casting Time: 2 seconds
-- Recast Time: 5 seconds
-----------------------------------
-- Combos: Resist Sleep
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
<<<<<<< refs/remotes/upstream/base
    params.ecosystem = xi.ecosystem.VERMIN

    if power > 99 then
        divisor = 57
        constant = 33.125
    elseif power > 59 then
        divisor =  2
        constant = 9
    end

    local final = getCureFinal(caster, spell, getBaseCureOld(power, divisor, constant), minCure, true)

    final = final + (final * (target:getMod(xi.mod.CURE_POTENCY_RCVD) / 100))

    if
        target:getAllegiance() == caster:getAllegiance() and
        (target:getObjType() == xi.objType.PC or target:getObjType() == xi.objType.MOB)
    then
        --Applying server mods
        final = final * xi.settings.main.CURE_POWER
    end

    local diff = (target:getMaxHP() - target:getHP())
    if final > diff then
        final = diff
    end

    target:addHP(final)

    if
        target:getAllegiance() == caster:getAllegiance() and
        (target:getObjType() == xi.objType.PC or target:getObjType() == xi.objType.MOB)
    then
        caster:updateEnmityFromCure(target, final)
    end

    spell:setMsg(xi.msg.basic.MAGIC_RECOVERS_HP)

    return final
=======
    params.minCure = 14
    params.divisor0 = 1
    params.constant0 = -6
    params.powerThreshold1 = 59
    params.divisor1 = 2
    params.constant1 = 9
    params.powerThreshold2 = 99
    params.divisor2 = 57
    params.constant2 = 33.125

    return bluDoCuringSpell(caster, target, spell, params)
>>>>>>> Healing spells + global blu functions name change
end

return spellObject
