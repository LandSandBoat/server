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

#include "puppetutils.h"
#include "battleutils.h"
#include "charutils.h"
#include "entities/automatonentity.h"
#include "itemutils.h"
#include "job_points.h"
#include "lua/luautils.h"
#include "packets/char_job_extra.h"
#include "packets/message_basic.h"
#include "petutils.h"
#include "status_effect_container.h"
#include "zoneutils.h"

namespace puppetutils
{
    void LoadAutomaton(CCharEntity* PChar)
    {
        const char* Query = "SELECT unlocked_attachments, name, equipped_attachments FROM "
                            "char_pet LEFT JOIN pet_name ON automatonid = id "
                            "WHERE charid = %u;";

        int32 ret = _sql->Query(Query, PChar->id);

        if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
        {
            size_t length      = 0;
            char*  attachments = nullptr;
            _sql->GetData(0, &attachments, &length);
            memcpy(&PChar->m_unlockedAttachments, attachments, (length > sizeof(PChar->m_unlockedAttachments) ? sizeof(PChar->m_unlockedAttachments) : length));

            if (PChar->PAutomaton != nullptr)
            {
                // Make sure we don't delete a pet that is active
                auto* PZone = zoneutils::GetZone(PChar->PAutomaton->getZone());
                if (PZone == nullptr || PZone->GetEntity(PChar->PAutomaton->targid, TYPE_PET) == nullptr)
                {
                    destroy(PChar->PAutomaton);
                }
                else
                {
                    PChar->PAutomaton->PMaster = nullptr;
                }
                PChar->PPet       = nullptr;
                PChar->PAutomaton = nullptr;
            }

            if (PChar->GetMJob() == JOB_PUP || PChar->GetSJob() == JOB_PUP)
            {
                PChar->PAutomaton = new CAutomatonEntity();
                PChar->PAutomaton->saveModifiers();

                PChar->PAutomaton->name.insert(0, (const char*)_sql->GetData(1));
                automaton_equip_t tempEquip;
                attachments = nullptr;
                _sql->GetData(2, &attachments, &length);
                memcpy(&tempEquip, attachments, (length > sizeof(tempEquip) ? sizeof(tempEquip) : length));

                // If any of this happens then the Automaton failed to load properly and should just reset (Should only occur with older characters or if DB is
                // missing)
                if (tempEquip.Head < HEAD_HARLEQUIN || tempEquip.Head > HEAD_SPIRITREAVER || tempEquip.Frame < FRAME_HARLEQUIN ||
                    tempEquip.Frame > FRAME_STORMWAKER)
                {
                    PChar->PAutomaton->setHead(HEAD_HARLEQUIN);
                    tempEquip.Head = HEAD_HARLEQUIN;
                    PChar->PAutomaton->setFrame(FRAME_HARLEQUIN);
                    tempEquip.Frame = FRAME_HARLEQUIN;
                    for (int i = 0; i < 12; i++)
                    {
                        tempEquip.Attachments[i] = 0;
                    }

                    for (int i = 0; i < 6; i++)
                    {
                        PChar->PAutomaton->setElementMax(i, 5);
                    }
                    PChar->PAutomaton->setElementMax(6, 3);
                    PChar->PAutomaton->setElementMax(7, 3);

                    for (int i = 0; i < 8; i++)
                    {
                        PChar->PAutomaton->m_ElementEquip[i] = 0;
                    }
                }

                // Add the elemental bonus before we set the head and frame
                PChar->PAutomaton->setElementalCapacityBonus(PChar->getMod(Mod::AUTO_ELEM_CAPACITY));

                setHead(PChar, tempEquip.Head);
                setFrame(PChar, tempEquip.Frame);
                LoadAutomatonStats(PChar);

                // Always load Optic Fiber and Optic Fiber II first
                for (int i = 0; i < 12; i++)
                {
                    if (tempEquip.Attachments[i] == 198 || tempEquip.Attachments[i] == 206)
                    {
                        setAttachment(PChar, i, tempEquip.Attachments[i]);
                    }
                }

                for (int i = 0; i < 12; i++)
                {
                    if (tempEquip.Attachments[i] != 198 && tempEquip.Attachments[i] != 206)
                    {
                        setAttachment(PChar, i, tempEquip.Attachments[i]);
                    }
                }

                // After the Automaton has all attachments set, make sure we update for Optic Fiber
                puppetutils::UpdateAttachments(PChar);

                // Set burden based on JP
                PChar->PAutomaton->setAllBurden(30 - PChar->PJobPoints->GetJobPointValue(JP_ACTIVATE_EFFECT));

                PChar->PAutomaton->UpdateHealth();
                PChar->PAutomaton->health.hp = PChar->PAutomaton->GetMaxHP();
                PChar->PAutomaton->health.mp = PChar->PAutomaton->GetMaxMP();
            }
        }
    }

    void SaveAutomaton(CCharEntity* PChar)
    {
        if (PChar->PAutomaton)
        {
            const char* Query = "UPDATE char_pet SET "
                                "unlocked_attachments = '%s', "
                                "equipped_attachments = '%s' "
                                "WHERE charid = %u;";

            char unlockedAttachmentsEscaped[sizeof(PChar->m_unlockedAttachments) * 2 + 1];
            char unlockedAttachments[sizeof(PChar->m_unlockedAttachments)];
            memcpy(unlockedAttachments, &PChar->m_unlockedAttachments, sizeof(unlockedAttachments));
            _sql->EscapeStringLen(unlockedAttachmentsEscaped, unlockedAttachments, sizeof(unlockedAttachments));

            char equippedAttachmentsEscaped[sizeof(PChar->PAutomaton->m_Equip) * 2 + 1];
            char equippedAttachments[sizeof(PChar->PAutomaton->m_Equip)];
            memcpy(equippedAttachments, &PChar->PAutomaton->m_Equip, sizeof(equippedAttachments));
            _sql->EscapeStringLen(equippedAttachmentsEscaped, equippedAttachments, sizeof(equippedAttachments));

            _sql->Query(Query, unlockedAttachmentsEscaped, equippedAttachmentsEscaped, PChar->id);
        }
        else
        {
            const char* Query = "UPDATE char_pet SET "
                                "unlocked_attachments = '%s' "
                                "WHERE charid = %u;";

            char unlockedAttachmentsEscaped[sizeof(PChar->m_unlockedAttachments) * 2 + 1];
            char unlockedAttachments[sizeof(PChar->m_unlockedAttachments)];
            memcpy(unlockedAttachments, &PChar->m_unlockedAttachments, sizeof(unlockedAttachments));
            _sql->EscapeStringLen(unlockedAttachmentsEscaped, unlockedAttachments, sizeof(unlockedAttachments));

            _sql->Query(Query, unlockedAttachmentsEscaped, PChar->id);
        }
        // TODO: PUP only: save equipped automaton items
    }

    bool UnlockAttachment(CCharEntity* PChar, CItem* PItem)
    {
        uint16 id = PItem->getID();

        if (!PItem->isType(ITEM_PUPPET))
        {
            return false;
        }

        uint8 slot = ((CItemPuppet*)PItem)->getEquipSlot();

        if (slot == 3) // automaton attachment
        {
            if (addBit(id & 0xFF, (uint8*)PChar->m_unlockedAttachments.attachments, sizeof(PChar->m_unlockedAttachments.attachments)))
            {
                SaveAutomaton(PChar);
                PChar->pushPacket(new CCharJobExtraPacket(PChar, PChar->GetMJob() == JOB_PUP));
                return true;
            }
            return false;
        }
        else if (slot == 2) // automaton frame
        {
            if (addBit(id & 0x0F, &PChar->m_unlockedAttachments.frames, sizeof(PChar->m_unlockedAttachments.frames)))
            {
                SaveAutomaton(PChar);
                PChar->pushPacket(new CCharJobExtraPacket(PChar, PChar->GetMJob() == JOB_PUP));
                return true;
            }
            return false;
        }
        else if (slot == 1) // automaton head
        {
            if (addBit(id & 0x0F, &PChar->m_unlockedAttachments.heads, sizeof(PChar->m_unlockedAttachments.heads)))
            {
                SaveAutomaton(PChar);
                PChar->pushPacket(new CCharJobExtraPacket(PChar, PChar->GetMJob() == JOB_PUP));
                return true;
            }
            return false;
        }
        return false;
    }

    bool HasAttachment(CCharEntity* PChar, CItem* PItem)
    {
        uint16 id = PItem->getID();

        if (!PItem->isType(ITEM_PUPPET))
        {
            return false;
        }

        uint8 slot = ((CItemPuppet*)PItem)->getEquipSlot();

        if (slot == 3) // automaton attachment
        {
            return hasBit(id & 0xFF, (uint8*)PChar->m_unlockedAttachments.attachments, sizeof(PChar->m_unlockedAttachments.attachments));
        }
        else if (slot == 2) // automaton frame
        {
            return hasBit(id & 0x0F, &PChar->m_unlockedAttachments.frames, sizeof(PChar->m_unlockedAttachments.frames));
        }
        else if (slot == 1) // automaton head
        {
            return hasBit(id & 0x0F, &PChar->m_unlockedAttachments.heads, sizeof(PChar->m_unlockedAttachments.heads));
        }
        return false;
    }

    void setAttachment(CCharEntity* PChar, uint8 slotId, uint8 attachment)
    {
        CItemPuppet* PAttachment = (CItemPuppet*)itemutils::GetItemPointer(0x2100 + attachment);

        if (attachment != 0)
        {
            if (PAttachment && !HasAttachment(PChar, PAttachment))
            {
                return;
            }

            for (int i = 0; i < 12; i++)
            {
                if (attachment == PChar->PAutomaton->getAttachment(i))
                {
                    return;
                }
            }
        }

        uint8 oldAttachment = PChar->PAutomaton->getAttachment(slotId);
        if (attachment != 0 && oldAttachment != 0)
        {
            setAttachment(PChar, slotId, 0);
        }

        if (attachment != 0)
        {
            bool valid = false;

            if (PAttachment && PAttachment->getEquipSlot() == ITEM_PUPPET_ATTACHMENT)
            {
                valid = true;
                for (int i = 0; i < 8; i++)
                {
                    if (PChar->PAutomaton->getElementCapacity(i) + ((PAttachment->getElementSlots() >> (i * 4)) & 0xF) > PChar->PAutomaton->getElementMax(i))
                    {
                        valid = false;
                        break;
                    }
                }
            }

            if (valid)
            {
                for (int i = 0; i < 8; i++)
                {
                    PChar->PAutomaton->addElementCapacity(i, (PAttachment->getElementSlots() >> (i * 4)) & 0xF);
                }
                luautils::OnAttachmentEquip(PChar->PAutomaton, PAttachment);
                PChar->PAutomaton->setAttachment(slotId, attachment);
            }
            else
            {
                setAttachment(PChar, slotId, oldAttachment);
            }
        }
        else
        {
            attachment = PChar->PAutomaton->getAttachment(slotId);

            if (attachment != 0)
            {
                PAttachment = (CItemPuppet*)itemutils::GetItemPointer(0x2100 + attachment);

                if (PAttachment && PAttachment->getEquipSlot() == ITEM_PUPPET_ATTACHMENT)
                {
                    for (int i = 0; i < 8; i++)
                    {
                        PChar->PAutomaton->addElementCapacity(i, -(int8)((PAttachment->getElementSlots() >> (i * 4)) & 0xF));
                    }
                    luautils::OnAttachmentUnequip(PChar->PAutomaton, PAttachment);
                    PChar->PAutomaton->setAttachment(slotId, 0);
                }
            }
        }
    }

    void setFrame(CCharEntity* PChar, uint8 frame)
    {
        uint8 tempElementMax[8];

        for (int i = 0; i < 8; i++)
        {
            tempElementMax[i] = PChar->PAutomaton->getElementMax(i);
        }

        if (PChar->PAutomaton->getFrame() != 0)
        {
            CItemPuppet* POldFrame = (CItemPuppet*)itemutils::GetItemPointer(0x2000 + PChar->PAutomaton->getFrame());
            if (POldFrame == nullptr || POldFrame->getEquipSlot() != ITEM_PUPPET_FRAME)
            {
                return;
            }
            for (int i = 0; i < 8; i++)
            {
                tempElementMax[i] -= (POldFrame->getElementSlots() >> (i * 4)) & 0xF;
            }
        }
        CItemPuppet* PFrame = (CItemPuppet*)itemutils::GetItemPointer(0x2000 + frame);
        if (PFrame == nullptr || PFrame->getEquipSlot() != ITEM_PUPPET_FRAME || (frame != FRAME_HARLEQUIN && !HasAttachment(PChar, PFrame)))
        {
            return;
        }
        for (int i = 0; i < 8; i++)
        {
            tempElementMax[i] += (PFrame->getElementSlots() >> (i * 4)) & 0xF;
        }

        bool valid = true;

        for (int i = 0; i < 8; i++)
        {
            if (tempElementMax[i] < PChar->PAutomaton->getElementCapacity(i))
            {
                valid = false;
                break;
            }
        }

        if (valid)
        {
            PChar->PAutomaton->setFrame((AUTOFRAMETYPE)frame);
            uint8 head                   = PChar->PAutomaton->getHead();
            PChar->PAutomaton->look.race = 0x07;
            if (head == 3)
            {
                PChar->PAutomaton->look.face = 0xBC + ((frame - 32) * 5);
            }
            else if (head == 4)
            {
                PChar->PAutomaton->look.face = 0xBB + ((frame - 32) * 5);
            }
            else if (head == 5)
            {
                PChar->PAutomaton->look.face = 0xD3 + ((frame - 32));
            }
            else if (head == 6)
            {
                PChar->PAutomaton->look.face = 0xD7 + ((frame - 32));
            }
            else
            {
                PChar->PAutomaton->look.face = 0xB9 + ((frame - 32) * 5) + (head - 1);
            }
            for (int i = 0; i < 8; i++)
            {
                PChar->PAutomaton->setElementMax(i, tempElementMax[i]);
            }
        }
    }

    void setHead(CCharEntity* PChar, uint8 head)
    {
        uint8 tempElementMax[8];

        for (int i = 0; i < 8; i++)
        {
            tempElementMax[i] = PChar->PAutomaton->getElementMax(i);
        }

        if (PChar->PAutomaton->getHead() != 0)
        {
            CItemPuppet* POldHead = (CItemPuppet*)itemutils::GetItemPointer(0x2000 + PChar->PAutomaton->getHead());
            if (POldHead == nullptr || POldHead->getEquipSlot() != ITEM_PUPPET_HEAD)
            {
                return;
            }
            for (int i = 0; i < 8; i++)
            {
                tempElementMax[i] -= (POldHead->getElementSlots() >> (i * 4)) & 0xF;
            }
        }
        CItemPuppet* PHead = (CItemPuppet*)itemutils::GetItemPointer(0x2000 + head);
        if (PHead == nullptr || PHead->getEquipSlot() != ITEM_PUPPET_HEAD || (head != HEAD_HARLEQUIN && !HasAttachment(PChar, PHead)))
        {
            return;
        }
        for (int i = 0; i < 8; i++)
        {
            tempElementMax[i] += (PHead->getElementSlots() >> (i * 4)) & 0xF;
        }

        bool valid = true;

        for (int i = 0; i < 8; i++)
        {
            if (tempElementMax[i] < PChar->PAutomaton->getElementCapacity(i))
            {
                valid = false;
                break;
            }
        }

        if (valid)
        {
            PChar->PAutomaton->setHead((AUTOHEADTYPE)head);
            uint8 frame                  = PChar->PAutomaton->getFrame();
            PChar->PAutomaton->look.race = 0x07;
            if (head == 3)
            {
                PChar->PAutomaton->look.face = 0xBC + ((frame - 32) * 5);
            }
            else if (head == 4)
            {
                PChar->PAutomaton->look.face = 0xBB + ((frame - 32) * 5);
            }
            else if (head == 5)
            {
                PChar->PAutomaton->look.face = 0xD3 + ((frame - 32));
            }
            else if (head == 6)
            {
                PChar->PAutomaton->look.face = 0xD7 + ((frame - 32));
            }
            else
            {
                PChar->PAutomaton->look.face = 0xB9 + ((frame - 32) * 5) + (head - 1);
            }
            for (int i = 0; i < 8; i++)
            {
                PChar->PAutomaton->setElementMax(i, tempElementMax[i]);
            }
        }
    }

    uint16 getSkillCap(CCharEntity* PChar, SKILLTYPE skill, uint8 level)
    {
        int8 rank = 0;
        if (skill < SKILL_AUTOMATON_MELEE || skill > SKILL_AUTOMATON_MAGIC)
        {
            return 0;
        }
        switch (PChar->PAutomaton->getFrame())
        {
            default: // case FRAME_HARLEQUIN:
                rank = 5;
                break;
            case FRAME_VALOREDGE:
                if (skill == SKILL_AUTOMATON_MELEE)
                {
                    rank = 2;
                }
                break;
            case FRAME_SHARPSHOT:
                if (skill == SKILL_AUTOMATON_MELEE)
                {
                    rank = 6;
                }
                else if (skill == SKILL_AUTOMATON_RANGED)
                {
                    rank = 3;
                }
                break;
            case FRAME_STORMWAKER:
                if (skill == SKILL_AUTOMATON_MELEE)
                {
                    rank = 7;
                }
                else if (skill == SKILL_AUTOMATON_MAGIC)
                {
                    rank = 3;
                }
                break;
        }

        switch (PChar->PAutomaton->getHead())
        {
            case HEAD_VALOREDGE:
                if (skill == SKILL_AUTOMATON_MELEE)
                {
                    rank -= 1;
                }
                break;
            case HEAD_SHARPSHOT:
                if (skill == SKILL_AUTOMATON_RANGED)
                {
                    rank -= 1;
                }
                break;
            case HEAD_STORMWAKER:
                if (skill == SKILL_AUTOMATON_MELEE || skill == SKILL_AUTOMATON_MAGIC)
                {
                    rank -= 1;
                }
                break;
            case HEAD_SOULSOOTHER:
            case HEAD_SPIRITREAVER:
                if (skill == SKILL_AUTOMATON_MAGIC)
                {
                    rank -= 2;
                }
                break;
            default:
                break;
        }

        // only happens if a head gives bonus to a rank of 0 - making it G or F rank
        if (rank < 0)
        {
            rank = 13 + rank;
        }

        return battleutils::GetMaxSkill(rank, level > 99 ? 99 : level);
    }

    uint16 getSkillCap(CCharEntity* PChar, SKILLTYPE skill)
    {
        if (PChar == nullptr)
        {
            ShowWarning("puppetutils::getSkillCap() - Null PChar passed to function.");
            return 0;
        }

        return getSkillCap(PChar, skill, PChar->PAutomaton->GetMLevel());
    }

    void LoadAutomatonStats(CCharEntity* PChar)
    {
        switch (PChar->PAutomaton->getFrame())
        {
            default: // case FRAME_HARLEQUIN:
                ShowWarning("puppetutils::LoadAutomatonStats Invalid frame detected for '%s', used Harlequin instead! (%u)",
                            PChar->getName(), (uint16)PChar->PAutomaton->getFrame());
            case FRAME_HARLEQUIN:
                petutils::LoadPet(PChar, PETID_HARLEQUINFRAME, false);
                break;
            case FRAME_VALOREDGE:
                petutils::LoadPet(PChar, PETID_VALOREDGEFRAME, false);
                break;
            case FRAME_SHARPSHOT:
                petutils::LoadPet(PChar, PETID_SHARPSHOTFRAME, false);
                break;
            case FRAME_STORMWAKER:
                petutils::LoadPet(PChar, PETID_STORMWAKERFRAME, false);
                break;
        }
        PChar->PPet = nullptr; // already saved as PAutomaton, don't need it twice unless it's summoned
    }

    void TrySkillUP(CAutomatonEntity* PAutomaton, SKILLTYPE SkillID, uint8 lvl)
    {
        if (!PAutomaton->PMaster || PAutomaton->PMaster->objtype != TYPE_PC)
        {
            ShowWarning("puppetutils::TrySkillUP() - PMaster was null, or was not a player.");
            return;
        }

        CCharEntity* PChar = (CCharEntity*)PAutomaton->PMaster;
        if (getSkillCap(PChar, SkillID) != 0 && !(PAutomaton->WorkingSkills.skill[SkillID] & 0x8000))
        {
            uint16 CurSkill = PChar->RealSkills.skill[SkillID];
            uint16 MaxSkill = getSkillCap(PChar, SkillID, std::min(PAutomaton->GetMLevel(), lvl));

            int16  Diff          = MaxSkill - CurSkill / 10;
            double SkillUpChance = Diff / 5.0 + settings::get<double>("map.SKILLUP_CHANCE_MULTIPLIER") * (2.0 - log10(1.0 + CurSkill / 100));

            double random = xirand::GetRandomNumber(1.);

            if (SkillUpChance > 0.5)
            {
                SkillUpChance = 0.5;
            }

            SkillUpChance *= ((100.f + PAutomaton->getMod(Mod::COMBAT_SKILLUP_RATE)) / 100.f);

            if (Diff > 0 && random < SkillUpChance)
            {
                double chance      = 0;
                uint8  SkillAmount = 1;
                uint8  tier        = std::min(1 + (Diff / 5), 5);

                for (uint8 i = 0; i < 4; ++i) // 1 + 4 possible additional ones (maximum 5)
                {
                    random = xirand::GetRandomNumber(1.);

                    switch (tier)
                    {
                        case 5:
                            chance = 0.900;
                            break;
                        case 4:
                            chance = 0.700;
                            break;
                        case 3:
                            chance = 0.500;
                            break;
                        case 2:
                            chance = 0.300;
                            break;
                        case 1:
                            chance = 0.200;
                            break;
                        default:
                            chance = 0.000;
                            break;
                    }

                    if (chance < random || SkillAmount == 5)
                    {
                        break;
                    }

                    tier -= 1;
                    SkillAmount += 1;
                }
                MaxSkill = MaxSkill * 10;

                // Do skill amount multiplier (Will only be applied if default setting is changed)
                if (settings::get<uint8>("map.SKILLUP_AMOUNT_MULTIPLIER") > 1)
                {
                    SkillAmount += (uint8)(SkillAmount * settings::get<uint8>("map.SKILLUP_AMOUNT_MULTIPLIER"));
                    if (SkillAmount > 9)
                    {
                        SkillAmount = 9;
                    }
                }

                if (SkillAmount + CurSkill >= MaxSkill)
                {
                    SkillAmount = MaxSkill - CurSkill;
                    PAutomaton->WorkingSkills.skill[SkillID] |= 0x8000;
                }

                PChar->RealSkills.skill[SkillID] += SkillAmount;
                PChar->pushPacket(new CMessageBasicPacket(PAutomaton, PAutomaton, SkillID, SkillAmount, 38));

                if ((CurSkill / 10) < (CurSkill + SkillAmount) / 10) // if gone up a level
                {
                    PChar->WorkingSkills.skill[SkillID] += 1;
                    PAutomaton->WorkingSkills.skill[SkillID] += 1;
                    if (SkillID == SKILL_AUTOMATON_MAGIC)
                    {
                        uint16 amaSkill                           = PAutomaton->WorkingSkills.skill[SKILL_AUTOMATON_MAGIC];
                        PAutomaton->WorkingSkills.automaton_magic = amaSkill;
                        PAutomaton->WorkingSkills.healing         = amaSkill;
                        PAutomaton->WorkingSkills.enhancing       = amaSkill;
                        PAutomaton->WorkingSkills.enfeebling      = amaSkill;
                        PAutomaton->WorkingSkills.elemental       = amaSkill;
                        PAutomaton->WorkingSkills.dark            = amaSkill;
                    }
                    PChar->pushPacket(new CCharJobExtraPacket(PChar, PChar->GetMJob() == JOB_PUP));
                    PChar->pushPacket(new CMessageBasicPacket(PAutomaton, PAutomaton, SkillID, (CurSkill + SkillAmount) / 10, 53));
                }
                charutils::SaveCharSkills(PChar, SkillID);
            }
        }
    }

    void CheckAttachmentsForManeuver(CCharEntity* PChar, EFFECT maneuver, bool gain)
    {
        CAutomatonEntity* PAutomaton = PChar->PAutomaton;

        if (PAutomaton)
        {
            uint8 element = maneuver - EFFECT_FIRE_MANEUVER;
            for (uint8 i = 0; i < 12; i++)
            {
                if (PAutomaton->getAttachment(i) != 0)
                {
                    CItemPuppet* PAttachment = (CItemPuppet*)itemutils::GetItemPointer(0x2100 + PAutomaton->getAttachment(i));

                    if (PAttachment && (PAttachment->getElementSlots() >> (element * 4)) & 0xF)
                    {
                        if (gain)
                        {
                            luautils::OnManeuverGain(PAutomaton, PAttachment, PChar->StatusEffectContainer->GetEffectsCount(maneuver));
                        }
                        else
                        {
                            luautils::OnManeuverLose(PAutomaton, PAttachment, PChar->StatusEffectContainer->GetEffectsCount(maneuver));
                        }
                    }
                }
            }
        }
    }

    void UpdateAttachments(CCharEntity* PChar)
    {
        CAutomatonEntity* PAutomaton = PChar->PAutomaton;

        if (PAutomaton)
        {
            for (uint8 i = 0; i < 12; i++)
            {
                if (PAutomaton->getAttachment(i) != 0)
                {
                    CItemPuppet* PAttachment = (CItemPuppet*)itemutils::GetItemPointer(0x2100 + PAutomaton->getAttachment(i));

                    if (PAttachment)
                    {
                        int32 maneuver = EFFECT_FIRE_MANEUVER;
                        for (int i = 0; i < 8; i++)
                        {
                            if (PAttachment->getElementSlots() >> (i * 4) & 0xF)
                            {
                                maneuver += i;
                                break;
                            }
                        }
                        luautils::OnUpdateAttachment(PAutomaton, PAttachment, PChar->StatusEffectContainer->GetEffectsCount((EFFECT)maneuver));
                    }
                }
            }
        }
    }

} // namespace puppetutils
