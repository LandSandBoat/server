--------------------------------------
-- Spell: Absorb-TP
-- Steals an enemy's TP.
--------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local cap = 1200
    local dmg = math.random(100, 1200)

    --get resist multiplier (1x if no resist)
    local params = {}
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.DARK_MAGIC
    local resist = applyResistance(caster, target, spell, params)

    --get the resisted damage
    dmg = dmg * resist

    --add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    dmg = addBonuses(caster, spell, target, dmg)

    --add in target adjustment
    dmg = adjustForTarget(target, dmg, spell:getElement())

    --add in final adjustments
    if (resist <= 0.125) then
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
        dmg = 0
    else
        spell:setMsg(tpz.msg.basic.MAGIC_ABSORB_TP)

        dmg = dmg * ((100 + caster:getMod(tpz.mod.AUGMENTS_ABSORB)) / 100)

        if ((target:getTP()) < dmg) then
            dmg = target:getTP()
        end

        if (dmg > cap) then
            dmg = cap
        end

        -- drain
        caster:addTP(dmg)
        target:addTP(-dmg)
    end

    return dmg
end
