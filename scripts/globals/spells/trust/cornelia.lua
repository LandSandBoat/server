-----------------------------------
-- Trust: Cornelia
-----------------------------------
-- NOTE: Removed from the game!
-- costume 70
-- INSERT INTO `spell_list` VALUES (1002,'cornelia',0x01010101010101010101010101010101010101010101,8,0,7,0,1,0,0,3000,24000,0,0,939,1500,0,0,1.00,0,0,0,0,NULL);
-- INSERT INTO `mob_pools` VALUES (6002,'cornelia','Cornelia',153,0x0000460000000000000000000000000000000000,21,0,3,240,100,0,0,0,0,0,0,32,0,3,0,0,0,0,0,0);
-----------------------------------
require("scripts/globals/job_utils/geomancer")
require("scripts/globals/status")
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

    -- Potency of benefits is dependent on your current level. At Level 99, her benefit to Accuracy and Ranged Accuracy is +30.
    local power = (mob:getMainLvl() / 10) * 3

    -- Grants the following aura benefits: Haste+ (Indi-Haste), Accuracy+ (Indi-Precision), Range Accuracy+, Magic Accuracy+ (Indi-Focus).
    xi.job_utils.geomancer.addAura(mob, 0, xi.effect.GEO_HASTE, power, xi.auraTarget.ALLIES)
    xi.job_utils.geomancer.addAura(mob, 0, xi.effect.GEO_ACCURACY_BOOST, power, xi.auraTarget.ALLIES)
    -- TODO: Range Accuracy+
    xi.job_utils.geomancer.addAura(mob, 0, xi.effect.GEO_MAGIC_ACC_BOOST, power, xi.auraTarget.ALLIES)

    -- TODO: Only shows the icon for Haste, but the other 3 beneficial effects are also automatically applied.

    mob:SetAutoAttackEnabled(false)
end

spell_object.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DESPAWN)
end

spell_object.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DEATH)
end

return spell_object
