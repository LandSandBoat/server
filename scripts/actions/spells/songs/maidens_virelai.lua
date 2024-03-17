-----------------------------------
-- Spell: Maiden's Virelai
-- Charms pet
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    if caster:getPet() ~= nil then
        return xi.msg.basic.ALREADY_HAS_A_PET
    elseif target:getMaster() ~= nil and target:getMaster():isPC() then
        return xi.msg.basic.THAT_SOMEONES_PET
    end

    -- Per wiki, Virelai wipes all shadows even if it resists or the target is immune to charm
    -- This can't be done in the onSpellCast function (that runs after it "hits")
    spell:setFlag(xi.magic.spellFlag.WIPE_SHADOWS)
    -- TODO:
    -- 1. move "spell:setFlag()" to a SpellFlags group of get/set/add/del functions
    -- 2. move spell flags to the spell table, so we don't have to do hacky things inside the casting check!

    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if target:hasStatusEffect(xi.effect.CHARM_I) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    else
        -- local dCHR = (caster:getStat(xi.mod.CHR) - target:getStat(xi.mod.CHR))
        local bonus = 0 -- No idea what value, but seems likely to need this edited later to get retail resist rates.
        local params = {}
        params.diff = nil
        params.attribute = xi.mod.CHR
        params.skillType = xi.skill.SINGING
        params.bonus = bonus
        params.effect = xi.effect.CHARM_I
        local resist = applyResistanceEffect(caster, target, spell, params)

        if resist >= 0.25 and caster:getCharmChance(target, false) > 0 then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
            if caster:isMob() then
                target:addStatusEffect(xi.effect.CHARM_I, 0, 0, 30 * resist)
                caster:charm(target)
            else
                caster:charmPet(target)
            end
        else
            -- Resist
            spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        end
    end

    return xi.effect.CHARM_I
end

return spellObject
