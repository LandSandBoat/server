-----------------------------------
-- Spell: Stoneskin
-----------------------------------
-- http://wiki.ffxiclopedia.org/wiki/Stoneskin
-- Max 350 damage absorbed
-- (before cap bonus gear, with no settings.lua adjustment)
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local pMod = caster:getSkillLevel(xi.skill.ENHANCING_MAGIC) / 3 + caster:getStat(xi.mod.MND)
    local pAbs = 0
    local pEquipMods = caster:getMod(xi.mod.STONESKIN_BONUS_HP)
    if pMod < 80 then
        pAbs = pMod
    elseif pMod <= 130 then
        pAbs = 2 * pMod - 60
    elseif pMod > 130 then
        pAbs = 3 * pMod - 190
    end

    -- hard cap of 350 from natural power
    -- pAbs = utils.clamp(1, xi.settings.main.STONESKIN_CAP) This just always sets it to 350, let's use the actual value, shall we?
    pAbs = utils.clamp(pAbs, 1, xi.settings.main.STONESKIN_CAP)

    local duration = calculateDuration(300, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    duration = calculateDurationForLvl(duration, 28, target:getMainLvl())

    local final = pAbs + pEquipMods
    if target:addStatusEffect(xi.effect.STONESKIN, final, 0, duration, 0, 0, 4) then
        spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.STONESKIN
end

return spellObject
