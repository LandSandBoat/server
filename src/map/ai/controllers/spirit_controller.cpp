#include "spirit_controller.h"

#include "../../../common/utils.h"
#include "../../entities/petentity.h"
#include "../../mob_modifier.h"
#include "../../modifier.h"

#include "../../status_effect_container.h"
#include "../../utils/battleutils.h"
#include "../../utils/petutils.h"
#include "../../utils/zoneutils.h"
#include "../ai_container.h"

CSpiritController::CSpiritController(CPetEntity* PSpirit)
: CPetController(PSpirit)
, PSpirit(PSpirit)
{
    lastChoice = 1;
}

void CSpiritController::Tick(time_point tick)
{
    TracyZoneScoped;

    if ((PSpirit->PMaster == nullptr || PSpirit->PMaster->isDead()) && PSpirit->isAlive())
    {
        PSpirit->Die();
        return;
    }

    if (PSpirit->shouldDespawn(tick))
    {
        petutils::DespawnPet(PSpirit->PMaster);
        return;
    }

    if (!PSpirit->m_setup)
    {
        setMagicCooldowns();

        if (PSpirit->m_PetID == PETID::PETID_LIGHTSPIRIT)
        {
            LoadLightSpiritSpellList();

            // Disable heal/buff on fallback logic.
            PSpirit->setMobMod(MOBMODIFIER::MOBMOD_BUFF_CHANCE, 0);
            PSpirit->setMobMod(MOBMODIFIER::MOBMOD_HEAL_CHANCE, 0);
        }

        PSpirit->m_LastMagicTime = tick;
        PSpirit->m_setup         = true;
    }

    if (PSpirit->PAI->IsEngaged())
    {
        PTarget = static_cast<CBattleEntity*>(PSpirit->GetEntity(PSpirit->GetBattleTargetID()));
        if (CPetController::TryDeaggro())
        {
            Disengage();
            return;
        }

        PSpirit->PAI->EventHandler.triggerListener("COMBAT_TICK", CLuaBaseEntity(PSpirit));
        luautils::OnMobFight(PSpirit, PTarget);
        if (TrySpellcast(tick))
        {
            PSpirit->m_LastMagicTime = tick;
            return;
        }

        CPetController::Move();
    }
    else
    {
        // if pet can't follow then don't
        if (!PSpirit->PAI->CanFollowPath())
        {
            return;
        }
        if (TryIdleSpellcast(tick))
        {
            PSpirit->m_LastMagicTime = tick;
            return;
        }
        else
        {
            CPetController::DoRoamTick(tick);
        }
    }

    CMobController::Tick(tick);
}

void CSpiritController::setMagicCooldowns()
{
    uint32 castTime = ((45000 + (GetSMNSkillReduction() / 3 * 1000)) + GetDayWeatherBonus());

    // Reduce cast delay when under effect of Astral Flow
    if (PSpirit->PMaster && PSpirit->PMaster->StatusEffectContainer->HasStatusEffect(EFFECT_ASTRAL_FLOW))
    {
        castTime -= 5000;
    }

    if (auto PMaster = dynamic_cast<CCharEntity*>(PSpirit->PMaster))
    {
        auto legSlotItem = PMaster->getEquip(SLOT_LEGS);

        // Summoner's Spats & Summoner's Spats +1
        if (legSlotItem && legSlotItem->getModifier(Mod::SPIRIT_SPELLCAST_DELAY))
        {
            castTime -= (legSlotItem->getModifier(Mod::SPIRIT_SPELLCAST_DELAY) * 1000);
        }
    }

    // Light Spirit idle spellcasting time is halved if the Light Spirit is not engaged.
    // Applies only to buffs, so we'll need to do another check elsewhere.
    if (PSpirit->m_PetID == PETID_LIGHTSPIRIT && !PSpirit->PAI->IsEngaged() && lastChoice == 2)
    {
        castTime /= 2;
    }

    PSpirit->m_magicCooldown = std::chrono::milliseconds(castTime);
}

bool CSpiritController::TrySpellcast(time_point tick)
{
    if (!PSpirit->PMaster || PSpirit->PMaster->objtype != TYPE_PC ||
        m_Tick <= PSpirit->m_LastMagicTime + PSpirit->m_magicCooldown ||
        PSpirit->StatusEffectContainer->HasPreventActionEffect() ||
        PSpirit->StatusEffectContainer->HasStatusEffect(EFFECT_SILENCE))
    {
        return false;
    }

    if ((PSpirit->m_PetID < PETID_LIGHTSPIRIT || PSpirit->m_PetID == PETID_DARKSPIRIT) && TryCastSpell())
    {
        return true;
    }
    else if (PSpirit->m_PetID == PETID_LIGHTSPIRIT)
    {
        uint8          numUnderThreshold = 0;
        uint16         chosenSpell       = 0;
        bool           castOnNearest     = false;
        PMemberTargets qualifiedTargets{ nullptr, nullptr };
        qualifiedTargets = GetBestQualifiedMembers();

        if (qualifiedTargets.PLowest != nullptr)
        {
            lastChoice = 1;
        }
        else
        {
            uint8 chance = xirand::GetRandomNumber(100);

            if (chance <= 25)
            {
                lastChoice = 2;
            }
            else
            {
                lastChoice = 3;
            }
        }

        switch (lastChoice)
        {
            case 1:
                if (PSpirit->m_healSingleSpells.size() > 0 || PSpirit->m_healAOESpells.size() > 0)
                {
                    numUnderThreshold = GetLowestHPThresholdCountForParty(*qualifiedTargets.PLowest);

                    // The light spirit still has a chance to use curaga, even when only one user is affected.
                    bool useCuraga = xirand::GetRandomNumber(10) <= 3;

                    // If more than one party member is at low health or we rolled a Curaga.
                    if (numUnderThreshold > 1 || useCuraga)
                        chosenSpell = DetermineHighestSpellFromMP(PSpirit->m_healAOESpells);

                    // If there's only one person or the light spirit rolled a Curaga,
                    // but doesn't even have MP for Curaga I.
                    if (!useCuraga || (useCuraga && PSpirit->health.mp < spell::GetSpell(SpellID::Curaga)->getMPCost()))
                        chosenSpell = DetermineHighestSpellFromMP(PSpirit->m_healSingleSpells);

                    // If the light spirit can't cast anything, then we return.
                    if (chosenSpell == 0)
                        return false;

                    // Otherwise, we cast the chosen spell on the lowest HP Party/Alliance member.
                    CastIdleSpell(static_cast<SpellID>(chosenSpell), qualifiedTargets.PLowest->targid);
                    setMagicCooldowns();
                    return true;
                }
                break;
            case 2:
                if (PSpirit->m_buffSpells.size() > 0)
                {
                    // Raycast check to prioritize people in raycast over master.
                    if (qualifiedTargets.PNearest != nullptr)
                    {
                        chosenSpell   = DetermineNextBuff(*qualifiedTargets.PNearest);
                        castOnNearest = true;
                    }
                    // Prioritize the master next.
                    if (chosenSpell == 0)
                    {
                        chosenSpell = DetermineNextBuff(*PSpirit->PMaster);
                        if (chosenSpell != 0)
                            qualifiedTargets.PLowest = PSpirit->PMaster;
                    }
                    // Prioritize anyone else in the party or alliance.
                    if (chosenSpell == 0)
                    {
                        PSpirit->PMaster->ForAlliance([&](CBattleEntity* PMember)
                                                      {
                            if (PMember != nullptr && PSpirit->PMaster->loc.zone->GetID() == PMember->loc.zone->GetID() && distance(PSpirit->loc.p, PMember->loc.p) <= 20 &&
                                !PMember->isDead() && !PMember->StatusEffectContainer->HasStatusEffect(EFFECT_INVISIBLE))
                                {
                                    if(chosenSpell == 0 && qualifiedTargets.PLowest == nullptr)
                                    {
                                        chosenSpell = DetermineNextBuff(*PMember);
                                        if(chosenSpell > 0)
                                            qualifiedTargets.PLowest = PMember;
                                    }
                                } });
                    }

                    bool spellIsCast;
                    // At this point, if chosenSpell is 0, everyone in the alliance is buffed.
                    if (chosenSpell != 0)
                    {
                        if (castOnNearest && qualifiedTargets.PNearest != nullptr)
                        {
                            spellIsCast = CastIdleSpell(static_cast<SpellID>(chosenSpell), qualifiedTargets.PNearest->targid);
                        }
                        else if (qualifiedTargets.PLowest != nullptr)
                        {
                            spellIsCast = CastIdleSpell(static_cast<SpellID>(chosenSpell), qualifiedTargets.PLowest->targid);
                        }
                        else
                        {
                            spellIsCast = TryCastSpell();
                        }
                    }
                    else
                    {
                        spellIsCast = TryCastSpell();
                    }
                    setMagicCooldowns();
                    return spellIsCast;
                }
                break;

            case 3:
                if (PSpirit->m_offensiveSpells.size() > 0)
                {
                    bool spellIsCast = TryCastSpell();
                    // Update the timer based on all factors.
                    setMagicCooldowns();
                    return spellIsCast;
                }
                break;
        }
    }

    return false;
}

bool CSpiritController::TryIdleSpellcast(time_point tick)
{
    if (!PSpirit->PMaster || PSpirit->PMaster->objtype != TYPE_PC ||
        tick <= PSpirit->m_LastMagicTime + PSpirit->m_magicCooldown ||
        PSpirit->StatusEffectContainer->HasPreventActionEffect() ||
        PSpirit->StatusEffectContainer->HasStatusEffect(EFFECT_SILENCE))
    {
        return false;
    }

    if (PSpirit->m_PetID == PETID_LIGHTSPIRIT)
    {
        uint8          numUnderThreshold = 0;
        uint16         chosenSpell       = 0;
        PMemberTargets qualifiedTargets{ nullptr, nullptr };
        bool           castOnNearest = false;
        // clang-format off
            // Light Spirit cures/curagas can target other alliance members.
            qualifiedTargets = GetBestQualifiedMembers();
            if(qualifiedTargets.PLowest != nullptr)
            {
                lastChoice = 1;
            }
            else
            {
                lastChoice = 2;
            }
        // clang-format on

        switch (lastChoice)
        {
            case 1:
                if (PSpirit->m_healSingleSpells.size() > 0 || PSpirit->m_healAOESpells.size() > 0)
                {
                    numUnderThreshold = GetLowestHPThresholdCountForParty(*qualifiedTargets.PLowest);

                    // The light spirit still has a chance to use curaga, even when only one user is affected.
                    bool useCuraga = xirand::GetRandomNumber(10) <= 3;

                    // If more than one party member is at low health or we rolled a Curaga.
                    if (numUnderThreshold > 1 || useCuraga)
                        chosenSpell = DetermineHighestSpellFromMP(PSpirit->m_healAOESpells);

                    // If there's only one person or the light spirit rolled a Curaga,
                    // but doesn't even have MP for Curaga I.
                    if (!useCuraga || (useCuraga && PSpirit->health.mp < spell::GetSpell(SpellID::Curaga)->getMPCost()))
                        chosenSpell = DetermineHighestSpellFromMP(PSpirit->m_healSingleSpells);

                    // If the light spirit can't cast anything, then we return.
                    if (chosenSpell == 0)
                        return false;
                }
                break;
            case 2:
                if (PSpirit->m_buffSpells.size() > 0)
                {
                    // Raycast check to prioritize people in raycast over master.
                    if (qualifiedTargets.PNearest != nullptr)
                    {
                        chosenSpell   = DetermineNextBuff(*qualifiedTargets.PNearest);
                        castOnNearest = true;
                    }
                    // Prioritize the master first.
                    if (chosenSpell == 0)
                    {
                        chosenSpell              = DetermineNextBuff(*PSpirit->PMaster);
                        qualifiedTargets.PLowest = PSpirit->PMaster;
                    }
                    if (chosenSpell == 0)
                    {
                        PSpirit->PMaster->ForAlliance([&](CBattleEntity* PMember)
                                                      {
                                if (PMember != nullptr && PMember->objtype == TYPE_PC && PSpirit->PMaster->loc.zone->GetID() == PMember->loc.zone->GetID() && distance(PSpirit->loc.p, PMember->loc.p) <= 20 &&
                                    !PMember->isDead() && !PMember->StatusEffectContainer->HasStatusEffect(EFFECT_INVISIBLE))
                                    {
                                        if(chosenSpell == 0 && qualifiedTargets.PLowest == nullptr)
                                        {
                                            chosenSpell = DetermineNextBuff(*PMember);
                                            if(chosenSpell > 0)
                                                qualifiedTargets.PLowest = PMember;
                                        }
                                    } });
                    }
                }
                break;
        }
        if (chosenSpell == 0)
            return false;
        if (!(chosenSpell == 0 || qualifiedTargets.PLowest == nullptr) || !(chosenSpell == 0 || qualifiedTargets.PNearest == nullptr))
        {
            bool spellIsCast = false;
            if (castOnNearest)
                spellIsCast = CastIdleSpell(static_cast<SpellID>(chosenSpell), qualifiedTargets.PNearest->targid);
            else
                spellIsCast = CastIdleSpell(static_cast<SpellID>(chosenSpell), qualifiedTargets.PLowest->targid);
            // Update the timer based on all factors.
            setMagicCooldowns();
            return spellIsCast;
        }
    }
    // Update the timer based on all factors.
    setMagicCooldowns();
    return false;
}

void CSpiritController::LoadLightSpiritSpellList()
{
    uint8 mLvl = PSpirit->GetMLevel();
    if (mLvl >= 71)
    {
        PSpirit->m_healAOESpells.push_back(static_cast<uint16>(SpellID::Curaga_IV));
    }
    if (mLvl >= 68)
    {
        PSpirit->m_buffSpells.push_back(static_cast<uint16>(SpellID::Shell_IV));
    }
    if (mLvl >= 65)
    {
        PSpirit->m_offensiveSpells.push_back(static_cast<uint16>(SpellID::Banish_III));
    }
    if (mLvl >= 63)
    {
        PSpirit->m_buffSpells.push_back(static_cast<uint16>(SpellID::Protect_IV));
    }
    if (mLvl >= 61)
    {
        PSpirit->m_healSingleSpells.push_back(static_cast<uint16>(SpellID::Cure_V));
    }
    if (mLvl >= 57 && mLvl < 68)
    {
        PSpirit->m_buffSpells.push_back(static_cast<uint16>(SpellID::Shell_III));
    }
    if (mLvl >= 51)
    {
        PSpirit->m_healAOESpells.push_back(static_cast<uint16>(SpellID::Curaga_III));
    }
    if (mLvl >= 50)
    {
        PSpirit->m_offensiveSpells.push_back(static_cast<uint16>(SpellID::Holy));
    }
    if (mLvl >= 47 && mLvl < 63)
    {
        PSpirit->m_buffSpells.push_back(static_cast<uint16>(SpellID::Protect_III));
    }
    if (mLvl >= 41)
    {
        PSpirit->m_healSingleSpells.push_back(static_cast<uint16>(SpellID::Cure_IV));
    }
    if (mLvl >= 40)
    {
        PSpirit->m_buffSpells.push_back(static_cast<uint16>(SpellID::Haste));
    }
    if (mLvl >= 37)
    {
        PSpirit->m_offensiveSpells.push_back(static_cast<uint16>(SpellID::Flash));
    }
    if (mLvl >= 37 && mLvl < 57)
    {
        PSpirit->m_buffSpells.push_back(static_cast<uint16>(SpellID::Shell_II));
    }
    if (mLvl >= 31)
    {
        PSpirit->m_offensiveSpells.push_back(static_cast<uint16>(SpellID::Dia_II));
    }
    if (mLvl >= 31)
    {
        PSpirit->m_healAOESpells.push_back(static_cast<uint16>(SpellID::Curaga_II));
    }
    if (mLvl >= 30)
    {
        PSpirit->m_offensiveSpells.push_back(static_cast<uint16>(SpellID::Banish_II));
    }
    if (mLvl >= 27 && mLvl < 57)
    {
        PSpirit->m_buffSpells.push_back(static_cast<uint16>(SpellID::Protect_II));
    }
    if (mLvl >= 21)
    {
        PSpirit->m_buffSpells.push_back(static_cast<uint16>(SpellID::Regen));
    }
    if (mLvl >= 21)
    {
        PSpirit->m_healSingleSpells.push_back(static_cast<uint16>(SpellID::Cure_III));
    }
    if (mLvl >= 17 && mLvl < 37)
    {
        PSpirit->m_buffSpells.push_back(static_cast<uint16>(SpellID::Shell));
    }
    if (mLvl >= 16)
    {
        PSpirit->m_healAOESpells.push_back(static_cast<uint16>(SpellID::Curaga));
    }
    if (mLvl >= 11)
    {
        PSpirit->m_healSingleSpells.push_back(static_cast<uint16>(SpellID::Cure_II));
    }
    if (mLvl >= 7 && mLvl < 27)
    {
        PSpirit->m_buffSpells.push_back(static_cast<uint16>(SpellID::Protect));
    }
    if (mLvl >= 5 && mLvl < 65)
    {
        PSpirit->m_offensiveSpells.push_back(static_cast<uint16>(SpellID::Banish));
    }
    if (mLvl >= 1)
    {
        PSpirit->m_healSingleSpells.push_back(static_cast<uint16>(SpellID::Cure));
    }
}

int16 CSpiritController::GetSMNSkillReduction()
{
    if (PSpirit->PMaster && PSpirit->PMaster->objtype == TYPE_PC)
    {
        uint8 masterLvl = PSpirit->PMaster->GetMLevel();

        if (PSpirit->PMaster->GetMJob() != JOB_SMN)
        {
            masterLvl = PSpirit->PMaster->GetSLevel();
        }

        uint16 skill    = PSpirit->PMaster->GetSkill(SKILL_SUMMONING_MAGIC);
        uint16 maxSkill = battleutils::GetMaxSkill(SKILL_SUMMONING_MAGIC, JOB_SMN, masterLvl);

        return (maxSkill - skill);
    }

    return 0;
}

int16 CSpiritController::GetDayWeatherBonus()
{
    if (PSpirit->PMaster == nullptr || PSpirit->PMaster->objtype != TYPE_PC)
    {
        return 0;
    }
    WEATHER zoneWeather = zoneutils::GetZone(PSpirit->PMaster->getZone())->GetWeather();
    uint32  vanaDay     = CVanaTime::getInstance()->getWeekday();
    int16   bonus       = 0;

    switch (PSpirit->m_PetID)
    {
        case PETID_EARTHSPIRIT:
            if (zoneWeather == WEATHER_DUST_STORM || zoneWeather == WEATHER_SAND_STORM)
            {
                bonus -= 2000;
            }
            if (zoneWeather == WEATHER_WIND || zoneWeather == WEATHER_GALES)
            {
                bonus += 2000;
            }
            if (vanaDay == DAYTYPE::EARTHSDAY)
            {
                bonus -= 3000;
            }
            if (vanaDay == DAYTYPE::WINDSDAY)
            {
                bonus += 3000;
            }
            break;
        case PETID_WATERSPIRIT:
            if (zoneWeather == WEATHER_RAIN || zoneWeather == WEATHER_SQUALL)
            {
                bonus -= 2000;
            }
            if (zoneWeather == WEATHER_THUNDER || zoneWeather == WEATHER_THUNDERSTORMS)
            {
                bonus += 2000;
            }
            if (vanaDay == DAYTYPE::WATERSDAY)
            {
                bonus -= 3000;
            }
            if (vanaDay == DAYTYPE::LIGHTNINGDAY)
            {
                bonus += 3000;
            }
            break;
        case PETID_AIRSPIRIT:
            if (zoneWeather == WEATHER_WIND || zoneWeather == WEATHER_GALES)
            {
                bonus -= 2000;
            }
            if (zoneWeather == WEATHER_SNOW || zoneWeather == WEATHER_BLIZZARDS)
            {
                bonus += 2000;
            }
            if (vanaDay == DAYTYPE::WINDSDAY)
            {
                bonus -= 3000;
            }
            if (vanaDay == DAYTYPE::ICEDAY)
            {
                bonus += 3000;
            }
            break;
        case PETID_FIRESPIRIT:
            if (zoneWeather == WEATHER_HOT_SPELL || zoneWeather == WEATHER_HEAT_WAVE)
            {
                bonus -= 2000;
            }
            if (zoneWeather == WEATHER_RAIN || zoneWeather == WEATHER_SQUALL)
            {
                bonus += 2000;
            }
            if (vanaDay == DAYTYPE::FIRESDAY)
            {
                bonus -= 3000;
            }
            if (vanaDay == DAYTYPE::WATERSDAY)
            {
                bonus += 3000;
            }
            break;
        case PETID_ICESPIRIT:
            if (zoneWeather == WEATHER_SNOW || zoneWeather == WEATHER_BLIZZARDS)
            {
                bonus -= 2000;
            }
            if (zoneWeather == WEATHER_HOT_SPELL || zoneWeather == WEATHER_HEAT_WAVE)
            {
                bonus += 2000;
            }
            if (vanaDay == DAYTYPE::ICEDAY)
            {
                bonus -= 3000;
            }
            if (vanaDay == DAYTYPE::FIRESDAY)
            {
                bonus += 3000;
            }
            break;
        case PETID_THUNDERSPIRIT:
            if (zoneWeather == WEATHER_THUNDER || zoneWeather == WEATHER_THUNDERSTORMS)
            {
                bonus -= 2000;
            }
            if (zoneWeather == WEATHER_DUST_STORM || zoneWeather == WEATHER_SAND_STORM)
            {
                bonus += 2000;
            }
            if (vanaDay == DAYTYPE::LIGHTNINGDAY)
            {
                bonus -= 3000;
            }
            if (vanaDay == DAYTYPE::EARTHSDAY)
            {
                bonus += 3000;
            }
            break;
        case PETID_DARKSPIRIT:
            if (zoneWeather == WEATHER_GLOOM || zoneWeather == WEATHER_DARKNESS)
            {
                bonus -= 2000;
            }
            if (zoneWeather == WEATHER_AURORAS || zoneWeather == WEATHER_STELLAR_GLARE)
            {
                bonus += 2000;
            }
            if (vanaDay == DAYTYPE::DARKSDAY)
            {
                bonus -= 3000;
            }
            if (vanaDay == DAYTYPE::LIGHTSDAY)
            {
                bonus += 3000;
            }
            break;
        case PETID_LIGHTSPIRIT:
            if (zoneWeather == WEATHER_AURORAS || zoneWeather == WEATHER_STELLAR_GLARE)
            {
                bonus -= 2000;
            }
            if (zoneWeather == WEATHER_GLOOM || zoneWeather == WEATHER_DARKNESS)
            {
                bonus += 2000;
            }
            if (vanaDay == DAYTYPE::LIGHTSDAY)
            {
                bonus -= 3000;
            }
            if (vanaDay == DAYTYPE::DARKSDAY)
            {
                bonus += 3000;
            }
            break;
    }

    return bonus;
}

PMemberTargets CSpiritController::GetBestQualifiedMembers()
{
    TracyZoneScoped;

    PMemberTargets qualifiedTargets;
    qualifiedTargets.PLowest     = nullptr;
    qualifiedTargets.PNearest    = nullptr;
    CBattleEntity* PLowest       = nullptr;
    uint8          lowestPercent = 50;
    float          closestPerson = 20.1f;

    // The SMN always takes priority over the rest of the alliance.
    if (PSpirit->PMaster->GetHPP() <= lowestPercent)
    {
        qualifiedTargets.PLowest = PSpirit->PMaster;
        return qualifiedTargets;
    }
    // clang-format off
    // Light Spirit cures/curagas can target other alliance members.
    // Light Spirit does not cast cures on invisible players, no matter how low their HP is.
    PSpirit->PMaster->ForAlliance([&](CBattleEntity* PMember)
    {
        // Party / Alliance member sanity checks + generic spirit checks.
        if( PMember != nullptr && PSpirit->PMaster->loc.zone->GetID() == PMember->loc.zone->GetID() && distance(PSpirit->loc.p, PMember->loc.p) <= 20 &&
            !PMember->isDead() && !(PMember->StatusEffectContainer->HasStatusEffect(EFFECT_INVISIBLE)))
            {
                uint8 memberHPP = PMember->GetHPP();
                float curDist = distance(PSpirit->loc.p, PMember->loc.p);

                // Check lowest HP
                if (PLowest == nullptr ||
                    (lowestPercent >= memberHPP))
                {
                    PLowest = PMember;
                    lowestPercent = memberHPP;
                }

                // Check distance.
                if (curDist < closestPerson && PSpirit->PAI->PathFind && PSpirit->PAI->PathFind->CanSeePoint(PMember->loc.p))
                {
                    closestPerson = curDist;
                    qualifiedTargets.PNearest = PMember;
                }
            }
    });
    // clang-format on

    return qualifiedTargets;
}

uint8 CSpiritController::GetLowestHPThresholdCountForParty(CBattleEntity& target)
{
    uint8 numMeetsThreshold = 0;
    // clang-format off
    target.ForParty([&](CBattleEntity* PMember)
    {
        // Check to see how many low HP party members are there in Curaga range.
        if(PMember != nullptr && PSpirit->PMaster->loc.zone->GetID() == PMember->loc.zone->GetID() &&
           distance(PSpirit->loc.p, PMember->loc.p) <= 20 && !PMember->isDead() && PMember->GetHPP() <= 50)
           {
                numMeetsThreshold++;
           }
    });
    // clang-format on

    return numMeetsThreshold;
}

uint16 CSpiritController::DetermineHighestSpellFromMP(std::vector<uint16>& spellList)
{
    for (
        std::vector<uint16>::iterator spellIterator = spellList.begin();
        spellIterator != spellList.end();
        ++spellIterator)
    {
        CSpell* spell       = spell::GetSpell(static_cast<SpellID>(*spellIterator));
        uint16  spellMPCost = spell->getMPCost();

        if (static_cast<CBattleEntity*>(PSpirit)->health.mp >= spellMPCost)
        {
            return *spellIterator;
        }
    }
    return static_cast<uint16>(0);
}

uint16 CSpiritController::DetermineNextBuff(CBattleEntity& target)
{
    uint16 protSpell  = 0;
    uint16 shellSpell = 0;

    for (uint16 buff : PSpirit->m_buffSpells)
    {
        if (buff >= 43 && buff <= 47 && buff > protSpell)
            protSpell = buff;

        if (buff >= 48 && buff <= 52 && buff > shellSpell)
            shellSpell = buff;
    }

    // Priority #1 - Protect
    bool hasProt = target.StatusEffectContainer->HasStatusEffect(EFFECT_PROTECT);
    int  dProt   = hasProt ? (target.StatusEffectContainer->GetStatusEffect(EFFECT_PROTECT)->GetTier() + (static_cast<uint16>(SpellID::Protect) - 1)) - protSpell : -1;
    if (!hasProt || dProt < 0)
        return protSpell;

    // Priority #2 - Haste
    bool hasHaste = target.StatusEffectContainer->HasStatusEffect(EFFECT_HASTE);
    if (PSpirit->GetMLevel() >= 40 && !hasHaste)
        return 57U; // Haste

    // Priority #3 - Regen
    bool hasRegen = target.StatusEffectContainer->HasStatusEffect(EFFECT_REGEN);
    if (PSpirit->GetMLevel() >= 21 && !hasRegen)
        return 108U; // Regen

    // Priority #4 - Shell
    bool hasShell = target.StatusEffectContainer->HasStatusEffect(EFFECT_SHELL);
    int  dShell   = hasShell ? (target.StatusEffectContainer->GetStatusEffect(EFFECT_SHELL)->GetTier() + (static_cast<uint16>(SpellID::Shell) - 1)) - shellSpell : -1;
    if (!hasShell || dShell < 0)
        return shellSpell;

    // Light spirit has nothing to cast.
    return 0;
}

bool CSpiritController::CastIdleSpell(SpellID spellId, uint16 target)
{
    if (CanCastSpells())
        return static_cast<CMobController>(PSpirit).Cast(target, spellId);
    return false;
}
