/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#pragma once

#include <cstdint>

/*
 * This contains a list of message IDs for this type of packet. They should be used
 * in the messageID parameter.
 * Located in 1-27-72.xml if using MassExtractor -full-scan
 */

// Todo: move to enum class
enum class MsgBasic : uint16_t
{
    NONE                           = 0,   // Display nothing
    ATTACK_HITS                    = 1,   // <attacker> hits <target> for <amount> points of damage.
    MAGIC_DAMAGE                   = 2,   // <caster> casts <spell>. <target> takes <amount> points of damage.
    STARTS_CASTING_SELF            = 3,   // <entity> starts casting <spell>.
    TARG_OUT_OF_RANGE              = 4,   // <target> is out of range.
    UNABLE_TO_SEE_TARG             = 5,   // Unable to see <target>.
    DEFEATS_TARG                   = 6,   // The <player> defeats <target>.
    MAGIC_RECOVERS_HP              = 7,   // <caster> casts <spell>. <target> recovers <amount> HP.
    ALREADY_CLAIMED                = 12,  // Cannot attack. Your target is already claimed.
    COUNTER_ABS_BY_SHADOW          = 14,  // The <player>'s attack is countered by the <target>. .. of <player>'s shadows absorbs the damage and disappears.
    ATTACK_MISSES                  = 15,  // <attacker> misses <target>.
    IS_INTERRUPTED                 = 16,  // The <player>'s casting is interrupted.
    UNABLE_TO_CAST                 = 18,  // Unable to cast spells at this time.
    CFH                            = 19,  // <player> calls for help!
    FALLS_TO_GROUND                = 20,  // The <target> falls to the ground.
    CANNOT_CFH                     = 22,  // You cannot call for help at this time.
    LEARNS_NEW_SPELL               = 23,  // <target> learns a new spell!
    TARGET_RECOVERS_HP_SIMPLE      = 24,  // <target> recovers <amount> HP.
    ITEM_USE                       = 28,  // <player> uses <item>.
    IS_PARALYZED                   = 29,  // The <player> is paralyzed.
    TARGET_ANTICIPATES             = 30,  // <target> anticipates the attack.
    SHADOW_ABSORB                  = 31,  // .. of <target>'s shadows absorb the damage and disappears.
    TARGET_DODGES                  = 32,  // <target> dodges the attack.
    ATTACK_COUNTERED_DAMAGE        = 33,  // <attacker>'s attack is countered by <target>. <attacker> takes <amount> points of damage.
    NOT_ENOUGH_MP                  = 34,  // The <player> does not have enough MP to cast (nullptr).
    NO_NINJA_TOOLS                 = 35,  // The <player> lacks the ninja tools to cast (nullptr).
    LOSE_SIGHT                     = 36,  // You lose sight of <target>.
    TOO_FAR_FOR_EXP                = 37,  // You are too far from the battle to gain experience.
    SKILL_GAIN                     = 38,  // <target>'s <skill> skill rises X points.
    CANNOT_IN_THIS_AREA            = 40,  // cannot use in this area
    READIES_WS                     = 43,  // <entity> readies <skill>.
    SPIKES_EFFECT_DMG              = 44,  // <target>'s spikes deal <number> damage to <attacker>
    LEARNS_ABILITY                 = 45,  // <target> learns <ability>!
    CANNOT_CAST_SPELL              = 47,  // <player> cannot cast <spell>.
    UNABLE_TO_CAST_SPELLS          = 49,  // The <player> is unable to cast spells.
    SKILL_LEVEL_UP                 = 53,  // <target>'s <skill> skill reaches level X.
    UNABLE_TO_USE_ITEM             = 56,  // Unable to use item.
    ITEM_FAILS_TO_ACTIVATE         = 62,  // The <item> fails to activate.
    DEBUG_RESISTED_SPELL           = 66,  // Debug: Resisted spell!
    ATTACK_CRIT                    = 67,  // <attacker> scores a critical hit! <target> takes <amount> points of damage.
    TARGET_PARRIES                 = 70,  // <target> parries <attacker>'s attack with his/her weapon.
    CANNOT_PERFORM_ACTION          = 71,  // You cannot perform that action on the specified target.
    MAGIC_NO_EFFECT                = 75,  // <caster>'s <spell> has no effect on <target>.
    NO_TARG_IN_AOE                 = 76,  // No valid target within area of effect.
    TOO_FAR_AWAY                   = 78,  // <target> is too far away.
    DEBUG_DBLATK_PROC              = 79,  // Debug: <target> uses Double Attack (..%)
    DEBUG_TRPATK_PROC              = 80,  // Debug: <target> uses Triple Attack (..%)
    IS_PARALYZED_2                 = 84,  // <target> is paralyzed.
    MAGIC_RESISTED                 = 85,  // <caster> casts <spell>. <target> resists the spell.
    UNABLE_TO_USE_JA               = 87,  // Unable to use job ability.
    UNABLE_TO_USE_JA2              = 88,  // Unable to use job ability.
    UNABLE_TO_USE_WS               = 89,  // Unable to use weaponskill.
    CANNOT_USE_ITEM_ON             = 92,  // Cannot use the <item> on <target>.
    MAGIC_TELEPORT                 = 93,  // <caster> casts <spell>. <target> vanishes.
    WAIT_LONGER                    = 94,  // You must wait longer to perform that action.
    PLAYER_DEFEATED_BY             = 97,  // <player> was defeated by the <target>.
    USES_JA                        = 100, // The <player> uses ..
    USES_JA2                       = 101, // The <player> uses ..
    USES_RECOVERS_HP               = 102, // The <player> uses .. <target> recovers .. HP.
    SKILL_RECOVERS_HP              = 103, // The <player> uses .. <target> recovers .. HP.
    IS_INTIMIDATED                 = 106, // The <player> is intimidated by <target>'s presence.
    USES_ABILITY_TAKES_DAMAGE      = 110, // <user> uses <ability>. <target> takes <amount> points of damage.
    SPIKES_EFFECT_HP_DRAIN         = 132, // <target>'s spikes drain <number> HP from the <attacker>.
    CHARM_SUCCESS                  = 136, // The <player> uses .. <target> is now under the <player>'s control.
    CHARM_FAIL                     = 137, // The <player> uses .. The <player> fails to charm <target>.
    USES_ABILITY_FORTIFIED_DRAGONS = 150, // <user> uses <ability>. <target> is fortified against dragons.
    TARGET_FORTIFIED_DRAGONS       = 151, // <target> is fortified against dragons.
    CANNOT_ON_THAT_TARG            = 155, // You cannot perform that action on the specified target.
    ABILITY_MISSES                 = 158, // <user> uses <ability>, but misses.
    ADD_EFFECT_HP_DRAINED          = 161, // Additional effect: <amount> HP drained from <target>.
    ADD_EFFECT_MP_DRAINED          = 162, // Additional effect: <amount> MP drained from <target>.
    ADD_EFFECT_DAMAGE              = 163, // Additional effect: <amount> points of damage.
    CHECK_DEFAULT                  = 174, // Even defense / even evasion. Does not print.
    USES_SKILL_TAKES_DAMAGE        = 185, // <user> uses <skill>. <target> takes <amount> points of damage.
    USES_SKILL_GAINS_EFFECT        = 186, // <user> uses <skill>. <target> gains the effect of <status>.
    USES_SKILL_HP_DRAINED          = 187, // <user> uses <skill>. <amount> HP drained from <target>.
    USES_SKILL_MISSES              = 188, // <user> uses <skill>, but misses <target>.
    USES_SKILL_NO_EFFECT           = 189, // <user> uses <skill>. No effect on <target>.
    CANNOT_USE_WS                  = 190, // The <player> cannot use that weapon ability.
    CANNOT_USE_ANY_WS              = 191, // The <player> is unable to use weapon skills.
    NOT_ENOUGH_TP                  = 192, // The <player> does not have enough TP.
    USES_ABILITY_RESISTS_DAMAGE    = 197, // <user> uses <ability>, but <target> resists. <target> takes <amount> points of damage.
    REQUIRES_SHIELD                = 199, // That action requires a shield.
    TIME_LEFT                      = 202, // Time left: (h:mm:ss)
    IS_STATUS                      = 203, // <target> is <status>.
    CANNOT_CHARM                   = 210, // The <player> cannot charm <target>!
    VERY_DIFFICULT_CHARM           = 211, // It would be very difficult for the <player> to charm <target>.
    DIFFICULT_TO_CHARM             = 212, // It would be difficult for the <player> to charm <target>.
    MIGHT_BE_ABLE_CHARM            = 213, // The <player> might be able to charm <target>.
    SHOULD_BE_ABLE_CHARM           = 214, // The <player> should be able to charm <target>.
    REQUIRES_A_PET                 = 215, // That action requires a pet.
    NO_RANGED_WEAPON               = 216, // You do not have an appropriate ranged weapon equipped.
    CANNOT_SEE                     = 217, // You cannot see <target>.
    MOVE_AND_INTERRUPT             = 218, // You move and interrupt your aim.
    USES_SKILL_RECOVERS_MP         = 224, // <user> uses <skill>. <target> recovers <amount> MP.
    USES_SKILL_MP_DRAINED          = 225, // <user> uses <skill>. <amount> MP drained from <target>.
    USES_SKILL_TP_DRAINED          = 226, // <user> uses <skill>. <amount> TP drained from <target>.
    MAGIC_DRAINS_HP                = 227, // <caster> casts <spell>. <amount> HP drained from <target>.
    ADD_EFFECT_ADDITIONAL_DAMAGE   = 229, // Additional effect: <target> takes <amount> additional points of damage.
    MAGIC_GAINS_EFFECT             = 230, // <caster> casts <spell>. <target> gains the effect of <status>.
    DRAWN_IN                       = 232, // <target> is drawn in!
    THAT_SOMEONES_PET              = 235, // That is someone's pet.
    MAGIC_STATUS                   = 236, // <caster> casts <spell>. <target> is <status>.
    MAGIC_RECEIVES_EFFECT          = 237, // <caster> casts <spell>. <target> receives the effect of <status>.
    USES_SKILL_RECOVERS_HP_AOE     = 238, // <user> uses <skill>. <target> recovers <amount> HP.
    USES_SKILL_STATUS              = 242, // <user> uses <skill>. <target> is <status>.
    USES_SKILL_RECEIVES_EFFECT     = 243, // <user> uses <skill>. <target> receives the effect of <status>.
    CHECK_ITG                      = 249, // <mob> strength is impossible to gauge!
    MAGIC_BURST_DAMAGE             = 252, // <caster> casts <spell>. Magic Burst! <target> takes <amount> points of damage.
    DEBUG_SUCCESS_CHANCE           = 255, // DEBUG: ..% chance of success
    GARDENING_SEED_SOWN            = 256, // In this flower pot: Seeds sown: <item>*/
    GARDENING_CRYSTAL_NONE         = 257, // Crystal used: none*/
    GARDENING_CRYSTAL_USED         = 258, // Crystal used: <item>*/
    TARGET_RECOVERS_HP2            = 263, // <target> recovers <amount> HP.
    TARGET_TAKES_DAMAGE            = 264, // <target> takes <amount> points of damage.
    TARGET_GAINS_EFFECT            = 266, // <target> gains the effect of <status>.
    TARGET_TELEPORT                = 273, // <target> vanishes.
    MAGIC_BURST_DRAINS_HP          = 274, // <caster> casts <spell>. Magic Burst! <amount> HP drained from <target>.
    TARGET_RECOVERS_MP             = 276, // <target> recovers <amount> MP.
    TARGET_STATUS                  = 277, // <target> is <status>.
    TARGET_RECEIVES_EFFECT         = 278, // <target> receives the effect of <status>.
    TARGET_HP_DRAINED              = 281, // <amount> HP drained from <target>.
    TARGET_EVADES                  = 282, // <target> evades.
    TARGET_NO_EFFECT               = 283, // No effect on <target>.
    MAGIC_RESISTED_TARGET          = 284, // <target> resists the effects of the spell!
    USES_ITEM_RECOVERS_HP_AOE      = 306, // <user> uses <item>. <target> recovers <amount> HP.
    NEEDS_2H_WEAPON                = 307, // That action requires a two-handed weapon.
    SKILL_DROP                     = 310, // <target>'s <skill> skill drops X points!
    OUT_OF_RANGE_UNABLE_CAST       = 313, // Out of range unable to cast
    ALREADY_HAS_A_PET              = 315, // The <player> already has a pet.
    CANNOT_USE_IN_AREA             = 316, // That action cannot be used in this area.
    USES_JA_TAKE_DAMAGE            = 317, // The <player> uses .. <target> takes .. points of damage.
    USES_ITEM_RECOVERS_HP_AOE2     = 318, // <user> uses <item>. <target> recovers <amount> HP.
    USES_BUT_MISSES                = 324, // The <player> uses .. but misses <target>.
    READIES_SKILL                  = 326, // <entity> readies <skill>.
    STARTS_CASTING_TARGET          = 327, // <entity> starts casting <spell> on <target>.
    TOO_FAR_AWAY_RED               = 328, // <target> is too far away. (but in the red color)
    NO_EFFECT_ON_PET               = 336, // No effect on that pet.
    NO_JUG_PET_ITEM                = 337, // You do not have the necessary item equipped to call a beast.
    YOUR_MOUNT_REFUSES             = 339, // Your mount senses a hostile presence and refuses to come to your side.
    TARGET_EFFECT_DISAPPEARS       = 343, // <target>'s <status> effect disappears!
    MUST_HAVE_FOOD                 = 347, // You must have pet food equipped to use that command.
    RANGED_ATTACK_HIT              = 352, // <user> ranged attack hits <target> for <amount> points of damage.
    RANGED_ATTACK_CRIT             = 353, // <user> ranged attack scores a critical hit! \n <target> takes <amount> points of damage.
    RANGED_ATTACK_MISS             = 354, // <user> ranged attack misses.
    RANGED_ATTACK_NO_EFFECT        = 355, // <user> ranged attack has no effect on <target>.
    FULL_INVENTORY                 = 356, // Cannot execute command. Your inventory is full.
    USES_SKILL_TP_REDUCED          = 362, // <user> uses <skill>. <target>'s TP is reduced to <amount>.
    TARGET_TP_REDUCED              = 363, // <target>'s TP is reduced to <amount>.
    TARGET_MP_DRAINED              = 366, // <amount> MP drained from <target>.
    TARGET_RECOVERS_HP             = 367, // <target> recovers <amount> HP.
    USES_SKILL_EFFECT_DRAINED      = 370, // <user> uses <skill>. <amount> status effects drained from <target>.
    SPIKES_EFFECT_RECOVER          = 373, // <defender> recovers <number> hit points!
    STATUS_SPIKES                  = 374, // Striking <defender>'s armor causes <attacker> to become <status effect>.
    USES_ABILITY_DISPEL            = 378, // <user> uses <ability>. <target>'s <status> effect disappears!
    MERIT_INCREASE                 = 380, // Your <merit> modification has risen to level <level>
    MERIT_DECREASE                 = 381, // Your <merit> modification has dropped to level <level>
    RANGED_ATTACK_ABSORBS          = 382, // <attacker>'s ranged attack hits <target>. <target> recovers <amount> hit points!
    SPIKES_EFFECT_HEAL             = 383, // <target>'s spikes restore <number> HP to <attacker>
    ADD_EFFECT_RECOVERS_HP         = 384, // Additional effect: <target> recovers <amount> HP.
    TARGET_EFFECT_DRAINED          = 404, // <amount> status effects drained from <target>.
    LEARNS_SPELL                   = 419, // <target> learns (nullptr)!
    ROLL_MAIN                      = 420, // The <player> uses .. The total comes to ..! <target> receives the effect of ..
    ROLL_SUB                       = 421, // <target> receives the effect of ..
    ROLL_MAIN_FAIL                 = 422, // The <player> uses .. The total comes to ..! No effect on <target>.
    ROLL_SUB_FAIL                  = 423, // No effect on <target>.
    DOUBLEUP                       = 424, // The <player> uses Double-Up. The total for . increases to ..! <target> receives the effect of ..
    DOUBLEUP_FAIL                  = 425, // The <player> uses Double-Up. The total for . increases to ..! No effect on <target>.
    DOUBLEUP_BUST                  = 426, // The <player> uses Double-Up. Bust! <target> loses the effect of ..
    DOUBLEUP_BUST_SUB              = 427, // <target> loses the effect of ..
    NO_ELIGIBLE_ROLL               = 428, // There are no rolls eligible for Double-Up. Unable to use ability.
    ROLL_ALREADY_ACTIVE            = 429, // The same roll is already active on the <player>.
    MAGIC_STEAL                    = 430, // <caster> casts <spell>. <number> of <target>'s effects is drained.
    USES_ABILITY_RECHARGE          = 435, // <user> uses <ability>! <target>'s abilities are recharged.
    TARGET_ABILITIES_RECHARGED     = 436, // <target>'s abilities are recharged.
    USES_ABILITY_RECHARGE_TP       = 437, // <user> uses <ability>! <target>'s abilities are recharged. <target>'s TP is increased.
    TARGET_RECHARGED_TP            = 438, // <target>'s abilities are recharged. <target>'s TP is increased.
    USES_ABILITY_RECHARGE_MP       = 439, // <user> uses <ability>! All of <target>'s abilities are recharged. <target> regains MP.
    TARGET_RECHARGED_MP            = 440, // All of <target>'s abilities are recharged. <target> regains MP.
    LEARNS_NEW_ABILITY             = 442, // <target> learns a new ability!
    CANNOT_USE_ITEMS               = 445, // You cannot use items at this time.
    CANNOT_ATTACK_TARGET           = 446, // You cannot attack that target
    REQUIRES_2H_FOR_GRIP           = 512, // You must have a two-handed weapon equipped to equip a grip.
    NO_FINISHINGMOVES              = 524,
    RETALIATE_SHADOW_ABSORBS       = 535, // <target> retaliates. <number> of <attacker>'s shadows absorbs the damage and disappears.
    RETALIATE_DAMAGE               = 536, // <target> retaliates. <attacker> takes <amount> points of damage.
    LEVEL_SYNC_ACTIVATED           = 540, // Level Sync activated. Your level has been restricted to X.
    LEVEL_SYNC_NO_EXP              = 545, // No experience points gained... The Level Sync designee is too far or unconscious.
    OBTAINS                        = 565, // <target> obtains <amount>.
    PET_CANNOT_DO_ACTION           = 574, // <player>'s pet is currently unable to perform that action.
    PET_NOT_ENOUGH_TP              = 575, // <player>'s pet does not have enough TP to perform that action.
    RANGED_ATTACK_SQUARELY         = 576, // <user> ranged attack hits the <target> squarely for <amount> points of damage.,
    RANGED_ATTACK_PUMMELS          = 577, // <user> ranged attack strikes true, pummeling <target> for <amount> points of damage!,
    TARGET_REGAINS_HP              = 587, // <target> regains <amount> HP.
    TARGET_REGAINS_MP              = 588, // <target> regains <amount> MP.
    PERFECT_COUNTER_MISS           = 592, // <player> attempts to counter <target>'s attack, but misses.
    TREASURE_HUNTER_UP             = 603, // Additional effect: Treasure Hunter effectiveness against <target> increases to ..
    COUNTER_ABSORBED_DMG           = 606, // The <target> absorbs <player>'s counter. The <target> recovers .. HP.
    SAME_EEFECT_LUOPAN             = 660, // The same effect is already active on that luopan!
    LUOPAN_ALREADY_PLACED          = 661, // <player> has already placed a luopan. Unable to use ability.
    REQUIRE_LUOPAN                 = 662, // This action requires a luopan.
    LUOPAN_HP_RATE_DOWN            = 663, // <player> uses <ability>. The luopan's HP consumption rate has been reduced.
    LUOPAN_HP_RATE_UP              = 664, // <player> uses <ability>. The luopan's HP consumption rate has been increased.
    HAS_LUOPON_NO_USE              = 665, // <player> has a pet. Unable to use ability.
    REQUIRE_RUNE                   = 666, // That action requires the ability Rune Enchantment.
    SWORDPLAY_GAIN                 = 667, // <Player> uses <Ability>. Accuracy and evasion are enhanced.
    VALLATION_GAIN                 = 668,
    VALIANCE_GAIN_PARTY_MEMBER     = 669, // <Target> receives the effect of Vallation, reducing damage taken from certain elemental magic spells. Vallation and Valiance both use this message for the RUN using the ja. Magic damage of a certain element is reduced for <Target>
    LIEMENT_GAIN                   = 670, // <Player> uses <Ability>. <Target> can now absorb magic damage of a certain element.
    PFLUG_GAIN                     = 671, // <Player> uses <Ability>. <Target> now has enhanced resistance.
    GAMBIT_GAIN                    = 672, // <Player> uses <Ability>. <Target> receives the effect of Gambit, reducing magic defense against magic of a certain element.
    FERETORY_COUNTDOWN             = 679, // <actor> will return to the Feretory in <n>
    ROE_RECORD                     = 697, // Records of Eminence: <record>.
    ROE_PROGRESS                   = 698, // Progress: <amount>/<amount>.
    TRUST_NO_CAST_TRUST            = 700, // You are unable to use Trust magic at this time.
    ROE_START                      = 704,
    ROE_TIMED                      = 705, // You have undertaken the timed record X.
    CHECKPARAM_PRIMARY             = 712,
    CHECKPARAM_AUXILIARY           = 713,
    CHECKPARAM_RANGE               = 714,
    CHECKPARAM_DEFENSE             = 715,
    TRUST_NO_CALL_AE               = 717, // You cannot call forth alter egos here.
    JOB_POINTS_INCREASE            = 720, // Your <job point category> modification has risen to level ≺level≻.
    CHECKPARAM_ILVL                = 731,
    CHECKPARAM_NAME                = 733,
    AUTO_EXCEEDS_CAPACITY          = 745, // Your automaton exceeds one or more elemental capacity values and cannot be activated.
    MOUNT_REQUIRED_LEVEL           = 773, // You are unable to call forth your mount because your main job level is not at least <level>.
};
