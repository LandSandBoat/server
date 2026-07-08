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
#include "common/timer.h"
#include "common/utils.h"
#include "enums/packet_s2c.h"
#include "lua/helpers/lua_client_entity_pair_entities.h"
#include "lua/helpers/lua_client_entity_pair_events.h"
#include "lua/helpers/lua_client_entity_pair_packets.h"
#include "lua/lua_client_entity_pair.h"
#include "lua/lua_simulation.h"
#include "map/ability.h"
#include "map/ai/controllers/player_controller.h"
#include "map/entities/char_entity.h"
#include "map/enums/party_kind.h"
#include "map/item_container.h"
#include "map/items/item.h"
#include "map/lua/lua_base_entity.h"
#include "map/packets/c2s/0x01a_action.h"
#include "map/packets/c2s/0x028_item_dump.h"
#include "map/packets/c2s/0x029_item_move.h"
#include "map/packets/c2s/0x032_trade_req.h"
#include "map/packets/c2s/0x033_trade_res.h"
#include "map/packets/c2s/0x034_trade_list.h"
#include "map/packets/c2s/0x036_item_transfer.h"
#include "map/packets/c2s/0x037_item_use.h"
#include "map/packets/c2s/0x03a_item_stack.h"
#include "map/packets/c2s/0x053_lockstyle.h"
#include "map/packets/c2s/0x06e_group_solicit_req.h"
#include "map/packets/c2s/0x074_group_solicit_res.h"
#include "map/packets/c2s/0x096_combine_ask.h"
#include "map/packets/c2s/0x0aa_guild_buy.h"
#include "map/packets/c2s/0x0ab_guild_buylist.h"
#include "map/packets/c2s/0x0ac_guild_sell.h"
#include "map/packets/c2s/0x0ad_guild_selllist.h"
#include "map/packets/c2s/0x0fa_myroom_layout.h"
#include "map/packets/c2s/0x0fc_myroom_plant_add.h"
#include "map/packets/c2s/0x0fd_myroom_plant_check.h"
#include "map/packets/c2s/0x0fe_myroom_plant_crop.h"
#include "map/packets/c2s/0x0ff_myroom_plant_stop.h"
#include "map/packets/c2s/0x102_extended_job.h"
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
    const auto packet    = parent_->packets().createPacket<GP_CLI_COMMAND_POS>();
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

    const auto packet               = parent_->packets().createPacket<GP_CLI_COMMAND_ACTION>();
    auto*      actionPacket         = packet->as<GP_CLI_COMMAND_ACTION>();
    actionPacket->UniqueNo          = target->getID();
    actionPacket->ActIndex          = target->getTargID();
    actionPacket->ActionID          = GP_CLI_COMMAND_ACTION_ACTIONID::CastMagic;
    actionPacket->CastMagic.SpellId = static_cast<uint32_t>(spellId);

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: setBlueSpells()
 *  Purpose : Populates the player's BLU spell page from a list of spell IDs.
 *  Example : player.actions:setBlueSpells({ xi.magic.spell.HEAVY_STRIKE })
 ************************************************************************/

void CLuaClientEntityPairActions::setBlueSpells(const sol::table& spellIds) const
{
    uint8 slot = 0;

    for (auto& kv : spellIds)
    {
        if (slot >= 20)
        {
            break;
        }

        const auto spellId                   = kv.second.as<uint16>();
        const auto offsettedId               = static_cast<uint8>(spellId - 0x200);
        const auto packet                    = parent_->packets().createPacket<GP_CLI_COMMAND_EXTENDED_JOB>();
        auto*      bluPacket                 = packet->as<GP_CLI_COMMAND_EXTENDED_JOB>();
        bluPacket->Data.bluData.JobIndex     = JOB_BLU;
        bluPacket->Data.bluData.SpellId      = offsettedId;
        bluPacket->Data.bluData.Spells[slot] = offsettedId;

        parent_->packets().sendBasicPacket(*packet);
        ++slot;
    }
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

    const auto packet                 = parent_->packets().createPacket<GP_CLI_COMMAND_ACTION>();
    auto*      actionPacket           = packet->as<GP_CLI_COMMAND_ACTION>();
    actionPacket->UniqueNo            = target->getID();
    actionPacket->ActIndex            = target->getTargID();
    actionPacket->ActionID            = GP_CLI_COMMAND_ACTION_ACTIONID::Weaponskill;
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

    const auto packet                = parent_->packets().createPacket<GP_CLI_COMMAND_ACTION>();
    auto*      actionPacket          = packet->as<GP_CLI_COMMAND_ACTION>();
    actionPacket->UniqueNo           = target->getID();
    actionPacket->ActIndex           = target->getTargID();
    actionPacket->ActionID           = GP_CLI_COMMAND_ACTION_ACTIONID::JobAbility;
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

    const auto packet       = parent_->packets().createPacket<GP_CLI_COMMAND_ACTION>();
    auto*      actionPacket = packet->as<GP_CLI_COMMAND_ACTION>();
    actionPacket->UniqueNo  = target->getID();
    actionPacket->ActIndex  = target->getTargID();
    actionPacket->ActionID  = GP_CLI_COMMAND_ACTION_ACTIONID::ChangeTarget;

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

    const auto packet       = parent_->packets().createPacket<GP_CLI_COMMAND_ACTION>();
    auto*      actionPacket = packet->as<GP_CLI_COMMAND_ACTION>();
    actionPacket->UniqueNo  = target->getID();
    actionPacket->ActIndex  = target->getTargID();
    actionPacket->ActionID  = GP_CLI_COMMAND_ACTION_ACTIONID::Shoot;

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

    const auto packet             = parent_->packets().createPacket<GP_CLI_COMMAND_ITEM_USE>();
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

    const auto packet       = parent_->packets().createPacket<GP_CLI_COMMAND_ACTION>();
    auto*      actionPacket = packet->as<GP_CLI_COMMAND_ACTION>();
    actionPacket->UniqueNo  = target->getID();
    actionPacket->ActIndex  = target->getTargID();
    actionPacket->ActionID  = GP_CLI_COMMAND_ACTION_ACTIONID::Talk;

    parent_->packets().sendBasicPacket(*packet);
    if (expectedEvent.has_value())
    {
        parent_->events().expect(expectedEvent.value());
    }
}

/************************************************************************
 *  Function: guildBuy()
 *  Purpose : Emits packet to buy an item from a guild shop.
 *  Example : player.actions:guildBuy(xi.item.CHUNK_OF_TIN_ORE, 1)
 ************************************************************************/

void CLuaClientEntityPairActions::guildBuy(uint16 itemId, uint8 quantity) const
{
    const auto packet      = parent_->packets().createPacket<GP_CLI_COMMAND_GUILD_BUY>();
    auto*      buy         = packet->as<GP_CLI_COMMAND_GUILD_BUY>();
    buy->ItemNo            = itemId;
    buy->PropertyItemIndex = 0;
    buy->ItemNum           = quantity;

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: guildSell()
 *  Purpose : Emits packet to sell an item to a guild shop.
 *  Example : player.actions:guildSell(xi.item.CHUNK_OF_TIN_ORE, 1)
 ************************************************************************/

void CLuaClientEntityPairActions::guildSell(uint16 itemId, uint8 quantity) const
{
    const auto packet       = parent_->packets().createPacket<GP_CLI_COMMAND_GUILD_SELL>();
    auto*      sell         = packet->as<GP_CLI_COMMAND_GUILD_SELL>();
    sell->ItemNo            = itemId;
    sell->PropertyItemIndex = 0;
    sell->ItemNum           = quantity;

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: guildBuyList()
 *  Purpose : Requests a guild shop's buy list and returns it decoded
 *  Example : local list = player.actions:guildBuyList()
 ************************************************************************/

auto CLuaClientEntityPairActions::guildBuyList() const -> sol::table
{
    parent_->packets().clear();

    const auto packet = parent_->packets().createPacket<GP_CLI_COMMAND_GUILD_BUYLIST>();
    parent_->packets().sendBasicPacket(*packet);

    return parent_->packets().guildList(static_cast<uint16>(PacketS2C::GP_SERV_COMMAND_GUILD_BUYLIST));
}

/************************************************************************
 *  Function: guildSellList()
 *  Purpose : Requests a guild shop's sell list and returns it decoded
 *  Example : local list = player.actions:guildSellList()
 ************************************************************************/

auto CLuaClientEntityPairActions::guildSellList() const -> sol::table
{
    parent_->packets().clear();

    const auto packet = parent_->packets().createPacket<GP_CLI_COMMAND_GUILD_SELLLIST>();
    parent_->packets().sendBasicPacket(*packet);

    return parent_->packets().guildList(static_cast<uint16>(PacketS2C::GP_SERV_COMMAND_GUILD_SELLLIST));
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

    const auto packet       = parent_->packets().createPacket<GP_CLI_COMMAND_GROUP_SOLICIT_REQ>();
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

    const auto packet       = parent_->packets().createPacket<GP_CLI_COMMAND_GROUP_SOLICIT_REQ>();
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
    const auto packet         = parent_->packets().createPacket<GP_CLI_COMMAND_GROUP_SOLICIT_RES>();
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

    const auto packet      = parent_->packets().createPacket<GP_CLI_COMMAND_ITEM_TRANSFER>();
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
 *  Function: tradeRequest()
 *  Purpose : Request a trade with another player.
 *  Example : p1.actions:tradeRequest(p2)
 ************************************************************************/

void CLuaClientEntityPairActions::tradeRequest(CLuaBaseEntity* target) const
{
    if (!target)
    {
        TestError("tradeRequest: Invalid target");
        return;
    }

    const auto packet = parent_->packets().createPacket<GP_CLI_COMMAND_TRADE_REQ>();
    auto*      data   = packet->as<GP_CLI_COMMAND_TRADE_REQ>();
    data->UniqueNo    = target->getID();
    data->ActIndex    = target->getTargID();

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: tradeAccept()
 *  Purpose : Accept the incoming trade request.
 *  Example : p2.actions:tradeAccept()
 ************************************************************************/

void CLuaClientEntityPairActions::tradeAccept() const
{
    const auto packet = parent_->packets().createPacket<GP_CLI_COMMAND_TRADE_RES>();
    auto*      data   = packet->as<GP_CLI_COMMAND_TRADE_RES>();
    data->Kind        = static_cast<uint32_t>(GP_CLI_COMMAND_TRADE_RES_KIND::Start);

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: tradeOffer()
 *  Purpose : Place an item in a trade slot.
 *  Example : p1.actions:tradeOffer(0, invSlot, itemId, qty)
 ************************************************************************/

void CLuaClientEntityPairActions::tradeOffer(uint8 tradeIndex, uint8 invSlot, uint16 itemId, uint32 quantity) const
{
    const auto packet = parent_->packets().createPacket<GP_CLI_COMMAND_TRADE_LIST>();
    auto*      data   = packet->as<GP_CLI_COMMAND_TRADE_LIST>();
    data->TradeIndex  = tradeIndex;
    data->ItemIndex   = invSlot;
    data->ItemNo      = itemId;
    data->ItemNum     = quantity;

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: tradeClearSlot()
 *  Purpose : Clear a trade slot.
 *  Example : p1.actions:tradeClearSlot(0)
 ************************************************************************/

void CLuaClientEntityPairActions::tradeClearSlot(uint8 tradeIndex) const
{
    const auto packet = parent_->packets().createPacket<GP_CLI_COMMAND_TRADE_LIST>();
    auto*      data   = packet->as<GP_CLI_COMMAND_TRADE_LIST>();
    data->TradeIndex  = tradeIndex;
    data->ItemIndex   = 0;
    data->ItemNo      = 0;
    data->ItemNum     = 0;

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: tradeMake()
 *  Purpose : Lock in this side's offer. Trade goes through once both sides lock.
 ************************************************************************/

void CLuaClientEntityPairActions::tradeMake() const
{
    const auto packet = parent_->packets().createPacket<GP_CLI_COMMAND_TRADE_RES>();
    auto*      data   = packet->as<GP_CLI_COMMAND_TRADE_RES>();
    data->Kind        = static_cast<uint32_t>(GP_CLI_COMMAND_TRADE_RES_KIND::Make);

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: tradeCancel()
 *  Purpose : Cancel the trade.
 ************************************************************************/

void CLuaClientEntityPairActions::tradeCancel() const
{
    const auto packet = parent_->packets().createPacket<GP_CLI_COMMAND_TRADE_RES>();
    auto*      data   = packet->as<GP_CLI_COMMAND_TRADE_RES>();
    data->Kind        = static_cast<uint32_t>(GP_CLI_COMMAND_TRADE_RES_KIND::Cancell);

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: acceptRaise()
 *  Purpose : Emits packet to accept a pending raise prompt.
 *  Example : player.actions:acceptRaise()
 *  Notes   :
 ************************************************************************/

void CLuaClientEntityPairActions::acceptRaise() const
{
    const auto packet                      = parent_->packets().createPacket<GP_CLI_COMMAND_ACTION>();
    auto*      responsePacket              = packet->as<GP_CLI_COMMAND_ACTION>();
    responsePacket->ActionID               = GP_CLI_COMMAND_ACTION_ACTIONID::RaiseMenu;
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
    const auto packet       = parent_->packets().createPacket<GP_CLI_COMMAND_ACTION>();
    auto*      attackPacket = packet->as<GP_CLI_COMMAND_ACTION>();
    attackPacket->UniqueNo  = mob->getID();
    attackPacket->ActIndex  = mob->getTargID();
    attackPacket->ActionID  = GP_CLI_COMMAND_ACTION_ACTIONID::Attack;

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
            if (!PMob->StatusEffectContainer->GetStatusEffect(xi::StatusEffect::Skillchain, 0))
            {
                TestError("Skillchain effect not found after weaponskill #{}", i + 1);
            }
        }

        if (i < wsIds.size() - 1)
        {
            parent_->simulation()->skipTime(3);

            // Backdate skillchain effect to bypass 3s timing window for next WS
            if (auto* scEffect = PMob->StatusEffectContainer->GetStatusEffect(xi::StatusEffect::Skillchain, 0))
            {
                scEffect->SetStartTime(timer::now() - 5s);
            }
        }
    }
}

void CLuaClientEntityPairActions::moveItem(const uint8 srcContainer, const uint8 srcSlot, const uint8 dstContainer, const uint32 quantity, const sol::optional<uint8> dstSlot) const
{
    const auto packet = parent_->packets().createPacket<GP_CLI_COMMAND_ITEM_MOVE>();
    auto*      p      = packet->as<GP_CLI_COMMAND_ITEM_MOVE>();
    p->ItemNum        = quantity;
    p->Category1      = srcContainer;
    p->Category2      = dstContainer;
    p->ItemIndex1     = srcSlot;
    p->ItemIndex2     = dstSlot.value_or(0xFF);

    parent_->packets().sendBasicPacket(*packet);
}

void CLuaClientEntityPairActions::sortContainer(const uint8 container) const
{
    const auto packet = parent_->packets().createPacket<GP_CLI_COMMAND_ITEM_STACK>();
    auto*      p      = packet->as<GP_CLI_COMMAND_ITEM_STACK>();
    p->Category       = container;

    parent_->packets().sendBasicPacket(*packet);
}

void CLuaClientEntityPairActions::dropItem(const uint8 container, const uint8 slot, const uint32 quantity) const
{
    const auto packet = parent_->packets().createPacket<GP_CLI_COMMAND_ITEM_DUMP>();
    auto*      p      = packet->as<GP_CLI_COMMAND_ITEM_DUMP>();
    p->ItemNum        = quantity;
    p->Category       = container;
    p->ItemIndex      = slot;

    parent_->packets().sendBasicPacket(*packet);
}

void CLuaClientEntityPairActions::setLockstyle(const uint8 mode, sol::optional<sol::table> items) const
{
    const auto packet = parent_->packets().createPacket<GP_CLI_COMMAND_LOCKSTYLE>();
    auto*      p      = packet->as<GP_CLI_COMMAND_LOCKSTYLE>();
    p->Mode           = mode;
    p->Count          = 0;

    if (items.has_value())
    {
        uint8 idx = 0;
        for (const auto& [key, val] : items.value())
        {
            if (!val.is<sol::table>() || idx >= 16)
            {
                break;
            }

            auto entry              = val.as<sol::table>();
            p->Items[idx].ItemNo    = entry.get_or<uint16_t>("itemId", 0);
            p->Items[idx].EquipKind = entry.get_or<uint8_t>("slot", 0);
            p->Items[idx].ItemIndex = 0;
            p->Items[idx].Category  = 0;
            ++idx;
        }
        p->Count = idx;
    }

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: craft()
 *  Purpose : Emits packet to start a synthesis with the given crystal +
 *            ingredient item IDs (looked up in the player's inventory).
 *  Example : player.actions:craft(xi.item.FIRE_CRYSTAL, { xi.item.SAND, xi.item.SAND })
 *  Notes   : Tick time forward to complete the synth.
 ************************************************************************/

void CLuaClientEntityPairActions::craft(const uint16 crystalItemId, const sol::table& ingredients) const
{
    const auto crystalSlot = parent_->getItemInvSlot(crystalItemId, 1);
    if (!crystalSlot.has_value())
    {
        TestError("craft: crystal {} not in inventory", crystalItemId);
        return;
    }

    const size_t ingredientCount = ingredients.size();
    if (ingredientCount == 0 || ingredientCount > 8)
    {
        TestError("craft: ingredient count must be 1..8 (got {})", ingredientCount);
        return;
    }

    const auto packet = parent_->packets().createPacket<GP_CLI_COMMAND_COMBINE_ASK>();
    auto*      p      = packet->as<GP_CLI_COMMAND_COMBINE_ASK>();
    p->Crystal        = crystalItemId;
    p->CrystalIdx     = crystalSlot.value();
    p->Items          = static_cast<uint8>(ingredientCount);

    uint8 idx = 0;
    for (const auto& [_key, val] : ingredients)
    {
        if (idx >= 8 || !val.is<uint16>())
        {
            break;
        }

        const uint16 ingredientId = val.as<uint16>();
        const auto   invSlot      = parent_->getItemInvSlot(ingredientId, 1);
        if (!invSlot.has_value())
        {
            TestError("craft: ingredient {} not in inventory", ingredientId);
            return;
        }

        p->ItemNo[idx]  = ingredientId;
        p->TableNo[idx] = invSlot.value();
        ++idx;
    }

    parent_->packets().sendBasicPacket(*packet);
}

namespace
{

auto storageItemNo(CCharEntity* PChar, const uint8 container, const uint8 slot) -> uint16
{
    CItemContainer* PContainer = PChar->getStorage(container);
    CItem*          PItem      = PContainer ? PContainer->GetItem(slot) : nullptr;

    return PItem ? PItem->getID() : 0;
}

} // namespace

/************************************************************************
 *  Function: plantAdd()
 *  Purpose : Sow a seed or feed a crystal into a gardening pot.
 *  Notes   : Pot and add item must both be in a mog safe.
 ************************************************************************/

void CLuaClientEntityPairActions::plantAdd(const uint8 potContainer, const uint8 potSlot, const uint8 addContainer, const uint8 addSlot) const
{
    auto* PChar = parent_->testChar()->entity();

    const auto packet       = parent_->packets().createPacket<GP_CLI_COMMAND_MYROOM_PLANT_ADD>();
    auto*      p            = packet->as<GP_CLI_COMMAND_MYROOM_PLANT_ADD>();
    p->MyroomPlantItemNo    = storageItemNo(PChar, potContainer, potSlot);
    p->MyroomAddItemNo      = storageItemNo(PChar, addContainer, addSlot);
    p->MyroomPlantItemIndex = potSlot;
    p->MyroomAddItemIndex   = addSlot;
    p->MyroomPlantCategory  = potContainer;
    p->MyroomAddCategory    = addContainer;

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: plantCheck()
 *  Purpose : Examine a plant, resetting its wilt timer.
 ************************************************************************/

void CLuaClientEntityPairActions::plantCheck(const uint8 potContainer, const uint8 potSlot) const
{
    auto* PChar = parent_->testChar()->entity();

    const auto packet       = parent_->packets().createPacket<GP_CLI_COMMAND_MYROOM_PLANT_CHECK>();
    auto*      p            = packet->as<GP_CLI_COMMAND_MYROOM_PLANT_CHECK>();
    p->MyroomPlantItemNo    = storageItemNo(PChar, potContainer, potSlot);
    p->MyroomPlantItemIndex = potSlot;
    p->MyroomPlantCategory  = potContainer;

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: plantHarvest()
 *  Purpose : Harvest a mature plant; uproot clears the pot instead.
 ************************************************************************/

void CLuaClientEntityPairActions::plantHarvest(const uint8 potContainer, const uint8 potSlot, const sol::optional<bool> uproot) const
{
    auto* PChar = parent_->testChar()->entity();

    const auto packet       = parent_->packets().createPacket<GP_CLI_COMMAND_MYROOM_PLANT_CROP>();
    auto*      p            = packet->as<GP_CLI_COMMAND_MYROOM_PLANT_CROP>();
    p->MyroomPlantItemNo    = storageItemNo(PChar, potContainer, potSlot);
    p->MyroomPlantItemIndex = potSlot;
    p->MyroomPlantCategory  = potContainer;
    p->CancellFlg           = uproot.value_or(false) ? 1 : 0;

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: plantDry()
 *  Purpose : Dry a plant so it stops growing and won't wilt.
 ************************************************************************/

void CLuaClientEntityPairActions::plantDry(const uint8 potContainer, const uint8 potSlot) const
{
    auto* PChar = parent_->testChar()->entity();

    const auto packet       = parent_->packets().createPacket<GP_CLI_COMMAND_MYROOM_PLANT_STOP>();
    auto*      p            = packet->as<GP_CLI_COMMAND_MYROOM_PLANT_STOP>();
    p->MyroomPlantItemNo    = storageItemNo(PChar, potContainer, potSlot);
    p->MyroomPlantItemIndex = potSlot;
    p->MyroomPlantCategory  = potContainer;

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: placeFurniture()
 *  Purpose : Install a furnishing on the 1st floor at grid cell (x, z).
 *  Example : player.actions:placeFurniture(xi.inv.MOGSAFE, slot, 0, 0)
 ************************************************************************/

void CLuaClientEntityPairActions::placeFurniture(const uint8 container, const uint8 slot, const uint8 x, const uint8 z) const
{
    auto* PChar = parent_->testChar()->entity();

    const auto packet  = parent_->packets().createPacket<GP_CLI_COMMAND_MYROOM_LAYOUT>();
    auto*      p       = packet->as<GP_CLI_COMMAND_MYROOM_LAYOUT>();
    p->MyroomItemNo    = storageItemNo(PChar, container, slot);
    p->MyroomItemIndex = slot;
    p->MyroomCategory  = container;
    p->MyroomFloorFlg  = 0;
    p->x               = x;
    p->z               = z;
    p->y               = 0;
    p->v               = 0;

    parent_->packets().sendBasicPacket(*packet);
}

/************************************************************************
 *  Function: finishFurnishing()
 *  Purpose : Finish placing furniture; recomputes the active moghancement.
 *  Example : player.actions:finishFurnishing()
 ************************************************************************/

void CLuaClientEntityPairActions::finishFurnishing() const
{
    const auto packet = parent_->packets().createPacket<GP_CLI_COMMAND_MYROOM_LAYOUT>();
    auto*      p      = packet->as<GP_CLI_COMMAND_MYROOM_LAYOUT>();
    p->MyroomItemNo   = 0;

    parent_->packets().sendBasicPacket(*packet);
}

void CLuaClientEntityPairActions::Register()
{
    SOL_USERTYPE("CClientEntityPairActions", CLuaClientEntityPairActions);
    SOL_REGISTER("move", CLuaClientEntityPairActions::move);
    SOL_REGISTER("useSpell", CLuaClientEntityPairActions::useSpell);
    SOL_REGISTER("setBlueSpells", CLuaClientEntityPairActions::setBlueSpells);
    SOL_REGISTER("useWeaponskill", CLuaClientEntityPairActions::useWeaponskill);
    SOL_REGISTER("useAbility", CLuaClientEntityPairActions::useAbility);
    SOL_REGISTER("changeTarget", CLuaClientEntityPairActions::changeTarget);
    SOL_REGISTER("rangedAttack", CLuaClientEntityPairActions::rangedAttack);
    SOL_REGISTER("useItem", CLuaClientEntityPairActions::useItem);
    SOL_REGISTER("trigger", CLuaClientEntityPairActions::trigger);
    SOL_REGISTER("guildBuy", CLuaClientEntityPairActions::guildBuy);
    SOL_REGISTER("guildSell", CLuaClientEntityPairActions::guildSell);
    SOL_REGISTER("guildBuyList", CLuaClientEntityPairActions::guildBuyList);
    SOL_REGISTER("guildSellList", CLuaClientEntityPairActions::guildSellList);
    SOL_REGISTER("inviteToParty", CLuaClientEntityPairActions::inviteToParty);
    SOL_REGISTER("formAlliance", CLuaClientEntityPairActions::formAlliance);
    SOL_REGISTER("acceptPartyInvite", CLuaClientEntityPairActions::acceptPartyInvite);
    SOL_REGISTER("tradeNpc", CLuaClientEntityPairActions::tradeNpc);
    SOL_REGISTER("tradeRequest", CLuaClientEntityPairActions::tradeRequest);
    SOL_REGISTER("tradeAccept", CLuaClientEntityPairActions::tradeAccept);
    SOL_REGISTER("tradeOffer", CLuaClientEntityPairActions::tradeOffer);
    SOL_REGISTER("tradeClearSlot", CLuaClientEntityPairActions::tradeClearSlot);
    SOL_REGISTER("tradeMake", CLuaClientEntityPairActions::tradeMake);
    SOL_REGISTER("tradeCancel", CLuaClientEntityPairActions::tradeCancel);
    SOL_REGISTER("acceptRaise", CLuaClientEntityPairActions::acceptRaise);
    SOL_REGISTER("engage", CLuaClientEntityPairActions::engage);
    SOL_REGISTER("skillchain", CLuaClientEntityPairActions::skillchain);
    SOL_REGISTER("moveItem", CLuaClientEntityPairActions::moveItem);
    SOL_REGISTER("sortContainer", CLuaClientEntityPairActions::sortContainer);
    SOL_REGISTER("dropItem", CLuaClientEntityPairActions::dropItem);
    SOL_REGISTER("setLockstyle", CLuaClientEntityPairActions::setLockstyle);
    SOL_REGISTER("craft", CLuaClientEntityPairActions::craft);
    SOL_REGISTER("plantAdd", CLuaClientEntityPairActions::plantAdd);
    SOL_REGISTER("plantCheck", CLuaClientEntityPairActions::plantCheck);
    SOL_REGISTER("plantHarvest", CLuaClientEntityPairActions::plantHarvest);
    SOL_REGISTER("plantDry", CLuaClientEntityPairActions::plantDry);
    SOL_REGISTER("placeFurniture", CLuaClientEntityPairActions::placeFurniture);
    SOL_REGISTER("finishFurnishing", CLuaClientEntityPairActions::finishFurnishing);
}
