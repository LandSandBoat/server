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

#include "common/cbasetypes.h"
#include "merit_category.h"

enum class MeritType : uint16
{
    // HP
    MaxHP    = MeritCategory::HP_MP + 0x00,
    MaxMP    = MeritCategory::HP_MP + 0x02,
    MaxMerit = MeritCategory::HP_MP + 0x04,

    // ATTRIBUTES
    STR = MeritCategory::Attributes + 0x00,
    DEX = MeritCategory::Attributes + 0x02,
    VIT = MeritCategory::Attributes + 0x04,
    AGI = MeritCategory::Attributes + 0x06,
    INT = MeritCategory::Attributes + 0x08,
    MND = MeritCategory::Attributes + 0x0A,
    CHR = MeritCategory::Attributes + 0x0C,

    // COMBAT SKILLS
    HandToHand   = MeritCategory::Combat + 0x00,
    Dagger       = MeritCategory::Combat + 0x02,
    Sword        = MeritCategory::Combat + 0x04,
    GreatSword   = MeritCategory::Combat + 0x06,
    Axe          = MeritCategory::Combat + 0x08,
    GreatAxe     = MeritCategory::Combat + 0x0A,
    Scythe       = MeritCategory::Combat + 0x0C,
    Polearm      = MeritCategory::Combat + 0x0E,
    Katana       = MeritCategory::Combat + 0x10,
    GreatKatana  = MeritCategory::Combat + 0x12,
    Club         = MeritCategory::Combat + 0x14,
    Staff        = MeritCategory::Combat + 0x16,
    Archery      = MeritCategory::Combat + 0x18,
    Marksmanship = MeritCategory::Combat + 0x1A,
    Throwing     = MeritCategory::Combat + 0x1C,
    Guarding     = MeritCategory::Combat + 0x1E,
    Evasion      = MeritCategory::Combat + 0x20,
    Shield       = MeritCategory::Combat + 0x22,
    Parrying     = MeritCategory::Combat + 0x24,

    // MAGIC SKILLS
    Divine     = MeritCategory::Magic + 0x00,
    Healing    = MeritCategory::Magic + 0x02,
    Enhancing  = MeritCategory::Magic + 0x04,
    Enfeebling = MeritCategory::Magic + 0x06,
    Elemental  = MeritCategory::Magic + 0x08,
    Dark       = MeritCategory::Magic + 0x0A,
    Summoning  = MeritCategory::Magic + 0x0C,
    Ninjutsu   = MeritCategory::Magic + 0x0E,
    Singing    = MeritCategory::Magic + 0x10,
    String     = MeritCategory::Magic + 0x12,
    Wind       = MeritCategory::Magic + 0x14,
    Blue       = MeritCategory::Magic + 0x16,
    Geomancy   = MeritCategory::Magic + 0x18,
    Handbell   = MeritCategory::Magic + 0x1A,

    // OTHERS
    EnmityIncrease       = MeritCategory::Others + 0x00,
    EnmityDecrease       = MeritCategory::Others + 0x02,
    CritHitRate          = MeritCategory::Others + 0x04,
    EnemyCritRate        = MeritCategory::Others + 0x06,
    SpellInteruptionRate = MeritCategory::Others + 0x08,

    // WAR 1
    BerserkRecast    = MeritCategory::WAR1 + 0x00,
    DefenderRecast   = MeritCategory::WAR1 + 0x02,
    WarcryRecast     = MeritCategory::WAR1 + 0x04,
    AggressorRecast  = MeritCategory::WAR1 + 0x06,
    DoubleAttackRate = MeritCategory::WAR1 + 0x08,

    // MNK 1
    FocusRecast    = MeritCategory::MNK1 + 0x00,
    DodgeRecast    = MeritCategory::MNK1 + 0x02,
    ChakraRecast   = MeritCategory::MNK1 + 0x04,
    CounterRate    = MeritCategory::MNK1 + 0x06,
    KickAttackRate = MeritCategory::MNK1 + 0x08,

    // WHM 1
    DivineSealRecast = MeritCategory::WHM1 + 0x00,
    CureCastTime     = MeritCategory::WHM1 + 0x02,
    BarSpellEffect   = MeritCategory::WHM1 + 0x04,
    BanishEffect     = MeritCategory::WHM1 + 0x06,
    RegenEffect      = MeritCategory::WHM1 + 0x08,

    // BLM 1
    ElementalSealRecast   = MeritCategory::BLM1 + 0x00,
    FireMagicPotency      = MeritCategory::BLM1 + 0x02,
    IceMagicPotency       = MeritCategory::BLM1 + 0x04,
    WindMagicPotency      = MeritCategory::BLM1 + 0x06,
    EarthMagicPotency     = MeritCategory::BLM1 + 0x08,
    LightningMagicPotency = MeritCategory::BLM1 + 0x0A,
    WaterMagicPotency     = MeritCategory::BLM1 + 0x0C,

    // RDM 1
    ConvertRecast          = MeritCategory::RDM1 + 0x00,
    FireMagicAccuracy      = MeritCategory::RDM1 + 0x02,
    IceMagicAccuracy       = MeritCategory::RDM1 + 0x04,
    WindMagicAccuracy      = MeritCategory::RDM1 + 0x06,
    EarthMagicAccuracy     = MeritCategory::RDM1 + 0x08,
    LightningMagicAccuracy = MeritCategory::RDM1 + 0x0A,
    WaterMagicAccuracy     = MeritCategory::RDM1 + 0x0C,

    // THF 1
    FleeRecast        = MeritCategory::THF1 + 0x00,
    HideRecast        = MeritCategory::THF1 + 0x02,
    SneakAttackRecast = MeritCategory::THF1 + 0x04,
    TrickAttackRecast = MeritCategory::THF1 + 0x06,
    TripleAttackRate  = MeritCategory::THF1 + 0x08,

    // PLD 1
    ShieldBashRecast  = MeritCategory::PLD1 + 0x00,
    HolyCircleRecast  = MeritCategory::PLD1 + 0x02,
    SentinelRecast    = MeritCategory::PLD1 + 0x04,
    CoverEffectLength = MeritCategory::PLD1 + 0x06,
    RampartRecast     = MeritCategory::PLD1 + 0x08,

    // DRK 1
    SouleaterRecast    = MeritCategory::DRK1 + 0x00,
    ArcaneCircleRecast = MeritCategory::DRK1 + 0x02,
    LastResortRecast   = MeritCategory::DRK1 + 0x04,
    LastResortEffect   = MeritCategory::DRK1 + 0x06,
    WeaponBashEffect   = MeritCategory::DRK1 + 0x08,

    // BST 1
    KillerEffects   = MeritCategory::BST1 + 0x00,
    RewardRecast    = MeritCategory::BST1 + 0x02,
    CallBeastRecast = MeritCategory::BST1 + 0x04,
    SicRecast       = MeritCategory::BST1 + 0x06,
    TameRecast      = MeritCategory::BST1 + 0x08,

    // BRD 1
    LullabyRecast  = MeritCategory::BRD1 + 0x00,
    FinaleRecast   = MeritCategory::BRD1 + 0x02,
    MinneEffect    = MeritCategory::BRD1 + 0x04,
    MinuetEffect   = MeritCategory::BRD1 + 0x06,
    MadrigalEffect = MeritCategory::BRD1 + 0x08,

    // RNG 1
    ScavengeEffect      = MeritCategory::RNG1 + 0x00,
    CamouflageRecast    = MeritCategory::RNG1 + 0x02,
    SharpshotRecast     = MeritCategory::RNG1 + 0x04,
    UnlimitedShotRecast = MeritCategory::RNG1 + 0x06,
    RapidShotRate       = MeritCategory::RNG1 + 0x08,

    // SAM 1
    ThirdEyeRecast      = MeritCategory::SAM1 + 0x00,
    WardingCircleRecast = MeritCategory::SAM1 + 0x02,
    StoreTPEffect       = MeritCategory::SAM1 + 0x04,
    MeditateRecast      = MeritCategory::SAM1 + 0x06,
    ZanshinAttackRate   = MeritCategory::SAM1 + 0x08,

    // NIN 1
    SubtleBlowEffect = MeritCategory::NIN1 + 0x00,
    KatonEffect      = MeritCategory::NIN1 + 0x02,
    HyotonEffect     = MeritCategory::NIN1 + 0x04,
    HutonEffect      = MeritCategory::NIN1 + 0x06,
    DotonEffect      = MeritCategory::NIN1 + 0x08,
    RaitonEffect     = MeritCategory::NIN1 + 0x0A,
    SuitonEffect     = MeritCategory::NIN1 + 0x0C,

    // DRG 1
    AncientCircleRecast = MeritCategory::DRG1 + 0x00,
    JumpRecast          = MeritCategory::DRG1 + 0x02,
    HighJumpRecast      = MeritCategory::DRG1 + 0x04,
    SuperJumpRecast     = MeritCategory::DRG1 + 0x06,
    SpiritLinkRecast    = MeritCategory::DRG1 + 0x08,

    // SMN 1
    AvatarPhysicalAccuracy = MeritCategory::SMN1 + 0x00,
    AvatarPhysicalAttack   = MeritCategory::SMN1 + 0x02,
    AvatarMagicalAccuracy  = MeritCategory::SMN1 + 0x04,
    AvatarMagicalAttack    = MeritCategory::SMN1 + 0x06,
    SummoningMagicCastTime = MeritCategory::SMN1 + 0x08,

    // BLU 1
    ChainAffinityRecast = MeritCategory::BLU1 + 0x00,
    BurstAffinityRecast = MeritCategory::BLU1 + 0x02,
    MonsterCorrelation  = MeritCategory::BLU1 + 0x04,
    PhysicalPotency     = MeritCategory::BLU1 + 0x06,
    MagicalAccuracy     = MeritCategory::BLU1 + 0x08,

    // COR 1
    PhantomRollRecast = MeritCategory::COR1 + 0x00,
    QuickDrawRecast   = MeritCategory::COR1 + 0x02,
    QuickDrawAccuracy = MeritCategory::COR1 + 0x04,
    RandomDealRecast  = MeritCategory::COR1 + 0x06,
    BustDuration      = MeritCategory::COR1 + 0x08,

    // PUP 1
    AutomatonSkills   = MeritCategory::PUP1 + 0x00,
    MaintenanceRecast = MeritCategory::PUP1 + 0x02,
    RepairEffect      = MeritCategory::PUP1 + 0x04,
    ActivateRecast    = MeritCategory::PUP1 + 0x06,
    RepairRecast      = MeritCategory::PUP1 + 0x08,

    // DNC 1
    StepAccuracy           = MeritCategory::DNC1 + 0x00,
    HasteSambaEffect       = MeritCategory::DNC1 + 0x02,
    ReverseFlourishEffect  = MeritCategory::DNC1 + 0x04,
    BuildingFlourishEffect = MeritCategory::DNC1 + 0x06,

    // SCH 1
    GrimoireRecast       = MeritCategory::SCH1 + 0x00,
    ModusVeritasDuration = MeritCategory::SCH1 + 0x02,
    HelixMagicAccAtt     = MeritCategory::SCH1 + 0x04,
    MaxSublimation       = MeritCategory::SCH1 + 0x06,

    // GEO 1
    FullCircleEffect        = MeritCategory::GEO1 + 0x00,
    EclipticAttritionRecast = MeritCategory::GEO1 + 0x02,
    LifeCycleRecast         = MeritCategory::GEO1 + 0x04,
    BlazeOfGloryRecast      = MeritCategory::GEO1 + 0x06,
    DematerializeRecast     = MeritCategory::GEO1 + 0x08,

    // RUN 1
    RuneEnhancementEffect = MeritCategory::RUN1 + 0x00,
    VallationEffect       = MeritCategory::RUN1 + 0x02,
    LungeEffect           = MeritCategory::RUN1 + 0x04,
    PflugEffect           = MeritCategory::RUN1 + 0x06,
    GambitEffect          = MeritCategory::RUN1 + 0x08,

    // WEAPON SKILLS
    ShijinSpiral = MeritCategory::WeaponSkills + 0x00,
    Exenterator  = MeritCategory::WeaponSkills + 0x02,
    Requiescat   = MeritCategory::WeaponSkills + 0x04,
    Resolution   = MeritCategory::WeaponSkills + 0x06,
    Ruinator     = MeritCategory::WeaponSkills + 0x08,
    Upheaval     = MeritCategory::WeaponSkills + 0x0A,
    Entropy      = MeritCategory::WeaponSkills + 0x0C,
    Stardiver    = MeritCategory::WeaponSkills + 0x0E,
    BladeShun    = MeritCategory::WeaponSkills + 0x10,
    TachiShoha   = MeritCategory::WeaponSkills + 0x12,
    Realmrazer   = MeritCategory::WeaponSkills + 0x14,
    Shattersoul  = MeritCategory::WeaponSkills + 0x16,
    ApexArrow    = MeritCategory::WeaponSkills + 0x18,
    LastStand    = MeritCategory::WeaponSkills + 0x1A,

    // unknown 0
    // MERIT_UNKNOWN1    = MCATEGORY_UNK_0 + 0x00,
    // MERIT_UNKNOWN2    = MCATEGORY_UNK_1 + 0x00,
    // MERIT_UNKNOWN3    = MCATEGORY_UNK_2 + 0x00,
    // MERIT_UNKNOWN4    = MCATEGORY_UNK_3 + 0x00,
    // MERIT_UNKNOWN5    = MCATEGORY_UNK_4 + 0x00,

    // unknown 1
    // MERIT_UNKNOWN1    = MCATEGORY_UNK_0 + 0x00,
    // MERIT_UNKNOWN2    = MCATEGORY_UNK_1 + 0x00,
    // MERIT_UNKNOWN3    = MCATEGORY_UNK_2 + 0x00,
    // MERIT_UNKNOWN4    = MCATEGORY_UNK_3 + 0x00,
    // MERIT_UNKNOWN5    = MCATEGORY_UNK_4 + 0x00,

    // unknown 2
    // MERIT_UNKNOWN1    = MCATEGORY_UNK_0 + 0x00,
    // MERIT_UNKNOWN2    = MCATEGORY_UNK_1 + 0x00,
    // MERIT_UNKNOWN3    = MCATEGORY_UNK_2 + 0x00,
    // MERIT_UNKNOWN4    = MCATEGORY_UNK_3 + 0x00,
    // MERIT_UNKNOWN5    = MCATEGORY_UNK_4 + 0x00,

    // WAR 2
    WarriorsCharge = MeritCategory::WAR2 + 0x00,
    Tomahawk       = MeritCategory::WAR2 + 0x02,
    Savagery       = MeritCategory::WAR2 + 0x04,
    AggressiveAim  = MeritCategory::WAR2 + 0x06,

    // MNK 2
    Mantra          = MeritCategory::MNK2 + 0x00,
    FormlessStrikes = MeritCategory::MNK2 + 0x02,
    Invigorate      = MeritCategory::MNK2 + 0x04,
    Penance         = MeritCategory::MNK2 + 0x06,

    // WHM 2
    Martyr       = MeritCategory::WHM2 + 0x00,
    Devotion     = MeritCategory::WHM2 + 0x02,
    ProtectraV   = MeritCategory::WHM2 + 0x04, // Deprecated
    ShellraV     = MeritCategory::WHM2 + 0x06, // Deprecated
    AnimusSolace = MeritCategory::WHM2 + 0x08,
    AnimusMisery = MeritCategory::WHM2 + 0x0A,

    // BLM 2
    FlareII                      = MeritCategory::BLM2 + 0x00, // Deprecated
    FreezeII                     = MeritCategory::BLM2 + 0x02, // Deprecated
    TornadoII                    = MeritCategory::BLM2 + 0x04, // Deprecated
    QuakeII                      = MeritCategory::BLM2 + 0x06, // Deprecated
    BurstII                      = MeritCategory::BLM2 + 0x08, // Deprecated
    FloodII                      = MeritCategory::BLM2 + 0x0A, // Deprecated
    AncientMagicMagicAttackBonus = MeritCategory::BLM2 + 0x0C,
    AncientMagicMagicBurstDmg    = MeritCategory::BLM2 + 0x0E,
    ElementalMagicAccuracy       = MeritCategory::BLM2 + 0x10,
    ElementalDebuffDuration      = MeritCategory::BLM2 + 0x12,
    ElementalDebuffEffect        = MeritCategory::BLM2 + 0x14,
    AspirAbsorptionAmount        = MeritCategory::BLM2 + 0x16,

    // RDM 2
    DiaIII                 = MeritCategory::RDM2 + 0x00, // Deprecated
    SlowII                 = MeritCategory::RDM2 + 0x02, // Deprecated
    ParalyzeII             = MeritCategory::RDM2 + 0x04, // Deprecated
    PhalanxII              = MeritCategory::RDM2 + 0x06, // Deprecated
    BioIII                 = MeritCategory::RDM2 + 0x08, // Deprecated
    BlindII                = MeritCategory::RDM2 + 0x0A, // Deprecated
    EnfeebleMagicDuration  = MeritCategory::RDM2 + 0x0C,
    MagicAccuracy          = MeritCategory::RDM2 + 0x0E,
    EnhancingMagicDuration = MeritCategory::RDM2 + 0x10,
    ImmunobreakChance      = MeritCategory::RDM2 + 0x12,
    EnspellDamage          = MeritCategory::RDM2 + 0x14,
    Accuracy               = MeritCategory::RDM2 + 0x16,

    // THF 2
    AssassinsCharge = MeritCategory::THF2 + 0x00,
    Feint           = MeritCategory::THF2 + 0x02,
    AuraSteal       = MeritCategory::THF2 + 0x04,
    Ambush          = MeritCategory::THF2 + 0x06,

    // PLD 2
    Fealty   = MeritCategory::PLD2 + 0x00,
    Chivalry = MeritCategory::PLD2 + 0x02,
    IronWill = MeritCategory::PLD2 + 0x04,
    Guardian = MeritCategory::PLD2 + 0x06,

    // DRK 2
    DarkSeal       = MeritCategory::DRK2 + 0x00,
    DiabolicEye    = MeritCategory::DRK2 + 0x02,
    MutedSoul      = MeritCategory::DRK2 + 0x04,
    DesperateBlows = MeritCategory::DRK2 + 0x06,

    // BST 2
    FeralHowl      = MeritCategory::BST2 + 0x00,
    KillerInstinct = MeritCategory::BST2 + 0x02,
    BeastAffinity  = MeritCategory::BST2 + 0x04,
    BeastHealer    = MeritCategory::BST2 + 0x06,

    // BRD 2
    Nightingale      = MeritCategory::BRD2 + 0x00,
    Troubadour       = MeritCategory::BRD2 + 0x02,
    FoeSirvente      = MeritCategory::BRD2 + 0x04, // Deprecated
    AdventurersDirge = MeritCategory::BRD2 + 0x06, // Deprecated
    ConAnima         = MeritCategory::BRD2 + 0x08,
    ConBrio          = MeritCategory::BRD2 + 0x0A,

    // RNG 2
    StealthShot = MeritCategory::RNG2 + 0x00,
    FlashyShot  = MeritCategory::RNG2 + 0x02,
    Snapshot    = MeritCategory::RNG2 + 0x04,
    Recycle     = MeritCategory::RNG2 + 0x06,

    // SAM 2
    Shikikoyo = MeritCategory::SAM2 + 0x00,
    BladeBash = MeritCategory::SAM2 + 0x02,
    Ikishoten = MeritCategory::SAM2 + 0x04,
    Overwhelm = MeritCategory::SAM2 + 0x06,

    // NIN 2
    Sange               = MeritCategory::NIN2 + 0x00,
    NinjaToolExpertise  = MeritCategory::NIN2 + 0x02,
    KatonSan            = MeritCategory::NIN2 + 0x04, // Deprecated
    HyotonSan           = MeritCategory::NIN2 + 0x06, // Deprecated
    HutonSan            = MeritCategory::NIN2 + 0x08, // Deprecated
    DotonSan            = MeritCategory::NIN2 + 0x0A, // Deprecated
    RaitonSan           = MeritCategory::NIN2 + 0x0C, // Deprecated
    SuitonSan           = MeritCategory::NIN2 + 0x0E, // Deprecated
    YoninEffect         = MeritCategory::NIN2 + 0x10,
    InninEffect         = MeritCategory::NIN2 + 0x12,
    NINMagicAccuracy    = MeritCategory::NIN2 + 0x14,
    NINMagicAttackBonus = MeritCategory::NIN2 + 0x16,

    // DRG 2
    DeepBreathing = MeritCategory::DRG2 + 0x00,
    Angon         = MeritCategory::DRG2 + 0x02,
    Empathy       = MeritCategory::DRG2 + 0x04,
    StrafeEffect  = MeritCategory::DRG2 + 0x06,

    // SMN 2
    MeteorStrike   = MeritCategory::SMN2 + 0x00,
    HeavenlyStrike = MeritCategory::SMN2 + 0x02,
    WindBlade      = MeritCategory::SMN2 + 0x04,
    Geocrush       = MeritCategory::SMN2 + 0x06,
    Thunderstorm   = MeritCategory::SMN2 + 0x08,
    Grandfall      = MeritCategory::SMN2 + 0x0A,

    // BLU 2
    Convergence  = MeritCategory::BLU2 + 0x00,
    Diffusion    = MeritCategory::BLU2 + 0x02,
    Enchainment  = MeritCategory::BLU2 + 0x04,
    Assimilation = MeritCategory::BLU2 + 0x06,

    // COR 2
    SnakeEye      = MeritCategory::COR2 + 0x00,
    Fold          = MeritCategory::COR2 + 0x02,
    WinningStreak = MeritCategory::COR2 + 0x04,
    LoadedDeck    = MeritCategory::COR2 + 0x06,

    // PUP 2
    RoleReversal = MeritCategory::PUP2 + 0x00,
    Ventriloquy  = MeritCategory::PUP2 + 0x02,
    FineTuning   = MeritCategory::PUP2 + 0x04,
    Optimization = MeritCategory::PUP2 + 0x06,

    // DNC 2
    SaberDance     = MeritCategory::DNC2 + 0x00,
    FanDance       = MeritCategory::DNC2 + 0x02,
    NoFootRise     = MeritCategory::DNC2 + 0x04,
    ClosedPosition = MeritCategory::DNC2 + 0x06,

    // SCH 2
    Altruism      = MeritCategory::SCH2 + 0x00,
    Focalization  = MeritCategory::SCH2 + 0x02,
    Tranquility   = MeritCategory::SCH2 + 0x04,
    Equanimity    = MeritCategory::SCH2 + 0x06,
    Enlightenment = MeritCategory::SCH2 + 0x08,
    Stormsurge    = MeritCategory::SCH2 + 0x0A,

    // unknown 3
    // MERIT_UNKNOWN1    = MCATEGORY_UNK_0 + 0x00,
    // MERIT_UNKNOWN2    = MCATEGORY_UNK_1 + 0x00,
    // MERIT_UNKNOWN3    = MCATEGORY_UNK_2 + 0x00,
    // MERIT_UNKNOWN4    = MCATEGORY_UNK_3 + 0x00,
    // MERIT_UNKNOWN5    = MCATEGORY_UNK_4 + 0x00,

    // GEO 2
    MendingHalation     = MeritCategory::GEO2 + 0x00,
    RadialArcana        = MeritCategory::GEO2 + 0x02,
    CurativeRecantation = MeritCategory::GEO2 + 0x04,
    PrimevalZeal        = MeritCategory::GEO2 + 0x06,

    // RUN 2
    Battuta        = MeritCategory::RUN2 + 0x00,
    Rayke          = MeritCategory::RUN2 + 0x02,
    Inspiration    = MeritCategory::RUN2 + 0x04,
    SleightOfSword = MeritCategory::RUN2 + 0x06,
};
