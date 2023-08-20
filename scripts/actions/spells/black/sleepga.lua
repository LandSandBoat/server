-----------------------------------
-- Spell: Sleepga
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if caster:isMob() then
        if caster:getPool() == 5310 then -- Amnaf (Flayer)
            caster:resetEnmity(target)
        end

        -- Todo: get rid of this whole block by handling it in the mob script
        -- this requires a multi target enmity without specifying a target (have to get hate list from mob)
        -- OR by altering onSpellPrecast to have a target param..
        -- OnMobMagicPrepare is not a realistic option.
        -- You'd have to script the use of every individual spell in Amnaf's list..
    end

    return xi.spells.enfeebling.useEnfeeblingSpell(caster, target, spell)
end

return spellObject
