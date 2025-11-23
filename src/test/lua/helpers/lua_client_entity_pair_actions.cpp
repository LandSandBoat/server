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

#include "lua/helpers/lua_client_entity_pair_actions.h"

#include "ai/ai_container.h"
#include "common/logging.h"
#include "common/timer.h"
#include "common/utils.h"
#include "enums/packet_c2s.h"
#include "lua/helpers/lua_client_entity_pair_entities.h"
#include "lua/helpers/lua_client_entity_pair_events.h"
#include "lua/helpers/lua_client_entity_pair_packets.h"
#include "lua/lua_client_entity_pair.h"
#include "lua/lua_simulation.h"
#include "lua/lua_spy.h"
#include "map/ability.h"
#include "map/ai/controllers/player_controller.h"
#include "map/enums/party_kind.h"
#include "map/lua/lua_baseentity.h"
#include "map/packets/c2s/0x01a_action.h"
#include "map/packets/c2s/0x036_item_transfer.h"
#include "map/packets/c2s/0x037_item_use.h"
#include "map/packets/c2s/0x06e_group_solicit_req.h"
#include "map/packets/c2s/0x074_group_solicit_res.h"
#include "map/spell.h"
#include "map/status_effect_container.h"
#include "packets/c2s/0x015_pos.h"
#include "test_char.h"
#include "test_common.h"

CLuaClientEntityPairActions::CLuaClientEntityPairActions(CLuaClientEntityPair* parent)
: parent_(parent)
{
}

/************************************************************************
 *  Function: move()
 *  Purpose : Emits packet to move the character.
 *  Example : player.actions:move(10, 10, 10)
 *  Notes   :
 ************************************************************************/

void CLuaClientEntityPairActions::move(const float x, const float y, const float z, sol::optional<uint8_t> rot) const
{
    const auto packet    = parent_->packets().createPacket(PacketC2S::GP_CLI_COMMAND_POS);
    auto*      posPacket = packet->as<GP_CLI_COMMAND_POS>();
    posPacket->x         = x;
    posPacket->z         = y;
    posPacket->y         = z;
    posPacket->dir       = rot.value_or(0);

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: useSpell()
 *  Purpose : Emits packet to use a spell on a target.
 *  Example : player.actions:useSpell(mob, xi.magic.spell.STONE)
 *  Notes   : This only starts the cast, you must skip time forward and tick to complete it.
 ************************************************************************/

void CLuaClientEntityPairActions::useSpell(CLuaBaseEntity* target, const SpellID spellId) const
{
    if (!target)
    {
        TestError("useSpell: Invalid target");
        return;
    }

    const auto packet               = parent_->packets().createPacket(PacketC2S::GP_CLI_COMMAND_ACTION);
    auto*      actionPacket         = packet->as<GP_CLI_COMMAND_ACTION>();
    actionPacket->UniqueNo          = target->getID();
    actionPacket->ActIndex          = target->getTargID();
    actionPacket->ActionID          = static_cast<uint16>(GP_CLI_COMMAND_ACTION_ACTIONID::CastMagic);
    actionPacket->CastMagic.SpellId = static_cast<uint32_t>(spellId);

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: useWeaponskill()
 *  Purpose : Emits packet to use a weaponskill on a target.
 *  Example : player.actions:useWeaponskill(mob, xi.ws.TACHI_KOKI)
 *  Notes   :
 ************************************************************************/

void CLuaClientEntityPairActions::useWeaponskill(CLuaBaseEntity* target, const uint16 wsId) const
{
    if (!target)
    {
        TestError("useWeaponskill: Invalid target");
        return;
    }

    const auto packet                 = parent_->packets().createPacket(PacketC2S::GP_CLI_COMMAND_ACTION);
    auto*      actionPacket           = packet->as<GP_CLI_COMMAND_ACTION>();
    actionPacket->UniqueNo            = target->getID();
    actionPacket->ActIndex            = target->getTargID();
    actionPacket->ActionID            = static_cast<uint16>(GP_CLI_COMMAND_ACTION_ACTIONID::Weaponskill);
    actionPacket->Weaponskill.SkillId = wsId;

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: useAbility()
 *  Purpose : Emits packet to use an ability on a target.
 *  Example : player.actions:useAbility(player, xi.ability.BERSERK)
 *  Notes   :
 ************************************************************************/

void CLuaClientEntityPairActions::useAbility(CLuaBaseEntity* target, const ABILITY abilityId) const
{
    if (!target)
    {
        TestError("useAbility: Invalid target");
        return;
    }

    const auto packet                = parent_->packets().createPacket(PacketC2S::GP_CLI_COMMAND_ACTION);
    auto*      actionPacket          = packet->as<GP_CLI_COMMAND_ACTION>();
    actionPacket->UniqueNo           = target->getID();
    actionPacket->ActIndex           = target->getTargID();
    actionPacket->ActionID           = static_cast<uint16>(GP_CLI_COMMAND_ACTION_ACTIONID::JobAbility);
    actionPacket->JobAbility.SkillId = abilityId;

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: changeTarget()
 *  Purpose : Emits packet to change target.
 *  Example : player.actions:changeTarget(newMob)
 *  Notes   :
 ************************************************************************/

void CLuaClientEntityPairActions::changeTarget(CLuaBaseEntity* target) const
{
    if (!target)
    {
        TestError("changeTarget: Invalid target");
        return;
    }

    const auto packet       = parent_->packets().createPacket(PacketC2S::GP_CLI_COMMAND_ACTION);
    auto*      actionPacket = packet->as<GP_CLI_COMMAND_ACTION>();
    actionPacket->UniqueNo  = target->getID();
    actionPacket->ActIndex  = target->getTargID();
    actionPacket->ActionID  = static_cast<uint16>(GP_CLI_COMMAND_ACTION_ACTIONID::ChangeTarget);

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: rangedAttack()
 *  Purpose : Emits packet to range attack.
 *  Example : player.actions:rangedAttack(mob)
 *  Notes   : This only starts the attack, you must skip time forward and tick to complete it.
 ************************************************************************/

void CLuaClientEntityPairActions::rangedAttack(CLuaBaseEntity* target) const
{
    if (!target)
    {
        TestError("rangedAttack: Invalid target");
        return;
    }

    const auto packet       = parent_->packets().createPacket(PacketC2S::GP_CLI_COMMAND_ACTION);
    auto*      actionPacket = packet->as<GP_CLI_COMMAND_ACTION>();
    actionPacket->UniqueNo  = target->getID();
    actionPacket->ActIndex  = target->getTargID();
    actionPacket->ActionID  = static_cast<uint16>(GP_CLI_COMMAND_ACTION_ACTIONID::Shoot);

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: useItem()
 *  Purpose : Emits packet to use an item.
 *  Example : player.actions:useItem(player, 5, xi.inv.INVENTORY) -- uses item in slot 5 of inventory on self
 *  Notes   : This only starts the item use, you must skip time forward and tick to complete it.
 ************************************************************************/

void CLuaClientEntityPairActions::useItem(CLuaBaseEntity* target, const uint8 slotId, const sol::optional<uint8> storageId) const
{
    if (!target)
    {
        TestError("useItem: Invalid target");
        return;
    }

    const auto packet             = parent_->packets().createPacket(PacketC2S::GP_CLI_COMMAND_ITEM_USE);
    auto*      itemPacket         = packet->as<GP_CLI_COMMAND_ITEM_USE>();
    itemPacket->UniqueNo          = target->getID();
    itemPacket->ItemNum           = 0;
    itemPacket->ActIndex          = target->getTargID();
    itemPacket->PropertyItemIndex = slotId;
    itemPacket->Category          = storageId.value_or(0);

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: trigger()
 *  Purpose : Emits packet to trigger a NPC.
 *  Example : player.actions:trigger(npc)
 *  Notes   : Can optionally expect a specific event to be triggered.
 ************************************************************************/

void CLuaClientEntityPairActions::trigger(CLuaBaseEntity* target, sol::optional<sol::table> expectedEvent) const
{
    if (!target)
    {
        TestError("trigger: Invalid target");
        return;
    }

    const auto packet       = parent_->packets().createPacket(PacketC2S::GP_CLI_COMMAND_ACTION);
    auto*      actionPacket = packet->as<GP_CLI_COMMAND_ACTION>();
    actionPacket->UniqueNo  = target->getID();
    actionPacket->ActIndex  = target->getTargID();
    actionPacket->ActionID  = static_cast<uint16>(GP_CLI_COMMAND_ACTION_ACTIONID::Talk);

    parent_->packets().sendBasicPacket(*packet);
    if (expectedEvent.has_value())
    {
        parent_->events().expect(expectedEvent.value());
    }
}

/************************************************************************
 *  Function: inviteToParty()
 *  Purpose : Emits packet to invite a PC.
 *  Example : player.actions:inviteToParty(player2)
 *  Notes   :
 ************************************************************************/

void CLuaClientEntityPairActions::inviteToParty(CLuaBaseEntity* player) const
{
    if (!player)
    {
        TestError("inviteToParty: Invalid player");
        return;
    }

    const auto packet       = parent_->packets().createPacket(PacketC2S::GP_CLI_COMMAND_GROUP_SOLICIT_REQ);
    auto*      invitePacket = packet->as<GP_CLI_COMMAND_GROUP_SOLICIT_REQ>();
    invitePacket->UniqueNo  = player->getID();
    invitePacket->ActIndex  = player->getTargID();
    invitePacket->Kind      = PartyKind::Party;

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: formAlliance()
 *  Purpose : Emits packet to form an alliance.
 *  Example : player.actions:formAlliance(player2)
 *  Notes   :
 ************************************************************************/

void CLuaClientEntityPairActions::formAlliance(CLuaBaseEntity* player) const
{
    if (!player)
    {
        TestError("formAlliance: Invalid player");
        return;
    }

    const auto packet       = parent_->packets().createPacket(PacketC2S::GP_CLI_COMMAND_GROUP_SOLICIT_REQ);
    auto*      invitePacket = packet->as<GP_CLI_COMMAND_GROUP_SOLICIT_REQ>();
    invitePacket->UniqueNo  = player->getID();
    invitePacket->ActIndex  = player->getTargID();
    invitePacket->Kind      = PartyKind::Alliance;

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: acceptPartyInvite()
 *  Purpose : Emits packet to accept a party invite.
 *  Example : player.actions:acceptPartyInvite()
 *  Notes   :
 ************************************************************************/

void CLuaClientEntityPairActions::acceptPartyInvite() const
{
    const auto packet         = parent_->packets().createPacket(PacketC2S::GP_CLI_COMMAND_GROUP_SOLICIT_RES);
    auto*      responsePacket = packet->as<GP_CLI_COMMAND_GROUP_SOLICIT_RES>();
    responsePacket->Res       = static_cast<uint8>(GP_CLI_COMMAND_GROUP_SOLICIT_RES_RES::Accept);

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: tradeNpc()
 *  Purpose : Emits packet to trade with a NPC.
 *  Example : player.actions:tradeNpc('Maat', { {itemId=1234, quantity=1}, 5678 }, { eventId=123 })
 *  Notes   : Can optionally expect a specific event to be triggered after trading.
 ************************************************************************/

void CLuaClientEntityPairActions::tradeNpc(const sol::object& npcQuery, const sol::table& items, sol::optional<sol::table> expectedEvent) const
{
    const auto entities = parent_->entities();
    auto       npc      = entities.moveTo(npcQuery);

    if (!npc.has_value())
    {
        TestError("Could not find or move to NPC for trading");
        return;
    }

    size_t itemCount = items.size();
    if (itemCount == 0)
    {
        TestError("Number of items in trade is 0");
        return;
    }

    if (itemCount > 9)
    {
        TestError("Too many items in trade: {} (max 9)", itemCount);
        return;
    }

    const auto packet      = parent_->packets().createPacket(PacketC2S::GP_CLI_COMMAND_ITEM_TRANSFER);
    auto*      tradePacket = packet->as<GP_CLI_COMMAND_ITEM_TRANSFER>();

    tradePacket->UniqueNo = npc.value().getID();
    tradePacket->ActIndex = npc.value().getTargID();
    tradePacket->ItemNum  = static_cast<uint8_t>(itemCount);

    size_t idx = 0;
    for (const auto& pair : items)
    {
        if (idx >= 9)
        {
            break;
        }

        uint16 itemId   = 0;
        uint8  quantity = 1;

        if (pair.second.is<uint16>())
        {
            itemId = pair.second.as<uint16>();
        }
        else if (pair.second.is<sol::table>())
        {
            auto itemInfo = pair.second.as<sol::table>();
            itemId        = itemInfo["itemId"].get_or<uint16>(0);
            quantity      = itemInfo["quantity"].get_or<uint8>(1);
        }

        auto invSlot = parent_->getItemInvSlot(itemId, quantity);
        if (!invSlot.has_value())
        {
            TestError("Could not find item with ID {} in inventory with needed quantity.", itemId);
        }

        tradePacket->PropertyItemIndexTbl[idx] = invSlot.value();
        tradePacket->ItemNumTbl[idx]           = quantity;

        idx++;
    }

    parent_->packets().sendBasicPacket(*packet);

    if (expectedEvent.has_value())
    {
        parent_->events().expect(expectedEvent.value());
    }
}

/************************************************************************
 *  Function: acceptRaise()
 *  Purpose : Emits packet to accept a pending raise prompt.
 *  Example : player.actions:acceptRaise()
 *  Notes   :
 ************************************************************************/

void CLuaClientEntityPairActions::acceptRaise() const
{
    const auto packet                      = parent_->packets().createPacket(PacketC2S::GP_CLI_COMMAND_ACTION);
    auto*      responsePacket              = packet->as<GP_CLI_COMMAND_ACTION>();
    responsePacket->ActionID               = static_cast<uint8_t>(GP_CLI_COMMAND_ACTION_ACTIONID::RaiseMenu);
    responsePacket->HomepointMenu.StatusId = GP_CLI_COMMAND_ACTION_HOMEPOINTMENU::Accept;

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: engage()
 *  Purpose : Moves char in range of mob and engages it.
 *  Example : player.actions:engage(mob)
 *  Notes   : Will make both entities face each other.
 ************************************************************************/

void CLuaClientEntityPairActions::engage(CLuaBaseEntity* mob) const
{
    auto* PChar = parent_->testChar()->entity();
    auto* PMob  = mob->GetBaseEntity();

    // 1. Move the player next to the mob
    this->move(PMob->loc.p.x - 1.0f, PMob->loc.p.y, PMob->loc.p.z, std::nullopt);

    // 2. Make the player and the mob face each other
    PChar->loc.p.rotation = worldAngle(PChar->loc.p, PMob->loc.p);
    PMob->loc.p.rotation  = worldAngle(PMob->loc.p, PChar->loc.p);

    // 3. Change last attack time so we can engage immediately
    auto* controller = static_cast<CPlayerController*>(parent_->testChar()->entity()->PAI->GetController());
    controller->setLastAttackTime(timer::now() - 30s);

    // 4. Send packet to engage
    const auto packet       = parent_->packets().createPacket(PacketC2S::GP_CLI_COMMAND_ACTION);
    auto*      attackPacket = packet->as<GP_CLI_COMMAND_ACTION>();
    attackPacket->UniqueNo  = mob->getID();
    attackPacket->ActIndex  = mob->getTargID();
    attackPacket->ActionID  = static_cast<uint8_t>(GP_CLI_COMMAND_ACTION_ACTIONID::Attack);

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: skillchain()
 *  Purpose : Executes a sequence of weaponskills to create a skillchain.
 *  Example : player.actions:skillchain(mob, xi.weaponskill.TACHI_FUDO, xi.weaponskill.TACHI_FUDO)
 *  Notes   : Auto-engages target, sets TP, and bypasses timing by manipulating effect state.
 *            Supports multistep skillchains with 2+ weaponskills.
 ************************************************************************/

void CLuaClientEntityPairActions::skillchain(CLuaBaseEntity* target, sol::variadic_args weaponskillIds) const
{
    if (!target)
    {
        TestError("CLuaClientEntityPairActions::skillchain: Invalid target");
        return;
    }

    std::vector<uint16> wsIds;
    for (const auto& arg : weaponskillIds)
    {
        if (arg.is<uint16>())
        {
            wsIds.push_back(arg.as<uint16>());
        }
    }

    if (wsIds.size() < 2)
    {
        TestError("CLuaClientEntityPairActions::skillchain: Need at least 2 weaponskills");
        return;
    }

    auto*       PChar = parent_->testChar()->entity();
    const auto* PMob  = static_cast<CBattleEntity*>(target->GetBaseEntity());

    this->engage(target);

    for (size_t i = 0; i < wsIds.size(); ++i)
    {
        PChar->health.tp = 3000;

        PChar->PAI->Internal_WeaponSkill(PMob->targid, wsIds[i]);
        parent_->simulation()->skipTime(2);

        if (i >= 1)
        {
            if (!PMob->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN, 0))
            {
                TestError("Skillchain effect not found after weaponskill #{}", i + 1);
            }
        }

        if (i < wsIds.size() - 1)
        {
            parent_->simulation()->skipTime(3);

            // Backdate skillchain effect to bypass 3s timing window for next WS
            if (auto* scEffect = PMob->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN, 0))
            {
                scEffect->SetStartTime(timer::now() - 5s);
            }
        }
    }
}

void CLuaClientEntityPairActions::Register()
{
    SOL_USERTYPE("CClientEntityPairActions", CLuaClientEntityPairActions);
    SOL_REGISTER("move", CLuaClientEntityPairActions::move);
    SOL_REGISTER("useSpell", CLuaClientEntityPairActions::useSpell);
    SOL_REGISTER("useWeaponskill", CLuaClientEntityPairActions::useWeaponskill);
    SOL_REGISTER("useAbility", CLuaClientEntityPairActions::useAbility);
    SOL_REGISTER("changeTarget", CLuaClientEntityPairActions::changeTarget);
    SOL_REGISTER("rangedAttack", CLuaClientEntityPairActions::rangedAttack);
    SOL_REGISTER("useItem", CLuaClientEntityPairActions::useItem);
    SOL_REGISTER("trigger", CLuaClientEntityPairActions::trigger);
    SOL_REGISTER("inviteToParty", CLuaClientEntityPairActions::inviteToParty);
    SOL_REGISTER("formAlliance", CLuaClientEntityPairActions::formAlliance);
    SOL_REGISTER("acceptPartyInvite", CLuaClientEntityPairActions::acceptPartyInvite);
    SOL_REGISTER("tradeNpc", CLuaClientEntityPairActions::tradeNpc);
    SOL_REGISTER("acceptRaise", CLuaClientEntityPairActions::acceptRaise);
    SOL_REGISTER("engage", CLuaClientEntityPairActions::engage);
    SOL_REGISTER("skillchain", CLuaClientEntityPairActions::skillchain);
}
