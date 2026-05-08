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

enum class MsgBasic : uint16_t
{
    None                            = 0,   // Display nothing
    AttackHits                      = 1,   // <attacker> hits <target> for <amount> points of damage.
    MagicDamage                     = 2,   // <caster> casts <spell>. <target> takes <amount> points of damage.
    StartsCastingSelf               = 3,   // <entity> starts casting <spell>.
    TargetOutOfRange                = 4,   // <target> is out of range.
    UnableToSeeTarget               = 5,   // Unable to see <target>.
    DefeatsTarget                   = 6,   // The <player> defeats <target>.
    MagicRecoversHP                 = 7,   // <caster> casts <spell>. <target> recovers <amount> HP.
    ExperiencePointsGained          = 8,   // <player> gains # experience points.
    LevelUp                         = 9,   // <player> attains level #!
    LevelDown                       = 11,  // <player> falls to level #.
    AlreadyClaimed                  = 12,  // Cannot attack. Your target is already claimed.
    CounterAbsByShadow              = 14,  // The <player>'s attack is countered by the <target>. .. of <player>'s shadows absorbs the damage and disappears.
    AttackMisses                    = 15,  // <attacker> misses <target>.
    IsInterrupted                   = 16,  // The <player>'s casting is interrupted.
    UnableToCast                    = 18,  // Unable to cast spells at this time.
    CallForHelp                     = 19,  // <player> calls for help!
    FallsToGround                   = 20,  // The <target> falls to the ground.
    CannotCallForHelp               = 22,  // You cannot call for help at this time.
    LearnsNewSpell                  = 23,  // <target> learns a new spell!
    TargetRecoversHPSimple          = 24,  // <target> recovers <amount> HP.
    ItemUse                         = 28,  // <player> uses <item>.
    IsParalyzed                     = 29,  // The <player> is paralyzed.
    TargetAnticipates               = 30,  // <target> anticipates the attack.
    ShadowAbsorb                    = 31,  // .. of <target>'s shadows absorb the damage and disappears.
    TargetDodges                    = 32,  // <target> dodges the attack.
    AttackCounteredDamage           = 33,  // <attacker>'s attack is countered by <target>. <attacker> takes <amount> points of damage.
    NotEnoughMP                     = 34,  // The <player> does not have enough MP to cast (nullptr).
    NoNinjaTools                    = 35,  // The <player> lacks the ninja tools to cast (nullptr).
    LoseSight                       = 36,  // You lose sight of <target>.
    TooFarForExp                    = 37,  // You are too far from the battle to gain experience.
    SkillGain                       = 38,  // <target>'s <skill> skill rises X points.
    NeedDualWield                   = 39,  // You need the Dual Wield ability to equip <name of item> as a sub-weapon
    CannotInThisArea                = 40,  // cannot use in this area
    ReadiesWeaponskill              = 43,  // <entity> readies <skill>.
    SpikesEffectDmg                 = 44,  // <target>'s spikes deal <number> damage to <attacker>
    LearnsAbility                   = 45,  // <target> learns <ability>!
    CannotCastSpell                 = 47,  // <player> cannot cast <spell>.
    UnableToCastSpells              = 49,  // The <player> is unable to cast spells.
    MeritPointGained                = 50,  // <player> earns a merit point! (Total: #)
    SkillLevelUp                    = 53,  // <target>'s <skill> skill reaches level X.
    UnableToUseItem                 = 56,  // Unable to use item.
    ItemFailsToActivate             = 62,  // The <item> fails to activate.
    DebugResistedSpell              = 66,  // Debug: Resisted spell!
    AttackCrit                      = 67,  // <attacker> scores a critical hit! <target> takes <amount> points of damage.
    TargetParries                   = 70,  // <target> parries <attacker>'s attack with his/her weapon.
    CannotPerformAction             = 71,  // You cannot perform that action on the specified target.
    MagicNoEffect                   = 75,  // <caster>'s <spell> has no effect on <target>.
    NoTargetInAreaOfEffect          = 76,  // No valid target within area of effect.
    UsesSangeTakesDamage            = 77,  // <user> uses Sange. <target> takes <amount> points of damage.
    TooFarAway                      = 78,  // <target> is too far away.
    DebugDoubleAttackProc           = 79,  // Debug: <target> uses Double Attack (..%)
    DebugTripleAttackProc           = 80,  // Debug: <target> uses Triple Attack (..%)
    IsParalyzed2                    = 84,  // <target> is paralyzed.
    MagicResisted                   = 85,  // <caster> casts <spell>. <target> resists the spell.
    UnableToUseJobAbility           = 87,  // Unable to use job ability.
    UnableToUseJobAbility2          = 88,  // Unable to use job ability.
    UnableToUseWeaponskill          = 89,  // Unable to use weaponskill.
    CannotUseItemOn                 = 92,  // Cannot use the <item> on <target>.
    MagicTeleport                   = 93,  // <caster> casts <spell>. <target> vanishes.
    WaitLonger                      = 94,  // You must wait longer to perform that action.
    PlayerDefeatedBy                = 97,  // <player> was defeated by the <target>.
    UsesJobAbility                  = 100, // The <player> uses ..
    UsesJobAbility2                 = 101, // The <player> uses ..
    UsesRecoversHP                  = 102, // The <player> uses .. <target> recovers .. HP.
    SkillRecoversHP                 = 103, // The <player> uses .. <target> recovers .. HP.
    IsIntimidated                   = 106, // The <player> is intimidated by <target>'s presence.
    UsesAbilityTakesDamage          = 110, // <user> uses <ability>. <target> takes <amount> points of damage.
    MagicFail                       = 114, // <caster> casts <spell> on <target>, but the spell fails to take effect
    UsesAbilityFortifiedUndead      = 131, // <user> uses <ability>. <target> is fortified against undead.
    SpikesEffectHPDrain             = 132, // <target>'s spikes drain <number> HP from the <attacker>.
    UsesAbilityFortifiedArcana      = 134, // <user> uses <ability>. <target> is fortified against arcana.
    CharmSuccess                    = 136, // The <player> uses .. <target> is now under the <player>'s control.
    CharmFail                       = 137, // The <player> uses .. The <player> fails to charm <target>.
    UsesAbilityFortifiedDemons      = 148, // <user> uses <ability>. <target> is fortified against demons.
    TargetFortifiedDemons           = 149, // <target> is fortified against demons.
    UsesAbilityFortifiedDragons     = 150, // <user> uses <ability>. <target> is fortified against dragons.
    TargetFortifiedDragons          = 151, // <target> is fortified against dragons.
    CannotOnThatTarget              = 155, // You cannot perform that action on the specified target.
    UsesBarrageTakesDamage          = 157, // <user> uses Barrage. <target> takes <amount> points of damage.
    AbilityMisses                   = 158, // <user> uses <ability>, but misses.
    AddEffectHPDrained              = 161, // Additional effect: <amount> HP drained from <target>.
    AddEffectMPDrained              = 162, // Additional effect: <amount> MP drained from <target>.
    AddEffectDamage                 = 163, // Additional effect: <amount> points of damage.
    CheckDefault                    = 174, // Even defense / even evasion. Does not print.
    UsesSkillTakesDamage            = 185, // <user> uses <skill>. <target> takes <amount> points of damage.
    UsesSkillGainsEffect            = 186, // <user> uses <skill>. <target> gains the effect of <status>.
    UsesSkillHPDrained              = 187, // <user> uses <skill>. <amount> HP drained from <target>.
    UsesSkillMisses                 = 188, // <user> uses <skill>, but misses <target>.
    UsesSkillNoEffect               = 189, // <user> uses <skill>. No effect on <target>.
    CannotUseWeaponskill            = 190, // The <player> cannot use that weapon ability.
    CannotUseAnyWeaponskill         = 191, // The <player> is unable to use weapon skills.
    NotEnoughTP                     = 192, // The <player> does not have enough TP.
    UsesAbilityResistsDamage        = 197, // <user> uses <ability>, but <target> resists. <target> takes <amount> points of damage.
    RequiresShield                  = 199, // That action requires a shield.
    TimeLeft                        = 202, // Time left: (h:mm:ss)
    IsStatus                        = 203, // <target> is <status>.
    CannotCharm                     = 210, // The <player> cannot charm <target>!
    VeryDifficultCharm              = 211, // It would be very difficult for the <player> to charm <target>.
    DifficultToCharm                = 212, // It would be difficult for the <player> to charm <target>.
    MightBeAbleCharm                = 213, // The <player> might be able to charm <target>.
    ShouldBeAbleCharm               = 214, // The <player> should be able to charm <target>.
    RequiresAPet                    = 215, // That action requires a pet.
    NoRangedWeapon                  = 216, // You do not have an appropriate ranged weapon equipped.
    CannotSee                       = 217, // You cannot see <target>.
    MoveAndInterrupt                = 218, // You move and interrupt your aim.
    UsesSkillRecoversMP             = 224, // <user> uses <skill>. <target> recovers <amount> MP.
    UsesSkillMPDrained              = 225, // <user> uses <skill>. <amount> MP drained from <target>.
    UsesSkillTPDrained              = 226, // <user> uses <skill>. <amount> TP drained from <target>.
    MagicDrainsHP                   = 227, // <caster> casts <spell>. <amount> HP drained from <target>.
    AddEffectAdditionalDamage       = 229, // Additional effect: <target> takes <amount> additional points of damage.
    MagicGainsEffect                = 230, // <caster> casts <spell>. <target> gains the effect of <status>.
    DrawnIn                         = 232, // <target> is drawn in!
    ThatSomeonesPet                 = 235, // That is someone's pet.
    MagicStatus                     = 236, // <caster> casts <spell>. <target> is <status>.
    MagicReceivesEffect             = 237, // <caster> casts <spell>. <target> receives the effect of <status>.
    UsesSkillRecoversHPAreaOfEffect = 238, // <user> uses <skill>. <target> recovers <amount> HP.
    UsesSkillStatus                 = 242, // <user> uses <skill>. <target> is <status>.
    UsesSkillReceivesEffect         = 243, // <user> uses <skill>. <target> receives the effect of <status>.
    CheckImpossibleToGauge          = 249, // <mob> strength is impossible to gauge!
    MagicBurstDamage                = 252, // <caster> casts <spell>. Magic Burst! <target> takes <amount> points of damage.
    ExpChain                        = 253, // EXP chain #! <player> gains # experience points.
    DebugSuccessChance              = 255, // DEBUG: ..% chance of success
    GardeningSeedSown               = 256, // In this flower pot: Seeds sown: <item>*/
    GardeningCrystalNone            = 257, // Crystal used: none*/
    GardeningCrystalUsed            = 258, // Crystal used: <item>*/
    TargetRecoversHP2               = 263, // <target> recovers <amount> HP.
    TargetTakesDamage               = 264, // <target> takes <amount> points of damage.
    TargetGainsEffect               = 266, // <target> gains the effect of <status>.
    TargetReceivesEffectAbility     = 267, // <target> receives the effect of <status>.
    TargetTeleport                  = 273, // <target> vanishes.
    MagicBurstDrainsHP              = 274, // <caster> casts <spell>. Magic Burst! <amount> HP drained from <target>.
    TargetRecoversMP                = 276, // <target> recovers <amount> MP.
    TargetStatus                    = 277, // <target> is <status>.
    TargetReceivesEffect            = 278, // <target> receives the effect of <status>.
    TargetHPDrained                 = 281, // <amount> HP drained from <target>.
    TargetEvades                    = 282, // <target> evades.
    TargetNoEffect                  = 283, // No effect on <target>.
    MagicResistedTarget             = 284, // <target> resists the effects of the spell!
    TargetFortifiedUndead           = 286, // <target> is fortified against undead.
    TargetFortifiedArcana           = 287, // <target> is fortified against arcana.
    UsesItemRecoversHPAreaOfEffect  = 306, // <user> uses <item>. <target> recovers <amount> HP.
    Needs2HWeapon                   = 307, // That action requires a two-handed weapon.
    SkillDrop                       = 310, // <target>'s <skill> skill drops X points!
    OutOfRangeUnableCast            = 313, // Out of range unable to cast
    AlreadyHasAPet                  = 315, // The <player> already has a pet.
    CannotUseInArea                 = 316, // That action cannot be used in this area.
    UsesJobAbilityTakeDamage        = 317, // The <player> uses .. <target> takes .. points of damage.
    UsesItemRecoversHPAreaOfEffect2 = 318, // <user> uses <item>. <target> recovers <amount> HP.
    UsesAbilityGainsEffect          = 319, // <user> uses <ability>. <target> gains the effect of <status>.
    UsesAbilityReceivesEffect       = 320, // <user> uses <ability>. <target> receives the effect of <status>.
    UsesAbilityNoEffect             = 323, // <user> uses <ability>. No effect on <target>.
    UsesButMisses                   = 324, // The <player> uses .. but misses <target>.
    ReadiesSkill                    = 326, // <entity> readies <skill>.
    StartsCastingTarget             = 327, // <entity> starts casting <spell> on <target>.
    TooFarAwayRed                   = 328, // <target> is too far away. (but in the red color)
    NoEffectOnPet                   = 336, // No effect on that pet.
    NoJugPetItem                    = 337, // You do not have the necessary item equipped to call a beast.
    YourMountRefuses                = 339, // Your mount senses a hostile presence and refuses to come to your side.
    TargetEffectDisappears          = 343, // <target>'s <status> effect disappears!
    MustHaveFood                    = 347, // You must have pet food equipped to use that command.
    RangedAttackHit                 = 352, // <user> ranged attack hits <target> for <amount> points of damage.
    RangedAttackCrit                = 353, // <user> ranged attack scores a critical hit! \n <target> takes <amount> points of damage.
    RangedAttackMiss                = 354, // <user> ranged attack misses.
    RangedAttackNoEffect            = 355, // <user> ranged attack has no effect on <target>.
    FullInventory                   = 356, // Cannot execute command. Your inventory is full.
    UsesSkillTPReduced              = 362, // <user> uses <skill>. <target>'s TP is reduced to <amount>.
    TargetTPReduced                 = 363, // <target>'s TP is reduced to <amount>.
    TargetMPDrained                 = 366, // <amount> MP drained from <target>.
    TargetRecoversHP                = 367, // <target> recovers <amount> HP.
    UsesSkillEffectDrained          = 370, // <user> uses <skill>. <amount> status effects drained from <target>.
    LimitPointsGained               = 371, // <player> gains # limit points.
    LimitChain                      = 372, // Limit chain ##! <player> gains # limit points.
    SpikesEffectRecover             = 373, // <defender> recovers <number> hit points!
    StatusSpikes                    = 374, // Striking <defender>'s armor causes <attacker> to become <status effect>.
    UsesAbilityDispel               = 378, // <user> uses <ability>. <target>'s <status> effect disappears!
    MeritIncrease                   = 380, // Your <merit> modification has risen to level <level>
    MeritDecrease                   = 381, // Your <merit> modification has dropped to level <level>
    RangedAttackAbsorbs             = 382, // <attacker>'s ranged attack hits <target>. <target> recovers <amount> hit points!
    SpikesEffectHeal                = 383, // <target>'s spikes restore <number> HP to <attacker>
    AddEffectRecoversHP             = 384, // Additional effect: <target> recovers <amount> HP.
    TargetEffectDrained             = 404, // <amount> status effects drained from <target>.
    LearnsSpell                     = 419, // <target> learns (nullptr)!
    RollMain                        = 420, // The <player> uses .. The total comes to ..! <target> receives the effect of ..
    ReceivesEffectAbility           = 421, // <target> receives the effect of <ability>.
    RollMainFail                    = 422, // The <player> uses .. The total comes to ..! No effect on <target>.
    RollSubFail                     = 423, // No effect on <target>.
    DoubleUp                        = 424, // The <player> uses Double-Up. The total for . increases to ..! <target> receives the effect of ..
    DoubleUpFail                    = 425, // The <player> uses Double-Up. The total for . increases to ..! No effect on <target>.
    DoubleUpBust                    = 426, // The <player> uses Double-Up. Bust! <target> loses the effect of ..
    DoubleUpBustSub                 = 427, // <target> loses the effect of ..
    NoEligibleRoll                  = 428, // There are no rolls eligible for Double-Up. Unable to use ability.
    RollAlreadyActive               = 429, // The same roll is already active on the <player>.
    MagicSteal                      = 430, // <caster> casts <spell>. <number> of <target>'s effects is drained.
    UsesAbilityRecharge             = 435, // <user> uses <ability>! <target>'s abilities are recharged.
    TargetAbilitiesRecharged        = 436, // <target>'s abilities are recharged.
    UsesAbilityRechargeTP           = 437, // <user> uses <ability>! <target>'s abilities are recharged. <target>'s TP is increased.
    TargetRechargedTP               = 438, // <target>'s abilities are recharged. <target>'s TP is increased.
    UsesAbilityRechargeMP           = 439, // <user> uses <ability>! All of <target>'s abilities are recharged. <target> regains MP.
    TargetRechargedMP               = 440, // All of <target>'s abilities are recharged. <target> regains MP.
    UsesAbilityEffect               = 441, // <user> receives the effect of <ability>.
    LearnsNewAbility                = 442, // <target> learns a new ability!
    CannotUseItems                  = 445, // You cannot use items at this time.
    CannotAttackTarget              = 446, // You cannot attack that target
    Requires2HForGrip               = 512, // You must have a two-handed weapon equipped to equip a grip.
    NoFinishingMoves                = 524,
    RetaliateShadowAbsorbs          = 535, // <target> retaliates. <number> of <attacker>'s shadows absorbs the damage and disappears.
    RetaliateDamage                 = 536, // <target> retaliates. <attacker> takes <amount> points of damage.
    LevelSyncActivated              = 540, // Level Sync activated. Your level has been restricted to X.
    LevelSyncNoExp                  = 545, // No experience points gained... The Level Sync designee is too far or unconscious.
    Obtains                         = 565, // <target> obtains <amount>.
    PetCannotDoAction               = 574, // <player>'s pet is currently unable to perform that action.
    PetNotEnoughTP                  = 575, // <player>'s pet does not have enough TP to perform that action.
    RangedAttackSquarely            = 576, // <user> ranged attack hits the <target> squarely for <amount> points of damage.,
    RangedAttackPummels             = 577, // <user> ranged attack strikes true, pummeling <target> for <amount> points of damage!,
    TargetRegainsHP                 = 587, // <target> regains <amount> HP.
    TargetRegainsMP                 = 588, // <target> regains <amount> MP.
    PerfectCounterMiss              = 592, // <player> attempts to counter <target>'s attack, but misses.
    TreasureHunterUp                = 603, // Additional effect: Treasure Hunter effectiveness against <target> increases to ..
    CounterAbsorbedDmg              = 606, // The <target> absorbs <player>'s counter. The <target> recovers .. HP.
    MagicCompleteResist             = 655, // <caster> casts <spell>. <target> completely resists the spell.
    SameEffectLuopan                = 660, // The same effect is already active on that luopan!
    LuopanAlreadyPlaced             = 661, // <player> has already placed a luopan. Unable to use ability.
    RequireLuopan                   = 662, // This action requires a luopan.
    LuopanHPRateDown                = 663, // <player> uses <ability>. The luopan's HP consumption rate has been reduced.
    LuopanHPRateUp                  = 664, // <player> uses <ability>. The luopan's HP consumption rate has been increased.
    HasLuopanNoUse                  = 665, // <player> has a pet. Unable to use ability.
    RequireRune                     = 666, // That action requires the ability Rune Enchantment.
    SwordplayGain                   = 667, // <Player> uses <Ability>. Accuracy and evasion are enhanced.
    VallationGain                   = 668,
    ValianceGainPartyMember         = 669, // <Target> receives the effect of Vallation, reducing damage taken from certain elemental magic spells. Vallation and Valiance both use this message for the RUN using the ja. Magic damage of a certain element is reduced for <Target>
    LiementGain                     = 670, // <Player> uses <Ability>. <Target> can now absorb magic damage of a certain element.
    PflugGain                       = 671, // <Player> uses <Ability>. <Target> now has enhanced resistance.
    GambitGain                      = 672, // <Player> uses <Ability>. <Target> receives the effect of Gambit, reducing magic defense against magic of a certain element.
    FeretoryCountdown               = 679, // <actor> will return to the Feretory in <n>
    ROERecord                       = 697, // Records of Eminence: <record>.
    ROEProgress                     = 698, // Progress: <amount>/<amount>.
    TrustNoCastTrust                = 700, // You are unable to use Trust magic at this time.
    ROEStart                        = 704,
    ROETimed                        = 705, // You have undertaken the timed record X.
    TrustPartyMessage               = 711, // Special lookup for various trust party messages.
    CheckparamPrimary               = 712,
    CheckparamAuxiliary             = 713,
    CheckparamRange                 = 714,
    CheckparamDefense               = 715,
    TrustNoCallAlterEgos            = 717, // You cannot call forth alter egos here.
    CapacityPointsGained            = 718, // <player> gains # capacity points.
    JobPointGained                  = 719, // <player> earns a job point! (Total: #)
    JobPointsIncrease               = 720, // Your <job point category> modification has risen to level ≺level≻.
    CheckparamIlvl                  = 731,
    CheckparamName                  = 733,
    CapacityChain                   = 735, // Capacity chain ##! <player> gains # capacity points.
    ROEUnable                       = 742, // You are currently unable to undertake this objective.
    AutoExceedsCapacity             = 745, // Your automaton exceeds one or more elemental capacity values and cannot be activated.
    MountRequiredLevel              = 773, // You are unable to call forth your mount because your main job level is not at least <level>.
    AlterEgoUpgrade                 = 828, // <category> attribute increased to #.
};
