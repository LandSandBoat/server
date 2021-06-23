-----------------------------------
-- Trust: Matsui-P
-----------------------------------
-- NOTE: Removed from the game!
-- !costume 3121
-- INSERT INTO `spell_list` VALUES (1003,'matsui-p',0x01010101010101010101010101010101010101010101,8,0,7,0,1,0,0,3000,24000,0,0,939,1500,0,0,1.00,0,0,0,0,NULL);
-- INSERT INTO `mob_pools` VALUES (6003,'matsui-p','Matsui-P',153,0x0000310C00000000000000000000000000000000,13,4,9,190,60,0,0,0,0,0,0,32,0,3,0,0,435,0,0,1148);
-----------------------------------
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/trust")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spell_object.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spell_object.onMobSpawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.SPAWN)

    -- "Prefers to open skillchains. Will remember the last weapon skill used by the party leader
    -- and will open the highest-tier skillchain possible. Will not open skillchains for other
    -- trusts in the party."
    mob:setTrustTPSkillSettings(ai.tp.OPENER, ai.s.SPECIAL_AYAME)
end

spell_object.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DESPAWN)
end

spell_object.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DEATH)
end

return spell_object
