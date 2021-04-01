-----------------------------------
-- Trust: Excenmille
-----------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/trust")
require("scripts/globals/weaponskillids")
require("scripts/globals/zone")
-----------------------------------
local spell_object = {}

local message_page_offset = 3

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell, xi.magic.spell.EXCENMILLE_S)
end

spell_object.onSpellCast = function(caster, target, spell)
    local SandoriaFirstTrust = caster:getCharVar("SandoriaFirstTrust")
    local zone = caster:getZoneID()

    if SandoriaFirstTrust == 1 and (zone == xi.zone.WEST_RONFAURE or zone == xi.zone.EAST_RONFAURE) then
        caster:setCharVar("SandoriaFirstTrust", 2)
    end

    return xi.trust.spawn(caster, spell)
end

spell_object.onMobSpawn = function(mob)
    xi.trust.teamworkMessage(mob, message_page_offset, {
        [ xi.magic.spell.RAHAL] = xi.trust.message_offset.TEAMWORK_1,
    })

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.SENTINEL,
                        ai.r.JA, ai.s.SPECIFIC, xi.ja.SENTINEL)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, xi.effect.FLASH,
                        ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.FLASH)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 75,
                        ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE)

    mob:addMod(xi.mod.STORETP, 25)
end

spell_object.onMobDespawn = function(mob)
    xi.trust.message(mob, message_page_offset, xi.trust.message_offset.DESPAWN)
end

spell_object.onMobDeath = function(mob)
    xi.trust.message(mob, message_page_offset, xi.trust.message_offset.DEATH)
end

return spell_object
