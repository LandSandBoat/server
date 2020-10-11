-----------------------------------------
-- Spell: Maiden's Virelai
-- Charms pet
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/pets")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    if (caster:getPet() ~= nil) then
        return tpz.msg.basic.ALREADY_HAS_A_PET
    elseif (target:getMaster() ~= nil and target:getMaster():isPC()) then
        return tpz.msg.basic.THAT_SOMEONES_PET
    end

    -- Per wiki, Virelai wipes all shadows even if it resists or the target is immune to charm
    -- This can't be done in the onSpellCast function (that runs after it "hits")
    spell:setFlag(tpz.magic.spellFlag.WIPE_SHADOWS)

    return 0
end

function onSpellCast(caster, target, spell)
    local dCHR = (caster:getStat(tpz.mod.CHR) - target:getStat(tpz.mod.CHR))
    local bonus = 0 -- No idea what value, but seems likely to need this edited later to get retail resist rates.
    local params = {}
    params.diff = nil
    params.attribute = tpz.mod.CHR
    params.skillType = tpz.skill.SINGING
    params.bonus = bonus
    params.effect = tpz.effect.CHARM_I
    local resist = applyResistanceEffect(caster, target, spell, params)
    -- print(resist)
    if (resist >= 0.25 and caster:getCharmChance(target, false) > 0) then
        spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
        if (caster:isMob()) then
            target:addStatusEffect(tpz.effect.CHARM_I, 0, 0, 30*resist)
            caster:charm(target)
        else
            caster:charmPet(target)
        end
    else
        -- Resist
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return tpz.effect.CHARM_I
end
