-----------------------------------
-- Spell: Maiden's Virelai
-- Charms pet
-----------------------------------
---@type TSpell
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
        local duration = 30

        if resist >= 0.50 then
            if caster:isMob() then
                -- Mobs charm players by first adding the charm status effect to the player
                -- Note the duration of the status effect determines the charm length
                target:addStatusEffect(xi.effect.CHARM_I, 0, 0, duration * resist)
                -- The charm function below simply changes the player AI
                caster:charm(target)
                spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
            elseif
                caster:isPC() and
                target:isMob() and
                target:getMobMod(xi.mobMod.CHARMABLE) > 0
            then
                -- Each Virelai mod boosts duration by 10%
                local iBoost = caster:getMod(xi.mod.VIRELAI_EFFECT) + caster:getMod(xi.mod.ALL_SONGS_EFFECT)
                duration = duration * (iBoost * 0.1 + 1)

                -- Players typically charm mobs by using job_utils.beastmaster however that uses BST assumptions
                -- Therefore instead we call charm directly with a duration based on resist of the spell
                caster:charm(target, math.floor(duration * resist))
                spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
            else
                spell:setMsg(xi.msg.basic.MAGIC_RESIST)
            end
        else
            -- Resist
            spell:setMsg(xi.msg.basic.MAGIC_RESIST)
        end
    end

    return xi.effect.CHARM_I
end

return spellObject
