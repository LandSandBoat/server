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
#include "enums/automaton.h"
#include "items/item_puppet.h"
#include "itemutils.h"
#include "job_points.h"
#include "lua/luautils.h"
#include "packets/s2c/0x029_battle_message.h"
#include "petutils.h"
#include "status_effect_container.h"
#include "zoneutils.h"

namespace puppetutils
{

namespace
{
// Returns automaton model ID for given frame and head
auto calculateAutomatonModel(const AutomatonFrame frame, const AutomatonHead head) -> uint16
{
    switch (frame)
    {
        case AutomatonFrame::Harlequin:
            switch (head)
            {
                case AutomatonHead::Harlequin:
                    return 0x07B9;
                case AutomatonHead::Valoredge:
                    return 0x07BA;
                case AutomatonHead::Sharpshot:
                    return 0x07BC;
                case AutomatonHead::Stormwaker:
                    return 0x07BB;
                case AutomatonHead::Soulsoother:
                    return 0x07D3;
                case AutomatonHead::Spiritreaver:
                    return 0x07D7;
            }
            break;
        case AutomatonFrame::Valoredge:
            switch (head)
            {
                case AutomatonHead::Harlequin:
                    return 0x07BE;
                case AutomatonHead::Valoredge:
                    return 0x07BF;
                case AutomatonHead::Sharpshot:
                    return 0x07C1;
                case AutomatonHead::Stormwaker:
                    return 0x07C0;
                case AutomatonHead::Soulsoother:
                    return 0x07D4;
                case AutomatonHead::Spiritreaver:
                    return 0x07D8;
            }
            break;
        case AutomatonFrame::Sharpshot:
            switch (head)
            {
                case AutomatonHead::Harlequin:
                    return 0x07C3;
                case AutomatonHead::Valoredge:
                    return 0x07C4;
                case AutomatonHead::Sharpshot:
                    return 0x07C6;
                case AutomatonHead::Stormwaker:
                    return 0x07C5;
                case AutomatonHead::Soulsoother:
                    return 0x07D5;
                case AutomatonHead::Spiritreaver:
                    return 0x07D9;
            }
            break;
        case AutomatonFrame::Stormwaker:
            switch (head)
            {
                case AutomatonHead::Harlequin:
                    return 0x07C8;
                case AutomatonHead::Valoredge:
                    return 0x07C9;
                case AutomatonHead::Sharpshot:
                    return 0x07CB;
                case AutomatonHead::Stormwaker:
                    return 0x07CA;
                case AutomatonHead::Soulsoother:
                    return 0x07D6;
                case AutomatonHead::Spiritreaver:
                    return 0x07DA;
            }
            break;
    }

    return 0x07B9; // Fallback: Harlequin frame + Harlequin head
}
} // namespace

void LoadAutomaton(CCharEntity* PChar)
{
    TracyZoneScoped;

    const char* Query = "SELECT unlocked_attachments, name, equipped_attachments FROM "
                        "char_pet LEFT JOIN pet_name ON automatonid = id "
                        "WHERE charid = ?";

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

            automaton_equip_t tempEquip{};
            db::extractFromBlob(rset, "equipped_attachments", tempEquip);

            // If any of this happens then the Automaton failed to load properly and should just reset (Should only occur with older characters or if DB is
            // missing)
            if (tempEquip.Head < AutomatonHead::Harlequin ||
                tempEquip.Head > AutomatonHead::Spiritreaver ||
                tempEquip.Frame < AutomatonFrame::Harlequin ||
                tempEquip.Frame > AutomatonFrame::Stormwaker)
            {
                PChar->setAutomatonHead(AutomatonHead::Harlequin);
                tempEquip.Head = AutomatonHead::Harlequin;
                PChar->setAutomatonFrame(AutomatonFrame::Harlequin);
                tempEquip.Frame = AutomatonFrame::Harlequin;

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
                if (static_cast<AutomatonAttachment>(tempEquip.Attachments[i]) == AutomatonAttachment::OpticFiber ||
                    static_cast<AutomatonAttachment>(tempEquip.Attachments[i]) == AutomatonAttachment::OpticFiberII)
                {
                    setAttachment(PChar, i, tempEquip.Attachments[i]);
                }
            }

            for (int i = 0; i < 12; i++)
            {
                if (static_cast<AutomatonAttachment>(tempEquip.Attachments[i]) != AutomatonAttachment::OpticFiber &&
                    static_cast<AutomatonAttachment>(tempEquip.Attachments[i]) != AutomatonAttachment::OpticFiberII)
                {
                    setAttachment(PChar, i, tempEquip.Attachments[i]);
                }
            }
        }
    }
}

void SaveAttachments(CCharEntity* PChar)
{
    db::preparedStmt("UPDATE char_pet SET "
                     "unlocked_attachments = ? "
                     "WHERE charid = ? LIMIT 1",
                     PChar->m_unlockedAttachments,
                     PChar->id);
}

void SaveAutomaton(CCharEntity* PChar)
{
    if (PChar->GetMJob() == JOBTYPE::JOB_PUP || PChar->GetSJob() == JOBTYPE::JOB_PUP)
    {
        db::preparedStmt("UPDATE char_pet SET "
                         "equipped_attachments = ? "
                         "WHERE charid = ? LIMIT 1",
                         PChar->automatonInfo.m_Equip,
                         PChar->id);
    }
}

auto UnlockAttachment(CCharEntity* PChar, const CItem* PItem) -> bool
{
    const uint16 id = PItem->getID();

    if (!PItem->isType(ITEM_PUPPET))
    {
        return false;
    }

    const uint8 slot = static_cast<const CItemPuppet*>(PItem)->getEquipSlot();
    if (slot == ITEM_PUPPET_ATTACHMENT)
    {
        if (addBit(id & 0xFF, reinterpret_cast<uint8*>(PChar->m_unlockedAttachments.attachments), sizeof(PChar->m_unlockedAttachments.attachments)))
        {
            SaveAttachments(PChar);
            charutils::SendExtendedJobPackets(PChar);
            return true;
        }
        return false;
    }
    else if (slot == ITEM_PUPPET_FRAME)
    {
        if (addBit(id & 0x0F, &PChar->m_unlockedAttachments.frames, sizeof(PChar->m_unlockedAttachments.frames)))
        {
            SaveAttachments(PChar);
            charutils::SendExtendedJobPackets(PChar);
            return true;
        }
        return false;
    }
    else if (slot == ITEM_PUPPET_HEAD)
    {
        if (addBit(id & 0x0F, &PChar->m_unlockedAttachments.heads, sizeof(PChar->m_unlockedAttachments.heads)))
        {
            SaveAttachments(PChar);
            charutils::SendExtendedJobPackets(PChar);
            return true;
        }
        return false;
    }
    return false;
}

auto HasAttachment(const CCharEntity* PChar, const CItem* PItem) -> bool
{
    const uint16 id = PItem->getID();
    if (!PItem->isType(ITEM_PUPPET))
    {
        return false;
    }

    const uint8 slot = static_cast<const CItemPuppet*>(PItem)->getEquipSlot();

    // Note: getEquipSlot() returns ITEM_PUPPET_EQUIPSLOT values (1-based from DB),
    // not AutomatonSlot packet indices (0-based).
    switch (slot)
    {
        case ITEM_PUPPET_ATTACHMENT:
            return hasBit(id & 0xFF, reinterpret_cast<const uint8*>(PChar->m_unlockedAttachments.attachments), sizeof(PChar->m_unlockedAttachments.attachments));
        case ITEM_PUPPET_FRAME:
            return hasBit(id & 0x0F, &PChar->m_unlockedAttachments.frames, sizeof(PChar->m_unlockedAttachments.frames));
        case ITEM_PUPPET_HEAD:
            return hasBit(id & 0x0F, &PChar->m_unlockedAttachments.heads, sizeof(PChar->m_unlockedAttachments.heads));
        default:
            return false;
    }
}

void setAttachment(CCharEntity* PChar, uint8 slotId, uint8 attachment)
{
    auto* PAttachment = xi::items::lookup<CItemPuppet>(0x2100 + attachment);
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

    const uint8 oldAttachment = PChar->getAutomatonAttachment(slotId);
    if (attachment != 0 && oldAttachment != 0)
    {
        setAttachment(PChar, slotId, 0);
    }

    if (attachment != 0)
    {
        if (PAttachment && PAttachment->getEquipSlot() == ITEM_PUPPET_ATTACHMENT)
        {
            bool valid = true;

            // Validate if the attachment fits the current automaton head/frame element capacity
            for (int element = 0; element < 8; element++)
            {
                const auto currentElementCapacity = PChar->getAutomatonElementCapacity(element);
                const auto elementMax             = PChar->getAutomatonElementMax(element);
                const auto attachmentElementPower = ((PAttachment->getElementSlots() >> (element * 4)) & 0xF);

                if (currentElementCapacity + attachmentElementPower > elementMax)
                {
                    valid = false;
                    break;
                }
            }

            if (valid)
            {
                for (int element = 0; element < 8; element++)
                {
                    PChar->addAutomatonElementCapacity(element, (PAttachment->getElementSlots() >> (element * 4)) & 0xF);
                }
                PChar->setAutomatonAttachment(slotId, attachment);
                return;
            }
        }

        // Invalid attachment or doesn't fit - restore old
        setAttachment(PChar, slotId, oldAttachment);
    }
    else
    {
        attachment = PChar->getAutomatonAttachment(slotId);

        if (attachment != 0)
        {
            PAttachment = xi::items::lookup<CItemPuppet>(0x2100 + attachment);

            if (PAttachment && PAttachment->getEquipSlot() == ITEM_PUPPET_ATTACHMENT)
            {
                for (int element = 0; element < 8; element++)
                {
                    PChar->addAutomatonElementCapacity(element, -static_cast<int8>((PAttachment->getElementSlots() >> (element * 4)) & 0xF));
                }

                PChar->setAutomatonAttachment(slotId, 0);
            }
        }
    }
}

void setFrame(CCharEntity* PChar, AutomatonFrame frame)
{
    uint8 tempElementMax[8];

    for (int element = 0; element < 8; element++)
    {
        tempElementMax[element] = PChar->getAutomatonElementMax(element);
    }

    if (static_cast<uint8>(PChar->getAutomatonFrame()) != 0)
    {
        const auto* POldFrame = xi::items::lookup<CItemPuppet>(0x2000 + static_cast<uint8>(PChar->getAutomatonFrame()));
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
    auto* PFrame = xi::items::lookup<CItemPuppet>(0x2000 + static_cast<uint8>(frame));
    if (PFrame == nullptr || PFrame->getEquipSlot() != ITEM_PUPPET_FRAME || (frame != AutomatonFrame::Harlequin && !HasAttachment(PChar, PFrame)))
    {
        return;
    }

    for (int element = 0; element < 8; element++)
    {
        tempElementMax[element] += (PFrame->getElementSlots() >> (element * 4)) & 0xF;
    }

    PChar->setAutomatonFrame(frame);
    PChar->automatonInfo.automatonLook.modelid = calculateAutomatonModel(frame, PChar->getAutomatonHead());

    for (int element = 0; element < 8; element++)
    {
        PChar->setAutomatonElementMax(element, tempElementMax[element]);
    }
}

void setHead(CCharEntity* PChar, AutomatonHead head)
{
    uint8 tempElementMax[8];

    for (int element = 0; element < 8; element++)
    {
        tempElementMax[element] = PChar->getAutomatonElementMax(element);
    }

    if (static_cast<uint8>(PChar->getAutomatonHead()) != 0)
    {
        const auto* POldHead = xi::items::lookup<CItemPuppet>(0x2000 + static_cast<uint8>(PChar->getAutomatonHead()));
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
    auto* PHead = xi::items::lookup<CItemPuppet>(0x2000 + static_cast<uint8>(head));
    if (PHead == nullptr || PHead->getEquipSlot() != ITEM_PUPPET_HEAD || (head != AutomatonHead::Harlequin && !HasAttachment(PChar, PHead)))
    {
        return;
    }

    for (int element = 0; element < 8; element++)
    {
        tempElementMax[element] += (PHead->getElementSlots() >> (element * 4)) & 0xF;
    }

    PChar->setAutomatonHead(head);
    PChar->automatonInfo.automatonLook.modelid = calculateAutomatonModel(PChar->getAutomatonFrame(), head);

    for (int element = 0; element < 8; element++)
    {
        PChar->setAutomatonElementMax(element, tempElementMax[element]);
    }
}

auto getSkillCap(const CCharEntity* PChar, const SKILLTYPE skill, const uint8 level) -> uint16
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
        default: // case Harlequin:
            rank = 5;
            break;
        case AutomatonFrame::Valoredge:
            if (skill == SKILL_AUTOMATON_MELEE)
            {
                rank = 2;
            }
            break;
        case AutomatonFrame::Sharpshot:
            if (skill == SKILL_AUTOMATON_MELEE)
            {
                rank = 6;
            }
            else if (skill == SKILL_AUTOMATON_RANGED)
            {
                rank = 3;
            }
            break;
        case AutomatonFrame::Stormwaker:
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
        case AutomatonHead::Valoredge:
            if (skill == SKILL_AUTOMATON_MELEE)
            {
                rank -= 1;
            }
            break;
        case AutomatonHead::Sharpshot:
            if (skill == SKILL_AUTOMATON_RANGED)
            {
                rank -= 1;
            }
            break;
        case AutomatonHead::Stormwaker:
            if (skill == SKILL_AUTOMATON_MELEE || skill == SKILL_AUTOMATON_MAGIC)
            {
                rank -= 1;
            }
            break;
        case AutomatonHead::Soulsoother:
        case AutomatonHead::Spiritreaver:
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

    auto* PChar = static_cast<CCharEntity*>(PAutomaton->PMaster);
    if (getSkillCap(PChar, SkillID, PAutomaton->GetMLevel()) != 0 && !(PAutomaton->WorkingSkills.skill[SkillID] & 0x8000))
    {
        const uint16 CurSkill = PChar->RealSkills.skill[SkillID];
        uint16       MaxSkill = getSkillCap(PChar, SkillID, std::min(PAutomaton->GetMLevel(), lvl));

        const int16 Diff          = MaxSkill - CurSkill / 10;
        double      SkillUpChance = Diff / 5.0 + settings::get<double>("map.SKILLUP_CHANCE_MULTIPLIER") * (2.0 - log10(1.0 + CurSkill / 100));

        double random = xirand::GetRandomNumber(1.);

        if (SkillUpChance > 0.5)
        {
            SkillUpChance = 0.5;
        }

        SkillUpChance *= ((100.0f + PAutomaton->getMod(Mod::COMBAT_SKILLUP_RATE)) / 100.0f);

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
                SkillAmount += static_cast<uint8>(SkillAmount * settings::get<uint8>("map.SKILLUP_AMOUNT_MULTIPLIER"));
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
            PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PAutomaton, PAutomaton, SkillID, SkillAmount, MsgBasic::SkillGain);

            if ((CurSkill / 10) < (CurSkill + SkillAmount) / 10) // if gone up a level
            {
                PChar->WorkingSkills.skill[SkillID] += 1;
                PAutomaton->WorkingSkills.skill[SkillID] += 1;
                if (SkillID == SKILL_AUTOMATON_MAGIC)
                {
                    const uint16 amaSkill                     = PAutomaton->WorkingSkills.skill[SKILL_AUTOMATON_MAGIC];
                    PAutomaton->WorkingSkills.automaton_magic = amaSkill;
                    PAutomaton->WorkingSkills.healing         = amaSkill;
                    PAutomaton->WorkingSkills.enhancing       = amaSkill;
                    PAutomaton->WorkingSkills.enfeebling      = amaSkill;
                    PAutomaton->WorkingSkills.elemental       = amaSkill;
                    PAutomaton->WorkingSkills.dark            = amaSkill;
                }

                charutils::SendExtendedJobPackets(PChar);
                PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PAutomaton, PAutomaton, SkillID, (CurSkill + SkillAmount) / 10, MsgBasic::SkillLevelUp);
            }
            charutils::SaveCharSkills(PChar, SkillID);
        }
    }
}

void CheckAttachmentsForManeuver(const CCharEntity* PChar, const EFFECT maneuver, const bool gain)
{
    auto* PAutomaton = dynamic_cast<CAutomatonEntity*>(PChar->PPet);
    if (PAutomaton)
    {
        uint8 element = maneuver - EFFECT_FIRE_MANEUVER;
        for (uint8 i = 0; i < 12; i++)
        {
            if (PAutomaton->getAttachment(i) != 0)
            {
                auto* PAttachment = xi::items::lookup<CItemPuppet>(0x2100 + PAutomaton->getAttachment(i));

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
                auto* PAttachment = xi::items::lookup<CItemPuppet>(0x2100 + PAutomaton->getAttachment(i));
                if (PAttachment)
                {
                    luautils::OnAttachmentEquip(PAutomaton, PAttachment);
                }
            }
        }
    }
}

void UpdateAttachments(const CCharEntity* PChar)
{
    auto* PAutomaton = dynamic_cast<CAutomatonEntity*>(PChar->PPet);
    if (PAutomaton)
    {
        for (uint8 i = 0; i < 12; i++)
        {
            if (PAutomaton->getAttachment(i) != 0)
            {
                auto* PAttachment = xi::items::lookup<CItemPuppet>(0x2100 + PAutomaton->getAttachment(i));

                if (PAttachment)
                {
                    int32 maneuver = EFFECT_FIRE_MANEUVER;
                    for (int j = 0; j < 8; j++)
                    {
                        if (PAttachment->getElementSlots() >> (j * 4) & 0xF)
                        {
                            maneuver += j;
                            break;
                        }
                    }
                    luautils::OnUpdateAttachment(PAutomaton, PAttachment, PChar->StatusEffectContainer->GetEffectsCount(static_cast<EFFECT>(maneuver)));
                }
            }
        }
    }
}

void PreLevelRestriction(const CCharEntity* PChar)
{
    auto* PAutomaton = dynamic_cast<CAutomatonEntity*>(PChar->PPet);
    if (PAutomaton)
    {
        for (int i = 0; i < 12; i++)
        {
            uint8 attachment = PAutomaton->getAttachment(i);

            if (attachment != 0)
            {
                const auto* PAttachment = xi::items::lookup<CItemPuppet>(0x2100 + attachment);

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

void PostLevelRestriction(const CCharEntity* PChar)
{
    auto* PAutomaton = dynamic_cast<CAutomatonEntity*>(PChar->PPet);
    if (PAutomaton)
    {
        for (int i = 0; i < 12; i++)
        {
            const uint8 attachment = PAutomaton->getAttachment(i);
            if (attachment != 0)
            {
                auto* PAttachment = xi::items::lookup<CItemPuppet>(0x2100 + attachment);
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
