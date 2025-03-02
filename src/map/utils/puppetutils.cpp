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
#include "instance.h"
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
        TracyZoneScoped;

        const char* Query = "SELECT unlocked_attachments, name, equipped_attachments FROM "
                            "char_pet LEFT JOIN pet_name ON automatonid = id "
                            "WHERE charid = (?)";

        auto rset = db::preparedStmt(Query, PChar->id);
        if (rset && rset->rowsCount() && rset->next())
        {
            db::extractFromBlob(rset, "unlocked_attachments", PChar->m_unlockedAttachments);

            if (PChar->GetMJob() == JOB_PUP || PChar->GetSJob() == JOB_PUP)
            {
                PChar->automatonInfo.m_automatonName = rset->get<std::string>("name");

                if (PChar->automatonInfo.m_automatonName.empty())
                {
                    PChar->automatonInfo.m_automatonName = "Automaton";
                }

                automaton_equip_t tempEquip;
                db::extractFromBlob(rset, "equipped_attachments", tempEquip);

                // If any of this happens then the Automaton failed to load properly and should just reset (Should only occur with older characters or if DB is
                // missing)
                if (tempEquip.Head < HEAD_HARLEQUIN ||
                    tempEquip.Head > HEAD_SPIRITREAVER ||
                    tempEquip.Frame < FRAME_HARLEQUIN ||
                    tempEquip.Frame > FRAME_STORMWAKER)
                {
                    PChar->setAutomatonHead(HEAD_HARLEQUIN);
                    tempEquip.Head = HEAD_HARLEQUIN;
                    PChar->setAutomatonFrame(FRAME_HARLEQUIN);
                    tempEquip.Frame = FRAME_HARLEQUIN;

                    for (int i = 0; i < 12; i++)
                    {
                        tempEquip.Attachments[i] = 0;
                    }

                    for (int i = 0; i < 6; i++)
                    {
                        PChar->setAutomatonElementMax(i, 5);
                    }

                    PChar->setAutomatonElementMax(6, 3);
                    PChar->setAutomatonElementMax(7, 3);

                    for (int i = 0; i < 8; i++)
                    {
                        PChar->automatonInfo.m_ElementEquip[i] = 0;
                    }
                }

                // Add the elemental bonus before we set the head and frame
                PChar->setAutomatonElementalCapacityBonus(PChar->getMod(Mod::AUTO_ELEM_CAPACITY));

                setHead(PChar, tempEquip.Head);
                setFrame(PChar, tempEquip.Frame);

                petutils::CalculateAutomatonStats(PChar, PChar->PPet);

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
            }
        }
    }

    void SaveAutomaton(CCharEntity* PChar)
    {
        if (PChar->GetMJob() == JOBTYPE::JOB_PUP || PChar->GetSJob() == JOBTYPE::JOB_PUP)
        {
            const char* Query = "UPDATE char_pet SET "
                                "unlocked_attachments = '%s', "
                                "equipped_attachments = '%s' "
                                "WHERE charid = %u";

            char unlockedAttachmentsEscaped[sizeof(PChar->m_unlockedAttachments) * 2 + 1];
            char unlockedAttachments[sizeof(PChar->m_unlockedAttachments)];
            std::memcpy(unlockedAttachments, &PChar->m_unlockedAttachments, sizeof(unlockedAttachments));
            _sql->EscapeStringLen(unlockedAttachmentsEscaped, unlockedAttachments, sizeof(unlockedAttachments));

            char equippedAttachmentsEscaped[sizeof(PChar->automatonInfo.m_Equip) * 2 + 1];
            char equippedAttachments[sizeof(PChar->automatonInfo.m_Equip)];
            std::memcpy(equippedAttachments, &PChar->automatonInfo.m_Equip, sizeof(equippedAttachments));
            _sql->EscapeStringLen(equippedAttachmentsEscaped, equippedAttachments, sizeof(equippedAttachments));

            _sql->Query(Query, unlockedAttachmentsEscaped, equippedAttachmentsEscaped, PChar->id);
        }
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
                PChar->pushPacket<CCharJobExtraPacket>(PChar, PChar->GetMJob() == JOB_PUP);
                return true;
            }
            return false;
        }
        else if (slot == 2) // automaton frame
        {
            if (addBit(id & 0x0F, &PChar->m_unlockedAttachments.frames, sizeof(PChar->m_unlockedAttachments.frames)))
            {
                SaveAutomaton(PChar);
                PChar->pushPacket<CCharJobExtraPacket>(PChar, PChar->GetMJob() == JOB_PUP);
                return true;
            }
            return false;
        }
        else if (slot == 1) // automaton head
        {
            if (addBit(id & 0x0F, &PChar->m_unlockedAttachments.heads, sizeof(PChar->m_unlockedAttachments.heads)))
            {
                SaveAutomaton(PChar);
                PChar->pushPacket<CCharJobExtraPacket>(PChar, PChar->GetMJob() == JOB_PUP);
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
                if (attachment == PChar->getAutomatonAttachment(i))
                {
                    return;
                }
            }
        }

        uint8 oldAttachment = PChar->getAutomatonAttachment(slotId);
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

                // Iterate through the 8 elements and validate if the attachment actually fits the current automaton head/frame
                for (int element = 0; element < 8; element++)
                {
                    auto currentElementCapacity = PChar->getAutomatonElementCapacity(element);
                    auto elementMax             = PChar->getAutomatonElementMax(element);
                    auto attachmentElementPower = ((PAttachment->getElementSlots() >> (element * 4)) & 0xF);

                    if (currentElementCapacity + attachmentElementPower > elementMax)
                    {
                        valid = false;
                        break;
                    }
                }
            }

            if (valid)
            {
                for (int element = 0; element < 8; element++)
                {
                    PChar->addAutomatonElementCapacity(element, (PAttachment->getElementSlots() >> (element * 4)) & 0xF);
                }

                PChar->setAutomatonAttachment(slotId, attachment);
            }
            else
            {
                setAttachment(PChar, slotId, oldAttachment);
            }
        }
        else
        {
            attachment = PChar->getAutomatonAttachment(slotId);

            if (attachment != 0)
            {
                PAttachment = (CItemPuppet*)itemutils::GetItemPointer(0x2100 + attachment);

                if (PAttachment && PAttachment->getEquipSlot() == ITEM_PUPPET_ATTACHMENT)
                {
                    for (int element = 0; element < 8; element++)
                    {
                        PChar->addAutomatonElementCapacity(element, -(int8)((PAttachment->getElementSlots() >> (element * 4)) & 0xF));
                    }

                    PChar->setAutomatonAttachment(slotId, 0);
                }
            }
        }
    }

    void setFrame(CCharEntity* PChar, uint8 frame)
    {
        uint8 tempElementMax[8];

        for (int element = 0; element < 8; element++)
        {
            tempElementMax[element] = PChar->getAutomatonElementMax(element);
        }

        if (PChar->getAutomatonFrame() != 0)
        {
            CItemPuppet* POldFrame = (CItemPuppet*)itemutils::GetItemPointer(0x2000 + PChar->getAutomatonFrame());
            if (POldFrame == nullptr || POldFrame->getEquipSlot() != ITEM_PUPPET_FRAME)
            {
                return;
            }
            for (int element = 0; element < 8; element++)
            {
                tempElementMax[element] -= (POldFrame->getElementSlots() >> (element * 4)) & 0xF;
            }
        }

        // Check if they actually have the frame
        CItemPuppet* PFrame = (CItemPuppet*)itemutils::GetItemPointer(0x2000 + frame);
        if (PFrame == nullptr || PFrame->getEquipSlot() != ITEM_PUPPET_FRAME || (frame != FRAME_HARLEQUIN && !HasAttachment(PChar, PFrame)))
        {
            return;
        }

        for (int element = 0; element < 8; element++)
        {
            tempElementMax[element] += (PFrame->getElementSlots() >> (element * 4)) & 0xF;
        }

        PChar->setAutomatonFrame((AUTOFRAMETYPE)frame);
        uint8 head                              = PChar->getAutomatonHead();
        PChar->automatonInfo.automatonLook.race = 0x07;

        if (head == 3)
        {
            PChar->automatonInfo.automatonLook.face = 0xBC + ((frame - 32) * 5);
        }
        else if (head == 4)
        {
            PChar->automatonInfo.automatonLook.face = 0xBB + ((frame - 32) * 5);
        }
        else if (head == 5)
        {
            PChar->automatonInfo.automatonLook.face = 0xD3 + ((frame - 32));
        }
        else if (head == 6)
        {
            PChar->automatonInfo.automatonLook.face = 0xD7 + ((frame - 32));
        }
        else
        {
            PChar->automatonInfo.automatonLook.face = 0xB9 + ((frame - 32) * 5) + (head - 1);
        }

        for (int element = 0; element < 8; element++)
        {
            PChar->setAutomatonElementMax(element, tempElementMax[element]);
        }
    }

    void setHead(CCharEntity* PChar, uint8 head)
    {
        uint8 tempElementMax[8];

        for (int element = 0; element < 8; element++)
        {
            tempElementMax[element] = PChar->getAutomatonElementMax(element);
        }

        if (PChar->getAutomatonHead() != 0)
        {
            CItemPuppet* POldHead = (CItemPuppet*)itemutils::GetItemPointer(0x2000 + PChar->getAutomatonHead());
            if (POldHead == nullptr || POldHead->getEquipSlot() != ITEM_PUPPET_HEAD)
            {
                return;
            }
            for (int element = 0; element < 8; element++)
            {
                tempElementMax[element] -= (POldHead->getElementSlots() >> (element * 4)) & 0xF;
            }
        }

        // Check if they actually have the head
        CItemPuppet* PHead = (CItemPuppet*)itemutils::GetItemPointer(0x2000 + head);
        if (PHead == nullptr || PHead->getEquipSlot() != ITEM_PUPPET_HEAD || (head != HEAD_HARLEQUIN && !HasAttachment(PChar, PHead)))
        {
            return;
        }

        for (int element = 0; element < 8; element++)
        {
            tempElementMax[element] += (PHead->getElementSlots() >> (element * 4)) & 0xF;
        }

        PChar->setAutomatonHead((AUTOHEADTYPE)head);
        uint8 frame                             = PChar->getAutomatonFrame();
        PChar->automatonInfo.automatonLook.race = 0x07;

        if (head == 3)
        {
            PChar->automatonInfo.automatonLook.face = 0xBC + ((frame - 32) * 5);
        }
        else if (head == 4)
        {
            PChar->automatonInfo.automatonLook.face = 0xBB + ((frame - 32) * 5);
        }
        else if (head == 5)
        {
            PChar->automatonInfo.automatonLook.face = 0xD3 + ((frame - 32));
        }
        else if (head == 6)
        {
            PChar->automatonInfo.automatonLook.face = 0xD7 + ((frame - 32));
        }
        else
        {
            PChar->automatonInfo.automatonLook.face = 0xB9 + ((frame - 32) * 5) + (head - 1);
        }
        for (int element = 0; element < 8; element++)
        {
            PChar->setAutomatonElementMax(element, tempElementMax[element]);
        }
    }

    uint16 getSkillCap(CCharEntity* PChar, SKILLTYPE skill, uint8 level)
    {
        if (PChar == nullptr)
        {
            ShowWarning("puppetutils::getSkillCap() - Null PChar passed to function.");
            return 0;
        }

        int8 rank = 0;
        if (skill < SKILL_AUTOMATON_MELEE || skill > SKILL_AUTOMATON_MAGIC)
        {
            return 0;
        }
        switch (PChar->getAutomatonFrame())
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

        switch (PChar->getAutomatonHead())
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

    void TrySkillUP(CAutomatonEntity* PAutomaton, SKILLTYPE SkillID, uint8 lvl)
    {
        if (!PAutomaton->PMaster || PAutomaton->PMaster->objtype != TYPE_PC)
        {
            ShowWarning("puppetutils::TrySkillUP() - PMaster was null, or was not a player.");
            return;
        }

        CCharEntity* PChar = (CCharEntity*)PAutomaton->PMaster;
        if (getSkillCap(PChar, SkillID, PAutomaton->GetMLevel()) != 0 && !(PAutomaton->WorkingSkills.skill[SkillID] & 0x8000))
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
                PChar->pushPacket<CMessageBasicPacket>(PAutomaton, PAutomaton, SkillID, SkillAmount, 38);

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
                    PChar->pushPacket<CCharJobExtraPacket>(PChar, PChar->GetMJob() == JOB_PUP);
                    PChar->pushPacket<CMessageBasicPacket>(PAutomaton, PAutomaton, SkillID, (CurSkill + SkillAmount) / 10, 53);
                }
                charutils::SaveCharSkills(PChar, SkillID);
            }
        }
    }

    void CheckAttachmentsForManeuver(CCharEntity* PChar, EFFECT maneuver, bool gain)
    {
        CAutomatonEntity* PAutomaton = dynamic_cast<CAutomatonEntity*>(PChar->PPet);

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

    void EquipAttachments(CAutomatonEntity* PAutomaton)
    {
        if (PAutomaton)
        {
            for (uint8 i = 0; i < 12; i++)
            {
                if (PAutomaton->getAttachment(i) != 0)
                {
                    CItemPuppet* PAttachment = (CItemPuppet*)itemutils::GetItemPointer(0x2100 + PAutomaton->getAttachment(i));

                    if (PAttachment)
                    {
                        luautils::OnAttachmentEquip(PAutomaton, PAttachment);
                    }
                }
            }
        }
    }

    void UpdateAttachments(CCharEntity* PChar)
    {
        CAutomatonEntity* PAutomaton = dynamic_cast<CAutomatonEntity*>(PChar->PPet);

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

    void PreLevelRestriction(CCharEntity* PChar)
    {
        CAutomatonEntity* PAutomaton = dynamic_cast<CAutomatonEntity*>(PChar->PPet);

        if (PAutomaton)
        {
            for (int i = 0; i < 12; i++)
            {
                uint8 attachment = PAutomaton->getAttachment(i);

                if (attachment != 0)
                {
                    CItemPuppet* PAttachment = dynamic_cast<CItemPuppet*>(itemutils::GetItemPointer(0x2100 + attachment));

                    if (PAttachment)
                    {
                        // Attachment scripts may have custom unequip logic that needs to run before the restriction is applied
                        // If they were to delMod after the restriction is applied, under/overflow may occur.
                        // This will also clear the localVars holding previously applied modifiers
                        luautils::OnAttachmentUnequip(PAutomaton, PAttachment);
                    }
                }
            }
        }
    }

    void PostLevelRestriction(CCharEntity* PChar)
    {
        CAutomatonEntity* PAutomaton = dynamic_cast<CAutomatonEntity*>(PChar->PPet);

        if (PAutomaton)
        {
            for (int i = 0; i < 12; i++)
            {
                uint8 attachment = PAutomaton->getAttachment(i);

                if (attachment != 0)
                {
                    CItemPuppet* PAttachment = dynamic_cast<CItemPuppet*>(itemutils::GetItemPointer(0x2100 + attachment));
                    if (PAttachment)
                    {
                        // Attachment scripts may have custom equip logic that needs to be computed against the LvRestricted puppet stats
                        luautils::OnAttachmentEquip(PAutomaton, PAttachment);
                    }
                }
            }

            // Now re-run the maneuvers apply logic on all attachments
            UpdateAttachments(PChar);
        }
    }
} // namespace puppetutils
