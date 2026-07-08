-----------------------------------
-- Trust: Naji
-----------------------------------
---@type TSpellTrust
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spellObject.onSpellCast = function(caster, target, spell)
    local bastokFirstTrust = caster:getCharVar('Quest[1][92]Prog')
    local zone = caster:getZoneID()

    if
        bastokFirstTrust == 1 and
        (zone == xi.zone.NORTH_GUSTABERG or zone == xi.zone.SOUTH_GUSTABERG)
    then
        caster:setCharVar('Quest[1][92]Prog', 2)
    end

    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.AYAME] = xi.trust.messageOffset.TEAMWORK_1,
    })

    mob:addGambit(ai.t.SELF, { ai.c.NOT_HAS_TOP_ENMITY, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.PROVOKE })
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
