-----------------------------------
-- Spell: Death
-- Has a chance to insta-kill the target. Ineffective against undead or notorious monsters.
-- (Player only) Consumes all MP no matter what.
-- (Player only) If Death fails to knock out the target, it will instead deal darkness damage.
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    spell:setFlag(xi.magic.spellFlag.IGNORE_SHADOWS)

    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- Player spell.
    if caster:isPC() then
        local instaDeath = false
        local result     = 0

        -- Insta-death calculations.
        if
            not target:isUndead() and
            not target:isNM() and
            not target:hasStatusEffect(xi.effect.MAGIC_SHIELD)
        then
            local resistRate = xi.combat.magicHitRate.calculateResistRate(caster, target, xi.magic.spellGroup.BLACK, xi.skill.DARK_MAGIC, 0, xi.element.DARK, 0, 0, 0)

            if resistRate == 1 then
                instaDeath = true
            end
        end

        if instaDeath then
            target:setHP(0)
        else
            spell:setMsg(xi.msg.basic.MAGIC_DMG)
            result = xi.spells.damage.useDamageSpell(caster, target, spell)
        end

        -- Handle MP comsumption. It bypasses "conserve MP" and any other form of mp reduction.
        caster:setMP(0)

        return result

    -- Not-player spell.
    else
        if math.random(1, 100) > target:getMod(xi.mod.DEATHRES) then
            target:setHP(0)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end

        return 0
    end
end

return spellObject
