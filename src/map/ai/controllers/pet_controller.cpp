/*
===========================================================================

Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "pet_controller.h"

#include "../../../common/utils.h"
#include "../../entities/petentity.h"
#include "../../status_effect_container.h"
#include "../../utils/battleutils.h"
#include "../../utils/petutils.h"
#include "../../utils/zoneutils.h"
#include "../ai_container.h"

CPetController::CPetController(CPetEntity* _PPet)
: CMobController(_PPet)
, PPet(_PPet)
{
    //#TODO: this probably will have to depend on pet type (automaton does WS on its own..)
    SetWeaponSkillEnabled(false);
}

void CPetController::Tick(time_point tick)
{
    TracyZoneScoped;
    TracyZoneIString(PPet->GetName());

    if (PPet->shouldDespawn(tick))
    {
        petutils::DespawnPet(PPet->PMaster);
        return;
    }

    if (PPet->m_PetID <= PETID_DARKSPIRIT && PPet->PMaster && PPet->PMaster->objtype == TYPE_PC && !m_Setup)
    {
        SetSMNCastTime();
        PPet->m_lastCast = tick;

        if (PPet->m_PetID == PETID_LIGHTSPIRIT)
        {
            SetSpiritSpellTables();
        }

        m_Setup = true;
    }

    CMobController::Tick(tick);
}

void CPetController::DoRoamTick(time_point tick)
{
    if ((PPet->PMaster == nullptr || PPet->PMaster->isDead()) && PPet->isAlive() && PPet->objtype != TYPE_MOB)
    {
        PPet->Die();
        return;
    }

    // if pet can't follow then don't
    if (!PPet->PAI->CanFollowPath())
    {
        return;
    }

    // automaton, wyvern
    if (PPet->getPetType() == PET_TYPE::WYVERN || PPet->getPetType() == PET_TYPE::AUTOMATON)
    {
        if (PetIsHealing())
        {
            return;
        }
    }
    else if (PPet->isBstPet() && PPet->StatusEffectContainer->GetStatusEffect(EFFECT_HEALING))
    {
        return;
    }

    if (PPet->m_PetID <= PETID::PETID_DARKSPIRIT)
    {
        TryIdleSpellCast();
    }

    float currentDistance = distance(PPet->loc.p, PPet->PMaster->loc.p);

    if (currentDistance > PetRoamDistance)
    {
        if (currentDistance < 35.0f && PPet->PAI->PathFind->PathAround(PPet->PMaster->loc.p, 2.0f, PATHFLAG_RUN | PATHFLAG_WALLHACK))
        {
            PPet->PAI->PathFind->FollowPath(m_Tick);
        }
        else if (PPet->GetSpeed() > 0)
        {
            PPet->PAI->PathFind->WarpTo(PPet->PMaster->loc.p, PetRoamDistance);
        }
    }
}

bool CPetController::PetIsHealing()
{
    bool isMasterHealing = (PPet->PMaster->animation == ANIMATION_HEALING);
    bool isPetHealing    = (PPet->animation == ANIMATION_HEALING);

    if (isMasterHealing && !isPetHealing && !PPet->StatusEffectContainer->HasPreventActionEffect())
    {
        // animation down
        PPet->animation = ANIMATION_HEALING;
        PPet->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_HEALING, 0, 0, settings::get<uint8>("map.HEALING_TICK_DELAY"), 0));
        PPet->updatemask |= UPDATE_HP;
        return true;
    }
    else if (!isMasterHealing && isPetHealing)
    {
        // animation up
        PPet->animation = ANIMATION_NONE;
        PPet->StatusEffectContainer->DelStatusEffect(EFFECT_HEALING);
        PPet->updatemask |= UPDATE_HP;
        return false;
    }
    return isMasterHealing;
}

void CPetController::TryIdleSpellCast()
{
    if (!PPet->PMaster || PPet->PMaster->objtype != TYPE_PC ||
        m_Tick <= PPet->m_lastCast + PPet->m_castCool ||
        PPet->StatusEffectContainer->HasPreventActionEffect() ||
        PPet->StatusEffectContainer->HasStatusEffect(EFFECT_SILENCE))
    {
        return;
    }
    else
    {
        uint8 mLvl = PPet->GetMLevel();

        switch (PPet->m_PetID)
        {
            case PETID_EARTHSPIRIT:
                if (mLvl >= 28 && !PPet->StatusEffectContainer->HasStatusEffect(EFFECT_STONESKIN) && CanCastSpells())
                {
                    CastSpell(SpellID::Stoneskin);
                }
                break;
            case PETID_WATERSPIRIT:
                if (mLvl >= 10 && !PPet->StatusEffectContainer->HasStatusEffect(EFFECT_AQUAVEIL) && CanCastSpells())
                {
                    CastSpell(SpellID::Aquaveil);
                }
                break;
            case PETID_AIRSPIRIT:
                if (mLvl >= 19 && !PPet->StatusEffectContainer->HasStatusEffect(EFFECT_BLINK) && CanCastSpells())
                {
                    CastSpell(SpellID::Blink);
                }
                break;
            case PETID_FIRESPIRIT:
                if (mLvl >= 10 && !PPet->StatusEffectContainer->HasStatusEffect(EFFECT_BLAZE_SPIKES) && CanCastSpells())
                {
                    CastSpell(SpellID::Blaze_Spikes);
                }
                break;
            case PETID_ICESPIRIT:
                if (mLvl >= 20 && !PPet->StatusEffectContainer->HasStatusEffect(EFFECT_ICE_SPIKES) && CanCastSpells())
                {
                    CastSpell(SpellID::Ice_Spikes);
                }
                break;
            case PETID_THUNDERSPIRIT:
                if (mLvl >= 30 && !PPet->StatusEffectContainer->HasStatusEffect(EFFECT_SHOCK_SPIKES) && CanCastSpells())
                {
                    CastSpell(SpellID::Shock_Spikes);
                }
                break;
            case PETID_DARKSPIRIT:
                break;
            case PETID_LIGHTSPIRIT:
                CBattleEntity* PLowest       = nullptr;
                float          lowestPercent = 100.f;
                uint8          choice        = 2;
                uint16         chosenSpell   = static_cast<uint16>(SpellID::Cure);

                // clang-format off
                PPet->PMaster->ForParty([&](CBattleEntity* PMember)
                {
                    if (PMember != nullptr && PPet->PMaster->loc.zone->GetID() == PMember->loc.zone->GetID() && distance(PPet->loc.p, PMember->loc.p) <= 20 &&
                        !PMember->isDead())
                    {
                        float memberPercent = PMember->health.hp / PMember->health.maxhp;
                        if (PLowest == nullptr ||
                            (lowestPercent >= memberPercent))
                        {
                            PLowest = PMember;
                            lowestPercent = memberPercent;
                        }
                    }
                });
                // clang-format on

                if (lowestPercent < 0.5f) // 50% HP
                {
                    choice = xirand::GetRandomNumber(100);

                    if (choice <= 25)
                    {
                        choice = 1;
                    }
                }

                switch (choice)
                {
                    case 1:
                        if (PPet->m_healSpells.size() > 0)
                        {
                            chosenSpell = xirand::GetRandomElement(PPet->m_healSpells);
                        }
                        break;
                    case 2:
                        if (PPet->m_buffSpells.size() > 0)
                        {
                            chosenSpell = xirand::GetRandomElement(PPet->m_buffSpells);
                        }
                        break;
                }

                if (CanCastSpells())
                {
                    CastSpell(static_cast<SpellID>(chosenSpell));
                }

                break;
        }

        if (PPet)
        {
            PPet->m_lastCast = m_Tick;
        }
    }
}

void CPetController::SetSpiritSpellTables()
{
    uint8 mLvl = PPet->GetMLevel();

    if (mLvl >= 71)
    {
        PPet->m_healSpells.push_back(static_cast<uint16>(SpellID::Curaga_IV));
    }
    if (mLvl >= 68)
    {
        PPet->m_buffSpells.push_back(static_cast<uint16>(SpellID::Shell_IV));
    }
    if (mLvl >= 65)
    {
        PPet->m_offensiveSpells.push_back(static_cast<uint16>(SpellID::Banish_III));
    }
    if (mLvl >= 63)
    {
        PPet->m_buffSpells.push_back(static_cast<uint16>(SpellID::Protect_IV));
    }
    if (mLvl >= 61)
    {
        PPet->m_healSpells.push_back(static_cast<uint16>(SpellID::Cure_V));
    }
    if (mLvl >= 57 && mLvl < 68)
    {
        PPet->m_buffSpells.push_back(static_cast<uint16>(SpellID::Shell_III));
    }
    if (mLvl >= 51)
    {
        PPet->m_healSpells.push_back(static_cast<uint16>(SpellID::Curaga_III));
    }
    if (mLvl >= 50)
    {
        PPet->m_offensiveSpells.push_back(static_cast<uint16>(SpellID::Holy));
    }
    if (mLvl >= 47 && mLvl < 63)
    {
        PPet->m_buffSpells.push_back(static_cast<uint16>(SpellID::Protect_III));
    }
    if (mLvl >= 41)
    {
        PPet->m_healSpells.push_back(static_cast<uint16>(SpellID::Cure_IV));
    }
    if (mLvl >= 40)
    {
        PPet->m_buffSpells.push_back(static_cast<uint16>(SpellID::Haste));
        PPet->m_offensiveSpells.push_back(static_cast<uint16>(SpellID::Banishga_II));
    }
    if (mLvl >= 37)
    {
        PPet->m_offensiveSpells.push_back(static_cast<uint16>(SpellID::Flash));
    }
    if (mLvl >= 37 && mLvl < 57)
    {
        PPet->m_buffSpells.push_back(static_cast<uint16>(SpellID::Shell_II));
    }
    if (mLvl >= 31)
    {
        PPet->m_offensiveSpells.push_back(static_cast<uint16>(SpellID::Dia_II));
    }
    if (mLvl >= 31 && mLvl < 71)
    {
        PPet->m_healSpells.push_back(static_cast<uint16>(SpellID::Curaga_II));
    }
    if (mLvl >= 30)
    {
        PPet->m_offensiveSpells.push_back(static_cast<uint16>(SpellID::Banish_II));
    }
    if (mLvl >= 27 && mLvl < 57)
    {
        PPet->m_buffSpells.push_back(static_cast<uint16>(SpellID::Protect_II));
    }
    if (mLvl >= 21)
    {
        PPet->m_buffSpells.push_back(static_cast<uint16>(SpellID::Regen));
    }
    if (mLvl >= 21 && mLvl < 41)
    {
        PPet->m_healSpells.push_back(static_cast<uint16>(SpellID::Cure_III));
    }
    if (mLvl >= 17 && mLvl < 37)
    {
        PPet->m_buffSpells.push_back(static_cast<uint16>(SpellID::Shell));
    }
    if (mLvl >= 16 && mLvl < 51)
    {
        PPet->m_healSpells.push_back(static_cast<uint16>(SpellID::Curaga));
    }
    if (mLvl >= 11 && mLvl < 41)
    {
        PPet->m_healSpells.push_back(static_cast<uint16>(SpellID::Cure_II));
    }
    if (mLvl >= 7 && mLvl < 27)
    {
        PPet->m_buffSpells.push_back(static_cast<uint16>(SpellID::Protect));
    }
    if (mLvl >= 5 && mLvl < 65)
    {
        PPet->m_offensiveSpells.push_back(static_cast<uint16>(SpellID::Banish));
    }
    if (mLvl >= 1 && mLvl < 21)
    {
        PPet->m_healSpells.push_back(static_cast<uint16>(SpellID::Cure));
    }
}

void CPetController::SetSMNCastTime()
{
    uint32 castTime = ((48000 + GetSMNSkillReduction()) / 3) + GetDayWeatherBonus();

    if (PPet->PMaster->StatusEffectContainer->HasStatusEffect(EFFECT_ASTRAL_FLOW))
    {
        castTime -= 5000;
    }

    CItemEquipment* legSlotItem = static_cast<CCharEntity*>(PPet->PMaster)->getEquip(SLOT_LEGS);
    // Summoner's Spats & Summoner's Spats +1
    if (legSlotItem && (legSlotItem->getID() == 15131 || legSlotItem->getID() == 15594))
    {
        castTime -= 5000;
    }

    PPet->m_castCool = std::chrono::milliseconds(castTime);
}

int16 CPetController::GetSMNSkillReduction()
{
    if (PPet->PMaster && PPet->PMaster->objtype == TYPE_PC)
    {
        uint8 masterLvl = PPet->PMaster->GetMLevel();

        if (PPet->PMaster->GetMJob() != JOB_SMN)
        {
            masterLvl = PPet->PMaster->GetSLevel();
        }

        uint16 skill    = PPet->PMaster->GetSkill(SKILL_SUMMONING_MAGIC);
        uint16 maxSkill = battleutils::GetMaxSkill(SKILL_SUMMONING_MAGIC, JOB_SMN, masterLvl);

        return (1000 * floor(maxSkill - skill));
    }

    return 0;
}

int16 CPetController::GetDayWeatherBonus()
{
    if (PPet->PMaster == nullptr || PPet->PMaster->objtype != TYPE_PC)
    {
        return 0;
    }

    WEATHER zoneWeather = zoneutils::GetZone(PPet->PMaster->getZone())->GetWeather();
    uint32  vanaDay     = CVanaTime::getInstance()->getWeekday();
    int16   bonus       = 0;

    switch (PPet->m_PetID)
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

bool CPetController::TryDeaggro()
{
    if (PTarget == nullptr)
    {
        return true;
    }

    // target is no longer valid, so wipe them from our enmity list
    if (PTarget->isDead() || PTarget->isMounted() || PTarget->loc.zone->GetID() != PPet->loc.zone->GetID() ||
        PPet->StatusEffectContainer->GetConfrontationEffect() != PTarget->StatusEffectContainer->GetConfrontationEffect() ||
        PPet->getBattleID() != PTarget->getBattleID())
    {
        return true;
    }
    return false;
}

bool CPetController::Ability(uint16 targid, uint16 abilityid)
{
    if (PPet->PAI->CanChangeState())
    {
        return PPet->PAI->Internal_Ability(targid, abilityid);
    }
    return false;
}

bool CPetController::PetSkill(uint16 targid, uint16 abilityid)
{
    TracyZoneScoped;
    if (POwner)
    {
        FaceTarget(targid);
        PPet->PAI->EventHandler.triggerListener("WEAPONSKILL_BEFORE_USE", PPet, abilityid);
        return POwner->PAI->Internal_PetSkill(targid, abilityid);
    }

    return false;
}
