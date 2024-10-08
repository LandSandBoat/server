-----------------------------------
-- Trust: Mildaurion
-- https://ffxiclopedia.fandom.com/wiki/Trust:_Mildaurion
-- https://www.bg-wiki.com/ffxi/Cipher:_Mildaurion
-- From wikis:
-- "Tries to open skillchains when the player reaches 1500 TP. Does not try to open skillchains with other trusts."
-- "Will close skillchains with players and other trusts if possible, otherwise uses a weapon skill at 3000 TP."
-- TODO: We don't have a combination of OPENER and CLOSER for TP skill settings, so leaving as OPENER for now.
-----------------------------------
---@type TSpellTrust
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.PRISHE] = xi.trust.messageOffset.TEAMWORK_1,
        [xi.magic.spell.ULMIA] = xi.trust.messageOffset.TEAMWORK_2,
    })

    mob:addListener('WEAPONSKILL_USE', 'MILDAURION_WEAPONSKILL_USE', function(mobArg, target, wsid, tp, action)
        if wsid == xi.mobSkill.LIGHT_BLADE then
            --  For Vana'diel!
            xi.trust.message(mobArg, xi.trust.messageOffset.SPECIAL_MOVE_1)
        end
    end)

    mob:addMod(xi.mod.MPP, 100)

    mob:setTrustTPSkillSettings(ai.tp.OPENER, ai.s.RANDOM)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
