-----------------------------------
-- Contagion Transfer
-- An ability that removes negative status effects and transfers them to the target.
--
-- When used by a moa, it will absorb positive and negative effects from the target.
--  Positive effects absorbed include job abilities,and food effects, but disclude
--  reraise, and two hour effects. It then immediately uses contamination, spreading
--  the negative effects in an AoE and dispelling them from itself.
--
-- Case by case should be handled per mob to reduce the required amount of code
--  Checks should be based off what positive effects a mob can have on themselves
--  and work around those effects.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local badEffects =
{
    xi.effect.SLEEP_I,
    xi.effect.POISON,
    xi.effect.PARALYSIS,
    xi.effect.BLINDNESS,
    xi.effect.SILENCE,
    xi.effect.PETRIFICATION,
    xi.effect.DISEASE,
    xi.effect.CURSE_I,
    xi.effect.STUN,
    xi.effect.BIND,
    xi.effect.WEIGHT,
    xi.effect.SLOW,
    xi.effect.SLEEP_II,
    xi.effect.CURSE_II,
    xi.effect.PLAGUE,
    xi.effect.BURN,
    xi.effect.FROST,
    xi.effect.CHOKE,
    xi.effect.RASP,
    xi.effect.SHOCK,
    xi.effect.DROWN,
    xi.effect.DIA,
    xi.effect.BIO,
    xi.effect.STR_DOWN,
    xi.effect.DEX_DOWN,
    xi.effect.VIT_DOWN,
    xi.effect.AGI_DOWN,
    xi.effect.INT_DOWN,
    xi.effect.MND_DOWN,
    xi.effect.CHR_DOWN,
    xi.effect.MAX_HP_DOWN,
    xi.effect.MAX_MP_DOWN,
    xi.effect.ACCURACY_DOWN,
    xi.effect.ATTACK_DOWN,
    xi.effect.EVASION_DOWN,
    xi.effect.DEFENSE_DOWN,
    xi.effect.FLASH,
    xi.effect.DREAD_SPIKES,
    xi.effect.MAGIC_ACC_DOWN,
    xi.effect.MAGIC_ATK_DOWN,
    xi.effect.REQUIEM,
    xi.effect.LULLABY,
    xi.effect.ELEGY,
    xi.effect.THRENODY,
}
local goodEffects =
{
    xi.effect.HASTE,
    xi.effect.BLAZE_SPIKES,
    xi.effect.ICE_SPIKES,
    xi.effect.BLINK,
    xi.effect.STONESKIN,
    xi.effect.SHOCK_SPIKES,
    xi.effect.AQUAVEIL,
    xi.effect.PROTECT,
    xi.effect.SHELL,
    xi.effect.REGEN,
    xi.effect.REFRESH,
    xi.effect.BOOST,
    xi.effect.BERSERK,
    xi.effect.DEFENDER,
    xi.effect.AGGRESSOR,
    xi.effect.FOCUS,
    xi.effect.DODGE,
    xi.effect.COUNTERSTANCE,
    xi.effect.SENTINEL,
    xi.effect.SOULEATER,
    xi.effect.LAST_RESORT,
    xi.effect.COPY_IMAGE,
    xi.effect.THIRD_EYE,
    xi.effect.WARCRY,
    xi.effect.SHARPSHOT,
    xi.effect.BARRAGE,
    xi.effect.HOLY_CIRCLE,
    xi.effect.ARCANE_CIRCLE,
    xi.effect.DIVINE_SEAL,
    xi.effect.ELEMENTAL_SEAL,
    xi.effect.STR_BOOST,
    xi.effect.DEX_BOOST,
    xi.effect.VIT_BOOST,
    xi.effect.AGI_BOOST,
    xi.effect.INT_BOOST,
    xi.effect.MND_BOOST,
    xi.effect.CHR_BOOST,
    xi.effect.MAX_HP_BOOST,
    xi.effect.MAX_MP_BOOST,
    xi.effect.ACCURACY_BOOST,
    xi.effect.ENFIRE,
    xi.effect.ENBLIZZARD,
    xi.effect.ENAERO,
    xi.effect.ENSTONE,
    xi.effect.ENTHUNDER,
    xi.effect.ENWATER,
    xi.effect.ENFIRE,
    xi.effect.ENBLIZZARD_II,
    xi.effect.ENAERO_II,
    xi.effect.ENSTONE_II,
    xi.effect.ENTHUNDER_II,
    xi.effect.ENWATER_II,
    xi.effect.BARFIRE,
    xi.effect.BARBLIZZARD,
    xi.effect.BARAERO,
    xi.effect.BARSTONE,
    xi.effect.BARTHUNDER,
    xi.effect.BARWATER,
    xi.effect.BARSLEEP,
    xi.effect.BARPOISON,
    xi.effect.BARPARALYZE,
    xi.effect.BARBLIND,
    xi.effect.BARSILENCE,
    xi.effect.BARPETRIFY,
    xi.effect.BARVIRUS,
    xi.effect.UNLIMITED_SHOT,
    xi.effect.PHALANX,
    xi.effect.WARDING_CIRCLE,
    xi.effect.ANCIENT_CIRCLE,
    xi.effect.STR_BOOST_II,
    xi.effect.DEX_BOOST_II,
    xi.effect.VIT_BOOST_II,
    xi.effect.AGI_BOOST_II,
    xi.effect.INT_BOOST_II,
    xi.effect.MND_BOOST_II,
    xi.effect.CHR_BOOST_II,
    xi.effect.SHINING_RUBY,
    xi.effect.CHAIN_AFFINITY,
    xi.effect.BURST_AFFINITY,
    xi.effect.MAGIC_ATK_BOOST,
    xi.effect.MAGIC_DEF_BOOST,
    xi.effect.PAEON,
    xi.effect.BALLAD,
    xi.effect.MINNE,
    xi.effect.MINUET,
    xi.effect.MADRIGAL,
    xi.effect.PRELUDE,
    xi.effect.MAMBO,
    xi.effect.AUBADE,
    xi.effect.PASTORAL,
    xi.effect.HUM,
    xi.effect.FANTASIA,
    xi.effect.OPERETTA,
    xi.effect.CAPRICCIO,
    xi.effect.SERENADE,
    xi.effect.ROUND,
    xi.effect.GAVOTTE,
    xi.effect.FUGUE,
    xi.effect.RHAPSODY,
    xi.effect.ARIA,
    xi.effect.MARCH,
    xi.effect.ETUDE,
    xi.effect.CAROL,
    xi.effect.HYMNUS,
    xi.effect.MAZURKA,
    xi.effect.HASSO,
    xi.effect.SEIGAN,
    xi.effect.DRAIN_SAMBA,
    xi.effect.ASPIR_SAMBA,
    xi.effect.HASTE_SAMBA,
    xi.effect.VELOCITY_SHOT,
    xi.effect.RETALIATION,
    xi.effect.FOOTWORK,
    xi.effect.SEKKANOKI,
    xi.effect.PIANISSIMO,
    xi.effect.COMPOSURE,
    xi.effect.YONIN,
    xi.effect.INNIN,
}
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local effects = target:getStatusEffects()
    local count = 0
    local power = math.ceil(mob:getMainLvl() / 5)

    -- Case for Giant Moa
    if mob:getPool() == 1532 then
        for _, v in pairs(effects) do
            if count < 8 and v ~= nil then
                for y = 1, #badEffects do
                    if target:hasStatusEffect(badEffects[y]) then
                        if badEffects[y] == xi.effect.PETRIFICATION then
                            mob:timer(2000, function(mobArg)
                                mob:addStatusEffect(badEffects[y], power, 3, 60)
                                target:delStatusEffect(badEffects[y])
                                count = count + 1
                            end)
                        else
                            mob:addStatusEffect(badEffects[y], power, 3, 60)
                            target:delStatusEffect(badEffects[y])
                            count = count + 1
                        end
                    end
                end

                for y = 1, #goodEffects do
                    if target:hasStatusEffect(goodEffects[y]) then
                        mob:addStatusEffect(goodEffects[y], power, 3, 60)
                        target:delStatusEffect(goodEffects[y])
                        count = count + 1
                    end
                end
            end
        end

        if count > 0 then
            skill:setMsg(xi.msg.basic.EFFECT_DRAINED)
        else
            skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        end

        return count
    else
        for _, v in pairs (effects) do
            if count < 8 and v ~= nil then
                for y = 1, #badEffects do
                    if mob:hasStatusEffect(badEffects[y]) then
                        target:addStatusEffect(badEffects[y], power, 0, 60)
                        mob:delStatusEffect(badEffects[y])

                        skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
                    end
                end
            end
        end
    end
end

return mobskillObject
