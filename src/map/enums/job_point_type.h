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
#include "job_point_category.h"

/************************************************************************
 *                                                                       *
 * Bonuses for each job point                                            *
 * Matches client order in the menu. 0x2 and 0x1 are swapped.            *
 *                                                                       *
 ************************************************************************/
enum class JobPointType : uint16
{
    // WAR
    MightyStrikesEffect = JobPointCategory::WAR + 0x00, // p.acc +2
    BrazenRushEffect    = JobPointCategory::WAR + 0x02, // p.atk +4
    BerserkEffect       = JobPointCategory::WAR + 0x01, // p.atk +2
    DefenderEffect      = JobPointCategory::WAR + 0x03, // p.def +3
    WarcryEffect        = JobPointCategory::WAR + 0x04, // p.atk +3
    AggressorEffect     = JobPointCategory::WAR + 0x05, // p.acc +1
    RetaliationEffect   = JobPointCategory::WAR + 0x06, // retaliation chance +1
    RestraintEffect     = JobPointCategory::WAR + 0x07, // time to max ws bonus -2%
    BloodRageEffect     = JobPointCategory::WAR + 0x08, // crit. hit rate +1
    DoubleAttackEffect  = JobPointCategory::WAR + 0x09, // double attack p.atk +1

    // MNK
    HundredFistsEffect   = JobPointCategory::MNK + 0x00, // p.acc +2
    InnerStrengthEffect  = JobPointCategory::MNK + 0x02, // hp recovered +2%
    DodgeEffect          = JobPointCategory::MNK + 0x01, // evasion +2
    FocusEffect          = JobPointCategory::MNK + 0x03, // accuracy +1
    ChakraEffect         = JobPointCategory::MNK + 0x04, // hp recovered from use +10
    CounterstanceEffect  = JobPointCategory::MNK + 0x05, // DEX +2
    FootworkEffect       = JobPointCategory::MNK + 0x06, // kick attack dmg +1
    PerfectCounterEffect = JobPointCategory::MNK + 0x07, // VIT bonus +1
    ImpetusEffect        = JobPointCategory::MNK + 0x08, // maximum p.atk +2
    KickAttacksEffect    = JobPointCategory::MNK + 0x09, // kick attacks atk +2 acc +1

    // WHM
    BenedictionEffect    = JobPointCategory::WHM + 0x00, // mp recovered +1%
    AsylumEffect         = JobPointCategory::WHM + 0x02, // m.eva +4
    DivineSealEffect     = JobPointCategory::WHM + 0x01, // reduce emnity from use +3
    WhmMagicAccBonus     = JobPointCategory::WHM + 0x03, // m.acc +1
    AfflatusSolaceEffect = JobPointCategory::WHM + 0x04, // cure potency +2 (not %)
    AfflatusMiseryEffect = JobPointCategory::WHM + 0x05, // banish +2 m.dmg, miss => acc +1 dmg +1
    DivineCaressDuration = JobPointCategory::WHM + 0x06, // dur. +2 sec
    SacrosanctityEffect  = JobPointCategory::WHM + 0x07, // minimum DEF +1
    RegenDuration        = JobPointCategory::WHM + 0x08, // dur. +3 sec
    BarSpellEffect       = JobPointCategory::WHM + 0x09, // resistance +2

    // BLM
    ManafontEffect        = JobPointCategory::BLM + 0x00, // elemental m.dmg +2
    SubtleSorceryEffect   = JobPointCategory::BLM + 0x02, // spellcasting time -1%
    ElementalSealEffect   = JobPointCategory::BLM + 0x01, // elemental magic emnity -3
    MagicBurstDmgBonus    = JobPointCategory::BLM + 0x03, // magic burst dmg +1%
    ManaWallEffect        = JobPointCategory::BLM + 0x04, // mp consumed -1%
    BlmMagicAccBonus      = JobPointCategory::BLM + 0x05, // m.acc +1
    EmnityDouseRecast     = JobPointCategory::BLM + 0x06, // recast -3sec
    ManawellEffect        = JobPointCategory::BLM + 0x07, // m.dmg +1
    MagicBurstEmnityBonus = JobPointCategory::BLM + 0x08, // emnity -1
    MagicDmgBonus         = JobPointCategory::BLM + 0x09, // m.dmg +1

    // RDM
    ChainspellEffect  = JobPointCategory::RDM + 0x00, // elem. m.dmg +2
    StymieEffect      = JobPointCategory::RDM + 0x02, // effect dur. +1s
    ConvertEffect     = JobPointCategory::RDM + 0x01, // HP consumed -1%
    RdmMagicAccBonus  = JobPointCategory::RDM + 0x03, // m.acc +1
    ComposureEffect   = JobPointCategory::RDM + 0x04, // p.acc +1
    RdmMagicAtkBonus  = JobPointCategory::RDM + 0x05, // MAB +1
    SaboteurEffect    = JobPointCategory::RDM + 0x06, // enfeeble m.acc +2
    EnfeebleDuration  = JobPointCategory::RDM + 0x07, // enfeeble dur. +1s
    QuickMagicEffect  = JobPointCategory::RDM + 0x08, // MP consumption -2%
    EnhancingDuration = JobPointCategory::RDM + 0x09, // dur. +1s

    // THF
    PerfectDodgeEffect = JobPointCategory::THF + 0x00, // m.eva +3
    LarcenyEffect      = JobPointCategory::THF + 0x02, // dur. +1s
    SneakAttackEffect  = JobPointCategory::THF + 0x01, // DEX bonus +1%
    TrickAttackEffect  = JobPointCategory::THF + 0x03, // AGI bonus +1%
    StealRecast        = JobPointCategory::THF + 0x04, // recast -2s
    MugEffect          = JobPointCategory::THF + 0x05, // drain HP == 5% (DEX + AGI)
    DespoilEffect      = JobPointCategory::THF + 0x06, // drain 2% tp
    ConspiratorEffect  = JobPointCategory::THF + 0x07, // p.acc +1
    BullyEffect        = JobPointCategory::THF + 0x08, // intimidation chance +1%
    TripleAttackEffect = JobPointCategory::THF + 0x09, // p.atk +1

    // PLD
    InvincibleEffect   = JobPointCategory::PLD + 0x00, // emnity +100
    InterveneEffect    = JobPointCategory::PLD + 0x02, // dmg +2%
    HolyCircleEffect   = JobPointCategory::PLD + 0x01, // dmg taken -1
    SentinelEffect     = JobPointCategory::PLD + 0x03, // emnity +1
    ShieldBashEffect   = JobPointCategory::PLD + 0x04, // dmg +10
    CoverDuration      = JobPointCategory::PLD + 0x05, // dur. +1s
    DivineEmblemEffect = JobPointCategory::PLD + 0x06, // m.dmg +2
    SepulcherDuration  = JobPointCategory::PLD + 0x07, // dur. +1s
    PalisadeEffect     = JobPointCategory::PLD + 0x08, // block chance +1%
    EnlightEffect      = JobPointCategory::PLD + 0x09, // ae.dmg +1 p.acc +1

    // DRK
    BloodWeaponEffect       = JobPointCategory::DRK + 0x00, // hp absorb +2%
    SoulEnslavementEffect   = JobPointCategory::DRK + 0x02, // tp absorb +1%
    ArcaneCircleEffect      = JobPointCategory::DRK + 0x01, // dmg taken -1
    LastResortEffect        = JobPointCategory::DRK + 0x03, // p.atk +2
    SouleaterDuration       = JobPointCategory::DRK + 0x04, // dur. +1s
    WeaponBashEffect        = JobPointCategory::DRK + 0x05, // dmg +10
    NetherVoidEffect        = JobPointCategory::DRK + 0x06, // absorb +2% abs-attri status +1/10
    ArcaneCrestDuration     = JobPointCategory::DRK + 0x07, // dur. +1s
    ScarletDeliriumDuration = JobPointCategory::DRK + 0x08, // dur. +1s
    EndarkEffect            = JobPointCategory::DRK + 0x09, // p.dmg p.atk p.acc +1

    // BST
    FamiliarEffect   = JobPointCategory::BST + 0x00, // all pet attr. +3
    UnleashEffect    = JobPointCategory::BST + 0x02, // sp.atk dmg +2%
    PetAccBonus      = JobPointCategory::BST + 0x01, // pet p.acc +1
    CharmSuccessRate = JobPointCategory::BST + 0x03, // success rate +1%
    RewardEffect     = JobPointCategory::BST + 0x04, // pet hp recov. +1%
    PetAtkSpdBonus   = JobPointCategory::BST + 0x05, // pet atk spd +1%
    ReadyEffect      = JobPointCategory::BST + 0x06, // pet sp.ability dmg +1%
    SpurEffect       = JobPointCategory::BST + 0x07, // pet p.atk +3
    RunWildDuration  = JobPointCategory::BST + 0x08, // dur. +2s
    PetEmnityBonus   = JobPointCategory::BST + 0x09, // emnity +1

    // BRD
    SoulVoiceEffect   = JobPointCategory::BRD + 0x00, // casting time -2%
    ClarionCallEffect = JobPointCategory::BRD + 0x02, // effect dur. +2s
    MinneEffect       = JobPointCategory::BRD + 0x01, // p.def +1
    MinuetEffect      = JobPointCategory::BRD + 0x03, // p.atk +1
    PianissimoEffect  = JobPointCategory::BRD + 0x04, // casting time -2%
    SongAccBonus      = JobPointCategory::BRD + 0x05, // song acc +1
    TenutoEffect      = JobPointCategory::BRD + 0x06, // song dur. +1s
    LullabyDuration   = JobPointCategory::BRD + 0x07, // lullaby dur. +1
    MarcatoEffect     = JobPointCategory::BRD + 0x08, // song dur. +1s
    RequiemEffect     = JobPointCategory::BRD + 0x09, // dot dmg +3

    // RNG
    EagleEyeShotEffect  = JobPointCategory::RNG + 0x00, // dmg +3%
    OverkillEffect      = JobPointCategory::RNG + 0x02, // emnity -1
    SharpshotEffect     = JobPointCategory::RNG + 0x01, // r.atk +2
    CamouflageEffect    = JobPointCategory::RNG + 0x03, // crit. hit rate +1%
    BarrageEffect       = JobPointCategory::RNG + 0x04, // r.atk +3
    ShadowbindDuration  = JobPointCategory::RNG + 0x05, // dur. +1s
    VelocityShotEffect  = JobPointCategory::RNG + 0x06, // r.atk +2
    DoubleShotEffect    = JobPointCategory::RNG + 0x07, // chance +1%
    DecoyShotEffect     = JobPointCategory::RNG + 0x08, // max emnity vol. +15, cum. +5
    UnlimitedShotEffect = JobPointCategory::RNG + 0x09, // emnity -2

    // SAM
    MeikyoShisuiEffect  = JobPointCategory::SAM + 0x00, // sc dmg +2%
    YaegasumiEffect     = JobPointCategory::SAM + 0x02, // tp bonus +30
    WardingCircleEffect = JobPointCategory::SAM + 0x01, // dmg taken -1
    HassoEffect         = JobPointCategory::SAM + 0x03, // STR +1
    MeditateEffect      = JobPointCategory::SAM + 0x04, // tp +5 per tick
    SeiganEffect        = JobPointCategory::SAM + 0x05, // p.def +3
    KonzenIttaiEffect   = JobPointCategory::SAM + 0x06, // sc dmg +1%
    HamanohaDuration    = JobPointCategory::SAM + 0x07, // dur. +1s
    HagakureEffect      = JobPointCategory::SAM + 0x08, // tp bonus +10
    ZanshinEffect       = JobPointCategory::SAM + 0x09, // zanshin follow-ups p.atk +2

    // NIN
    MijinGaukureEffect    = JobPointCategory::NIN + 0x00, // dmg +3%
    MikageEffect          = JobPointCategory::NIN + 0x02, // p.atk +3
    YoninEffect           = JobPointCategory::NIN + 0x01, // p.eva +2
    InninEffect           = JobPointCategory::NIN + 0x03, // p.acc +1
    NinjitsuAccBonus      = JobPointCategory::NIN + 0x04, // ninjitsu acc +1
    NinjitsuCastTimeBonus = JobPointCategory::NIN + 0x05, // casting time -1%
    FutaeEffect           = JobPointCategory::NIN + 0x06, // m.dmg +5
    ElemNinjitsuEffect    = JobPointCategory::NIN + 0x07, // m.dmg +2
    IssekiganEffect       = JobPointCategory::NIN + 0x08, // vol. emnity +10
    TacticalParryEffect   = JobPointCategory::NIN + 0x09, // counter when parry +1%

    // DRG
    SpiritSurgeEffect     = JobPointCategory::DRG + 0x00, // Weapon DMG +1
    FlyHighEffect         = JobPointCategory::DRG + 0x02, // all jump p.atk +5
    AncientCircleEffect   = JobPointCategory::DRG + 0x01, // dmg taken -1
    JumpEffect            = JobPointCategory::DRG + 0x03, // jump/spirit jump p.atk +3
    SpiritLinkEffect      = JobPointCategory::DRG + 0x04, // hp consumption -1%
    WyvernMaxHpBonus      = JobPointCategory::DRG + 0x05, // wyvern max hp +10
    DragonBreakerDuration = JobPointCategory::DRG + 0x06, // dur. +1s
    WyvernBreathEffect    = JobPointCategory::DRG + 0x07, // breath effect +10
    HighJumpEffect        = JobPointCategory::DRG + 0x08, // high jump/soul jump atk +3
    WyvernAttrBonus       = JobPointCategory::DRG + 0x09, // wyvern p.atk/p.def +2

    // SMN
    AstralFlowEffect      = JobPointCategory::SMN + 0x00, // all pet attr. +5
    AstralConduitEffect   = JobPointCategory::SMN + 0x02, // BPR: dmg +1% BPW: duration +1%
    SummonAccBonus        = JobPointCategory::SMN + 0x01, // pet p.acc +1
    SummonMagicAccBonus   = JobPointCategory::SMN + 0x03, // pet m.acc +1
    ElementalSiphonEffect = JobPointCategory::SMN + 0x04, // mp recov. +3
    SummonPhysAtkBonus    = JobPointCategory::SMN + 0x05, // pet p.atk +2
    ManaCedeEffect        = JobPointCategory::SMN + 0x06, // pet tp +50
    AvatarsFavorEffect    = JobPointCategory::SMN + 0x07, // favor +3s dur. bonus
    SummonMagicDmgBonus   = JobPointCategory::SMN + 0x08, // pet m.dmg +5
    BloodPactDmgBonus     = JobPointCategory::SMN + 0x09, // BPR/BPW dmg +5

    // BLU
    AzureLoreEffect       = JobPointCategory::BLU + 0x00, // dmg +1
    UnbridledWisdomEffect = JobPointCategory::BLU + 0x02, // conserve mp +3
    BlueMagicPointBonus   = JobPointCategory::BLU + 0x01, // blue magic points +1
    BurstAffinityBonus    = JobPointCategory::BLU + 0x03, // dmg +2
    ChainAffinityEffect   = JobPointCategory::BLU + 0x04, // sc dmg +1%
    BluePhysAeAccBonus    = JobPointCategory::BLU + 0x05, // phys. add. effect acc +1
    UnbridledLrnEffect    = JobPointCategory::BLU + 0x06, // dmg +1%
    UnbridledLrnEffectII  = JobPointCategory::BLU + 0x07, // party enhancing dur. +1%
    EffluxEffect          = JobPointCategory::BLU + 0x08, // tp bonus +10
    BluMagicAccBonus      = JobPointCategory::BLU + 0x09, // m.acc +1

    // COR
    WildCardEffect      = JobPointCategory::COR + 0x00, // probability of reset +1%
    CuttingCardsEffect  = JobPointCategory::COR + 0x02, // recast of party abil. -1%
    PhantomRollDuration = JobPointCategory::COR + 0x01, // dur. +2s
    BustEvasion         = JobPointCategory::COR + 0x03, // bust chance -1%
    QuickDrawEffect     = JobPointCategory::COR + 0x04, // m.dmg +2
    AmmoConsumption     = JobPointCategory::COR + 0x05, // no ammo chance +1%
    RandomDealEffect    = JobPointCategory::COR + 0x06, // 2 abil random deal +2%
    CorRangedAccBonus   = JobPointCategory::COR + 0x07, // r.acc +1
    TripleShotEffect    = JobPointCategory::COR + 0x08, // triple shot chance +1%
    OptimalRangeBonus   = JobPointCategory::COR + 0x09, // sweet spot dmg +1

    // PUP
    OverdriveEffect      = JobPointCategory::PUP + 0x00, // all pet attr. +5
    HeadyArtificeEffect  = JobPointCategory::PUP + 0x02, // increase head effects (see wiki)
    AutomatonHpMpBonus   = JobPointCategory::PUP + 0x01, // pet hp+10, mp+5
    ActivateEffect       = JobPointCategory::PUP + 0x03, // burden -1
    RepairEffect         = JobPointCategory::PUP + 0x04, // mp hot based on oil (see wiki)
    DeusExAutomataRecast = JobPointCategory::PUP + 0x05, // recast -1s
    TacticalSwitchBonus  = JobPointCategory::PUP + 0x06, // tp +20
    CooldownEffect       = JobPointCategory::PUP + 0x07, // burden -1
    DeactivateEffect     = JobPointCategory::PUP + 0x08, // hp require. -1%
    PupMartialArtsEffect = JobPointCategory::PUP + 0x09, // delay -2

    // DNC
    TranceEffect      = JobPointCategory::DNC + 0x00, // tp +100
    GrandPasEffect    = JobPointCategory::DNC + 0x02, // dmg +1
    StepDuration      = JobPointCategory::DNC + 0x01, // dur. +1s
    SambaDuration     = JobPointCategory::DNC + 0x03, // dur. +2s
    WaltzPotencyBonus = JobPointCategory::DNC + 0x04, // waltz potency +2 (not %)
    JigDuration       = JobPointCategory::DNC + 0x05, // dur. +1s
    FlourishIEffect   = JobPointCategory::DNC + 0x06, // effect bonuses (see wiki)
    FlourishIIEffect  = JobPointCategory::DNC + 0x07, // effect bonuses (see wiki)
    FlourishIIIEffect = JobPointCategory::DNC + 0x08, // CHR bonus +1%
    ContradanceEffect = JobPointCategory::DNC + 0x09, // waltz tp -3%

    // SCH
    TabulaRasaEffect       = JobPointCategory::SCH + 0x00, // mp recov. +2%
    CaperEmmissariusEffect = JobPointCategory::SCH + 0x02, // hp recov. +2%
    LightArtsEffect        = JobPointCategory::SCH + 0x01, // dur. +3s
    DarkArtsEffect         = JobPointCategory::SCH + 0x03, // dur. +3s
    StrategemEffectI       = JobPointCategory::SCH + 0x04, // m.acc +1
    StrategemEffectII      = JobPointCategory::SCH + 0x05, // cast time -1%
    StrategemEffectIII     = JobPointCategory::SCH + 0x06, // m.dmg +2
    StrategemEffectIV      = JobPointCategory::SCH + 0x07, // recast -2%
    ModusVeritasEffect     = JobPointCategory::SCH + 0x08, // dot +3
    SublimationEffect      = JobPointCategory::SCH + 0x09, // sublimation mp +3%

    // GEO
    BolsterEffect         = JobPointCategory::GEO + 0x00, // luopan hp +3% perp. -1mp
    WidenedCompassEffect  = JobPointCategory::GEO + 0x02, // cast time -3%
    LifeCycleEffect       = JobPointCategory::GEO + 0x01, // luopan hp recov. +1%
    BlazeOfGloryEffect    = JobPointCategory::GEO + 0x03, // luopan init. hp +1%
    GeoMagicAtkBonus      = JobPointCategory::GEO + 0x04, // m.att bonus +1
    GeoMagicAccBonus      = JobPointCategory::GEO + 0x05, // m.acc +1
    DematerializeDuration = JobPointCategory::GEO + 0x06, // dur. +1s
    TheurgicFocusEffect   = JobPointCategory::GEO + 0x07, // m.dmg +3
    ConcentricPulseEffect = JobPointCategory::GEO + 0x08, // dmg +1%
    IndiSpellDuration     = JobPointCategory::GEO + 0x09, // indi dur. +2s

    // RUN
    ElementalSforzoEffect = JobPointCategory::RUN + 0x00, // dmg absorb +2%
    OdyllicSubterEffect   = JobPointCategory::RUN + 0x02, // enemy m.att bonus -2
    RuneEnchantmentEffect = JobPointCategory::RUN + 0x01, // rune resist +1
    VallationDuration     = JobPointCategory::RUN + 0x03, // dur. +1s
    SwordplayEffect       = JobPointCategory::RUN + 0x04, // max p.acc/p.eva +2
    SwipeEffect           = JobPointCategory::RUN + 0x05, // swipe/lunge dmg (skill) +1%
    EmboldenEffect        = JobPointCategory::RUN + 0x06, // enhanc. mag effect +1
    VivaciousPulseEffect  = JobPointCategory::RUN + 0x07, // viv. pulse => hp +1%
    OneForAllDuration     = JobPointCategory::RUN + 0x08, // dur. +1s
    GambitDuration        = JobPointCategory::RUN + 0x09, // dur +1s
};
