-----------------------------------
-- Spell: Absorb-TP
-- Steals an enemy's TP.
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
    -- Caps TP drained at 40% of the target's current TP
    local cap = target:getTP() * 0.4
    local dmg = math.random(100, cap)

    -- Get resist multiplier (1x if no resist)
    local params = {}
        params.attribute = xi.mod.INT
        params.skillType = xi.skill.DARK_MAGIC
    local resist = applyResistance(caster, target, spell, params)

    -- Get the resisted damage
    dmg = dmg * resist

    -- Add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    dmg = addBonuses(caster, spell, target, dmg)

    -- Add in target adjustment
    dmg = adjustForTarget(target, dmg, spell:getElement())

    -- Add in final adjustments
    if resist <= 0.125 then
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        dmg = 0
    else
        spell:setMsg(xi.msg.basic.MAGIC_ABSORB_TP)

        local enhancesAbsorb = (100 + caster:getMod(xi.mod.ENHANCES_ABSORB_TP)) / 100
        local augmentsAbsorb = (100 + caster:getMod(xi.mod.AUGMENTS_ABSORB)) / 100

        dmg = dmg * enhancesAbsorb * augmentsAbsorb

        if target:getTP() < dmg then
            dmg = target:getTP()
        end

        if dmg > cap then
            dmg = cap
        end

        -- Drain TP
        caster:addTP(dmg)
        target:addTP(-dmg)
    end

    return dmg
end

return spellObject
