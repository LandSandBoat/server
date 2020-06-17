-----------------------------------
--
-- ABILITIES
--
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

tpz = tpz or {}

tpz.jobAbility =
{
    MIGHTY_STRIKES     = 0,
    HUNDRED_FISTS      = 1,
    BENEDICTION        = 2,
    MANAFONT           = 3,
    CHAINSPELL         = 4,
    PERFECT_DODGE      = 5,
    INVINCIBLE         = 6,
    BLOOD_WEAPON       = 7,
    FAMILIAR           = 8,
    SOUL_VOICE         = 9,
    EAGLE_EYE_SHOT     = 10,
    MEIKYO_SHISUI      = 11,
    MIJIN_GAKURE       = 12,
    SPIRIT_SURGE       = 13,
    ASTRAL_FLOW        = 14,
    BERSERK            = 15,
    WARCRY             = 16,
    DEFENDER           = 17,
    AGGRESSOR          = 18,
    PROVOKE            = 19,
    FOCUS              = 20,
    DODGE              = 21,
    CHAKRA             = 22,
    BOOST              = 23,
    COUNTERSTANCE      = 24,
    STEAL              = 25,
    FLEE               = 26,
    HIDE               = 27,
    SNEAK_ATTACK       = 28,
    MUG                = 29,
    SHIELD_BASH        = 30,
    HOLY_CIRCLE        = 31,
    SENTINEL           = 32,
    SOULEATER          = 33,
    ARCANE_CIRCLE      = 34,
    LAST_RESORT        = 35,
    CHARM              = 36,
    GAUGE              = 37,
    TAME               = 38,
    PET_COMMANDS       = 39,
    SCAVENGE           = 40,
    SHADOWBIND         = 41,
    CAMOUFLAGE         = 42,
    SHARPSHOT          = 43,
    BARRAGE            = 44,
    CALL_WYVERN        = 45,
    THIRD_EYE          = 46,
    MEDITATE           = 47,
    WARDING_CIRCLE     = 48,
    ANCIENT_CIRCLE     = 49,
    JUMP               = 50,
    HIGH_JUMP          = 51,
    SUPER_JUMP         = 52,
    FIGHT              = 53,
    HEEL               = 54,
    LEAVE              = 55,
    SIC                = 56,
    STAY               = 57,
    DIVINE_SEAL        = 58,
    ELEMENTAL_SEAL     = 59,
    TRICK_ATTACK       = 60,
    WEAPON_BASH        = 61,
    REWARD             = 62,
    COVER              = 63,
    SPIRIT_LINK        = 64,
    CHI_BLAST          = 66,
    CONVERT            = 67,
    ACCOMPLICE         = 68,
    CALL_BEAST         = 69,
    UNLIMITED_SHOT     = 70,
    DISMISS            = 71,
    ASSAULT            = 72,
    RETREAT            = 73,
    RELEASE            = 74,
    BLOOD_PACT_RAGE    = 75,
    RAMPART            = 76,
    AZURE_LORE         = 77,
    CHAIN_AFFINITY     = 78,
    BURST_AFFINITY     = 79,
    WILD_CARD          = 80,
    PHANTOM_ROLL       = 81,
    FIGHTERS_ROLL      = 82,
    MONKS_ROLL         = 83,
    HEALERS_ROLL       = 84,
    WIZARDS_ROLL       = 85,
    WARLOCKS_ROLL      = 86,
    ROGUES_ROLL        = 87,
    GALLANTS_ROLL      = 88,
    CHAOS_ROLL         = 89,
    BEAST_ROLL         = 90,
    CHORAL_ROLL        = 91,
    HUNTERS_ROLL       = 92,
    SAMURAI_ROLL       = 93,
    NINJA_ROLL         = 94,
    DRACHEN_ROLL       = 95,
    EVOKERS_ROLL       = 96,
    MAGUSS_ROLL        = 97,
    CORSAIRS_ROLL      = 98,
    PUPPET_ROLL        = 99,
    DANCERS_ROLL       = 100,
    SCHOLARS_ROLL      = 101,
    BOLTERS_ROLL       = 102,
    CASTERS_ROLL       = 103,
    COURSERS_ROLL      = 104,
    BLITZERS_ROLL      = 105,
    TACTICIANS_ROLL    = 106,
    DOUBLE_UP          = 107,
    QUICK_DRAW         = 108,
    FIRE_SHOT          = 109,
    ICE_SHOT           = 110,
    WIND_SHOT          = 111,
    EARTH_SHOT         = 112,
    THUNDER_SHOT       = 113,
    WATER_SHOT         = 114,
    LIGHT_SHOT         = 115,
    DARK_SHOT          = 116,
    RANDOM_DEAL        = 117,
    OVERDRIVE          = 119,
    ACTIVATE           = 120,
    REPAIR             = 121,
    DEPLOY             = 122,
    DEACTIVATE         = 123,
    RETRIEVE           = 124,
    FIRE_MANEUVER      = 125,
    ICE_MANEUVER       = 126,
    WIND_MANEUVER      = 127,
    EARTH_MANEUVER     = 128,
    THUNDER_MANEUVER   = 129,
    WATER_MANEUVER     = 130,
    LIGHT_MANEUVER     = 131,
    DARK_MANEUVER      = 132,
    WARRIORS_CHARGE    = 133,
    TOMAHAWK           = 134,
    MANTRA             = 135,
    FORMLESS_STRIKES   = 136,
    MARTYR             = 137,
    DEVOTION           = 138,
    ASSASSINS_CHARGE   = 139,
    FEINT              = 140,
    FEALTY             = 141,
    CHIVALRY           = 142,
    DARK_SEAL          = 143,
    DIABOLIC_EYE       = 144,
    FERAL_HOWL         = 145,
    KILLER_INSTINCT    = 146,
    NIGHTINGALE        = 147,
    TROUBADOUR         = 148,
    STEALTH_SHOT       = 149,
    FLASHY_SHOT        = 150,
    SHIKIKOYO          = 151,
    BLADE_BASH         = 152,
    DEEP_BREATHING     = 153,
    ANGON              = 154,
    SANGE              = 155,
    BLOOD_PACT_WARD    = 156,
    HASSO              = 157,
    SEIGAN             = 158,
    CONVERGENCE        = 159,
    DIFFUSION          = 160,
    SNAKE_EYE          = 161,
    FOLD               = 162,
    ROLE_REVERSAL      = 163,
    VENTRILOQUY        = 164,
    TRANCE             = 165,
    SAMBAS             = 166,
    WALTZES            = 167,
    DRAIN_SAMBA        = 168,
    DRAIN_SAMBA_II     = 169,
    DRAIN_SAMBA_III    = 170,
    ASPIR_SAMBA        = 171,
    ASPIR_SAMBA_II     = 172,
    HASTE_SAMBA        = 173,
    CURING_WALTZ       = 174,
    CURING_WALTZ_II    = 175,
    CURING_WALTZ_III   = 176,
    CURING_WALTZ_IV    = 177,
    HEALING_WALTZ      = 178,
    DIVINE_WALTZ       = 179,
    SPECTRAL_JIG       = 180,
    CHOCOBO_JIG        = 181,
    JIGS               = 182,
    STEPS              = 183,
    FLOURISHES_I       = 184,
    QUICKSTEP          = 185,
    BOX_STEP           = 186,
    STUTTER_STEP       = 187,
    ANIMATED_FLOURISH  = 188,
    DESPERATE_FLOURISH = 189,
    REVERSE_FLOURISH   = 190,
    VIOLENT_FLOURISH   = 191,
    BUILDING_FLOURISH  = 192,
    WILD_FLOURISH      = 193,
    TABULA_RASA        = 194,
    LIGHT_ARTS         = 195,
    DARK_ARTS          = 196,
    FLOURISHES_II      = 197,
    MODUS_VERITAS      = 198,
    PENURY             = 199,
    CELERITY           = 200,
    RAPTURE            = 201,
    ACCESSION          = 202,
    PARSIMONY          = 203,
    ALACRITY           = 204,
    EBULLIENCE         = 205,
    MANIFESTATION      = 206,
    STRATAGEMS         = 207,
    VELOCITY_SHOT      = 208,
    SNARL              = 209,
    RETALIATION        = 210,
    FOOTWORK           = 211,
    DESPOIL            = 212,
    PIANISSIMO         = 213,
    SEKKANOKI          = 214,
    ELEMENTAL_SIPHON   = 216,
    SUBLIMATION        = 217,
    ADDENDUM_WHITE     = 218,
    ADDENDUM_BLACK     = 219,
    COLLABORATOR       = 220,
    SABER_DANCE        = 221,
    FAN_DANCE          = 222,
    NO_FOOT_RISE       = 223,
    ALTRUISM           = 224,
    FOCALIZATION       = 225,
    TRANQUILITY        = 226,
    EQUANIMITY         = 227,
    ENLIGHTENMENT      = 228,
    AFFLATUS_SOLACE    = 229,
    AFFLATUS_MISERY    = 230,
    COMPOSURE          = 231,
    YONIN              = 232,
    INNIN              = 233,
    AVATARS_FAVOR      = 234,
    READY              = 235,
    RESTRAINT          = 236,
    PERFECT_COUNTER    = 237,
    MANA_WALL          = 238,
    DIVINE_EMBLEM      = 239,
    NETHER_VOID        = 240,
    DOUBLE_SHOT        = 241,
    SENGIKORI          = 242,
    FUTAE              = 243,
    SPIRIT_JUMP        = 244,
    PRESTO             = 245,
    DIVINE_WALTZ_II    = 246,
    FLOURISHES_III     = 247,
    CLIMACTIC_FLOURISH = 248,
    LIBRA              = 249,
    TACTICAL_SWITCH    = 250,
    BLOOD_RAGE         = 251,
    IMPETUS            = 253,
    DIVINE_CARESS      = 254,
    SANCROSANCTITY     = 255,
    ENMITY_DOUSE       = 256,
    MANAWELL           = 257,
    SABOTEUR           = 258,
    SPONTANEITY        = 259,
    CONSPIRATOR        = 260,
    SEPULCHER          = 261,
    PALISADE           = 262,
    ARCANE_CREST       = 263,
    SCARLET_DELIRIUM   = 264,
    SPUR               = 265,
    RUN_WILD           = 266,
    TENUTO             = 267,
    MARCATO            = 268,
    BOUNTY_SHOT        = 269,
    DECOY_SHOT         = 270,
    HAMANOHA           = 271,
    HAGAKURE           = 272,
    ISSEKIGAN          = 275,
    DRAGON_BREAKER     = 276,
    SOUL_JUMP          = 277,
    STEADY_WING        = 279,
    MANA_CEDE          = 280,
    EFFLUX             = 281,
    UNBRIDLED_LEARNING = 282,
    TRIPLE_SHOT        = 285,
    ALLIES_ROLL        = 286,
    MISER_S_ROLL       = 287,
    COMPANION_S_ROLL   = 288,
    AVENGER_S_ROLL     = 289,
    COOLDOWN           = 293,
    DEUX_EX_AUTOMATA   = 294,
    CURING_WALTZ_V     = 295,
    FEATHER_STEP       = 296,
    STRIKING_FLOURISH  = 297,
    TERNARY_FLOURISH   = 298,
    PERPETUANCE        = 300,
    IMMANENCE          = 301,
    SMITING_BREATH     = 302,
    RESTORING_BREATH   = 303,
    KONZEN_ITTAI       = 304,
    BULLY              = 305,
    MAINTENANCE        = 306,
    -- WAR_SP2            = 307,
    -- MNK_SP2            = 308,
    -- ASYLUM             = 309,
    -- SUBLTE_SORCERY     = 310,  --yes, subtle is misspelled
    -- RDM_SP2            = 311,
    -- THF_SP2            = 312,
    -- PLD_SP2            = 313,
    -- SOUL_ENSLAVEMENT   = 314,
    -- BST_SP2            = 315,
    -- BRD_SP2            = 316,
    -- RNG_SP2            = 317,
    -- YAEGASUMI          = 318,
    -- NIN_SP2            = 319,
    -- DSG_SP2            = 320,
    -- ASTRAL_CONDUIT     = 321,
    -- UNBRIDLED_WISDOM   = 322,
    -- COR_SP2            = 323,
    -- HEADY_ARTIFICE     = 324,
    -- GRAND_PAS          = 325,
    -- CAPER_EMISSARIUS   = 326,
    BOLSTER            = 327,
    FULL_CIRCLE        = 329,
    LASTING_EMANATION  = 330,
    ECLIPTIC_ATTRITION = 331,
    COLLIMATED_FERVOR  = 332,
    LIFE_CYCLE         = 333,
    BLAZE_OF_GLORY     = 334,
    DEMATERIALIZE      = 335,
    THEURGIC_FOCUS     = 336,
    CONCENTRIC_PULSE   = 337,
    ELEMENTAL_SFORZO   = 340,
    RUNE_ENCHANTMENT   = 341,
    IGNIS              = 342,
    GELUS              = 343,
    FLABRA             = 344,
    TELLUS             = 345,
    SULPOR             = 346,
    UNDA               = 347,
    LUX                = 348,
    TENEBRAE           = 349,
    VALLATION          = 350,
    SWORDPLAY          = 351,
    LUNGE              = 352,
    PFLUG              = 353,
    EMBOLDEN           = 354,
    VALIANCE           = 355,
    GAMBIT             = 356,
    LIEMENT            = 357,
    ONE_FOR_ALL        = 358,
    WARD               = 363,
    EFFUSION           = 364,
    APOGEE             = 369,
    CONSUME_MANA       = 373,
    NATURALISTS_ROLL   = 374,
    RUNEISTS_ROLL      = 375,
    HEALING_RUBY       = 496,
    POISON_NAILS       = 497,
    SHINING_RUBY       = 498,
    GLITTERING_RUBY    = 499,
    METEORITE          = 500,
    HEALING_RUBY_II    = 501,
    SEARING_LIGHT      = 502,
    MOONLIT_CHARGE     = 512,
    CRESCENT_FANG      = 513,
    LUNAR_CRY          = 514,
    LUNAR_ROAR         = 515,
    ECLIPTIC_GROWL     = 516,
    ECLIPTIC_HOWL      = 517,
    ECLIPSE_BITE       = 518,
    HOWLING_MOON       = 520,
    PUNCH              = 528,
    FIRE_II            = 529,
    BURNING_STRIKE     = 530,
    DOUBLE_PUNCH       = 531,
    CRIMSON_HOWL       = 532,
    FIRE_IV            = 533,
    FLAMING_CRUSH      = 534,
    METEOR_STRIKE      = 535,
    INFERNO            = 536,
    ROCK_THROW         = 544,
    STONE_II           = 545,
    ROCK_BUSTER        = 546,
    MEGALITH_THROW     = 547,
    EARTHEN_WARD       = 548,
    STONE_IV           = 549,
    MOUNTAIN_BUSTER    = 550,
    GEOCRUSH           = 551,
    EARTHEN_FURY       = 552,
    BARRACUDA_DIVE     = 560,
    WATER_II           = 561,
    TAIL_WHIP          = 562,
    SLOWGA             = 564,
    SPRING_WATER       = 563,
    WATER_IV           = 565,
    SPINNING_DIVE      = 566,
    GRAND_FALL         = 567,
    TIDAL_WAVE         = 568,
    CLAW               = 576,
    AERO_II            = 577,
    WHISPERING_WIND    = 578,
    HASTEGA            = 579,
    AERIAL_ARMOR       = 580,
    AERO_IV            = 581,
    PREDATOR_CLAWS     = 582,
    WIND_BLADE         = 583,
    AERIAL_BLAST       = 584,
    AXE_KICK           = 592,
    BLIZZARD_II        = 593,
    FROST_ARMOR        = 594,
    SLEEPGA            = 595,
    DOUBLE_SLAP        = 596,
    BLIZZARD_IV        = 597,
    RUSH               = 598,
    HEAVENLY_STRIKE    = 599,
    DIAMOND_DUST       = 600,
    SHOCK_STRIKE       = 608,
    THUNDER_II         = 609,
    THUNDERSPARK       = 611,
    ROLLING_THUNDER    = 610,
    LIGHTNING_ARMOR    = 612,
    THUNDER_IV         = 613,
    CHAOTIC_STRIKE     = 614,
    THUNDERSTORM       = 615,
    JUDGMENT_BOLT      = 616,
}
tpz.ja = tpz.jobAbility

tpz.reaction =
{
    NONE     = 0x00,
    MISS     = 0x01,
    PARRY    = 0x03,
    BLOCK    = 0x04,
    HIT      = 0x08,
    EVADE    = 0x09,
    GUARD    = 0x14,
}

tpz.specEffect =
{
    NONE           = 0x00,
    BLOOD          = 0x02,
    HIT            = 0x10,
    RAISE          = 0x11,
    RECOIL         = 0x20,
    CRITICAL_HIT   = 0x22,
}

function corsairSetup(caster, ability, action, effect, job)
    local roll = math.random(1,6)
    caster:delStatusEffectSilent(tpz.effect.DOUBLE_UP_CHANCE)
    caster:addStatusEffectEx(tpz.effect.DOUBLE_UP_CHANCE,
                             tpz.effect.DOUBLE_UP_CHANCE,
                             roll,
                             0,
                             45,
                             ability:getID(),
                             effect,
                             job,
                             true)
    caster:setLocalVar("corsairRollTotal", roll)
    action:speceffect(caster:getID(), roll)
    if (checkForElevenRoll(caster)) then
        action:recast(action:recast()/2) -- halves phantom roll recast timer for all rolls while under the effects of an 11 (upon first hitting 11, phantom roll cooldown is reset in double-up.lua)
    end
    checkForJobBonus(caster, job)
end

function atMaxCorsairBusts(caster)
    local numBusts = caster:numBustEffects()
    return (numBusts >= 2 and caster:getMainJob() == tpz.job.COR) or (numBusts >= 1 and caster:getMainJob() ~= tpz.job.COR)
end

function checkForJobBonus(caster, job)
    local jobBonus = 0
    if (caster:hasPartyJob(job) or math.random(0, 99) < caster:getMod(tpz.mod.JOB_BONUS_CHANCE)) then
        jobBonus = 1
    end
    caster:setLocalVar("corsairRollBonus", jobBonus)
end

function checkForElevenRoll(caster)
    local effects = caster:getStatusEffects()
    for _,effect in ipairs(effects) do
        if (effect:getType() >= tpz.effect.FIGHTERS_ROLL and
            effect:getType() <= tpz.effect.NATURALISTS_ROLL and
            effect:getSubPower() == 11) then
            return true
        end
        if (effect:getType() == tpz.effect.RUNEISTS_ROLL and
                effect:getSubPower() == 11) then
            return true
        end
    end
    return false
end

function phantombuffMultiple(caster) -- Check for tpz.mod.PHANTOM_ROLL Value and apply non-stack logic.
    local phantomValue = caster:getMod(tpz.mod.PHANTOM_ROLL)
    local phantombuffValue = 0
    if (phantomValue == 3) then
        phantombuffMultiplier = 3
    elseif ((phantomValue == 5) or (phantomValue == 8)) then
        phantombuffMultiplier = 5
    elseif ((phantomValue == 7) or (phantomValue == 10) or (phantomValue == 12) or (phantomValue == 15)) then
        phantombuffMultiplier = 7
    else
        phantombuffMultiplier = 0
    end

    return phantombuffMultiplier
end

function AbilityFinalAdjustments(dmg,mob,skill,target,skilltype,skillparam,shadowbehav)
    -- physical attack missed, skip rest
    local msg = skill:getMsg()
    if (msg == 158 or msg == 188 or msg == 31 or msg == 30) then
        return 0
    end

    --handle pd
    if ((target:hasStatusEffect(tpz.effect.PERFECT_DODGE) or target:hasStatusEffect(tpz.effect.TOO_HIGH) )
            and skilltype == tpz.attackType.PHYSICAL) then
        skill:setMsg(tpz.msg.basic.JA_MISS_2)
        return 0
    end

    -- set message to damage
    -- this is for AoE because its only set once
    skill:setMsg(tpz.msg.basic.USES_JA_TAKE_DAMAGE)

    --Handle shadows depending on shadow behaviour / skilltype
    if (shadowbehav ~= MOBPARAM_WIPE_SHADOWS and shadowbehav ~= MOBPARAM_IGNORE_SHADOWS) then --remove 'shadowbehav' shadows.

        dmg = utils.takeShadows(target, dmg, shadowbehav)

        -- dealt zero damage, so shadows took hit
        if (dmg == 0) then
            skill:setMsg(tpz.msg.basic.SHADOW_ABSORB)
            return shadowbehav
        end

    elseif (shadowbehav == MOBPARAM_WIPE_SHADOWS) then --take em all!
        target:delStatusEffect(tpz.effect.COPY_IMAGE)
        target:delStatusEffect(tpz.effect.BLINK)
        target:delStatusEffect(tpz.effect.THIRD_EYE)
    end

    --handle Third Eye using shadowbehav as a guide
    if (skilltype == tpz.attackType.PHYSICAL and utils.thirdeye(target)) then
        skill:setMsg(tpz.msg.basic.ANTICIPATE)
        return 0
    end

    if (skilltype == tpz.attackType.PHYSICAL) then
        dmg = target:physicalDmgTaken(dmg, skillparam)
    elseif (skilltype == tpz.attackType.MAGICAL) then
        dmg = target:magicDmgTaken(dmg)
    elseif (skilltype == tpz.attackType.BREATH) then
        dmg = target:breathDmgTaken(dmg)
    elseif (skilltype == tpz.attackType.RANGED) then
        dmg = target:rangedDmgTaken(dmg)
    end

    --handling phalanx
    dmg = dmg - target:getMod(tpz.mod.PHALANX)

    if (dmg < 0) then
        return 0
    end

    dmg = utils.stoneskin(target, dmg)

    if (dmg > 0) then
        target:wakeUp()
        target:updateEnmityFromDamage(mob,dmg)
    end

    return dmg
end


function takeAbilityDamage(defender, attacker, params, primary, finaldmg, attackType, damageType, slot, tpHitsLanded, extraHitsLanded, shadowsAbsorbed, bonusTP, action, taChar)
    if tpHitsLanded + extraHitsLanded > 0 then
        if finaldmg >= 0 then
            if finaldmg > 0 then
                action:reaction(defender:getID(), tpz.reaction.HIT)
                action:speceffect(defender:getID(), tpz.specEffect.RECOIL)
            end
        else
            -- TODO: ability absorb messages (if there are any)
            -- action:messageID(defender:getID(), tpz.msg.basic.WHATEVER)
        end
        action:param(defender:getID(), finaldmg)
    elseif shadowsAbsorbed > 0 then
        action:messageID(defender:getID(), tpz.msg.basic.SHADOW_ABSORB)
        action:param(defender:getID(), shadowsAbsorbed)
    else
        -- no abilities that use ability message can miss (the rest use ws messages)
    end
    local targetTPMult = params.targetTPMult or 1
    finaldmg = defender:takeWeaponskillDamage(attacker, finaldmg, attackType, damageType, slot, primary, tpHitsLanded, (extraHitsLanded * 10) + bonusTP, targetTPMult)
    local enmityEntity = taChar or attacker
    if (params.overrideCE and params.overrideVE) then
        defender:addEnmity(enmityEntity, params.overrideCE, params.overrideVE)
    else
        local enmityMult = params.enmityMult or 1
        defender:updateEnmityFromDamage(enmityEntity, finaldmg * enmityMult)
    end

    return finaldmg
end
