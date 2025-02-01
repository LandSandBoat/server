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

#include <cmath>

#include "lua_baseentity.h"
#include "lua_battlefield.h"
#include "lua_instance.h"
#include "lua_item.h"
#include "lua_spell.h"
#include "lua_statuseffect.h"
#include "lua_trade_container.h"
#include "lua_zone.h"
#include "luautils.h"

#include "common/kernel.h"
#include "common/logging.h"
#include "common/timer.h"
#include "common/utils.h"

#include "ability.h"
#include "alliance.h"
#include "battlefield.h"
#include "daily_system.h"
#include "enmity_container.h"
#include "fishingcontest.h"
#include "guild.h"
#include "instance.h"
#include "item_container.h"
#include "latent_effect_container.h"
#include "linkshell.h"
#include "map.h"
#include "message.h"
#include "mob_modifier.h"
#include "mob_spell_container.h"
#include "mobskill.h"
#include "notoriety_container.h"
#include "recast_container.h"
#include "roe.h"
#include "spell.h"
#include "status_effect.h"
#include "status_effect_container.h"
#include "timetriggers.h"
#include "trade_container.h"
#include "transport.h"
#include "treasure_pool.h"
#include "weapon_skill.h"

#include "ai/ai_container.h"

#include "ai/states/ability_state.h"
#include "ai/states/attack_state.h"
#include "ai/states/death_state.h"
#include "ai/states/despawn_state.h"
#include "ai/states/inactive_state.h"
#include "ai/states/item_state.h"
#include "ai/states/magic_state.h"
#include "ai/states/mobskill_state.h"
#include "ai/states/petskill_state.h"
#include "ai/states/raise_state.h"
#include "ai/states/range_state.h"
#include "ai/states/respawn_state.h"
#include "ai/states/weaponskill_state.h"

#include "ai/controllers/mob_controller.h"
#include "ai/controllers/trust_controller.h"

#include "ai/helpers/gambits_container.h"

#include "entities/automatonentity.h"
#include "entities/charentity.h"
#include "entities/fellowentity.h"
#include "entities/mobentity.h"
#include "entities/npcentity.h"
#include "entities/petentity.h"
#include "entities/trustentity.h"

#include "packets/action.h"
#include "packets/auction_house.h"
#include "packets/change_music.h"
#include "packets/char.h"
#include "packets/char_abilities.h"
#include "packets/char_appearance.h"
#include "packets/char_emotion.h"
#include "packets/char_equip.h"
#include "packets/char_health.h"
#include "packets/char_job_extra.h"
#include "packets/char_jobs.h"
#include "packets/char_mounts.h"
#include "packets/char_recast.h"
#include "packets/char_skills.h"
#include "packets/char_spells.h"
#include "packets/char_stats.h"
#include "packets/char_sync.h"
#include "packets/char_update.h"
#include "packets/chat_message.h"
#include "packets/conquest_map.h"
#include "packets/entity_animation.h"
#include "packets/entity_enable_list.h"
#include "packets/entity_update.h"
#include "packets/entity_visual.h"
#include "packets/event.h"
#include "packets/event_string.h"
#include "packets/event_update.h"
#include "packets/event_update_string.h"
#include "packets/guild_menu.h"
#include "packets/guild_menu_buy.h"
#include "packets/independent_animation.h"
#include "packets/instance_entry.h"
#include "packets/inventory_assign.h"
#include "packets/inventory_finish.h"
#include "packets/inventory_item.h"
#include "packets/inventory_modify.h"
#include "packets/inventory_size.h"
#include "packets/key_items.h"
#include "packets/linkshell_equip.h"
#include "packets/menu_jobpoints.h"
#include "packets/menu_merit.h"
#include "packets/menu_mog.h"
#include "packets/menu_raisetractor.h"
#include "packets/message_basic.h"
#include "packets/message_combat.h"
#include "packets/message_name.h"
#include "packets/message_special.h"
#include "packets/message_standard.h"
#include "packets/message_system.h"
#include "packets/message_text.h"
#include "packets/monipulator1.h"
#include "packets/monipulator2.h"
#include "packets/objective_utility.h"
#include "packets/position.h"
#include "packets/quest_mission_log.h"
#include "packets/release.h"
#include "packets/roe_questlog.h"
#include "packets/server_ip.h"
#include "packets/shop_items.h"
#include "packets/shop_menu.h"
#include "packets/weather.h"

#include "utils/battleutils.h"
#include "utils/blueutils.h"
#include "utils/charutils.h"
#include "utils/dboxutils.h"
#include "utils/guildutils.h"
#include "utils/instanceutils.h"
#include "utils/itemutils.h"
#include "utils/jailutils.h"
#include "utils/mobutils.h"
#include "utils/petutils.h"
#include "utils/puppetutils.h"
#include "utils/trustutils.h"
#include "utils/zoneutils.h"

#include <magic_enum/magic_enum.hpp>

extern std::unordered_map<uint32, std::unordered_map<uint16, std::vector<std::pair<uint16, uint8>>>> PacketMods;

//======================================================//

CLuaBaseEntity::CLuaBaseEntity(CBaseEntity* PEntity)
: m_PBaseEntity(PEntity)
{
    if (PEntity == nullptr)
    {
        ShowError("CLuaBaseEntity created with nullptr instead of valid CBaseEntity*!");
    }
}

/************************************************************************
 *  Function: showText()
 *  Purpose : Displays dialogue for NPC
 *  Example : target:showText(mob, ID.text.YOU_DECIDED_TO_SHOW_UP) -- Fighting Maat
 *  Notes   : Mainly used for showing retail text specific to an NPC
 ************************************************************************/

void CLuaBaseEntity::showText(CLuaBaseEntity* mob, uint16 messageID, sol::object const& p0, sol::object const& p1, sol::object const& p2, sol::object const& p3)
{
    CBaseEntity* PBaseEntity = mob->GetBaseEntity();

    if (PBaseEntity->objtype == TYPE_NPC)
    {
        PBaseEntity->m_TargID       = m_PBaseEntity->targid;
        PBaseEntity->loc.p.rotation = worldAngle(PBaseEntity->loc.p, m_PBaseEntity->loc.p);

        PBaseEntity->loc.zone->UpdateEntityPacket(PBaseEntity, ENTITY_UPDATE, UPDATE_POS);
    }

    uint32 param0 = (p0 != sol::lua_nil) ? p0.as<uint32>() : 0;
    uint32 param1 = (p1 != sol::lua_nil) ? p1.as<uint32>() : 0;
    uint32 param2 = (p2 != sol::lua_nil) ? p2.as<uint32>() : 0;
    uint32 param3 = (p3 != sol::lua_nil) ? p3.as<uint32>() : 0;

    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        static_cast<CCharEntity*>(m_PBaseEntity)->pushPacket<CMessageSpecialPacket>(PBaseEntity, messageID, param0, param1, param2, param3);
    }
    else
    {
        m_PBaseEntity->loc.zone->PushPacket(m_PBaseEntity, CHAR_INRANGE, std::make_unique<CMessageSpecialPacket>(PBaseEntity, messageID, param0, param1, param3));
    }
}

/************************************************************************
 *  Function: messageText()
 *  Purpose : Displays text to a target PC (private)
 *  Example : player:messageText(target, ID.text.NOT_HAVE_ENOUGH_GP, false, 6);
 *  Notes   : Mainly used for sending retail text messages
 ************************************************************************/

void CLuaBaseEntity::messageText(CLuaBaseEntity* PLuaBaseEntity, uint16 messageID, sol::object const& arg2, sol::object const& arg3)
{
    if (PLuaBaseEntity == nullptr)
    {
        ShowError("CLuaBaseEntity::messageText() - argument 1 of CLuaBaseEntity* was nullptr");
        return;
    }

    CBaseEntity* PTarget  = PLuaBaseEntity->m_PBaseEntity;
    bool         showName = true;
    uint8        mode     = 0;

    bool  faceGiven = false;
    uint8 face      = 0;

    // TODO: Clean this up.  We could potentially accept two int vals for optional args, which could cause unexpected showName behavior.
    if (arg2 != sol::lua_nil)
    {
        if (arg2.is<bool>())
        {
            showName = arg2.as<bool>();
        }
        else if (arg2.is<int>())
        {
            mode = arg2.as<uint8>();
        }
        else if (arg2.get_type() == sol::type::table)
        {
            auto table   = arg2.as<sol::table>();
            auto faceArg = table.get<sol::object>("face");
            faceGiven    = true;

            if (faceArg.get_type() == sol::type::number)
            {
                face = faceArg.as<uint8>();
            }
            else if (faceArg.get_type() == sol::type::number)
            {
                face = worldAngle(PTarget->loc.p, m_PBaseEntity->loc.p);
            }
            else
            {
                faceGiven = false;
            }

            showName = table.get_or("showName", true);
            mode     = table.get_or("mode", mode);
        }
    }

    if (arg3 != sol::lua_nil)
    {
        mode = arg3.as<uint8>();
    }

    if (faceGiven)
    {
        PTarget->m_TargID       = m_PBaseEntity->targid;
        PTarget->loc.p.rotation = face;
        PTarget->updatemask |= UPDATE_POS;
    }

    if (auto player = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        player->gotMessage = true;
        player->pushPacket<CMessageTextPacket>(PTarget, messageID, showName, mode);
    }
    else
    { // broadcast in range
        m_PBaseEntity->loc.zone->PushPacket(m_PBaseEntity, CHAR_INRANGE, std::make_unique<CMessageTextPacket>(PTarget, messageID, showName, mode));
    }
}

/************************************************************************
 *  Function: printToPlayer()
 *  Purpose : Displays either standad messages to a PC or custom text
 *  Example : player:printToPlayer("Hello!", xi.msg.channel.NS_SAY)
 *          : player:printToPlayer(string.format("Hello, %s!", player:getName()), xi.msg.channel.SYSTEM_1)
 *  Notes   : see scripts/enum/msg.lua for message channels
 *          : Can modify the name shown through explicit declaration
 ************************************************************************/

void CLuaBaseEntity::printToPlayer(std::string const& message, sol::object const& messageTypeObj, sol::object const& nameObj)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowError("Function called on non-PC entity (%s)", m_PBaseEntity->name.c_str());
        return;
    }

    auto messageType = (messageTypeObj == sol::lua_nil) ? MESSAGE_SYSTEM_1 : messageTypeObj.as<CHAT_MESSAGE_TYPE>();
    auto name        = (nameObj == sol::lua_nil) ? "" : nameObj.as<std::string>();

    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        PChar->pushPacket<CChatMessagePacket>(PChar, messageType, message, name);
    }
}

/************************************************************************
 *  Function: printToArea()
 *  Purpose : Version of printToPlayer that passes to message server
 *  Example : player:printToArea("Im a real boy!", xi.msg.channel.SHOUT, xi.msg.area.SYSTEM, "Pinocchio");
 *          : would print a shout type message from Pinocchio to the entire server
 ************************************************************************/

void CLuaBaseEntity::printToArea(std::string const& message, sol::object const& arg1, sol::object const& arg2, sol::object const& arg3)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowError("Function called on non-PC entity (%s)", m_PBaseEntity->name.c_str());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    // see scripts\globals\msg.lua or src\map\packets\chat_message.h for values
    CHAT_MESSAGE_TYPE messageLook  = (arg1 == sol::lua_nil) ? MESSAGE_SYSTEM_1 : arg1.as<CHAT_MESSAGE_TYPE>();
    uint8             messageRange = (arg2 == sol::lua_nil) ? MESSAGE_AREA_SYSTEM : arg2.as<CHAT_MESSAGE_AREA>();
    std::string       name         = (arg3 == sol::lua_nil) ? std::string() : arg3.as<std::string>();

    if (messageRange == MESSAGE_AREA_SYSTEM)
    {
        message::send(MSG_CHAT_SERVMES, nullptr, 0, std::make_unique<CChatMessagePacket>(PChar, messageLook, message, name));
    }
    else if (messageRange == MESSAGE_AREA_SAY)
    {
        PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, std::make_unique<CChatMessagePacket>(PChar, messageLook, message, name));
        PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, std::make_unique<CChatMessagePacket>(PChar, messageLook, message, name));
    }
    else if (messageRange == MESSAGE_AREA_SHOUT)
    {
        PChar->loc.zone->PushPacket(PChar, CHAR_INSHOUT, std::make_unique<CChatMessagePacket>(PChar, messageLook, message, name));
        PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, std::make_unique<CChatMessagePacket>(PChar, messageLook, message, name));
    }
    else if (messageRange == MESSAGE_AREA_PARTY)
    {
        int8 packetData[8]{};
        if (PChar->PParty->m_PAlliance)
        {
            ref<uint32>(packetData, 0) = PChar->PParty->m_PAlliance->m_AllianceID;
            ref<uint32>(packetData, 4) = 0; // No ID so that the PChar sees the message too
            message::send(MSG_CHAT_ALLIANCE, packetData, sizeof(packetData), std::make_unique<CChatMessagePacket>(PChar, messageLook, message, name));
        }
        else if (PChar->PParty)
        {
            ref<uint32>(packetData, 0) = PChar->PParty->GetPartyID();
            ref<uint32>(packetData, 4) = 0; // No ID so that the PChar sees the message too
            message::send(MSG_CHAT_PARTY, packetData, sizeof(packetData), std::make_unique<CChatMessagePacket>(PChar, messageLook, message, name));
        }
    }
    else if (messageRange == MESSAGE_AREA_YELL)
    {
        message::send(MSG_CHAT_YELL, nullptr, 0, std::make_unique<CChatMessagePacket>(PChar, messageLook, message, name));
        PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, std::make_unique<CChatMessagePacket>(PChar, messageLook, message, name));
    }
    else if (messageRange == MESSAGE_AREA_UNITY)
    {
        message::send(MSG_CHAT_UNITY, nullptr, 0, std::make_unique<CChatMessagePacket>(PChar, messageLook, message, name));
        PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, std::make_unique<CChatMessagePacket>(PChar, messageLook, message, name));
    }
    else
    {
        ShowError("CLuaBaseEntity::printToArea : invalid message area/messageRange value %u given by script.", messageRange);
    }
    /*
    Todo: Assist channels
    */
}

/************************************************************************
 *  Function: messageBasic()
 *  Purpose : Send a basic message packet to the PC
 *  Example : target:messageBasic(xi.msg.basic.RECOVERS_HP_AND_MP);
 *  Notes   : Mainly used when effects are applied
 ************************************************************************/

void CLuaBaseEntity::messageBasic(uint16 messageID, sol::object const& p0, sol::object const& p1, sol::object const& target)
{
    uint32 param0 = (p0 != sol::lua_nil) ? p0.as<uint32>() : 0;
    uint32 param1 = (p1 != sol::lua_nil) ? p1.as<uint32>() : 0;

    auto* PTarget = (target != sol::lua_nil) ? target.as<CLuaBaseEntity*>()->m_PBaseEntity : m_PBaseEntity;

    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        static_cast<CCharEntity*>(m_PBaseEntity)->pushPacket<CMessageBasicPacket>(m_PBaseEntity, PTarget, param0, param1, messageID);
    }
    else
    {
        // Broadcast in range
        m_PBaseEntity->loc.zone->PushPacket(m_PBaseEntity, CHAR_INRANGE, std::make_unique<CMessageBasicPacket>(m_PBaseEntity, PTarget, param0, param1, messageID));
    }
}

/************************************************************************
 *  Function: messageName()
 *  Purpose : Message displayed with an entity's name in it
 *  Example : target:messageName(messageID, entity, param0, param1, param2, param3, chatType);
 *  Notes   : Used in Doom countdown messages, as an example
 ************************************************************************/

void CLuaBaseEntity::messageName(uint16 messageID, sol::object const& entity, sol::object const& p0, sol::object const& p1,
                                 sol::object const& p2, sol::object const& p3, sol::object const& chat)
{
    CLuaBaseEntity* PLuaEntity  = (entity != sol::lua_nil) ? entity.as<CLuaBaseEntity*>() : nullptr;
    CBaseEntity*    PNameEntity = PLuaEntity ? PLuaEntity->m_PBaseEntity : nullptr;

    int32 param0 = (p0 != sol::lua_nil) ? p0.as<int32>() : 0;
    int32 param1 = (p1 != sol::lua_nil) ? p1.as<int32>() : 0;
    int32 param2 = (p2 != sol::lua_nil) ? p2.as<int32>() : 0;
    int32 param3 = (p3 != sol::lua_nil) ? p3.as<int32>() : 0;

    int32 chatType = (chat != sol::lua_nil) ? chat.as<int32>() : 4;

    if (CCharEntity* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        PChar->pushPacket<CMessageNamePacket>(PChar, messageID, PNameEntity, param0, param1, param2, param3, chatType);
    }
    else
    {
        m_PBaseEntity->loc.zone->PushPacket(m_PBaseEntity, CHAR_INRANGE, std::make_unique<CMessageNamePacket>(m_PBaseEntity, messageID, PNameEntity, param0, param1, param2, param3, chatType));
    }
}

/************************************************************************
 *  Function: messagePublic()
 *  Purpose : Push message to all players
 *  Example : target:messagePublic(112, target, remainingTicks, remainingTicks);
 *  Notes   : Used in Doom countdown messages, as an example
 ************************************************************************/

void CLuaBaseEntity::messagePublic(uint16 messageID, CLuaBaseEntity const* PEntity, sol::object const& arg2, sol::object const& arg3)
{
    uint32 param0 = (arg2 != sol::lua_nil) ? arg2.as<uint32>() : 0;
    uint32 param1 = (arg3 != sol::lua_nil) ? arg3.as<uint32>() : 0;

    if (PEntity != nullptr)
    {
        m_PBaseEntity->loc.zone->PushPacket(m_PBaseEntity, CHAR_INRANGE_SELF, std::make_unique<CMessageBasicPacket>(m_PBaseEntity, PEntity->GetBaseEntity(), param0, param1, messageID));
    }
}

/************************************************************************
 *  Function: messageSpecial()
 *  Purpose : Displays special messages
 *  Example : player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY);
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::messageSpecial(uint16 messageID, sol::variadic_args va)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowError("Function called on non-PC entity (%s)", m_PBaseEntity->name.c_str());
        return;
    }

    uint32 param0   = va.get_type(0) == sol::type::number ? va.get<uint32>(0) : 0;
    uint32 param1   = va.get_type(1) == sol::type::number ? va.get<uint32>(1) : 0;
    uint32 param2   = va.get_type(2) == sol::type::number ? va.get<uint32>(2) : 0;
    uint32 param3   = va.get_type(3) == sol::type::number ? va.get<uint32>(3) : 0;
    bool   showName = va.get_type(4) == sol::type::boolean ? va.get<bool>(4) : false;

    static_cast<CCharEntity*>(m_PBaseEntity)->pushPacket<CMessageSpecialPacket>(m_PBaseEntity, messageID, param0, param1, param2, param3, showName);
}

/************************************************************************
 *  Function: messageSystem()
 *  Purpose : Sends a standard system message
 *  Example : player:messageSystem("Text")
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::messageSystem(MsgStd messageID, sol::object const& p0, sol::object const& p1)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowError("Function called on non-PC entity (%s)", m_PBaseEntity->name.c_str());
        return;
    }

    uint32 param0 = (p0 != sol::lua_nil) ? p0.as<uint32>() : 0;
    uint32 param1 = (p1 != sol::lua_nil) ? p1.as<uint32>() : 0;

    static_cast<CCharEntity*>(m_PBaseEntity)->pushPacket<CMessageSystemPacket>(param0, param1, messageID);
}

/************************************************************************
 *  Function: messageCombat(...)
 *  Purpose : Various combat related messages are ended with this packet
 *  Example : master:messageCombat(mob, offset + id, 0, 711)
 *  Notes   :
 ************************************************************************/
void CLuaBaseEntity::messageCombat(sol::object const& speaker, int32 p0, int32 p1, int16 message)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowError("Function called on non-PC entity (%s)", m_PBaseEntity->name.c_str());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    CBaseEntity* PSpeaker = nullptr;
    if (speaker != sol::lua_nil)
    {
        CLuaBaseEntity* PLuaBaseEntity = speaker.as<CLuaBaseEntity*>();
        PSpeaker                       = PLuaBaseEntity->m_PBaseEntity;
    }
    else
    {
        PSpeaker = m_PBaseEntity;
    }

    PChar->pushPacket<CMessageCombatPacket>(PSpeaker, PChar, p0, p1, message);
}

/************************************************************************
 *  Function: messageStandard(id)
 *  Purpose : Sends a standard message
 *  Example : player:messageStandard(287)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::messageStandard(uint16 messageID)
{
    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        PChar->pushPacket<CMessageStandardPacket>(messageID);
    }
}

void CLuaBaseEntity::customMenu(sol::object const& obj)
{
    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity);
        PChar && obj.get_type() == sol::type::table)
    {
        auto menuString = luautils::SetCustomMenuContext(PChar, obj.as<sol::table>());
        PChar->pushPacket<CChatMessagePacket>(PChar, MESSAGE_GMPROMPT, menuString.c_str(), "_CUSTOM_MENU");
    }
}

/************************************************************************
 *  Function: getCharVar()
 *  Purpose : Returns a var value assigned to a PC (in char_vars.sql)
 *  Example : local status = player:getCharVar("[ZM]Status")
 *  Notes   :
 ************************************************************************/

int32 CLuaBaseEntity::getCharVar(std::string const& varName)
{
    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        return PChar->getCharVar(varName);
    }
    return 0;
}

/************************************************************************
 *  Function: setCharVar()
 *  Purpose : Updates PC's variable to an explicit value
 *  Example : player:setCharVar("[ZM]Status", 4)
 *  Notes   : Passing a '0' value will delete the variable.
 ************************************************************************/

void CLuaBaseEntity::setCharVar(std::string const& varName, int32 value, sol::object const& expiry)
{
    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        uint32 varTimestamp = expiry.is<uint32>() ? expiry.as<uint32>() : 0;

        if (varTimestamp > 0 && varTimestamp <= CVanaTime::getInstance()->getSysTime())
        {
            ShowWarning(fmt::format("Attempting to set variable '{}' with an expired time: {}", varName, varTimestamp));
            return;
        }

        PChar->setCharVar(varName, value, varTimestamp);
    }
}

/************************************************************************
 *  Function: setCharVarExpiration()
 *  Purpose : Updates PC's variable expiration to a specific timestamp
 *  Example : player:setCharVarExpiration("Timer", VanadielTime() + 3600)
 *  Notes   : Passing a '0' value will set the variable to not expire.
 ************************************************************************/

void CLuaBaseEntity::setCharVarExpiration(std::string const& varName, uint32 expiry)
{
    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        if (expiry > 0 && expiry <= CVanaTime::getInstance()->getSysTime())
        {
            ShowWarning(fmt::format("Attempting to set variable '{}' with an expired time: {}", varName, expiry));
            return;
        }

        PChar->setCharVar(varName, PChar->getCharVar(varName), expiry);
    }
}

/************************************************************************
 *  Function: incrementCharVar()
 *  Purpose : Increments PC's variable by an explicit amount
 *  Example : player:incrementCharVar("[ZM]Status", 1) -- if 4, becomes 5
 *  Notes   : Can use values greater than 1 to increment more.  This does
 *            not handle expiration times.
 ************************************************************************/

void CLuaBaseEntity::incrementCharVar(std::string const& varName, int32 value)
{
    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        charutils::IncrementCharVar(PChar, varName, value);
    }
}

/************************************************************************
 *  Function: setVolatileCharVar()
 *  Purpose : Updates PC's variable to an explicit value,
 &            but allow it to be stored to the database at a later time.
 *  Example : player:setVolatileCharVar("[DIG]DigCount", count)
 *  Notes   : Passing a '0' value will delete the variable
 ************************************************************************/

void CLuaBaseEntity::setVolatileCharVar(std::string const& varName, int32 value, sol::object const& expiry)
{
    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        uint32 varTimestamp = expiry.is<uint32>() ? expiry.as<uint32>() : 0;

        if (varTimestamp > 0 && varTimestamp <= CVanaTime::getInstance()->getSysTime())
        {
            ShowWarning(fmt::format("Attempting to set variable '{}' with an expired time: {}", varName, varTimestamp));
            return;
        }

        PChar->setVolatileCharVar(varName, value, varTimestamp);
    }
}

/************************************************************************
 *  Function: getLocalVars()
 *  Purpose : Returns all variables assigned locally to an entity
 *  Example : local localVars = KingArthro:getLocalVars()
 *  Notes   :
 ************************************************************************/

auto CLuaBaseEntity::getLocalVars() -> sol::table
{
    auto  table     = lua.create_table();
    auto& localVars = m_PBaseEntity->GetLocalVars();

    for (auto const& [varName, value] : localVars)
    {
        auto subtable       = lua.create_table();
        subtable["varname"] = varName;
        subtable["value"]   = value;
        table.add(subtable);
    }
    return table;
}

/************************************************************************
 *  Function: getLocalVar()
 *  Purpose : Returns a variable assigned locally to an entity
 *  Example : if KingArthro:getLocalVar("[POP]King_Arthro") > 0 then
 *  Notes   :
 ************************************************************************/

uint32 CLuaBaseEntity::getLocalVar(std::string const& var)
{
    return m_PBaseEntity->GetLocalVar(var.c_str());
}

/************************************************************************
 *  Function: setLocalVar()
 *  Purpose : Assigns a local variable to an entity
 *  Example : mob:setLocalVar("pop", os.time() + math.random(1200,7200));
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setLocalVar(std::string const& var, uint32 val)
{
    m_PBaseEntity->SetLocalVar(var.c_str(), val);
}

/************************************************************************
 *  Function: clearLocalVarsWithPrefix()
 *  Purpose : Deletes all local variables with the given prefix.
 *  Example : pet:clearLocalVarsWithPrefix("volt");
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::clearLocalVarsWithPrefix(std::string const& prefix)
{
    for (const auto& [localVar, _] : m_PBaseEntity->GetLocalVars())
    {
        if (starts_with(localVar, prefix))
        {
            m_PBaseEntity->SetLocalVar(localVar, 0);
        }
    }
}

/************************************************************************
 *  Function: resetLocalVars()
 *  Purpose : Reset local variables back to default (ex: on Mob disengage)
 *  Example : GetMobByID(Defender):resetLocalVars();
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::resetLocalVars()
{
    m_PBaseEntity->ResetLocalVars();
}

/************************************************************************
 *  Function: clearVarsWithPrefix()
 *  Purpose : Deletes all variables from a player with the given prefix.
 *  Example : player:clearVarsWithPrefix(quest)
 *  Notes   : Prefix has to be a certain length, to avoid deleting unrelated variables.
 ************************************************************************/

void CLuaBaseEntity::clearVarsWithPrefix(std::string const& prefix)
{
    if (auto player = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        charutils::ClearCharVarsWithPrefix(player, prefix);
    }
    else
    {
        ShowError("Trying to clearVarsWithPrefix(%s) on invalid type", prefix);
    }
}

/************************************************************************
 *  Function: getLastOnline()
 *  Purpose : Returns the unix timestamp of the last time the char logged off or zoned
 *  Example : player:getLastOnline()
 *  Notes   :
 ************************************************************************/

uint32 CLuaBaseEntity::getLastOnline()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        return PChar->lastOnline;
    }

    return 0;
}

/************************************************************************
 *  Function: injectPacket()
 *  Purpose : Injects a packet to the player's client
 *  Example : player:injectPacket(packet)
 *  Notes   : Used only for testing through inject.lua command
 ************************************************************************/

void CLuaBaseEntity::injectPacket(std::string const& filename)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    uint8 size = 0;
    FILE* File = fopen(filename.c_str(), "rb");

    if (File)
    {
        auto PPacket = std::make_unique<CBasicPacket>();

        fseek(File, 1, SEEK_SET);
        if (fread(&size, 1, 1, File) != 1)
        {
            ShowError("CLuaBaseEntity::injectPacket : Did not read size");
            fclose(File);
            return;
        }

        fseek(File, 0, SEEK_SET);
        if (fread(*PPacket, 1, size * 2, File) != (size * 2U))
        {
            ShowError("CLuaBaseEntity::injectPacket : Did not read entire packet");
            fclose(File);
            return;
        }

        ((CCharEntity*)m_PBaseEntity)->pushPacket(std::move(PPacket));

        fclose(File);
    }
    else
    {
        ShowError("CLuaBaseEntity::injectPacket : Cannot open file");
    }
}

/************************************************************************
 *  Function: injectActionPacket()
 *  Purpose : Used for injecting action packets
 *  Example : "steal" a target's weapon on a target: player:injectActionPacket(target:getID(), 3, 181, 0, 24, 125, 41, 4370);
 *  Notes   : Used for very special cases, like JoL or Plouton generating action packets that only play animations, and don't actually use abilities.
 *            There are no safeties, You can crash a client with malformed parameters. You have been warned.
 ************************************************************************/
void CLuaBaseEntity::injectActionPacket(uint32 inTargetID, uint16 inCategory, uint16 inAnimationID, uint16 inSpecEffect, uint16 inReaction, uint16 inMessage, uint16 inActionParam, uint16 inParam)
{
    SPECEFFECT speceffect = static_cast<SPECEFFECT>(inSpecEffect);
    REACTION   reaction   = static_cast<REACTION>(inReaction);
    ACTIONTYPE actiontype = static_cast<ACTIONTYPE>(inCategory);

    action_t Action;

    Action.id       = m_PBaseEntity->id;
    Action.actionid = inActionParam;

    Action.actiontype      = actiontype;
    actionList_t& list     = Action.getNewActionList();
    list.ActionTargetID    = inTargetID;
    actionTarget_t& target = list.getNewActionTarget();
    target.animation       = inAnimationID;
    target.param           = inParam;
    target.messageID       = inMessage;
    target.speceffect      = speceffect;
    target.reaction        = reaction;

    m_PBaseEntity->loc.zone->PushPacket(m_PBaseEntity, CHAR_INRANGE_SELF, std::make_unique<CActionPacket>(Action));
}

/************************************************************************
 *  Function: entityVisualPacket()
 *  Purpose : Sends a visual packet to the PC
 *  Example : player:entityVisualPacket("byc7")
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::entityVisualPacket(std::string const& command, sol::object const& entity)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    CBaseEntity* PNpc = nullptr;
    if (entity != sol::lua_nil)
    {
        CLuaBaseEntity* PLuaBaseEntity = entity.as<CLuaBaseEntity*>();
        PNpc                           = PLuaBaseEntity->m_PBaseEntity;
    }

    static_cast<CCharEntity*>(m_PBaseEntity)->pushPacket<CEntityVisualPacket>(PNpc, command.c_str());
}

/************************************************************************
 *  Function: entityAnimationPacket()
 *  Purpose : Sends an animation packet to the entity
 *  Example : mob:entityAnimationPacket("sp00")
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::entityAnimationPacket(const char* command, sol::object const& target)
{
    CBaseEntity* PTarget = nullptr;
    if (target != sol::lua_nil)
    {
        // If we have a target then set PTarget to that
        CLuaBaseEntity* PLuaBaseEntity = target.as<CLuaBaseEntity*>();
        PTarget                        = PLuaBaseEntity->GetBaseEntity();
    }
    else
    {
        // If no target PTarget defaults to m_PBaseEntity
        PTarget = m_PBaseEntity;
    }

    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        static_cast<CCharEntity*>(m_PBaseEntity)->pushPacket<CEntityAnimationPacket>(m_PBaseEntity, PTarget, command);
    }
    else
    {
        m_PBaseEntity->loc.zone->PushPacket(m_PBaseEntity, CHAR_INRANGE, std::make_unique<CEntityAnimationPacket>(m_PBaseEntity, PTarget, command));
    }
}

/************************************************************************
 *  Function: sendDebugPacket()
 *  Purpose :
 *  Example : mob:sendDebugPacket({ table })
 *  Notes   : For debugging and development only!
 ************************************************************************/
void CLuaBaseEntity::sendDebugPacket(sol::table const& packetData)
{
    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        auto packet = std::make_unique<CBasicPacket>();
        for (int i = 0; i < packetData.size(); i++)
        {
            packet->ref<uint8>(i) = packetData.get<uint8>(i + 1); // Lua is 1-indexed
        }
        PChar->pushPacket(std::move(packet));
    }
}

/************************************************************************
 *  Helper function for the lua bindings that start events.
 ************************************************************************/
void CLuaBaseEntity::StartEventHelper(int32 EventID, sol::variadic_args va, EVENT_TYPE eventType)
{
    auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity);

    if (!PChar)
    {
        ShowError("CLuaBaseEntity::StartEventHelper: Could not start event, Base Entity is not a Character Entity.");
        return;
    }

    if (PChar->currentEvent->eventId == EventID)
    {
        ShowError("CLuaBaseEntity::StartEventHelper: Could not start event, Character Entity already triggered.");
        return;
    }
    PChar->StatusEffectContainer->DelStatusEffect(EFFECT_BOOST);

    PChar->queueEvent(ParseEvent(EventID, va, PChar->eventPreparation, eventType));
}

/************************************************************************
 *  Helper function for parsing event information from lua.
 ************************************************************************/
EventInfo* CLuaBaseEntity::ParseEvent(int32 EventID, sol::variadic_args va, EventPrep* eventPreparation, EVENT_TYPE eventType)
{
    EventInfo* eventToStart = new EventInfo();
    eventToStart->eventId   = EventID;
    if (eventPreparation)
    {
        eventToStart->targetEntity = eventPreparation->targetEntity;
        eventToStart->scriptFile   = eventPreparation->scriptFile;
    }
    eventToStart->textTable = -1;
    eventToStart->type      = eventType;

    // The most common option for accepting a warp is 0, so this is default, if it's an optional cutscene
    std::vector<int32> cutsceneOptions = { 0 };

    if (va.get_type(0) == sol::type::table)
    {
        // Table usage of starting events, like player:startEvent(eventId, { [2] = p2, ... })

        // Parse out numbered parameters from the table.
        auto table = va.get<sol::table>(0);
        for (int i = 0; i < 8; i++)
        {
            uint32 param = table.get_or<uint32>(i, 0);
            if (param != 0)
            {
                eventToStart->params[i] = param;
            }
        }

        // Parse out strings if such a table is given
        sol::object strings = table["strings"];
        if (strings.valid() && strings.is<sol::table>())
        {
            for (const auto& kv : strings.as<sol::table>())
            {
                if (kv.first.get_type() == sol::type::number && kv.second.is<std::string>())
                {
                    eventToStart->strings[kv.first.as<int32>()] = kv.second.as<std::string>();
                }
            }
        }

        // Parse out other misc. possible arguments for events.
        eventToStart->textTable     = table.get_or<int16>("text_table", -1);
        eventToStart->interruptText = table.get_or<int16>("interrupt_text", 0);
        eventToStart->eventFlags    = table.get_or<uint32>("flags", 0);

        sol::object csOption = table["cs_option"];
        if (csOption.is<int32>())
        {
            cutsceneOptions = { csOption.as<int32>() };
        }
        else if (csOption.get_type() == sol::type::table)
        {
            for (const auto& kv : csOption.as<sol::table>())
            {
                if (kv.second.is<int32>())
                {
                    cutsceneOptions.emplace_back(kv.second.as<int32>());
                }
            }
        }
    }
    else
    {
        // Non-table usage of starting events, like player:startEvent(eventId, p0, p1, p2, ...)
        int currentIndex = 0;

        // If first variable argument is a string, parse out the first 4 arguments as strings for event_string.
        if (va.get_type(0) == sol::type::string)
        {
            for (int i = 0; i < 4; i++)
            {
                if (va.get_type(currentIndex) == sol::type::string)
                {
                    eventToStart->strings[i] = va.get<std::string>(currentIndex);
                }
                currentIndex++;
            }
        }

        // Parse out 8 integer parameters from the variable args.
        for (int i = 0; i < 8; i++)
        {
            if (va.get_type(currentIndex) == sol::type::number)
            {
                eventToStart->params[i] = va.get<uint32>(currentIndex);
            }
            currentIndex++;
        }

        // Finally parse out an optional last argument as text_table
        eventToStart->textTable = va.get_type(8) == sol::type::number ? va.get<int16>(8) : -1;
    }

    if (eventType == OPTIONAL_CUTSCENE)
    {
        // If it's a teleporter or door, where the player has to select the option to
        // go through first, we store which options will trigger this on the event object.
        eventToStart->cutsceneOptions = std::move(cutsceneOptions);
    }

    return eventToStart;
}

/************************************************************************
 *  Function: startEvent()
 *  Purpose : Starts an event (cutscene)
 *  Example : player:startEvent(4)
 *          : player:startEvent(csid, op1, op2, op3, op4, op5, op6, op7, op8, texttable)
 *          : player:startEvent(csid, { [2] = op3, [7] = op8, text_table = 0 })
 *  Notes   : Cutscene ID must be associated with the zone
 *            https://sol2.readthedocs.io/en/latest/api/variadic_args.html
 *            Arguments listed after sol::variadic_args are INCLUDED in it at position 0!
 ************************************************************************/

void CLuaBaseEntity::startEvent(int32 EventID, sol::variadic_args va)
{
    StartEventHelper(EventID, va, EVENT_TYPE::NORMAL);
}

/************************************************************************
 *  Function: startEventString()
 *  Purpose : Starts an event (cutscene) with string parameters (0x33 packet)
 *  Example : Too long to show
 *  Notes   : See scripts/zones/Aht_Urhgan_Whitegate/npcs/Ghatsad.lua
 ************************************************************************/

void CLuaBaseEntity::startEventString(int32 EventID, sol::variadic_args va)
{
    StartEventHelper(EventID, va, EVENT_TYPE::NORMAL);
}

/************************************************************************
 *  Function: startCutscene()
 *  Purpose : Starts a cutscene, which locks the player and clears enmity
 *  Example : player:startCutscene(4)
 *  Notes   : Cutscene ID must be associated with the zone
 ************************************************************************/

void CLuaBaseEntity::startCutscene(int32 EventID, sol::variadic_args va)
{
    StartEventHelper(EventID, va, EVENT_TYPE::CUTSCENE);
}

/************************************************************************
 *  Function: startOptionalCutscene()
 *  Purpose : Starts an event, which has an option that takes the player into a cutscene.
 *            This is used for teleporters, portals, and doors.
 *  Example : player:startOptionalCutscene(4)
 *  Notes   : Event ID must be associated with the zone.
 ************************************************************************/

void CLuaBaseEntity::startOptionalCutscene(int32 EventID, sol::variadic_args va)
{
    StartEventHelper(EventID, va, EVENT_TYPE::OPTIONAL_CUTSCENE);
}

/************************************************************************
 *  Function: updateEvent()
 *  Purpose : Sends new arguments to an event
 *  Example : player:updateEvent(ring[1],ring[2],ring[3])
 *  Notes   : Ex: CoP ring selection uses this to redisplay correct order of rings
 ************************************************************************/

void CLuaBaseEntity::updateEvent(sol::variadic_args va)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    std::vector<std::pair<uint8, uint32>> params;

    if (va.get_type(0) == sol::type::table)
    {
        auto table = va.get<sol::table>(0);
        for (int i = 0; i < 8; i++)
        {
            uint32 param = table.get_or<uint32>(i, 0);
            if (param != 0)
            {
                params.emplace_back(i, param);
            }
        }
    }
    else
    {
        for (int i = 0; i < 8; i++)
        {
            if (va.get_type(i) == sol::type::number)
            {
                params.emplace_back(i, va.get<uint32>(i));
            }
        }
    }

    static_cast<CCharEntity*>(m_PBaseEntity)->pushPacket<CEventUpdatePacket>(params);
}

/************************************************************************
 *  Function: updateEventString()
 *  Purpose : Sends a string to an event in progress
 *  Example : player:updateEventString(name)
 *  Notes   : Used by BCNM to display record holder's name
 ************************************************************************/

void CLuaBaseEntity::updateEventString(sol::variadic_args va)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    std::string string0 = va.get_type(0) == sol::type::string ? va.get<std::string>(0) : "";
    std::string string1 = va.get_type(1) == sol::type::string ? va.get<std::string>(1) : "";
    std::string string2 = va.get_type(2) == sol::type::string ? va.get<std::string>(2) : "";
    std::string string3 = va.get_type(3) == sol::type::string ? va.get<std::string>(3) : "";

    uint32 param0 = va.get_type(4) == sol::type::number ? va.get<uint32>(4) : 0;
    uint32 param1 = va.get_type(5) == sol::type::number ? va.get<uint32>(5) : 0;
    uint32 param2 = va.get_type(6) == sol::type::number ? va.get<uint32>(6) : 0;
    uint32 param3 = va.get_type(7) == sol::type::number ? va.get<uint32>(7) : 0;
    uint32 param4 = va.get_type(8) == sol::type::number ? va.get<uint32>(8) : 0;
    uint32 param5 = va.get_type(9) == sol::type::number ? va.get<uint32>(9) : 0;
    uint32 param6 = va.get_type(10) == sol::type::number ? va.get<uint32>(10) : 0;
    uint32 param7 = va.get_type(11) == sol::type::number ? va.get<uint32>(11) : 0;
    uint32 param8 = va.get_type(12) == sol::type::number ? va.get<uint32>(12) : 0;

    ((CCharEntity*)m_PBaseEntity)
        ->pushPacket<CEventUpdateStringPacket>(string0, string1, string2, string3, param0, param1, param2, param3, param4, param5, param6, param7, param8);
}

/************************************************************************
 *  Function: getEventTarget()
 *  Purpose : Returns object data of the NPC in the event
 *  Example : local npc = player:getEventTarget()
 *  Notes   : Used to relocate Siren's Tear, as an example
 ************************************************************************/

std::optional<CLuaBaseEntity> CLuaBaseEntity::getEventTarget()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return std::nullopt;
    }

    auto* PChar = (CCharEntity*)m_PBaseEntity;
    if (PChar->currentEvent->targetEntity == nullptr)
    {
        ShowWarning("EventTarget for event %d is empty: %s", PChar->currentEvent->eventId, m_PBaseEntity->getName());
        return std::nullopt;
    }

    return std::optional<CLuaBaseEntity>(PChar->currentEvent->targetEntity);
}

/************************************************************************
 *  Function: isInEvent()
 *  Purpose : Returns true if the player is in an event
 *  Example : if player:isInEvent() then
 *  Notes   : Primarily used by the interaction framework.
 ************************************************************************/

bool CLuaBaseEntity::isInEvent()
{
    if (auto player = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        return player->isInEvent();
    }

    return false;
}

/************************************************************************
 *  Function: release()
 *  Purpose : Ends an event for a PC; releases from cutscene
 *  Example : player:release()
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::release()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    RELEASE_TYPE releaseType = RELEASE_TYPE::STANDARD;

    if (PChar->isInEvent())
    {
        // Message: Event skipped
        releaseType = RELEASE_TYPE::SKIPPING;
        PChar->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::EventSkipped);
    }

    PChar->inSequence = false;
    PChar->pushPacket<CReleasePacket>(PChar, releaseType);
    PChar->pushPacket<CReleasePacket>(PChar, RELEASE_TYPE::EVENT);
    PChar->endCurrentEvent();
}

/************************************************************************
 *  Function: startSequence()
 *  Purpose : Sets the player to be flagged as being in a sequence, which
 *            means that it should not be released immediately from the NPC.
 *            The player will have to be manually be released by a future call.
 *  Example : player:startSequence()
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::startSequence()
{
    if (auto player = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        player->inSequence = true;
        return true;
    }

    return false;
}

/************************************************************************
 *  Function: didGetMessage()
 *  Purpose : Returns the gotMessage variable for the player.
 *  Example : player:didGetMessage()
 *  Notes   : Used for backwards-compatibility with global lua handlers in NPC files,
 *            to be able to check if an NPC reacted with a message or not.
 ************************************************************************/

bool CLuaBaseEntity::didGetMessage()
{
    if (auto player = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        return player->gotMessage;
    }

    return false;
}

/************************************************************************
 *  Function: resetGotMessage()
 *  Purpose : Resets the gotMessage variable for players.
 *  Example : player:resetGotMessage()
 *  Notes   : Used for backwards-compatibility with global lua handlers in NPC files,
 *            to be able to check if an NPC reacted with a message or not.
 ************************************************************************/

void CLuaBaseEntity::resetGotMessage()
{
    if (auto player = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        player->gotMessage = false;
    }
}

/************************************************************************
 *  Function: getMoghouseFlag()
 *  Purpose : Returns exit flag for Mog House
 *  Example :
 *  Notes   :  Used in Mog House exit quests (ex. A Lady's Heart)
 ************************************************************************/

uint16 CLuaBaseEntity::getMoghouseFlag()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        return PChar->profile.mhflag;
    }

    return 0;
}

/************************************************************************
 *  Function: setMoghouseFlag()
 *  Purpose : Creates or returns exit flag for Mog House
 *  Example : player:moghouseFlag(bit.band(mhflag, 0x02))
 *  Notes   : Used in Mog House exit quests (ex. A Lady's Heart)
 ************************************************************************/

void CLuaBaseEntity::setMoghouseFlag(uint16 flag)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        PChar->profile.mhflag = flag;
        charutils::SaveCharStats(PChar);
    }
}

/************************************************************************
 *  Function: needToZone()
 *  Purpose : Checks to see if a player has zoned since the flag was raised
 *  Example : player:needToZone(true)
 *  Notes   : Used in events where player needs to zone before continuing
 *  TODO    : Separate this into get/set functions
 ************************************************************************/

bool CLuaBaseEntity::needToZone(sol::object const& arg0)
{
    if (arg0 != sol::lua_nil)
    {
        m_PBaseEntity->loc.zoning = arg0.as<bool>();
    }

    return m_PBaseEntity->loc.zoning;
}

/************************************************************************
 *  Function: getID()
 *  Purpose : Get Entity's ID
 *  Example : npc:getID(); target:getID()
 *  Notes   :
 ************************************************************************/

uint32 CLuaBaseEntity::getID()
{
    return m_PBaseEntity->id;
}

/************************************************************************
 *  Function: getTargID()
 *  Purpose : Gets the ID of a Target
 *  Example : mob:getTargID(); pet:getTargID()
 *  Notes   :
 ************************************************************************/

uint16 CLuaBaseEntity::getTargID()
{
    return m_PBaseEntity->targid;
}

/************************************************************************
 *  Function: getCursorTarget()
 *  Purpose : GM command - gets the ID of selected Mob's, NPC's, Players
 *  Example : player:getCursorTarget()
 *  Notes   :
 ************************************************************************/

std::optional<CLuaBaseEntity> CLuaBaseEntity::getCursorTarget()
{
    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        if (auto* PTarget = PChar->GetEntity(PChar->m_TargID))
        {
            return std::optional<CLuaBaseEntity>(PTarget);
        }
    }

    return std::nullopt;
}

/************************************************************************
 *  Function: getObjType()
 *  Purpose : Returns the int value of an entity's object type (Mob,PC...)
 *  Example : if caster:getObjType() == xi.objType.PC then
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getObjType() const
{
    return m_PBaseEntity->objtype;
}

/************************************************************************
 *  Function: isPC()
 *  Purpose : Returns true if entity is of the PC object type
 *  Example : if target:isPC() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isPC() const
{
    return m_PBaseEntity->objtype == TYPE_PC;
}

/************************************************************************
 *  Function: isNPC()
 *  Purpose : Returns true if entity is of the NPC object type
 *  Example : if target:isNPC() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isNPC() const
{
    return m_PBaseEntity->objtype == TYPE_NPC;
}

/************************************************************************
 *  Function: isMob()
 *  Purpose : Returns true if entity is of the Mob object type
 *  Example : if target:isMob() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isMob() const
{
    return m_PBaseEntity->objtype == TYPE_MOB;
}

/************************************************************************
 *  Function: isPet()
 *  Purpose : Returns true if entity is of the Pet object type
 *  Example : if caster:isPet() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isPet() const
{
    return m_PBaseEntity->objtype == TYPE_PET;
}

/************************************************************************
 *  Function: isTrust()
 *  Purpose : Returns true if entity is of the Trust object type
 *  Example : if caster:isTrust() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isTrust() const
{
    return m_PBaseEntity->objtype == TYPE_TRUST;
}

/************************************************************************
 *  Function: isFellow()
 *  Purpose : Returns true if entity is of the Fellow object type
 *  Example : if caster:isFellow() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isFellow() const
{
    return m_PBaseEntity->objtype == TYPE_FELLOW;
}

/************************************************************************
 *  Function: isAlly()
 *  Purpose : Returns true if entity is an ally
 *  Example : if mob:isAlly() then table.insert(allies, mob) end
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isAlly() const
{
    const auto isMob          = m_PBaseEntity->objtype == TYPE_MOB;
    const auto playerAlliance = m_PBaseEntity->allegiance == ALLEGIANCE_TYPE::PLAYER;
    return isMob && playerAlliance;
}

/************************************************************************
 *  Function: initNpcAi()
 *  Purpose : Initiate pre-defined NPC AI
 *  Example : npc:initNpcAi(); -- Red Ghost in Port Jeuno (walks a path)
 *  Notes   : To Do: Change name, this is ugly
 ************************************************************************/

void CLuaBaseEntity::initNpcAi()
{
    if (m_PBaseEntity->objtype != TYPE_NPC)
    {
        ShowWarning("Attempting to init NPC AI for invalid entity type (%s).", m_PBaseEntity->getName());
        return;
    }

    m_PBaseEntity->PAI = std::make_unique<CAIContainer>(m_PBaseEntity, std::make_unique<CPathFind>(m_PBaseEntity), nullptr, nullptr);
}

/************************************************************************
 *  Function: resetAI()
 *  Purpose : Resets the AI to the default state
 *  Example : mob:resetAI()
 *  Notes   : Most used by mobs (esp Aerns after Reraise)
 ************************************************************************/

void CLuaBaseEntity::resetAI()
{
    m_PBaseEntity->PAI->Reset();
}

/************************************************************************
 *  Function: getStatus()
 *  Purpose : Returns the status (or 'state') of an entity
 *  Example : if qm2:getStatus() ~= xi.status.DISAPPEAR then
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getStatus()
{
    return static_cast<uint8>(m_PBaseEntity->status);
}

/************************************************************************
 *  Function: setStatus()
 *  Purpose : Updates the status (or 'state') of an entity
 *  Example : npc:setStatus(STATUS_NORMAL)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setStatus(uint8 status)
{
    m_PBaseEntity->status = static_cast<STATUS_TYPE>(status);
    m_PBaseEntity->updatemask |= UPDATE_HP;
}

/************************************************************************
 *  Function: getCurrentAction()
 *  Purpose : Returns the current state of a non-NPC entity
 *  Example : if target:getCurrentAction() ~= xi.act.MOBABILITY_USING then
 *  Notes   : Function name ambiguous, but getCurrentState() in use already
 *          : See scripts/enum/action.lua for action definitions
 ************************************************************************/

uint8 CLuaBaseEntity::getCurrentAction()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    uint8 action = 0;

    if (m_PBaseEntity->PAI->IsStateStackEmpty())
    {
        action = 16; // For mobs, this means roaming
    }
    else if (m_PBaseEntity->PAI->IsCurrentState<CRespawnState>())
    {
        action = 0;
    }
    else if (m_PBaseEntity->PAI->IsCurrentState<CAttackState>())
    {
        action = 1;
    }
    else if (m_PBaseEntity->PAI->IsCurrentState<CRangeState>())
    {
        action = 12;
    }
    else if (m_PBaseEntity->PAI->IsCurrentState<CWeaponSkillState>())
    {
        action = 3;
    }
    else if (m_PBaseEntity->PAI->IsCurrentState<CMagicState>())
    {
        action = 30;
    }
    else if (m_PBaseEntity->PAI->IsCurrentState<CItemState>())
    {
        action = 28;
    }
    else if (m_PBaseEntity->PAI->IsCurrentState<CAbilityState>())
    {
        action = 6;
    }
    else if (m_PBaseEntity->PAI->IsCurrentState<CInactiveState>())
    {
        action = 27;
    }
    else if (m_PBaseEntity->PAI->IsCurrentState<CDeathState>())
    {
        action = 22;
    }
    else if (m_PBaseEntity->PAI->IsCurrentState<CDespawnState>())
    {
        action = 24;
    }
    else if (m_PBaseEntity->PAI->IsCurrentState<CRaiseState>())
    {
        action = 37;
    }
    else if (m_PBaseEntity->PAI->IsCurrentState<CMobSkillState>())
    {
        action = 34;
    }
    else if (m_PBaseEntity->PAI->IsCurrentState<CPetSkillState>())
    {
        CPetSkillState* PPetSkillState = dynamic_cast<CPetSkillState*>(m_PBaseEntity->PAI->GetCurrentState());

        if (PPetSkillState)
        {
            action = PPetSkillState->GetPetSkill()->getSkillFinishCategory();
        }
    }
    else
    {
        ShowWarning("getCurrentAction: Unhandled State for %s, defaulting to NONE (0).", m_PBaseEntity->getName());
    }

    return action;
}

/************************************************************************
 *  Function: canUseAbilities()
 *  Purpose : Sees if a mob has perticular effects that stop it from doing thing
 *  Example : mob:canUseAbilities()
 *  Notes   : Can't use on NPCs
 ************************************************************************/

bool CLuaBaseEntity::canUseAbilities()
{
    if (auto* PEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity))
    {
        return !(PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_SLEEP) ||
                 PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_IMPAIRMENT) ||
                 PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_SLEEP_II) ||
                 PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_STUN) ||
                 PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_AMNESIA) ||
                 PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_LULLABY) ||
                 PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_PETRIFICATION) ||
                 PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_TERROR) ||
                 !(m_PBaseEntity->PAI->CanChangeState()));
    }

    ShowError("canUseAbilities() : Wrong Entity Type");
    return false;
}

/************************************************************************
 *  Function: lookAt()
 *  Purpose : Forces an entity to 'look' at something like it's self-aware
 *  Example : npc:lookAt(player:getPos()) -- Make an NPC look at the PC
 *  Notes   : Expects x, y, and z and does not confirm missing!
 ************************************************************************/

void CLuaBaseEntity::lookAt(sol::object const& arg0, sol::object const& arg1, sol::object const& arg2)
{
    position_t point;

    if ((arg0 != sol::lua_nil) && (arg0.is<double>()))
    {
        point.x = arg0.as<float>();
        point.y = arg1.as<float>();
        point.z = arg2.as<float>();
    }
    else
    {
        auto position = arg0.as<std::map<std::string, float>>();

        point.x = position["x"];
        point.y = position["y"];
        point.z = position["z"];
    }

    // Avoid unpredictable results if we're too close.
    if (!isWithinDistance(m_PBaseEntity->loc.p, point, 0.1f, true))
    {
        m_PBaseEntity->loc.p.rotation = worldAngle(m_PBaseEntity->loc.p, point);
        m_PBaseEntity->updatemask |= UPDATE_POS;
    }
}

/************************************************************************
 *  Function: facePlayer()
 *  Purpose : change entities rotation to the direction of a player
 *  Example : npc:facePlayer(player, true/false)
 *  Notes   : Arbitrary points are not supported!
 *            Bool set "false" changes the facing for everyone.
 ************************************************************************/

void CLuaBaseEntity::facePlayer(CLuaBaseEntity* PLuaBaseEntity, sol::object const& nonGlobal)
{
    if (PLuaBaseEntity)
    {
        CCharEntity* PChar = dynamic_cast<CCharEntity*>(PLuaBaseEntity->GetBaseEntity());

        if (PChar)
        {
            bool onePersonOnly = nonGlobal.get_type() == sol::type::boolean ? nonGlobal.as<bool>() : true;

            if (onePersonOnly)
            {
                auto storedRotation           = m_PBaseEntity->loc.p.rotation;
                m_PBaseEntity->loc.p.rotation = worldAngle(m_PBaseEntity->loc.p, PChar->loc.p);
                // Update 1 player's client only
                PChar->updateEntityPacket(m_PBaseEntity, static_cast<ENTITYUPDATE>(ENTITY_UPDATE), UPDATE_POS);
                // Now that the packet is sent to that 1 player, turn this back.
                m_PBaseEntity->loc.p.rotation = storedRotation;
            }
            else
            {
                m_PBaseEntity->loc.p.rotation = worldAngle(m_PBaseEntity->loc.p, PChar->loc.p);
                m_PBaseEntity->updatemask |= UPDATE_POS;
            }
        }
        else
        {
            ShowError("non-player entity used as param in CLuaBaseEntity::facePlayer call");
        }
    }
    else
    {
        ShowError("missing entity to CLuaBaseEntity::facePlayer call");
    }
}

/************************************************************************
 *  Function: clearTargID()
 *  Purpose : Clears an active target from an Entity
 *  Example : GetNPCByID(17719350):clearTargID()
 *  Notes   : This is only used in scripts/zones/Southern_San_dOria/npcs/Raminel.lua
 *          : to get the NPC to stop looking at Raminel after he gets too far
 ************************************************************************/

void CLuaBaseEntity::clearTargID()
{
    m_PBaseEntity->m_TargID = 0;
    m_PBaseEntity->loc.zone->UpdateEntityPacket(m_PBaseEntity, ENTITY_UPDATE, UPDATE_POS);
}

/************************************************************************
 *  Function: atPoint()
 *  Purpose : Used to check whether an entity is at a specified point in the specified path
 *  Example : if npc:atPoint(pathfind.get(path, 45)) then
 *  Notes   : Used to trigger delays, messages, etc (Ex: Patroller in West Ronfaure)
 ************************************************************************/

bool CLuaBaseEntity::atPoint(sol::variadic_args va)
{
    position_t pos;

    if (va.get_type(0) == sol::type::number)
    {
        pos.x = va.get<float>(0);
        pos.y = va.get<float>(1);
        pos.z = va.get<float>(2);
    }
    else if (va.get_type(0) == sol::type::table)
    {
        auto table = va.get<sol::table>(0);
        auto vec   = table.as<std::vector<float>>();

        pos.x = vec[0];
        pos.y = vec[1];
        pos.z = vec[2];
    }

    return isWithinDistance(m_PBaseEntity->loc.p, pos, 0.01f);
}

/************************************************************************
 *  Function: pathTo()
 *  Purpose : Makes a non-PC move toward a target without changing action
 *  Example : mob:pathTo(Pos.x + math.cos(radians) * 16, Pos.y, Pos.z + math.sin(radians) * 16);
 *  Notes   : Currently only used by Selh'Teus during final CoP fight
 ************************************************************************/

void CLuaBaseEntity::pathTo(float x, float y, float z, sol::object const& flags)
{
    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        ShowWarning("Invalid entity (Player: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    position_t point;
    point.x = x;
    point.y = y;
    point.z = z;

    if (m_PBaseEntity->PAI->PathFind)
    {
        uint8 pathFlags = (flags != sol::lua_nil) ? flags.as<uint8>() : (PATHFLAG_RUN | PATHFLAG_WALLHACK | PATHFLAG_SCRIPT);

        m_PBaseEntity->PAI->PathFind->PathTo(point, pathFlags);
    }
}

/************************************************************************
 *  Function: pathThrough()
 *  Purpose : Makes an Entity follow a given set of points
 *  Example : mob:pathThrough(pathfind.first(path), xi.path.flag.RUN)
 *  Notes   : Ex: Gets Zipacna back on his specified path
 ************************************************************************/

bool CLuaBaseEntity::pathThrough(sol::table const& pointsTable, sol::object const& flagsObj)
{
    uint8 flags = 0;

    if (flagsObj.is<uint8>())
    {
        flags = flagsObj.as<uint8>();
    }

    std::vector<pathpoint_t> points;

    if (flags & PATHFLAG_PATROL || (flags & PATHFLAG_COORDS))
    {
        // Grab points from array and store in points array
        float x = m_PBaseEntity->loc.p.x;
        float y = m_PBaseEntity->loc.p.y;
        float z = m_PBaseEntity->loc.p.z;
        for (std::size_t i = 1; i <= pointsTable.size(); ++i)
        {
            sol::table  pointData = pointsTable[i];
            pathpoint_t point;
            x              = pointData.get_or("x", x);
            y              = pointData.get_or("y", y);
            z              = pointData.get_or("z", z);
            point.position = { x, y, z, 0, 0 };

            auto rotation     = pointData["rotation"];
            point.setRotation = rotation.valid();
            if (point.setRotation)
            {
                point.position.rotation = rotation.get<uint8>();
            }

            auto wait  = pointData["wait"];
            point.wait = wait.valid() ? wait.get<uint32>() : 0;
            points.emplace_back(point);
        }
    }
    else
    {
        // Grab points from array and store in points array
        for (std::size_t i = 1; i < pointsTable.size(); i += 3)
        {
            points.emplace_back(pathpoint_t{ { (float)pointsTable[i], (float)pointsTable[i + 1], (float)pointsTable[i + 2], 0, 0 }, 0, false });
        }
    }

    CBattleEntity* PBattle = (CBattleEntity*)m_PBaseEntity;

    return PBattle->PAI->PathFind->PathThrough(std::move(points), flags);
}

/************************************************************************
 *  Function: isFollowingPath()
 *  Purpose : Returns true if entity is following its specified path
 *  Example : if npc:isFollowingPath() then
 *  Notes   : Often used in conjunction with pathThrough()
 ************************************************************************/

bool CLuaBaseEntity::isFollowingPath()
{
    if (m_PBaseEntity->PAI && m_PBaseEntity->PAI->PathFind)
    {
        return m_PBaseEntity->PAI->PathFind->IsFollowingPath();
    }

    return false;
}

/************************************************************************
 *  Function: clearPath()
 *  Purpose : Clears all path points and stops entity movement
 *  Example : npc:clearPath()
 *  Notes   : Optional argument to stop AI onPath ticks for an NPC
 ************************************************************************/

void CLuaBaseEntity::clearPath(sol::object const& pauseObj)
{
    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);
    bool  pause   = pauseObj.is<bool>() ? pauseObj.as<bool>() : false;

    // Stop onPath ticks for NPCs if this is true
    if (m_PBaseEntity->objtype == TYPE_NPC && pause)
    {
        m_PBaseEntity->SetLocalVar("pauseNPCPathing", 1);
    }
    else if (PBattle->PAI->PathFind != nullptr)
    {
        PBattle->PAI->PathFind->Clear();
    }
}

/************************************************************************
 *  Function: continuePath()
 *  Purpose : Resumes NPC pathing
 *  Example : npc:continuePath()
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::continuePath()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        m_PBaseEntity->SetLocalVar("pauseNPCPathing", 0);
    }
}

/************************************************************************
 *  Function: checkDistance()
 *  Purpose : Returns the yalm distance between entities
 *  Example1: if player:checkDistance(target) <= 25 then
 *  Example2: if player:checkDistance(pos) <= 25 then
 *  Example3: if player:checkDistance(posX, posY, PosZ) <= 25 then
 *  Notes   : Example1 is an entity, the others are coordinate point inputs
 ************************************************************************/

float CLuaBaseEntity::checkDistance(sol::variadic_args va)
{
    float calcdistance = 0;

    if (va.get_type(0) == sol::type::userdata)
    {
        auto* PLuaBaseEntity = va.get<CLuaBaseEntity*>(0);
        calcdistance         = distance(m_PBaseEntity->loc.p, PLuaBaseEntity->GetBaseEntity()->loc.p);
    }
    else
    {
        float      posX = 0;
        float      posY = 0;
        float      posZ = 0;
        position_t point;

        if (va.get_type(0) == sol::type::table)
        {
            sol::table table = va.get<sol::table>(0);

            posX = table.get<float>("x");
            posY = table.get<float>("y");
            posZ = table.get<float>("z");
        }
        else if (va.get_type(0) == sol::type::number &&
                 va.get_type(1) == sol::type::number &&
                 va.get_type(2) == sol::type::number)
        {
            posX = va.get<float>(0);
            posY = va.get<float>(1);
            posZ = va.get<float>(2);
        }
        else
        {
            ShowError("Lua::checkDistance : invalid inputs.");
            return 0.0f;
        }

        point.x      = posX;
        point.y      = posY;
        point.z      = posZ;
        calcdistance = distance(m_PBaseEntity->loc.p, point);
    }

    return calcdistance;
}

/************************************************************************
 *  Function: wait()
 *  Purpose : Makes a non-PC inactive for a set amount of time
 *  Example : npc:wait(10000) -- wait 10 seconds
 *  Notes   : Default is 4 seconds unless specified in ms
 ************************************************************************/

void CLuaBaseEntity::wait(sol::object const& milliseconds)
{
    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        ShowWarning("Invalid entity (Player: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    int32 waitTime = (milliseconds != sol::lua_nil) ? milliseconds.as<uint32>() : 4000;
    m_PBaseEntity->PAI->Inactive(std::chrono::milliseconds(waitTime), true);
}

/************************************************************************
 *  Function: follow(target)
 *  Purpose : Makes a Mob follow the provided target
 *  Example : mob:follow(target, xi.followType.Roam)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::follow(CLuaBaseEntity* target, uint8 followType)
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Invalid entity (%s) calling function.", m_PBaseEntity->getName());
        return;
    }

    auto* controller = static_cast<CMobController*>(m_PBaseEntity->PAI->GetController());
    controller->SetFollowTarget(target->m_PBaseEntity, static_cast<FollowType>(followType));
}

bool CLuaBaseEntity::hasFollowTarget()
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Invalid entity (%s) calling function.", m_PBaseEntity->getName());
        return false;
    }

    auto* controller = static_cast<CMobController*>(m_PBaseEntity->PAI->GetController());
    return controller->HasFollowTarget();
}

/************************************************************************
 *  Function: unfollow()
 *  Purpose : Makes a Mob stop following
 *  Example : mob:unfollow()
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::unfollow()
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Invalid entity (%s) calling function.", m_PBaseEntity->getName());
        return;
    }

    auto* controller = static_cast<CMobController*>(m_PBaseEntity->PAI->GetController());
    controller->ClearFollowTarget();
}

/************************************************************************
 *  Function: setCarefulPathing(...)
 *  Purpose : Enables or disables careful pathing for an entity.
 *  Example : mob:setCarefulPathing(true)
 *  Notes   : !!! THIS IS VERY EXPENSIVE !!!. Only use this as a last resort!
 ************************************************************************/

void CLuaBaseEntity::setCarefulPathing(bool careful)
{
    if (m_PBaseEntity->PAI->PathFind)
    {
        m_PBaseEntity->PAI->PathFind->SetCarefulPathing(careful);
    }
}

/************************************************************************
 *  Function: openDoor()
 *  Purpose : Opens a door for 7 seconds; different time can be specified
 *  Example : npc:openDoor(30) -- Open for 30 sec; npc:openDoor() -- 7 sec
 ************************************************************************/

void CLuaBaseEntity::openDoor(sol::object const& seconds)
{
    if (m_PBaseEntity->objtype != TYPE_NPC)
    {
        ShowWarning("Attempting to open door with invalid entity type (%s).", m_PBaseEntity->getName());
        return;
    }

    if (m_PBaseEntity->animation == ANIMATION_CLOSE_DOOR)
    {
        uint32 OpenTime = (seconds != sol::lua_nil) ? seconds.as<uint32>() * 1000 : 7000;

        m_PBaseEntity->animation = ANIMATION_OPEN_DOOR;
        m_PBaseEntity->loc.zone->UpdateEntityPacket(m_PBaseEntity, ENTITY_UPDATE, UPDATE_COMBAT);

        // clang-format off
        m_PBaseEntity->PAI->QueueAction(queueAction_t(std::chrono::milliseconds(OpenTime), false,
        [](CBaseEntity* PNpc)
        {
            PNpc->animation = ANIMATION_CLOSE_DOOR;
            PNpc->loc.zone->UpdateEntityPacket(PNpc, ENTITY_UPDATE, UPDATE_COMBAT);
        }));
        // clang-format on
    }
}

/************************************************************************
 *  Function: closeDoor()
 *  Purpose : Closes a door for 7 seconds; different delay can be specified
 *  Example : npc:closeDoor(); GetNPCByID(ID.npc.LANTERN):closeDoor(1)
 ************************************************************************/

void CLuaBaseEntity::closeDoor(sol::object const& seconds)
{
    if (m_PBaseEntity->objtype != TYPE_NPC)
    {
        ShowWarning("CLuaBaseEntity::closeDoor() - Non-NPC passed to function.");
        return;
    }

    if (m_PBaseEntity->animation == ANIMATION_OPEN_DOOR)
    {
        uint32 CloseTime         = (seconds != sol::lua_nil) ? seconds.as<uint32>() * 1000 : 7000;
        m_PBaseEntity->animation = ANIMATION_CLOSE_DOOR;
        m_PBaseEntity->loc.zone->UpdateEntityPacket(m_PBaseEntity, ENTITY_UPDATE, UPDATE_COMBAT);

        // clang-format off
        m_PBaseEntity->PAI->QueueAction(queueAction_t(std::chrono::milliseconds(CloseTime), false, [](CBaseEntity* PNpc)
        {
            PNpc->animation = ANIMATION_OPEN_DOOR;
            PNpc->loc.zone->UpdateEntityPacket(PNpc, ENTITY_UPDATE, UPDATE_COMBAT);
        }));
        // clang-format on
    }
}

/************************************************************************
 *  Function: setElevator()
 *  Purpose : Initializes an elevator or something that moves regularly
 *  Example : See Comments Below
 *  Notes   : See: scripts/zones/Metalworks/npcs/_6lt.lua
 ************************************************************************/

void CLuaBaseEntity::setElevator(uint8 id, uint32 lowerDoor, uint32 upperDoor, uint32 elevatorId, bool reversed)
{
    // Usage: setElevator(id, lower door id, upper door id, elevator platform id, animations reversed bool)
    // If giving the elevator ANIMATION_ELEVATOR_UP makes it go down, set this bool to true
    if (m_PBaseEntity->objtype != TYPE_NPC)
    {
        ShowWarning("Attempting to set elevator with invalid entity type (%s).", m_PBaseEntity->getName());
        return;
    }

    Elevator_t elevator = {};

    elevator.id                 = id;
    elevator.LowerDoor          = static_cast<CNpcEntity*>(zoneutils::GetEntity(lowerDoor, TYPE_NPC));
    elevator.UpperDoor          = static_cast<CNpcEntity*>(zoneutils::GetEntity(upperDoor, TYPE_NPC));
    elevator.Elevator           = static_cast<CNpcEntity*>(zoneutils::GetEntity(elevatorId, TYPE_NPC));
    elevator.animationsReversed = reversed;
    elevator.state              = STATE_ELEVATOR_BOTTOM;
    elevator.lastTrigger        = 0;

    if (!elevator.Elevator || !elevator.LowerDoor || !elevator.UpperDoor)
    {
        ShowWarning("Elevator id %d initialization failed - an ID resolved to no entity.", elevatorId);
        return;
    }

    // ID of 0 means it is a timed, automatic elevator
    elevator.activated   = elevator.id == 0;
    elevator.isPermanent = elevator.id == 0;

    elevator.movetime = 3;
    elevator.interval = 8;

    elevator.zoneID = m_PBaseEntity->loc.zone->GetID();

    CTransportHandler::getInstance()->insertElevator(elevator);
}

/************************************************************************
 *  Function: addPeriodicTrigger()
 *  Purpose : registers a periodic trigger for an NPC
 *  Example : BastokDrawbridge:addPeriodicTrigger(0, 360, 80)
 *  Notes   : See usage below
 ************************************************************************/

void CLuaBaseEntity::addPeriodicTrigger(uint8 id, uint16 period, uint16 minOffset)
{
    // Usage npc:addPeriodicTrigger( triggerID, period, minute offset )
    // triggerID is an ID unique to the NPC
    // period is the time in vanadiel minutes that separates two triggers of the event
    // minute offset is the time in vanadiel minutes after the se epoch that the trigger period should synchronize to

    if (m_PBaseEntity->objtype != TYPE_NPC)
    {
        ShowWarning("Attempting to add periodic trigger to invalid entity type (%s).", m_PBaseEntity->getName());
        return;
    }

    Trigger_t trigger{};

    trigger.id           = id;
    trigger.period       = period;
    trigger.minuteOffset = minOffset;
    trigger.npc          = dynamic_cast<CNpcEntity*>(zoneutils::GetEntity(m_PBaseEntity->id, TYPE_NPC));
    trigger.lastTrigger  = 0;

    if (!trigger.npc)
    {
        ShowWarning("Trigger initialization failed - npc ID %d resolved to no entity.", m_PBaseEntity->id);
        return;
    }

    CTriggerHandler::getInstance()->insertTrigger(trigger);
}

/************************************************************************
 *  Function: showNPC()
 *  Purpose : Opposite of hide, shows an NPC for a set amount of time
 *  Example : npc:showNPC(30) -- Appears for 30 sec, then disappears
 *  Notes   : Default is 15 seconds
 ************************************************************************/

void CLuaBaseEntity::showNPC(sol::object const& seconds)
{
    if (m_PBaseEntity->objtype != TYPE_NPC)
    {
        ShowWarning("Attempting to show NPC with invalid entity type (%s).", m_PBaseEntity->getName());
        return;
    }

    uint32 showTime = (seconds != sol::lua_nil) ? seconds.as<uint32>() * 1000 : 15000;

    m_PBaseEntity->status = STATUS_TYPE::NORMAL;
    m_PBaseEntity->loc.zone->UpdateEntityPacket(m_PBaseEntity, ENTITY_UPDATE, UPDATE_COMBAT);

    // clang-format off
    m_PBaseEntity->PAI->QueueAction(queueAction_t(std::chrono::milliseconds(showTime), false, [](CBaseEntity* PNpc)
    {
        PNpc->status = STATUS_TYPE::DISAPPEAR;
        PNpc->loc.zone->UpdateEntityPacket(PNpc, ENTITY_DESPAWN, UPDATE_NONE);
    }));
    // clang-format on
}

/************************************************************************
 *  Function: hideNPC()
 *  Purpose : Hides an NPC for a set amount of time
 *  Example : npc:hideNPC(30) -- Will hide for 30 seconds
 *  Notes   : Default is 15 seconds
 ************************************************************************/

void CLuaBaseEntity::hideNPC(sol::object const& seconds)
{
    if (m_PBaseEntity->objtype != TYPE_NPC)
    {
        ShowWarning("Attempting to hide NPC with invalid entity type (%s).", m_PBaseEntity->getName());
        return;
    }

    if (m_PBaseEntity->status == STATUS_TYPE::NORMAL)
    {
        uint32 hideTime = (seconds != sol::lua_nil) ? seconds.as<uint32>() * 1000 : 15000;

        m_PBaseEntity->status = STATUS_TYPE::DISAPPEAR;
        m_PBaseEntity->loc.zone->UpdateEntityPacket(m_PBaseEntity, ENTITY_DESPAWN, UPDATE_NONE);

        // clang-format off
        m_PBaseEntity->PAI->QueueAction(queueAction_t(std::chrono::milliseconds(hideTime), false, [](CBaseEntity* PNpc)
        {
            PNpc->status = STATUS_TYPE::NORMAL;
            PNpc->loc.zone->UpdateEntityPacket(PNpc, ENTITY_UPDATE, UPDATE_COMBAT);
        }));
        // clang-format on
    }
}

/************************************************************************
 *  Function: updateNPCHideTime()
 *  Purpose : Adds more time to an NPC being hidden
 *  Example : npc:updateNPCHideTime(50000) -- Hide-and-Seek World Champ
 *  Notes   : Default is 15 seconds
 ************************************************************************/

void CLuaBaseEntity::updateNPCHideTime(sol::object const& seconds)
{
    if (m_PBaseEntity->objtype != TYPE_NPC)
    {
        ShowWarning("Attempting to update NPC hide time with invalid entity type (%s).", m_PBaseEntity->getName());
        return;
    }

    if (m_PBaseEntity->status == STATUS_TYPE::DISAPPEAR)
    {
        uint32 hideTime = (seconds != sol::lua_nil) ? seconds.as<uint32>() * 1000 : 15000;

        // clang-format off
        m_PBaseEntity->PAI->QueueAction(queueAction_t(std::chrono::milliseconds(hideTime), false, [](CBaseEntity* PNpc)
        {
            PNpc->status = STATUS_TYPE::NORMAL;
            PNpc->loc.zone->UpdateEntityPacket(PNpc, ENTITY_UPDATE, UPDATE_COMBAT);
        }));
        // clang-format on
    }
}

/************************************************************************
 *  Function: getWeather()
 *  Purpose : Returns the current weather status
 *  Example : if player:getWeather() == xi.weather.WIND then
 ************************************************************************/

uint8 CLuaBaseEntity::getWeather(sol::object const& ignoreScholar)
{
    WEATHER weather = WEATHER_NONE;

    if (m_PBaseEntity->objtype & TYPE_PC || m_PBaseEntity->objtype & TYPE_MOB)
    {
        bool ignoreScholarWeather = ignoreScholar.is<bool>() ? ignoreScholar.as<bool>() : false;
        weather                   = battleutils::GetWeather(static_cast<CBattleEntity*>(m_PBaseEntity), ignoreScholarWeather);
    }
    else
    {
        weather = zoneutils::GetZone(m_PBaseEntity->getZone())->GetWeather();
    }

    return static_cast<uint8>(weather);
}

/************************************************************************
 *  Function: setWeather()
 *  Purpose : Updates the current weather status
 *  Example : player:setWeather(weatherList.sunshine);
 *  Notes   : Only used for GM command: scripts/commands/setweather.lua
 ************************************************************************/

void CLuaBaseEntity::setWeather(uint8 weatherType)
{
    if (weatherType < MAX_WEATHER_ID)
    {
        zoneutils::GetZone(m_PBaseEntity->getZone())->SetWeather(static_cast<WEATHER>(weatherType));
        luautils::OnZoneWeatherChange(m_PBaseEntity->getZone(), weatherType);
    }
}

/************************************************************************
 *  Function: changeMusic()
 *  Purpose : Select a new .bgw file to play on the client
 *  Example : player:changeMusic(5,84)
 *  Notes   : Used for mounting Chocobo and changing Jeuno music in Winter
 ************************************************************************/

void CLuaBaseEntity::changeMusic(uint16 blockID, uint16 musicTrackID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    PChar->pushPacket<CChangeMusicPacket>(blockID, musicTrackID);
}

/************************************************************************
 *  Function: sendMenu()
 *  Purpose : Sends a menu to the PC (Ex: Auction, Mog House, Shop)
 *  Example : player:sendMenu(xi.menuType.AUCTION)
 ************************************************************************/

void CLuaBaseEntity::sendMenu(uint32 menu)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    switch (menu)
    {
        case 1:
            PChar->pushPacket<CMenuMogPacket>();
            break;
        case 2:
            PChar->pushPacket<CShopMenuPacket>(PChar);
            PChar->pushPacket<CShopItemsPacket>(PChar);
            break;
        case 3:
            PChar->pushPacket<CAuctionHousePacket>(2);
            break;
        default:
            ShowDebug("Menu %i not implemented, yet.", menu);
            break;
    }
}

/************************************************************************
 *  Function: sendGuild()
 *  Purpose : Sends a guild menu to the PC (Ex: Cooking, Smithing, etc)
 *  Example : if player:sendGuild(60426,1,18,6) then
 *  Notes   : L2 and L3 only need simplified 24-hour time format (1,2,etc)
 ************************************************************************/

bool CLuaBaseEntity::sendGuild(uint16 guildID, uint8 open, uint8 close, uint8 holiday)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return GUILD_OPEN;
    }

    if (open > close)
    {
        ShowWarning("Open Time (%d) exceeds Close Time (%d)", open, close);
        return GUILD_OPEN;
    }

    uint8 VanadielHour = (uint8)CVanaTime::getInstance()->getHour();

    GUILDSTATUS status = GUILD_OPEN;

    // Guild holiday - Removed in 2014
    // uint8 vanadielDay = (uint8)CVanaTime::getInstance()->getWeekday();
    //
    // if (vanadielDay == holiday)
    // {
    //     status = GUILD_HOLYDAY;
    // }

    if ((VanadielHour < open) || (VanadielHour >= close))
    {
        status = GUILD_CLOSE;
    }

    CItemContainer* PGuildShop = guildutils::GetGuildShop(guildID);
    auto*           PChar      = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->PGuildShop = PGuildShop;
    PChar->pushPacket<CGuildMenuPacket>(status, open, close, holiday);

    if (status == GUILD_OPEN)
    {
        PChar->pushPacket<CGuildMenuBuyPacket>(PChar, PGuildShop);
    }

    return status == GUILD_OPEN;
}

/************************************************************************
 *  Function: openSendBox()
 *  Purpose : Opens the send box for a PC
 *  Example : player:openSendBox()
 ************************************************************************/

void CLuaBaseEntity::openSendBox()
{
    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        dboxutils::OpenSendBox(PChar, 0x0D, 2);
    }
}

/************************************************************************
 *  Function: leaveGame()
 *  Purpose : Forces a client shutdown
 *  Example : player:leaveGame()
 *  Notes   : Used for logoff commands
 ************************************************************************/

void CLuaBaseEntity::leaveGame()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity);
    if (PChar)
    {
        // Because we can't detect if this is happening in the middle of an effect wearing off or not, this can be processed after player tick in CZoneEntities::ZoneServer
        PChar->status = STATUS_TYPE::SHUTDOWN;
    }
}

/************************************************************************
 *  Function: sendEmote()
 *  Purpose : Makes a player entity emit an emote.
 *  Example : player:sendEmote(npc, xi.emote.EXCAVATION, xi.emoteMode.MOTION)
 *  Notes   : Currently only used for HELM animations.
 ************************************************************************/

void CLuaBaseEntity::sendEmote(CLuaBaseEntity* target, uint8 emID, uint8 emMode)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    if (target)
    {
        auto* const PChar   = dynamic_cast<CCharEntity*>(m_PBaseEntity);
        auto* const PTarget = target->GetBaseEntity();

        if (PChar && PTarget)
        {
            const auto emoteID   = static_cast<Emote>(emID);
            const auto emoteMode = static_cast<EmoteMode>(emMode);

            PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, std::make_unique<CCharEmotionPacket>(PChar, PTarget->id, PTarget->targid, emoteID, emoteMode, 0));
        }
    }
}

/************************************************************************
 *  Function: getWorldAngle()
 *  Purpose : Returns angle between two entities, relative to cardinal direction
 *  Example : player:worldAngle(target)
 *  Notes   : Target is... 0: east; 64: south; 128: west, 192: north
 *            Default angle is 255-based mob rotation value - NOT a 360 angle
 *            CAREFUL! If the entities are too close, this can return unexpected results.
 ************************************************************************/

int16 CLuaBaseEntity::getWorldAngle(sol::variadic_args va)
{
    int16 angle = 0;

    if (va.get_type(0) == sol::type::userdata)
    {
        angle = worldAngle(m_PBaseEntity->loc.p, va.get<CLuaBaseEntity*>(0)->GetBaseEntity()->loc.p);

        int16 degrees = (va[1].get_type() == sol::type::number) ? va[1].as<int16>() : 256;
        if (degrees != 256)
        {
            if (degrees % 4 == 0)
            {
                angle = static_cast<int16>(round((angle * M_PI / 128) * (degrees / (2 * M_PI))));
                angle = angle % degrees; // If we rounded up to the "final" angle, we want the starting angle
            }
            else
            {
                ShowError("getWorldAngle: Called with degrees %d which isn't multiple of 4 ", degrees);
            }
        }
    }
    else
    {
        float posX = va.get_type(0) == sol::type::number ? va.get<float>(0) : 0.0f;
        float posY = va.get_type(1) == sol::type::number ? va.get<float>(1) : 0.0f;
        float posZ = va.get_type(2) == sol::type::number ? va.get<float>(2) : 0.0f;

        position_t point{ posX, posY, posZ, false, 0 };

        angle = worldAngle(m_PBaseEntity->loc.p, point);
    }

    return angle;
}

/************************************************************************
 *  Function: getFacingAngle()
 *  Purpose : Returns angle comparison of where entity is facing versus where
 *            a target is. Returned value is how many degrees the
 *            entity would need to turn to directly face the target.
 *  Example : attacker:getFacingAngle(defender)
 *  Notes   : 0: directly facing; 64: to a side; 128 target behind entity
 *            Returned angle is 255-based rotation value - NOT a 360 angle
 *            Return value is signed to indicate this shortest turn direction.
 *            Negative: counter-clockwise (left), Positive: clockwise (right)
 *            CAREFUL! If the entities are too close, this can return unexpected results.
 ************************************************************************/

int16 CLuaBaseEntity::getFacingAngle(CLuaBaseEntity const* target)
{
    return facingAngle(m_PBaseEntity->loc.p, target->GetBaseEntity()->loc.p);
}

/************************************************************************
 *  Function: isFacing()
 *  Purpose : Returns true if an entity is facing another entity
 *  Example : if attacker:isFacing(target) then
 *  Notes   : Can specify angle for wider/narrower ranges
 ************************************************************************/

bool CLuaBaseEntity::isFacing(CLuaBaseEntity const* target, sol::object const& angleArg)
{
    uint8 angle = (angleArg != sol::lua_nil) ? angleArg.as<uint8>() : 64;

    return facing(m_PBaseEntity->loc.p, target->GetBaseEntity()->loc.p, angle);
}

/************************************************************************
 *  Function: isInfront()
 *  Purpose : Returns true if an entity is in front of another entity
 *  Example : if attacker:isInfront(target) then
 *  Notes   : Can specify angle for wider/narrower ranges
 ************************************************************************/

bool CLuaBaseEntity::isInfront(CLuaBaseEntity const* target, sol::object const& angleArg)
{
    uint8 angle = (angleArg != sol::lua_nil) ? angleArg.as<uint8>() : 64;

    return infront(m_PBaseEntity->loc.p, target->GetBaseEntity()->loc.p, angle);
}

/************************************************************************
 *  Function: isBehind()
 *  Purpose : Returns true if an entity is behind another entity
 *  Example : if attacker:isBehind(target) then
 *  Notes   : Can specify angle for wider/narrower ranges
 ************************************************************************/

bool CLuaBaseEntity::isBehind(CLuaBaseEntity const* target, sol::object const& angleArg)
{
    uint8 angle = (angleArg != sol::lua_nil) ? angleArg.as<uint8>() : 64;

    return behind(m_PBaseEntity->loc.p, target->GetBaseEntity()->loc.p, angle);
}

/************************************************************************
 *  Function: isBeside()
 *  Purpose : Returns true if an entity is to the side of another entity
 *  Example : if attacker:isBeside(target) then
 *  Notes   : Can specify angle for wider/narrower ranges
 ************************************************************************/

bool CLuaBaseEntity::isBeside(CLuaBaseEntity const* target, sol::object const& angleArg)
{
    uint8 angle = (angleArg != sol::lua_nil) ? angleArg.as<uint8>() : 64;

    return beside(m_PBaseEntity->loc.p, target->GetBaseEntity()->loc.p, angle);
}

/************************************************************************
 *  Function: getZone(isZoning)
 *  Purpose : Returns a pointer to a zone object?
 *  Example : if player:getZone() == mob:getZone() then
 *  Notes   : To Do: I don't think some scripts are using this correctly...
 *  Optional isZoning parameter will return player's destination zone if
 *  they are in the process of zoning (for use in onZoneIn)
 ************************************************************************/

std::optional<CLuaZone> CLuaBaseEntity::getZone(sol::object const& arg0)
{
    if (m_PBaseEntity->loc.zone)
    {
        return std::optional<CLuaZone>(m_PBaseEntity->loc.zone);
    }
    else if (m_PBaseEntity->loc.destination && (arg0 != sol::lua_nil) && arg0.is<bool>() && arg0.as<bool>() != false)
    {
        return std::optional<CLuaZone>(zoneutils::GetZone(m_PBaseEntity->loc.destination));
    }

    return std::nullopt;
}

/************************************************************************
 *  Function: getZoneID()
 *  Purpose : Returns the integer value associated with the current zone
 *  Example : if player:getZoneID() == xi.zone.AHT_URHGAN_WHITEGATE then
 *  Notes   :
 ************************************************************************/

uint16 CLuaBaseEntity::getZoneID()
{
    return m_PBaseEntity->getZone();
}

/************************************************************************
 *  Function: getZoneName()
 *  Purpose : Returns the string text assigned to the zone
 *  Example : local zoneName = player:getZoneName()
 *  Notes   : Highly useful for the above example
 ************************************************************************/

auto CLuaBaseEntity::getZoneName() -> std::string
{
    if (m_PBaseEntity->loc.zone == nullptr)
    {
        ShowWarning("Attempting to get Zone Name when player's zone is null.");
        return {};
    }

    return m_PBaseEntity->loc.zone->getName();
}

/************************************************************************
 *  Function: hasVisitedZone()
 *  Purpose : Returns true if a player has ever visited the zone
 *  Example : if not target:hasVisitedZone(xi.zone.BIBIKI_BAY) then
 *  Notes   : Mainly used for teleport items (like to Bibiki Bay)
 ************************************************************************/

bool CLuaBaseEntity::hasVisitedZone(uint16 zone)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    return hasBit(zone, PChar->m_ZonesList, sizeof(PChar->m_ZonesList));
}

/************************************************************************
 *  Function: getPreviousZone()
 *  Purpose : Returns the integer ID of the last zone the PC visited
 *  Example : local prev = player:getPreviousZone()
 *  Notes   : Useful for returning players to their last position
 ************************************************************************/

uint16 CLuaBaseEntity::getPreviousZone()
{
    return m_PBaseEntity->loc.prevzone;
}

/************************************************************************
 *  Function: getCurrentRegion()
 *  Purpose : Returns the integer value of the PC's region
 *  Example : local region = target:getCurrentRegion()
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getCurrentRegion()
{
    return static_cast<uint8>(zoneutils::GetCurrentRegion(m_PBaseEntity->getZone()));
}

/************************************************************************
 *  Function: getContinentID()
 *  Purpose : Returns the integer value of a continent
 *  Example : local continentId = player:getContinentID()
 *  Notes   : Used in Signet/Sanction applications
 ************************************************************************/

uint8 CLuaBaseEntity::getContinentID()
{
    return static_cast<uint8>(m_PBaseEntity->loc.zone->GetContinentID());
}

/************************************************************************
 *  Function: isInMogHouse()
 *  Purpose : Returns true if a PC is in their Mog House
 *  Example : if player:isInMogHouse() then -- watch Netflix and chill
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isInMogHouse()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    return static_cast<CCharEntity*>(m_PBaseEntity)->m_moghouseID;
}

/************************************************************************
*  Function: getPlayerTriggerAreaInZone
*  Purpose : Returns the player's current trigger area inside the zone
*  Example : local triggerAreaID = player:getPlayerTriggerAreaInZone()
*  Notes   : This refers to trigger areas added via the registerTriggerArea function
             Currently only used for port bastok drawbridge
************************************************************************/
uint32 CLuaBaseEntity::getPlayerTriggerAreaInZone()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    return PChar->m_InsideTriggerAreaID;
}

/************************************************************************
*  Function: updateToEntireZone
*  Purpose : Updates NPC status/animation then sends an update packet zone-wide.
*  Example : drawBridge:updateToEntireZone()
*  Notes   : Currently only used for port bastok drawbridge as
             setAnimation() only updates for chars in range.
************************************************************************/
void CLuaBaseEntity::updateToEntireZone(uint8 statusID, uint8 animation, sol::object const& matchTime)
{
    if (m_PBaseEntity->objtype != TYPE_NPC)
    {
        ShowWarning("Attempting to update NPC to entire zone with invalid entity type (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PNpc          = static_cast<CNpcEntity*>(m_PBaseEntity);
    bool  updateForTime = (matchTime != sol::lua_nil) ? matchTime.as<bool>() : false;

    PNpc->status    = static_cast<STATUS_TYPE>(statusID);
    PNpc->animation = animation;

    // If this flag is high, update the NPC's name to match the current time
    if (updateForTime == true)
    {
        PNpc->SetLocalVar("TransportTimestamp", CVanaTime::getInstance()->getVanaTime());
    }

    PNpc->loc.zone->UpdateEntityPacket(PNpc, ENTITY_UPDATE, UPDATE_COMBAT, true);
}

// Sends an arbitrary entity update to a specific player only
void CLuaBaseEntity::sendEntityUpdateToPlayer(CLuaBaseEntity* entityToUpdate, uint8 entityUpdate, uint8 updateMask)
{
    if (m_PBaseEntity->objtype == TYPE_PC && entityToUpdate->GetBaseEntity())
    {
        CCharEntity* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

        PChar->updateEntityPacket(entityToUpdate->GetBaseEntity(), static_cast<ENTITYUPDATE>(entityUpdate), updateMask);
    }
}

// Seems to be needed for Chocobo Racing
void CLuaBaseEntity::sendEmptyEntityUpdateToPlayer(CLuaBaseEntity* entityToUpdate)
{
    if (m_PBaseEntity->objtype == TYPE_PC && entityToUpdate->GetBaseEntity())
    {
        auto packet = std::make_unique<CBasicPacket>();
        packet->setType(0x0E);
        packet->setSize(0x50);
        packet->ref<uint32>(0x04) = entityToUpdate->GetBaseEntity()->id;
        packet->ref<uint16>(0x08) = entityToUpdate->GetBaseEntity()->targid;
        packet->ref<uint8>(0x0A)  = 0x20; // Matches retail observation
        packet->ref<uint8>(0x30)  = 0x01; // MODEL_TYPE::MODEL_EQUIPPED
        static_cast<CCharEntity*>(m_PBaseEntity)->pushPacket(std::move(packet));
    }
}

void CLuaBaseEntity::forceRezone()
{
    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        charutils::ForceRezone(PChar);
    }
}

void CLuaBaseEntity::forceLogout()
{
    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        charutils::ForceLogout(PChar);
    }
}

/************************************************************************
 *  Function: getPos()
 *  Purpose : Returns a table of signed coordinates (x,y,z,rot)
 *  Example : local pos = battletarget:getPos() -- pos becomes a Lua table
 *  Notes   : Access values with key identifiers (pos.x or pos.y)
 ************************************************************************/

auto CLuaBaseEntity::getPos() -> sol::table
{
    auto pos = lua.create_table();

    pos["x"]   = m_PBaseEntity->loc.p.x;
    pos["y"]   = m_PBaseEntity->loc.p.y;
    pos["z"]   = m_PBaseEntity->loc.p.z;
    pos["rot"] = m_PBaseEntity->loc.p.rotation;

    return pos;
}

/************************************************************************
 *  Function: showPosition()
 *  Purpose : Displays PC's coordinates in standard message
 *  Example : player:showPosition()
 *  Notes   : Format: x,y,z,rot
 ************************************************************************/

void CLuaBaseEntity::showPosition()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->pushPacket<CMessageStandardPacket>((int32)PChar->loc.p.x, (int32)PChar->loc.p.y, (int32)PChar->loc.p.z, PChar->loc.p.rotation, MsgStd::Compass);
}

/************************************************************************
 *  Function: getXPos()
 *  Purpose : Returns a signed x coordinate
 *  Example : local x = player:getXPos()
 *  Notes   :
 ************************************************************************/

float CLuaBaseEntity::getXPos()
{
    return m_PBaseEntity->GetXPos();
}

/************************************************************************
 *  Function: getYPos()
 *  Purpose : Returns a signed y coordinate
 *  Example : local y = player:getYPos()
 *  Notes   :
 ************************************************************************/

float CLuaBaseEntity::getYPos()
{
    return m_PBaseEntity->GetYPos();
}

/************************************************************************
 *  Function: getZPos()
 *  Purpose : Returns a signed z coordinate
 *  Example : local z = player:getZPos()
 *  Notes   :
 ************************************************************************/

float CLuaBaseEntity::getZPos()
{
    return m_PBaseEntity->GetZPos();
}

/************************************************************************
 *  Function: getRotPos()
 *  Purpose : Returns an unsigned rotation coordinate
 *  Example : local rot = player:getRotPos()
 *  Notes   : Rot = Rotation of 0-359 degrees
 ************************************************************************/

uint8 CLuaBaseEntity::getRotPos()
{
    return m_PBaseEntity->GetRotPos();
}

/************************************************************************
 *  Function: setRotation()
 *  Purpose : Sets the rotation of the entity.
 *  Example : npc:setRotation(82)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setRotation(uint8 rotation)
{
    m_PBaseEntity->loc.p.rotation = rotation;
    m_PBaseEntity->updatemask |= UPDATE_POS;
}

/************************************************************************
 *  Function: setPos()
 *  Purpose : Sends a PC to a new position
 *  Example : player:setPos(x,y,z,rot,zone) -- zone value is optional
 *  Notes   : Using without zone will send player to coordinates on same map
 *          : Can handle:
 *          : setPos(1, 2, 3, 4, 5),
 *          : setPos({ 1, 2, 3, 4, 5 }),
 *          : setPos(({ x = 1, y = 2, z = 3, rotation = 4, zone = 5 }))
 ************************************************************************/

void CLuaBaseEntity::setPos(sol::variadic_args va)
{
    float x        = 0;
    float y        = 0;
    float z        = 0;
    uint8 rotation = 0;

    if (va[0].is<sol::table>())
    {
        auto table = va[0].as<sol::table>();
        if (table["x"].get_type() == sol::type::number) // Named table
        {
            x        = table["x"].get_or<float>(m_PBaseEntity->loc.p.x);
            y        = table["y"].get_or<float>(m_PBaseEntity->loc.p.y);
            z        = table["z"].get_or<float>(m_PBaseEntity->loc.p.z);
            rotation = table["rotation"].get_or<uint8>(m_PBaseEntity->loc.p.rotation);
        }
        else // Raw table
        {
            x        = table[1].get_or<float>(m_PBaseEntity->loc.p.x);
            y        = table[2].get_or<float>(m_PBaseEntity->loc.p.y);
            z        = table[3].get_or<float>(m_PBaseEntity->loc.p.z);
            rotation = table[4].get_or<uint8>(m_PBaseEntity->loc.p.rotation);
        }
    }
    else if (va[0].is<float>()) // Pure args
    {
        x        = va[0].get_type() == sol::type::number ? va[0].as<float>() : m_PBaseEntity->loc.p.x;
        y        = va[1].get_type() == sol::type::number ? va[1].as<float>() : m_PBaseEntity->loc.p.y;
        z        = va[2].get_type() == sol::type::number ? va[2].as<float>() : m_PBaseEntity->loc.p.z;
        rotation = va[3].get_type() == sol::type::number ? va[3].as<uint8>() : m_PBaseEntity->loc.p.rotation;
    }
    else
    {
        ShowError("CLuaBaseEntity::setPos() - Received non-table or float value for first parameter!");
        return;
    }

    // Set
    m_PBaseEntity->loc.p.x        = x;
    m_PBaseEntity->loc.p.y        = y;
    m_PBaseEntity->loc.p.z        = z;
    m_PBaseEntity->loc.p.rotation = rotation;

    // Zoning
    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        auto* PChar = ((CCharEntity*)m_PBaseEntity);
        if (va[4].is<uint8>() && PChar->status == STATUS_TYPE::DISAPPEAR)
        {
            // do not modify zone/position if the character is already zoning
            return;
        }
    }

    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

        if (va[4].is<double>())
        {
            auto zoneid = va[4].as<uint16>();
            if (zoneid >= MAX_ZONEID)
            {
                return;
            }

            auto ipp = zoneutils::GetZoneIPP(zoneid);
            if (ipp == 0)
            {
                ShowWarning(fmt::format("Char {} requested zone ({}) returned IPP of 0", PChar->name, zoneid));
                PChar->pushPacket<CMessageSystemPacket>(0, 0, MsgStd::CouldNotEnter); // You could not enter the next area.
                return;
            }

            PChar->loc.destination     = zoneid;
            PChar->status              = STATUS_TYPE::DISAPPEAR;
            PChar->loc.boundary        = 0;
            PChar->m_moghouseID        = 0;
            PChar->requestedZoneChange = true;
        }
        else if (PChar->status != STATUS_TYPE::DISAPPEAR)
        {
            PChar->pushPacket<CPositionPacket>(PChar);
        }
    }
    m_PBaseEntity->updatemask |= UPDATE_POS;
}

/************************************************************************
 *  Function: warp()
 *  Purpose : Warps a PC to their established homepoint
 *  Example : player:warp()
 ************************************************************************/

void CLuaBaseEntity::warp()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        PChar->requestedWarp = true;
    }
}

/************************************************************************
 *  Function:teleport()
 *  Purpose : Teleports an entity to a position
 *  Example : mob:teleport(pos, battletarget)
 *  Notes   : scripts/globals/mobskills/tarutaru_warp_ii.lua
 ************************************************************************/

void CLuaBaseEntity::teleport(std::map<std::string, float> pos, sol::object const& arg1)
{
    m_PBaseEntity->loc.p.x = pos["x"];
    m_PBaseEntity->loc.p.y = pos["y"];
    m_PBaseEntity->loc.p.z = pos["z"];

    if (arg1.is<int>())
    {
        m_PBaseEntity->loc.p.rotation = arg1.as<uint8>();
    }
    else if (arg1.is<CLuaBaseEntity*>())
    {
        CLuaBaseEntity* PLuaBaseEntity = arg1.as<CLuaBaseEntity*>();
        m_PBaseEntity->loc.p.rotation  = worldAngle(m_PBaseEntity->loc.p, PLuaBaseEntity->GetBaseEntity()->loc.p);
    }

    m_PBaseEntity->loc.zone->PushPacket(m_PBaseEntity, CHAR_INRANGE, std::make_unique<CPositionPacket>(m_PBaseEntity));
    m_PBaseEntity->updatemask |= UPDATE_POS;
}

/************************************************************************
 *  Function: addTeleport(uint8 type, uint32 destination)
 *  Purpose : Grants acces to a new teleport for a PC
 *  Example : player:addTeleport(xi.teleport.type.HOMEPOINT,16)
 *  Notes   : Param 2 is bits to shift, not exponentiated value
 ************************************************************************/

void CLuaBaseEntity::addTeleport(uint8 teleType, uint32 bitval, sol::object const& setval)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        return;
    }

    CCharEntity* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    TELEPORT_TYPE type = static_cast<TELEPORT_TYPE>(teleType);
    uint32        bit  = 1 << bitval;
    uint8         set  = (setval != sol::lua_nil) ? setval.as<uint8>() : 0;

    if ((type == TELEPORT_TYPE::HOMEPOINT || type == TELEPORT_TYPE::SURVIVAL) && ((setval == sol::lua_nil) || set > 3))
    {
        ShowError("Lua::addteleport : Attempt to index array out-of-bounds or parameter is nil.");
    }
    else if (type == TELEPORT_TYPE::ABYSSEA_CONFLUX && (setval == sol::lua_nil || set >= MAX_ABYSSEAZONES))
    {
        ShowError("Lua::addTeleport : Attempt to add Abyssea Conflux with invalid setval or set variable.\n");
        return;
    }

    switch (type)
    {
        case TELEPORT_TYPE::OUTPOST_SANDY:
            PChar->teleport.outpostSandy |= bit;
            break;
        case TELEPORT_TYPE::OUTPOST_BASTOK:
            PChar->teleport.outpostBastok |= bit;
            break;
        case TELEPORT_TYPE::OUTPOST_WINDY:
            PChar->teleport.outpostWindy |= bit;
            break;
        case TELEPORT_TYPE::RUNIC_PORTAL:
            PChar->teleport.runicPortal |= bit;
            break;
        case TELEPORT_TYPE::PAST_MAW:
            PChar->teleport.pastMaw |= bit;
            break;
        case TELEPORT_TYPE::CAMPAIGN_SANDY:
            PChar->teleport.campaignSandy |= bit;
            break;
        case TELEPORT_TYPE::CAMPAIGN_BASTOK:
            PChar->teleport.campaignBastok |= bit;
            break;
        case TELEPORT_TYPE::CAMPAIGN_WINDY:
            PChar->teleport.campaignWindy |= bit;
            break;
        case TELEPORT_TYPE::HOMEPOINT:
            PChar->teleport.homepoint.access[set] |= bit;
            break;
        case TELEPORT_TYPE::SURVIVAL:
            PChar->teleport.survival.access[set] |= bit;
            break;
        case TELEPORT_TYPE::ABYSSEA_CONFLUX:
            PChar->teleport.abysseaConflux[set] |= bit;
            break;
        case TELEPORT_TYPE::WAYPOINT:
        {
            uint8 index  = bitval / 32;
            uint8 setBit = bitval % 32;

            PChar->teleport.waypoints.access[index] |= (1 << setBit);
        }
        break;
        case TELEPORT_TYPE::ESCHAN_PORTAL:
            PChar->teleport.eschanPortal |= bit;
            break;
        default:
            ShowError("LuaBaseEntity::addTeleport : Parameter 1 out of bounds.");
            return;
    }

    charutils::SaveTeleport(PChar, type);
}

/************************************************************************
 *  Function: getTeleport(uint8 type)
 *  Purpose : Returns bit mask or table for supplied type of teleport
 *  Example : player:getTeleport(xi.teleport.type.HOMEPOINT)
 *  Notes   :
 ************************************************************************/

uint32 CLuaBaseEntity::getTeleport(uint8 type, sol::object const& abysseaRegionObj)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        return 0;
    }

    TELEPORT_TYPE tele_type = static_cast<TELEPORT_TYPE>(type);
    CCharEntity*  PChar     = static_cast<CCharEntity*>(m_PBaseEntity);

    switch (tele_type)
    {
        case TELEPORT_TYPE::OUTPOST_SANDY:
            return PChar->teleport.outpostSandy;
            break;
        case TELEPORT_TYPE::OUTPOST_BASTOK:
            return PChar->teleport.outpostBastok;
            break;
        case TELEPORT_TYPE::OUTPOST_WINDY:
            return PChar->teleport.outpostWindy;
            break;
        case TELEPORT_TYPE::RUNIC_PORTAL:
            return PChar->teleport.runicPortal;
            break;
        case TELEPORT_TYPE::PAST_MAW:
            return PChar->teleport.pastMaw;
            break;
        case TELEPORT_TYPE::CAMPAIGN_SANDY:
            return PChar->teleport.campaignSandy;
            break;
        case TELEPORT_TYPE::CAMPAIGN_BASTOK:
            return PChar->teleport.campaignBastok;
            break;
        case TELEPORT_TYPE::CAMPAIGN_WINDY:
            return PChar->teleport.campaignWindy;
            break;
        case TELEPORT_TYPE::ABYSSEA_CONFLUX:
        {
            uint8 abysseaRegion = abysseaRegionObj.is<uint8>() ? abysseaRegionObj.as<uint8>() : MAX_ABYSSEAZONES;

            if (abysseaRegion >= MAX_ABYSSEAZONES)
            {
                return 0;
            }

            return PChar->teleport.abysseaConflux[abysseaRegion];
        }
        case TELEPORT_TYPE::ESCHAN_PORTAL:
            return PChar->teleport.eschanPortal;
            break;
        default:
            ShowError("LuaBaseEntity::getteleport : Parameter 1 out of bounds.");
    }

    return 0;
}

sol::table CLuaBaseEntity::getTeleportTable(uint8 type)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return sol::lua_nil;
    }

    sol::table teleTable = lua.create_table();

    TELEPORT_TYPE tele_type = static_cast<TELEPORT_TYPE>(type);
    CCharEntity*  PChar     = (CCharEntity*)m_PBaseEntity;

    switch (tele_type)
    {
        case TELEPORT_TYPE::HOMEPOINT:
            for (uint8 x = 0; x < 4; x++)
            {
                teleTable.add(PChar->teleport.homepoint.access[x]);
            }
            return teleTable;
            break;
        case TELEPORT_TYPE::SURVIVAL:
            for (uint8 x = 0; x < 4; x++)
            {
                teleTable.add(PChar->teleport.survival.access[x]);
            }
            return teleTable;
            break;
        case TELEPORT_TYPE::WAYPOINT:
            for (uint8 x = 0; x < 2; x++)
            {
                teleTable.add(PChar->teleport.waypoints.access[x]);
            }
            return teleTable;
            break;
        default:
            ShowError("LuaBaseEntity::getteleport : Parameter 1 out of bounds.");
    }

    return sol::lua_nil;
}

/************************************************************************
 *  Function: hasTeleport(uint8 type, uint8 bit, uint8 set (optional))
 *  Purpose : Returns true if player has HP, false otherwise
 *  Example : player:hasTeleport(xi.teleport.type.HOMEPOINT, bit, set)
 *  Notes   : Refactor this to reduce the amount of returns
 ************************************************************************/

bool CLuaBaseEntity::hasTeleport(uint8 tType, uint8 bit, sol::object const& arg2)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    TELEPORT_TYPE type = static_cast<TELEPORT_TYPE>(tType);
    uint8         set  = (arg2 == sol::lua_nil) ? 0 : arg2.as<uint8>();

    if (type == TELEPORT_TYPE::HOMEPOINT || type == TELEPORT_TYPE::SURVIVAL)
    {
        if ((arg2 == sol::lua_nil) || set > 3)
        {
            ShowError("Lua::addTeleport : Attempt to index array out-of-bounds or parameter is nil.");
            return false;
        }

        if (type == TELEPORT_TYPE::HOMEPOINT)
        {
            return PChar->teleport.homepoint.access[set] & (1 << bit);
        }
        else
        {
            return PChar->teleport.survival.access[set] & (1 << bit);
        }
    }

    switch (type)
    {
        case TELEPORT_TYPE::OUTPOST_SANDY:
        {
            return PChar->teleport.outpostSandy & (1 << bit);
        }
        case TELEPORT_TYPE::OUTPOST_BASTOK:
        {
            return PChar->teleport.outpostBastok & (1 << bit);
        }
        case TELEPORT_TYPE::OUTPOST_WINDY:
        {
            return PChar->teleport.outpostWindy & (1 << bit);
        }
        case TELEPORT_TYPE::RUNIC_PORTAL:
        {
            return PChar->teleport.runicPortal & (1 << bit);
        }
        case TELEPORT_TYPE::PAST_MAW:
        {
            return PChar->teleport.pastMaw & (1 << bit);
        }
        case TELEPORT_TYPE::CAMPAIGN_SANDY:
        {
            return PChar->teleport.campaignSandy & (1 << bit);
        }
        case TELEPORT_TYPE::CAMPAIGN_BASTOK:
        {
            return PChar->teleport.campaignBastok & (1 << bit);
        }
        case TELEPORT_TYPE::CAMPAIGN_WINDY:
        {
            return PChar->teleport.campaignWindy & (1 << bit);
        }
        case TELEPORT_TYPE::WAYPOINT:
        {
            uint8 index  = bit / 32;
            uint8 bitVal = bit % 32;

            return PChar->teleport.waypoints.access[index] & (1 << bitVal);
        }
        default:
        {
            ShowError("LuaBaseEntity::hasTeleport : Parameter 1 out of bounds.");
            return false;
        }
    }
}

/************************************************************************
 *  Function: setTeleportMenu(uint8 type)
 *  Purpose : Store favorite homepoints or menu layout
 *  Example : player:setTeleportMenu(xi.teleport.type.HOMEPOINT)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setTeleportMenu(uint16 type, sol::object const& teleportObj)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    CCharEntity*  PChar    = static_cast<CCharEntity*>(m_PBaseEntity);
    TELEPORT_TYPE teleType = static_cast<TELEPORT_TYPE>(type);

    if (teleType != TELEPORT_TYPE::HOMEPOINT && teleType != TELEPORT_TYPE::SURVIVAL && teleType != TELEPORT_TYPE::WAYPOINT)
    {
        ShowError("LuaBaseEntity::setteleportMenu : Invalid Teleport Type passed to function.");
        return;
    }

    switch (teleType)
    {
        case TELEPORT_TYPE::HOMEPOINT:
        {
            auto  favs = teleportObj.as<sol::table>();
            uint8 x    = 0;

            for (auto& entry : favs)
            {
                PChar->teleport.homepoint.menu[x++] = entry.second.as<int32>();
            }
        }
        break;

        case TELEPORT_TYPE::SURVIVAL:
        {
            auto  favs = teleportObj.as<sol::table>();
            uint8 x    = 0;

            for (auto& entry : favs)
            {
                PChar->teleport.survival.menu[x++] = entry.second.as<int32>();
            }
        }
        break;

        case TELEPORT_TYPE::WAYPOINT:
        {
            PChar->teleport.waypoints.confirmation = teleportObj.as<bool>();
        }
        break;

        default:
        {
            return;
        }
    }

    charutils::SaveTeleport(PChar, teleType);
}

/************************************************************************
 *  Function: getTeleportMenu(uint8)
 *  Purpose : Return lua table containing integer values for favs + layout
 *  Example : player:getTeleportMenu(xi.teleport.teleport.HOMEPOINT)
 *  Notes   :
 ************************************************************************/

sol::table CLuaBaseEntity::getTeleportMenu(uint8 type)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return sol::lua_nil;
    }

    CCharEntity*  PChar    = static_cast<CCharEntity*>(m_PBaseEntity);
    TELEPORT_TYPE teleType = static_cast<TELEPORT_TYPE>(type);

    if (teleType != TELEPORT_TYPE::HOMEPOINT && teleType != TELEPORT_TYPE::SURVIVAL && teleType != TELEPORT_TYPE::WAYPOINT)
    {
        ShowError("LuaBaseEntity::getTeleportMenu : Invalid Teleport Type passed to function.");
        return sol::lua_nil;
    }

    auto table = lua.create_table();
    switch (teleType)
    {
        case TELEPORT_TYPE::HOMEPOINT:
        {
            for (uint8 x = 0; x < 10; x++)
            {
                table.add(PChar->teleport.homepoint.menu[x]);
            }
        }
        break;

        case TELEPORT_TYPE::SURVIVAL:
        {
            for (uint8 x = 0; x < 10; x++)
            {
                table.add(PChar->teleport.survival.menu[x]);
            }
        }
        break;

        case TELEPORT_TYPE::WAYPOINT:
        {
            table.add(PChar->teleport.waypoints.confirmation);
        }
        break;

        default:
        {
            return sol::lua_nil;
        }
    }

    return table;
}

/************************************************************************
 *  Function: setHomePoint()
 *  Purpose : Sets a PC's homepoint.
 *  Example : player:setHomePoint(xi.teleport.type.HOMEPOINT)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setHomePoint()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->profile.home_point.p           = PChar->loc.p;
    PChar->profile.home_point.destination = PChar->getZone();

    const char* fmtQuery = "UPDATE chars \
                            SET home_zone = %u, home_rot = %u, home_x = %.3f, home_y = %.3f, home_z = %.3f \
                            WHERE charid = %u";

    _sql->Query(fmtQuery, PChar->profile.home_point.destination, PChar->profile.home_point.p.rotation, PChar->profile.home_point.p.x,
                PChar->profile.home_point.p.y, PChar->profile.home_point.p.z, PChar->id);
}

/************************************************************************
 *  Function: resetPlayer()
 *  Purpose : Delete player's account session and send them to Lower Jeuno
 *  Example : player:resetPlayer()
 *  Notes   : Function name is ambiguous
 ************************************************************************/

void CLuaBaseEntity::resetPlayer(const char* charName)
{
    uint32 id = 0;

    // char will not be logged in so get the id manually
    char escapedCharName[16 * 2 + 1];
    _sql->EscapeString(escapedCharName, charName);
    const char* Query = "SELECT charid FROM chars WHERE charname = '%s'";
    int32       ret   = _sql->Query(Query, escapedCharName);

    if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
    {
        id = _sql->GetIntData(0);
    }

    // could not get player from database
    if (id == 0)
    {
        ShowDebug("Could not get the character from database.");
        return;
    }

    // delete the account session
    Query = "DELETE FROM accounts_sessions WHERE charid = %u";
    _sql->Query(Query, id);

    // send the player to lower jeuno
    Query = "UPDATE chars "
            "SET "
            "pos_zone = %u,"
            "pos_prevzone = %u,"
            "pos_rot = %u,"
            "pos_x = %.3f,"
            "pos_y = %.3f,"
            "pos_z = %.3f,"
            "boundary = %u,"
            "moghouse = %u "
            "WHERE charid = %u";

    _sql->Query(Query,
                245,     // lower jeuno
                122,     // prev zone
                86,      // rotation
                33.464f, // x
                -5.000f, // y
                69.162f, // z
                0,       // boundary,
                0,       // moghouse,
                id);

    ShowDebug("Player reset was successful.");
}

/************************************************************************
 *  Function: goToEntity()
 *  Purpose : Transports PC to a Mob or NPC; works across multiple servers
 *  Example : player:goToEntity(ID, Option)
 *  Notes   : Option 0: Spawned/Unspawned | Option 1: Spawned only
 ************************************************************************/

void CLuaBaseEntity::goToEntity(uint32 targetID, sol::object const& option)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    bool spawnedOnly = (option != sol::lua_nil) ? option.as<bool>() : false;

    uint16 targetZone = (targetID >> 12) & 0x0FFF;
    uint16 playerID   = m_PBaseEntity->id;
    uint16 playerZone = PChar->loc.zone->GetID();

    char buf[12];
    std::memset(&buf[0], 0, sizeof(buf));

    ref<bool>(&buf, 0)    = true;        // Toggle for message routing; goes to entity server first
    ref<bool>(&buf, 1)    = spawnedOnly; // Specification for Spawned Only or Any
    ref<uint16>(&buf, 2)  = targetZone;
    ref<uint16>(&buf, 4)  = playerZone;
    ref<uint32>(&buf, 6)  = targetID;
    ref<uint16>(&buf, 10) = playerID;

    message::send(MSG_SEND_TO_ENTITY, &buf[0], sizeof(buf), nullptr);
}

/************************************************************************
 *  Function: gotoPlayer()
 *  Purpose : Transports PC to another PC
 *  Example : player:gotoPlayer(playername)
 ************************************************************************/

bool CLuaBaseEntity::gotoPlayer(std::string const& playerName)
{
    bool found = false;

    char escapedCharName[16 * 2 + 1];
    _sql->EscapeString(escapedCharName, playerName.c_str());

    const char* fmtQuery = "SELECT charid FROM chars WHERE charname = '%s'";
    int32       ret      = _sql->Query(fmtQuery, escapedCharName);

    if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
    {
        char buf[30];
        std::memset(&buf[0], 0, sizeof(buf));

        ref<uint32>(&buf, 0) = _sql->GetUIntData(0); // target char
        ref<uint32>(&buf, 4) = m_PBaseEntity->id;    // warping to target char, their server will send us a zoning message with their pos

        message::send(MSG_SEND_TO_ZONE, &buf[0], sizeof(buf), nullptr);
        found = true;
    }

    return found;
}

/************************************************************************
 *  Function: bringPlayer()
 *  Purpose : Brings a PC to another PC; returns true if success
 *  Example : player:bringPlayer(playername)
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::bringPlayer(std::string const& playerName)
{
    bool found = false;

    char escapedCharName[16 * 2 + 1];
    _sql->EscapeString(escapedCharName, playerName.c_str());

    const char* fmtQuery = "SELECT charid FROM chars WHERE charname = '%s'";
    int32       ret      = _sql->Query(fmtQuery, escapedCharName);

    if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
    {
        char buf[30];
        std::memset(&buf[0], 0, sizeof(buf));

        ref<uint32>(&buf, 0)  = _sql->GetUIntData(0); // target char
        ref<uint32>(&buf, 4)  = 0;                    // wanting to bring target char here so wont give our id
        ref<uint16>(&buf, 8)  = m_PBaseEntity->getZone();
        ref<uint16>(&buf, 10) = static_cast<uint16>(m_PBaseEntity->loc.p.x);
        ref<uint16>(&buf, 14) = static_cast<uint16>(m_PBaseEntity->loc.p.y);
        ref<uint16>(&buf, 18) = static_cast<uint16>(m_PBaseEntity->loc.p.z);
        ref<uint8>(&buf, 22)  = m_PBaseEntity->loc.p.rotation;

        if (m_PBaseEntity->objtype == TYPE_PC)
        {
            ref<uint32>(&buf, 23) = static_cast<CCharEntity*>(m_PBaseEntity)->m_moghouseID;
        }

        message::send(MSG_SEND_TO_ZONE, &buf[0], sizeof(buf), nullptr);
        found = true;
    }

    return found;
}

/************************************************************************
 *  Function: getEquipID()
 *  Purpose : Returns the Item ID for an item
 *  Example : player:getEquipID(xi.slot.MAIN)
 *  Notes   :
 ************************************************************************/

uint16 CLuaBaseEntity::getEquipID(SLOTTYPE slot)
{
    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        if (slot > 15)
        {
            ShowWarning("Invalid slot passed to function.");
            return 0;
        }

        CCharEntity* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity);
        CItem*       PItem = PChar->getEquip(slot);

        if (PItem && PItem->isType(ITEM_EQUIPMENT))
        {
            return PItem->getID();
        }
    }

    return 0;
}

/************************************************************************
 *  Function: getEquippedItem()
 *  Purpose : Returns the Item for a given slot
 *  Example : player:getEquippedItem(xi.slot.MAIN)
 *  Notes   :
 ************************************************************************/

std::optional<CLuaItem> CLuaBaseEntity::getEquippedItem(uint8 slot)
{
    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        if (slot > 15)
        {
            ShowWarning("Invalid slot passed to function.");
            return std::nullopt;
        }

        auto* PChar    = static_cast<CCharEntity*>(m_PBaseEntity);
        auto* slotItem = PChar->getEquip(static_cast<SLOTTYPE>(slot));

        if (slotItem)
        {
            return std::optional<CLuaItem>(slotItem);
        }
    }

    return std::nullopt;
}

/************************************************************************
 *  Function: hasEquipped(equipmentID)
 *  Purpose : Returns true if the player has the item equipped in any slot
 *  Example : player:hasEquipped(xi.item.BREATH_MANTLE)
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::hasEquipped(uint16 equipmentID)
{
    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        for (uint8 equipmentSlot = 0; equipmentSlot <= 15; equipmentSlot++)
        {
            if (getEquipID(static_cast<SLOTTYPE>(equipmentSlot)) == equipmentID)
            {
                return true;
            }
        }
    }
    return false;
}

/************************************************************************
 *  Function: hasItem()
 *  Purpose : Returns true if a player possesses an item
 *  Example : if player:hasItem(500) then -- Second var optional
 *  Notes   : Send with an L2 value to specify container
 ************************************************************************/

bool CLuaBaseEntity::hasItem(uint16 itemID, sol::object const& location)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        return false;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (location != sol::lua_nil)
    {
        uint8 locationID = LOC_INVENTORY;

        locationID = location.as<uint8>();
        locationID = (locationID < CONTAINER_ID::MAX_CONTAINER_ID ? locationID : (uint8)LOC_INVENTORY);

        return PChar->getStorage(locationID)->SearchItem(itemID) != ERROR_SLOTID;
    }

    return charutils::HasItem(PChar, itemID);
}

/************************************************************************
 *  Function: getItemCount()
 *  Purpose : Returns the total count of a specific item across all inventories
 *  Example : if player:getItemCount(xi.item.BONANZA_PEARL) then
 ************************************************************************/

uint32 CLuaBaseEntity::getItemCount(uint16 itemID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        return false;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    return charutils::getItemCount(PChar, itemID);
}

/************************************************************************
 *  Function: addItem()
 *  Purpose : Adds an item to a player's inventory
 *  Example : player:addItem(4102, 12) -- a stack of Light Crystals
 *  Notes   : See format and variable options below
 ************************************************************************/

bool CLuaBaseEntity::addItem(sol::variadic_args va)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    uint8 SlotID = ERROR_SLOTID;

    CCharEntity* PChar = (CCharEntity*)m_PBaseEntity;

    /* FORMAT 1:
    player:addItem({ id = itemID, quantity  = quantity               }) -- add quantity of itemID
    player:addItem({ id = itemID, silent    = true                   }) -- silently add 1 of itemID
    player:addItem({ id = itemID, signature = "Char"                 }) -- add 1 signed of itemID
    player:addItem({ id = itemID, augments  = { [4] = 5, [10] = 10 } }) -- add 1 of itemID with augment id 4 and 10, with values of 5 and 10, respectively
    player:addItem({ id = itemID, exdata    = { [10] = 10 }          }) -- add 1 item of itemID, with the exdata at index 10 (0-indexed!) set to 10
    */

    if (va.get_type(0) == sol::type::table)
    {
        auto table = va.get<sol::table>(0);

        if (!table["id"].valid())
        {
            ShowError("AddItem: id is nil");
            return false;
        }
        uint16 id = table.get<uint16>("id");

        int32 quantity = 1;
        if (table["quantity"].valid())
        {
            quantity = table.get<int32>("quantity");
        }

        while (PChar->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() != 0 && quantity > 0)
        {
            if (CItem* PItem = itemutils::GetItem(id))
            {
                PItem->setQuantity(quantity);
                quantity -= PItem->getStackSize();

                bool silent = table.get_or("silent", false);

                std::string signature;
                sol::object signatureObj = table["signature"];
                if (signatureObj.valid() && signatureObj.is<std::string>())
                {
                    signature = signatureObj.as<std::string>();
                }

                if (!signature.empty())
                {
                    char encoded[SignatureStringLength];

                    std::memset(&encoded, 0, sizeof(encoded));
                    PItem->setSignature(EncodeStringSignature(signature, encoded));
                }

                sol::object appraisalObj = table["appraisal"];
                if (appraisalObj.get_type() == sol::type::number)
                {
                    PItem->setAppraisalID(appraisalObj.as<uint8>());
                }

                if (PItem->isType(ITEM_EQUIPMENT))
                {
                    uint16 trial = table.get_or("trial", 0);
                    if (trial != 0)
                    {
                        ((CItemEquipment*)PItem)->setTrialNumber(trial);
                    }

                    sol::object augmentsObj = table["augments"];
                    if (augmentsObj.is<sol::table>())
                    {
                        auto augmentsTable = augmentsObj.as<sol::table>();
                        for (auto const& entryPair : augmentsTable)
                        {
                            auto   pair   = entryPair.second.as<sol::table>();
                            uint16 augid  = pair[0];
                            uint8  augval = pair[1];
                            ((CItemEquipment*)PItem)->PushAugment(augid, augval);
                        }
                    }
                }

                sol::object exdataObj = table["exdata"];
                if (exdataObj.is<sol::table>())
                {
                    auto exdataTable = exdataObj.as<sol::table>();
                    for (auto const& entryPair : exdataTable)
                    {
                        uint8 index = entryPair.first.as<uint8>();
                        uint8 value = entryPair.second.as<uint8>();

                        if (index < CItem::extra_size)
                        {
                            PItem->m_extra[index] = value;
                        }
                        else
                        {
                            ShowWarning("AddItem: Trying to write to invalid exdata index: <%i>", index);
                        }
                    }
                }

                SlotID = charutils::AddItem(PChar, LOC_INVENTORY, PItem, silent);
                if (SlotID == ERROR_SLOTID)
                {
                    break;
                }
            }
            else
            {
                ShowWarning("charplugin::AddItem: Item <%i> is not found in a database", id);
                break;
            }
        }
    }
    else
    {
        /* FORMAT 2:
        player:addItem(itemID, quantity) -- add quantity of itemID

        player:addItem(itemID, true) -- silently add 1 of itemID

        player:addItem(itemID, quantity, true) -- silently add quantity of itemID
        */

        uint16 itemID   = va.get<uint16>(0);
        bool   silence  = false;
        int32  quantity = 1;

        if (va.get_type(1) == sol::type::boolean)
        {
            silence = va.get<bool>(1);
        }
        else if (va.get_type(1) == sol::type::number)
        {
            quantity = va.get<int32>(1);
            if (va.get_type(2) == sol::type::boolean)
            {
                silence = va.get<bool>(2);
            }
        }

        uint16 augment0    = va.get_type(2) == sol::type::number ? va.get<uint16>(2) : 0;
        uint8  augment0val = va.get_type(3) == sol::type::number ? va.get<uint8>(3) : 0;
        uint16 augment1    = va.get_type(4) == sol::type::number ? va.get<uint16>(4) : 0;
        uint8  augment1val = va.get_type(5) == sol::type::number ? va.get<uint8>(5) : 0;
        uint16 augment2    = va.get_type(6) == sol::type::number ? va.get<uint16>(6) : 0;
        uint8  augment2val = va.get_type(7) == sol::type::number ? va.get<uint8>(7) : 0;
        uint16 augment3    = va.get_type(8) == sol::type::number ? va.get<uint16>(8) : 0;
        uint8  augment3val = va.get_type(9) == sol::type::number ? va.get<uint8>(9) : 0;
        uint16 trialNumber = va.get_type(10) == sol::type::number ? va.get<uint16>(10) : 0;

        while (PChar->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() != 0 && quantity > 0)
        {
            if (CItem* PItem = itemutils::GetItem(itemID))
            {
                PItem->setQuantity(quantity);
                quantity -= PItem->getStackSize();

                if (PItem->isType(ITEM_EQUIPMENT))
                {
                    if (augment0 != 0)
                    {
                        ((CItemEquipment*)PItem)->setAugment(0, augment0, augment0val);
                    }
                    if (augment1 != 0)
                    {
                        ((CItemEquipment*)PItem)->setAugment(1, augment1, augment1val);
                    }
                    if (augment2 != 0)
                    {
                        ((CItemEquipment*)PItem)->setAugment(2, augment2, augment2val);
                    }
                    if (augment3 != 0)
                    {
                        ((CItemEquipment*)PItem)->setAugment(3, augment3, augment3val);
                    }
                    if (trialNumber != 0)
                    {
                        ((CItemEquipment*)PItem)->setTrialNumber(trialNumber);
                    }
                }
                SlotID = charutils::AddItem(PChar, LOC_INVENTORY, PItem, silence);

                // Paranoid check
                if (SlotID == ERROR_SLOTID)
                {
                    break;
                }
            }
            else
            {
                ShowWarning("charplugin::AddItem: Item <%i> is not found in a database", itemID);
                break;
            }
        }
    }

    return SlotID != ERROR_SLOTID;
}

/************************************************************************
 *  Function: delItem()
 *  Purpose : Deletes an item from a player's inventory
 *  Example : player:delItem(4102, 12)
 *  Notes   : Can specify container using third variable
 ************************************************************************/

bool CLuaBaseEntity::delItem(uint16 itemID, int32 quantity, sol::object const& containerID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    uint8 location = containerID.get_type() == sol::type::number ? containerID.as<uint8>() : 0;

    if (location >= CONTAINER_ID::MAX_CONTAINER_ID)
    {
        ShowWarning("Lua::delItem: Attempting to delete an item from an invalid slot. Defaulting to main inventory.");
    }

    auto* PChar  = static_cast<CCharEntity*>(m_PBaseEntity);
    auto  SlotID = PChar->getStorage(location)->SearchItem(itemID);

    if (SlotID != ERROR_SLOTID)
    {
        charutils::UpdateItem(PChar, location, SlotID, -quantity);
        PChar->pushPacket<CInventoryFinishPacket>();

        return true;
    }

    return false;
}

/************************************************************************
 *  Function: delContainerItems()
 *  Purpose : Deletes all items from a specific player's container
 *  Example : player:delContainerItems(xi.inv.INVENTORY)
 *  Notes   : Used in delinventory command
 ************************************************************************/

bool CLuaBaseEntity::delContainerItems(sol::object const& containerID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    uint8 location = containerID.get_type() == sol::type::number ? containerID.as<uint8>() : 0;

    if (location >= CONTAINER_ID::MAX_CONTAINER_ID)
    {
        ShowWarning("Attempting to delete items from an invalid container.");
        return false;
    }

    auto* PChar          = static_cast<CCharEntity*>(m_PBaseEntity);
    auto* PItemContainer = PChar->getStorage(location);
    uint8 containerSize  = PItemContainer->GetSize();

    for (uint8 i = 1; i <= containerSize; ++i)
    {
        auto* PItem = PItemContainer->GetItem(i);

        if (PItem != nullptr)
        {
            int32 quantity = PItem->getQuantity();

            charutils::UpdateItem(PChar, location, i, -quantity);
        }
    }

    PChar->pushPacket<CInventoryFinishPacket>();
    return true;
}

/************************************************************************
 *  Function: addUsedItem()
 *  Purpose : Add charged item with use timer already on full cooldown
 *  Example : player:addUsedItem(xi.item.WARP_CUDGEL)
 ************************************************************************/

bool CLuaBaseEntity::addUsedItem(uint16 itemID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    auto* PChar  = static_cast<CCharEntity*>(m_PBaseEntity);
    uint8 SlotID = ERROR_SLOTID;

    if (PChar->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() != 0)
    {
        CItem* PItem = itemutils::GetItem(itemID);

        if (PItem != nullptr)
        {
            if (PItem->isSubType(ITEM_CHARGED))
            {
                auto* PUsable = static_cast<CItemUsable*>(PItem);
                PUsable->setQuantity(1);
                PUsable->setLastUseTime(CVanaTime::getInstance()->getVanaTime());
                SlotID = charutils::AddItem(PChar, LOC_INVENTORY, PUsable, false);
            }
            else
            {
                ShowWarning("addUsedItem: tried to setLastUseTime but itemID <%i> is not type ITEM_CHARGED", itemID);
            }
        }
        else
        {
            ShowWarning("charplugin::AddItem: Item <%i> is not found in a database", itemID);
        }
    }

    return SlotID != ERROR_SLOTID;
}

/************************************************************************
 *  Function: getWornUses()
 *  Purpose : Gets the worn state on an item
 *  Example : if player:getWornUses(trade:getItemId()) > 0 then
 *  Notes   : Used mainly for Testimonies and BCNM orbs
 ************************************************************************/

uint8 CLuaBaseEntity::getWornUses(uint16 itemID)
{
    auto* PChar  = static_cast<CCharEntity*>(m_PBaseEntity);
    uint8 slotID = PChar->getStorage(LOC_INVENTORY)->SearchItem(itemID);

    if (slotID != ERROR_SLOTID)
    {
        CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(slotID);

        if (PItem != nullptr)
        {
            return PItem->m_extra[0];
        }
    }

    return 0;
}

/************************************************************************
 *  Function: incrementItemWear()
 *  Purpose : Increments an item's worn state and returns it
 *  Example : player:incrementItemWear(itemID)
 *  Notes   : Prevent Orbs and Testimonies from being used again
 ************************************************************************/

uint8 CLuaBaseEntity::incrementItemWear(uint16 itemID)
{
    auto* PChar  = static_cast<CCharEntity*>(m_PBaseEntity);
    uint8 slotID = PChar->getStorage(LOC_INVENTORY)->SearchItem(itemID);

    if (slotID != ERROR_SLOTID)
    {
        CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(slotID);

        if (PItem == nullptr)
        {
            return 0;
        }

        if (PItem->m_extra[0] == UINT8_MAX)
        {
            return PItem->m_extra[0];
        }

        ++PItem->m_extra[0];

        char extra[sizeof(PItem->m_extra) * 2 + 1];
        _sql->EscapeStringLen(extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));

        const char* Query = "UPDATE char_inventory "
                            "SET extra = '%s' "
                            "WHERE charid = %u AND location = %u AND slot = %u";

        _sql->Query(Query, extra, PChar->id, PItem->getLocationID(), PItem->getSlotID());

        return PItem->m_extra[0];
    }

    return 0;
}

/************************************************************************
 *  Function: addTempItem()
 *  Purpose : Add a temporary item to the player
 *  Example : player:addTempItem(5399) -- Azouph Fireflies
 *  Notes   : Used almost exclusively for instances
 ************************************************************************/

bool CLuaBaseEntity::addTempItem(uint16 itemID, sol::object const& arg1)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    uint32 quantity = (arg1 != sol::lua_nil) ? arg1.as<uint32>() : 1;
    uint8  SlotID   = ERROR_SLOTID;

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (PChar->getStorage(LOC_TEMPITEMS)->GetFreeSlotsCount() != 0 && quantity != 0)
    {
        CItem* PItem = itemutils::GetItem(itemID);

        if (PItem != nullptr)
        {
            PItem->setQuantity(quantity);

            SlotID = charutils::AddItem(PChar, LOC_TEMPITEMS, PItem);
        }
        else
        {
            ShowWarning("charplugin::AddItem: Item <%i> is not found in a database", itemID);
        }
    }

    return SlotID != ERROR_SLOTID;
}

/************************************************************************
 *  Function: findItem()
 *  Purpose : Like hasItem, but returns the item object (nil if not found)
 *  Example : local item = player:findItem(426) -- Orchestrion
 *  Notes   :
 ************************************************************************/
std::optional<CLuaItem> CLuaBaseEntity::findItem(uint16 itemID, sol::object const& location)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        return std::nullopt;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    // Look in a specific container
    if (location != sol::lua_nil)
    {
        uint8 locationID = LOC_INVENTORY;

        locationID = location.as<uint8>();
        locationID = (locationID < CONTAINER_ID::MAX_CONTAINER_ID ? locationID : (uint8)LOC_INVENTORY);

        if (auto slot = PChar->getStorage(locationID)->SearchItem(itemID); slot != ERROR_SLOTID)
        {
            auto* item = PChar->getStorage(locationID)->GetItem(slot);
            return item ? std::optional<CLuaItem>(item) : std::nullopt;
        }
    }
    else // Look in all containers
    {
        for (uint8 i = 0; i < CONTAINER_ID::MAX_CONTAINER_ID; ++i)
        {
            if (auto slot = PChar->getStorage(i)->SearchItem(itemID); slot != ERROR_SLOTID)
            {
                auto* item = PChar->getStorage(i)->GetItem(slot);
                if (item && item->getID() == itemID)
                {
                    return std::optional<CLuaItem>(item);
                }
            }
        }
    }

    // Didn't find any matches
    return std::nullopt;
}

/************************************************************************
 *  Function: createShop()
 *  Purpose : Create a temporary shop for display to a player
 *  Example : player:createShop(Size, Nation);
 *  Notes   : Used solely in scripts/globals/shop.lua
 ************************************************************************/

void CLuaBaseEntity::createShop(uint8 size, sol::object const& arg1)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->Container->Clean();
    PChar->Container->setSize(size + 1);

    if (arg1 != sol::lua_nil && arg1.is<double>())
    {
        PChar->Container->setType(arg1.as<uint8>());
    }
}

/************************************************************************
 *  Function: addShopItem()
 *  Purpose : Adds an item and established price to an existing shop
 *          : Optionally accepts a GuildID + Guild Rank requirement
 *  Example : addShopItem(512, 8000)                                                   --Regular item
 *          : addShopItem(512, 8000, xi.skill.CLOTHCRAFT, xi.craftRank.JOURNEYMAN)   --Guild-rank locked item
 *  Notes   : Use with createShop() - 16 Max Items in Shop
 ************************************************************************/

void CLuaBaseEntity::addShopItem(uint16 itemID, double rawPrice, sol::object const& arg2, sol::object const& arg3)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    CCharEntity* PChar  = static_cast<CCharEntity*>(m_PBaseEntity);
    uint8        slotID = PChar->Container->getItemsCount();
    uint32       price  = static_cast<uint32>(rawPrice);

    PChar->Container->setItem(slotID, itemID, 0, price);

    // Players can add items to the shop container during shop interaction,
    // so track the shop's number of items separately from the container's size.
    PChar->Container->setExSize(PChar->Container->getExSize() + 1);

    if (arg2.is<int>() && arg3.is<int>())
    {
        uint8  guildID   = arg2.as<uint8>();
        uint16 guildRank = arg3.as<uint16>();

        static_cast<CCharEntity*>(m_PBaseEntity)->Container->setGuildID(slotID, guildID);
        static_cast<CCharEntity*>(m_PBaseEntity)->Container->setGuildRank(slotID, guildRank);
    }
}

/************************************************************************
 *  Function: getCurrentGPItem()
 *  Purpose : Returns the current Guild Point Item needed
 *  Example : player:getCurrentGPItem(guildID)
 *  Notes   :
 ************************************************************************/

auto CLuaBaseEntity::getCurrentGPItem(uint8 guildID) -> std::tuple<uint16, uint16>
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return { 0, 0 };
    }

    CGuild*      PGuild = guildutils::GetGuild(guildID);
    CCharEntity* PChar  = static_cast<CCharEntity*>(m_PBaseEntity);

    auto GPItem = PGuild->getDailyGPItem(PChar);

    return { GPItem.first, GPItem.second };
}

/************************************************************************
 *  Function: breakLinkshell()
 *  Purpose : Breaks linkshell and all pearls/sacks
 *  Example : player:breakLinkshell(LSname)
 *  Notes   : Used by GMs to break a linkshell
 ************************************************************************/

bool CLuaBaseEntity::breakLinkshell(std::string const& lsname)
{
    bool found = false;

    int32 ret = _sql->Query("SELECT broken, linkshellid FROM linkshells WHERE name = '%s'", lsname);
    if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
    {
        uint8 broken = _sql->GetUIntData(0);

        if (broken)
        {
            return true;
        }

        uint32      lsid       = _sql->GetUIntData(1);
        CLinkshell* PLinkshell = linkshell::GetLinkshell(lsid);

        if (!PLinkshell)
        {
            PLinkshell = linkshell::LoadLinkshell(lsid);
        }

        PLinkshell->BreakLinkshell();
        linkshell::UnloadLinkshell(lsid);
        found = true;
    }

    return found;
}

/************************************************************************
 *  Function: addLinkpearl()
 *  Purpose : Adds a linkpearl (pearlsack for GMs) to inventory, optionally equips to slot 2
 *  Example : player:addLinkpearl("NewPlayers", true)
 ************************************************************************/

bool CLuaBaseEntity::addLinkpearl(std::string const& lsname, bool equip)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    CCharEntity*    PChar          = (CCharEntity*)m_PBaseEntity;
    CItemLinkshell* PItemLinkPearl = PChar->m_GMlevel > 0 ? (CItemLinkshell*)itemutils::GetItem(514) : (CItemLinkshell*)itemutils::GetItem(515);
    LSTYPE          lstype         = PChar->m_GMlevel > 0 ? LSTYPE_PEARLSACK : LSTYPE_LINKPEARL;
    if (PItemLinkPearl != nullptr)
    {
        const char* Query = "SELECT linkshellid, color FROM linkshells WHERE name = '%s' AND broken = 0";
        int32       ret   = _sql->Query(Query, lsname);
        if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
        {
            // build linkpearl
            char EncodedString[LinkshellStringLength];

            std::memset(&EncodedString, 0, sizeof(EncodedString));
            EncodeStringLinkshell(lsname, EncodedString);
            ((CItem*)PItemLinkPearl)->setSignature(EncodedString);
            PItemLinkPearl->SetLSID(_sql->GetUIntData(0));
            PItemLinkPearl->SetLSColor(_sql->GetIntData(1));
            PItemLinkPearl->SetLSType(lstype);
            PItemLinkPearl->setQuantity(1);
            if (charutils::AddItem(PChar, LOC_INVENTORY, PItemLinkPearl) != ERROR_SLOTID)
            {
                // equip linkpearl to slot 2
                if (equip)
                {
                    linkshell::AddOnlineMember(PChar, PItemLinkPearl, 2);
                    PItemLinkPearl->setSubType(ITEM_LOCKED);
                    PChar->equip[SLOT_LINK2]    = PItemLinkPearl->getSlotID();
                    PChar->equipLoc[SLOT_LINK2] = LOC_INVENTORY;
                    PChar->pushPacket<CInventoryAssignPacket>(PItemLinkPearl, INV_LINKSHELL);
                    charutils::SaveCharEquip(PChar);
                    PChar->pushPacket<CLinkshellEquipPacket>(PChar, PItemLinkPearl->GetLSID());
                    PChar->pushPacket<CInventoryItemPacket>(PItemLinkPearl, LOC_INVENTORY, PItemLinkPearl->getSlotID());
                    PChar->pushPacket<CInventoryFinishPacket>();
                    charutils::LoadInventory(PChar);
                }
                return true;
            }
        }
    }
    return false;
}

auto CLuaBaseEntity::addSoulPlate(std::string const& name, uint16 mobFamily, uint8 zeni, uint16 skillIndex, uint8 fp) -> std::optional<CLuaItem>
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return std::nullopt;
    }

    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        // Deduct Blank Plate
        battleutils::RemoveAmmo(PChar);

        PChar->pushPacket<CInventoryFinishPacket>();

        // Used Soul Plate
        CItem* PItem = itemutils::GetItem(2477);

        if (PItem == nullptr)
        {
            ShowError("PItem was null for soulplate");
            return std::nullopt;
        }

        PItem->setQuantity(1);
        PItem->setSoulPlateData(name, mobFamily, zeni, skillIndex, fp);
        auto SlotID = charutils::AddItem(PChar, LOC_INVENTORY, PItem, true);
        if (SlotID == ERROR_SLOTID)
        {
            return std::nullopt;
        }

        return std::optional<CLuaItem>(PItem);
    }
    return std::nullopt;
}

/************************************************************************
 *  Function: getContainerSize()
 *  Purpose : Returns the size of an item container
 *  Example : player:getContainerSize(xi.inv.INVENTORY)
 ************************************************************************/

uint8 CLuaBaseEntity::getContainerSize(uint8 locationID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    return PChar->getStorage(locationID)->GetSize();
}

/************************************************************************
 *  Function: changeContainerSize()
 *  Purpose : Upgrades the capacity of a container
 *  Example : player:changeContainerSize(container, newSize)
 *  Notes   : Used primarily for Gobbie Bag quests
 ************************************************************************/

void CLuaBaseEntity::changeContainerSize(uint8 locationID, int8 newSize)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    if (locationID < CONTAINER_ID::MAX_CONTAINER_ID)
    {
        auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

        PChar->getStorage(locationID)->AddBuff(newSize);
        PChar->pushPacket<CInventorySizePacket>(PChar);
        charutils::SaveCharInventoryCapacity(PChar);
    }
    else
    {
        ShowError("CLuaBaseEntity::changeContainerSize: bad container id (%u)", locationID);
    }
}

/************************************************************************
 *  Function: getFreeSlotsCount()
 *  Purpose : Returns the amount of free slots in a container
 *  Example : if player:getFreeSlotsCount() == 0 then
 *  Notes   : Default slot is inventory; add value to specify containers
 ************************************************************************/

uint8 CLuaBaseEntity::getFreeSlotsCount(sol::object const& locID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    uint8 locationID = (locID != sol::lua_nil) ? locID.as<CONTAINER_ID>() : LOC_INVENTORY;
    return static_cast<CCharEntity*>(m_PBaseEntity)->getStorage(locationID)->GetFreeSlotsCount();
}

/************************************************************************
 *  Function: confirmTrade()
 *  Purpose : Completes a trade and takes ONLY confirmed items
 *  Example : player:confirmTrade()
 *  Notes   : Must use trade:confirmItem(slotID) first
 ************************************************************************/

void CLuaBaseEntity::confirmTrade()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    for (uint8 slotID = 0; slotID < TRADE_CONTAINER_SIZE; ++slotID)
    {
        if (PChar->TradeContainer->getInvSlotID(slotID) != 0xFF)
        {
            CItem* PItem = PChar->TradeContainer->getItem(slotID);
            if (PItem)
            {
                uint32 confirmedItems = PChar->TradeContainer->getConfirmedStatus(slotID);
                auto   quantity       = (int32)std::min<uint32>(PChar->TradeContainer->getQuantity(slotID), confirmedItems);

                PItem->setReserve(PItem->getReserve() - quantity);
                if (confirmedItems > 0)
                {
                    uint8 invSlotID = PChar->TradeContainer->getInvSlotID(slotID);
                    charutils::UpdateItem(PChar, LOC_INVENTORY, invSlotID, -quantity);
                }
            }
        }
    }
    PChar->TradeContainer->Clean();
    PChar->pushPacket<CInventoryFinishPacket>();
}

/************************************************************************
 *  Function: tradeComplete()
 *  Purpose : Completes trade and removes all items in trade container
 *  Example : player:tradeComplete()
 ************************************************************************/

void CLuaBaseEntity::tradeComplete()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    for (uint8 slotID = 0; slotID < TRADE_CONTAINER_SIZE; ++slotID)
    {
        if (PChar->TradeContainer->getInvSlotID(slotID) != 0xFF)
        {
            uint8  invSlotID = PChar->TradeContainer->getInvSlotID(slotID);
            int32  quantity  = PChar->TradeContainer->getQuantity(slotID);
            CItem* PItem     = PChar->TradeContainer->getItem(slotID);
            if (PItem)
            {
                PItem->setReserve(0);
                charutils::UpdateItem(PChar, LOC_INVENTORY, invSlotID, -quantity);
            }
        }
    }
    PChar->TradeContainer->Clean();
    PChar->pushPacket<CInventoryFinishPacket>();
}

std::optional<CLuaTradeContainer> CLuaBaseEntity::getTrade()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return std::nullopt;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    return std::optional<CLuaTradeContainer>(PChar->TradeContainer);
}

/************************************************************************
 *  Function: canEquipItem()
 *  Purpose : Returns true if a player can equip the item
 *  Example : if player:canEquipItem(17652) then
 *  Notes   : CItemEquipment* is a pointer to weapons or armor
 ************************************************************************/

bool CLuaBaseEntity::canEquipItem(uint16 itemID, sol::object const& chkLevel)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Attempt to check equippable item with non-player (%s).", m_PBaseEntity->getName());
        return false;
    }

    if (itemID > MAX_ITEMID)
    {
        ShowWarning("ItemID exceeds MAX_ITEMID (%d).", itemID);
    }

    bool checkLevel = (chkLevel != sol::lua_nil) ? chkLevel.as<bool>() : false;

    auto* PItem = static_cast<CItemEquipment*>(itemutils::GetItem(itemID));
    auto* PChar = static_cast<CBattleEntity*>(m_PBaseEntity);

    if (PItem == nullptr)
    {
        ShowError("PItem was null, itemID = %d.", itemID);
        return false;
    }

    if (!PItem->isType(ITEM_EQUIPMENT))
    {
        return false;
    }

    if (!(PItem->getJobs() & (1 << (PChar->GetMJob() - 1))))
    {
        return false;
    }
    if (!PItem->isEquippableByRace(PChar->look.race))
    {
        return false;
    }
    if (checkLevel && (PItem->getReqLvl() > PChar->GetMLevel()))
    {
        return false;
    }

    return true;
}

/************************************************************************
 *  Function: equipItem()
 *  Purpose : Equips an item on the player
 *  Example : equipItem(itemID, optional container ID)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::equipItem(uint16 itemID, sol::object const& container)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto*           PChar             = static_cast<CCharEntity*>(m_PBaseEntity);
    uint8           containerID       = container.is<uint8>() ? container.as<uint8>() : static_cast<uint8>(LOC_INVENTORY);
    CItemContainer* PStorageContainer = PChar->getStorage(containerID);

    if (PStorageContainer == nullptr)
    {
        // getStorage logs for invalid, so just bail out here
        return;
    }

    uint8 slotId = PChar->getStorage(containerID)->SearchItem(itemID);
    if (slotId != ERROR_SLOTID)
    {
        if (auto* PItem = dynamic_cast<CItemEquipment*>(PChar->getStorage(containerID)->GetItem(slotId)))
        {
            charutils::EquipItem(PChar, slotId, PItem->getSlotType(), containerID);
            PChar->RequestPersist(CHAR_PERSIST::EQUIP);
        }
    }
}

/************************************************************************
 *  Function: unequipItem()
 *  Purpose : Unequips an item from player
 *  Example : player:unequipItem(17845)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::unequipItem(uint8 itemID)
{
    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
        charutils::UnequipItem(PChar, itemID);
    }
}

/************************************************************************
 *  Function: setEquipBlock()
 *  Purpose : Blocks player from equipping gear
 *  Example : target:setEquipBlock(effect:getPower())
 *  Notes   : Used exclusively for Encumbrance
 ************************************************************************/

void CLuaBaseEntity::setEquipBlock(uint16 equipBlock)
{
    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        auto* PChar         = static_cast<CCharEntity*>(m_PBaseEntity);
        PChar->m_EquipBlock = equipBlock;
        PChar->pushPacket<CCharJobsPacket>(PChar);
    }
}

/************************************************************************
 *  Function: lockEquipSlot()
 *  Purpose : Used to keep players from equipment certain equipment?
 *  Example : player:lockEquipSlot(xi.slot.MAIN)
 *  Notes   : Currently not implemented in any file, imagine this is for Salvage
 ************************************************************************/

void CLuaBaseEntity::lockEquipSlot(uint8 slot)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    if (slot > 15)
    {
        ShowWarning("Invalid slot passed to function.");
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    charutils::EquipItem(PChar, 0, slot, LOC_INVENTORY);

    PChar->m_EquipBlock |= 1 << slot;
    PChar->pushPacket<CCharAppearancePacket>(PChar);
    PChar->pushPacket<CEquipPacket>(0, slot, LOC_INVENTORY);
    PChar->pushPacket<CCharJobsPacket>(PChar);
    PChar->updatemask |= UPDATE_LOOK;
}

/************************************************************************
 *  Function: unlockEquipSlot()
 *  Purpose : Allows player to equip items in that slot again
 *  Example : player:unlockEquipSlot(xi.slot.MAIN)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::unlockEquipSlot(uint8 slot)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    if (slot > 15)
    {
        ShowWarning("Invalid slot passed to function.");
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->m_EquipBlock &= ~(1 << slot);
    PChar->pushPacket<CCharJobsPacket>(PChar);
}

/************************************************************************
 *  Function: hasSlotEquipped()
 *  Purpose : Returns true if a player has an item equipped in the slot
 *  Example : if player:hasSlotEquipped(xi.slot.RING1) then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::hasSlotEquipped(uint8 slot)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Attempt to check item slot for a non-player (%s).", m_PBaseEntity->getName());
        return false;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    return charutils::hasSlotEquipped(PChar, slot);
}

/************************************************************************
 *  Function: getShieldSize()
 *  Purpose : Return the shield size of the equipped shield
 *  Example : player:getShieldSize()
 *  Notes   : Returns 0 if player does not have shield equipped
 ************************************************************************/

int8 CLuaBaseEntity::getShieldSize()
{
    // TODO: Why is TYPE_PET being checked below, when we only act on TYPE_PC?
    if (m_PBaseEntity->objtype != TYPE_PC && m_PBaseEntity->objtype != TYPE_PET)
    {
        ShowWarning("Entity is not a Player or Pet type (%s).", m_PBaseEntity->getName());
        return 0;
    }

    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        return static_cast<CCharEntity*>(m_PBaseEntity)->getShieldSize();
    }

    return 0;
}

/************************************************************************
 *  Function: getShieldDefense()
 *  Purpose : Return the defense of the equipped shield
 *  Example : player:getShieldDefense()
 *  Notes   : Returns 0 if player does not have shield equipped
 ************************************************************************/

int16 CLuaBaseEntity::getShieldDefense()
{
    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        return static_cast<CCharEntity*>(m_PBaseEntity)->getShieldDefense();
    }
    else
    {
        ShowWarning("Entity is not a Player: (%s).", m_PBaseEntity->getName());
    }

    return 0;
}

/************************************************************************
 *  Function: addGearSetMod()
 *  Purpose : Need to research functionality more to provide description
 *  Example : player:addGearSetMod(setId, modId, modValue)
 *  Notes   : Used exclusively in scripts/globals/gear_sets.lua
 ************************************************************************/

void CLuaBaseEntity::addGearSetMod(uint8 setId, Mod modId, uint16 modValue)
{
    CCharEntity* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity);

    if (!PChar)
    {
        ShowWarning("CLuaBaseEntity::addGearSetMod() - m_pBaseEntity is not of type Char.");
        return;
    }

    GearSetMod_t gearSetMod = {};
    gearSetMod.setId        = setId;
    gearSetMod.modId        = modId;
    gearSetMod.modValue     = modValue;

    PChar->m_GearSetMods.emplace_back(gearSetMod);
    PChar->addModifier(gearSetMod.modId, gearSetMod.modValue);
}

/************************************************************************
 *  Function: clearGearSetMods()
 *  Purpose : Clears all mods the player has from gear sets
 *  Example : player:clearGearSetMods()
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::clearGearSetMods()
{
    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        for (std::size_t i = 0; i < PChar->m_GearSetMods.size(); ++i)
        {
            GearSetMod_t gearSetMod = PChar->m_GearSetMods.at(i);
            PChar->delModifier(gearSetMod.modId, gearSetMod.modValue);
        }
        PChar->m_GearSetMods.clear();
    }
}

/************************************************************************
 *  Function: getStorageItem()
 *  Purpose : Returns object data for an item in a container
 *  Example : player:getStorageItem(0, 0, xi.slot.RANGED)
 *  Notes   :
 ************************************************************************/

std::optional<CLuaItem> CLuaBaseEntity::getStorageItem(uint8 container, uint8 slotID, uint8 equipID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("%s is trying to access their inventory, but is not TYPE_PC, so doesn't have one!", m_PBaseEntity->getName());
        return std::nullopt;
    }

    CCharEntity* PChar = (CCharEntity*)m_PBaseEntity;

    CItem* PItem = nullptr;

    if (equipID == 255)
    {
        PItem = PChar->getStorage(container)->GetItem(slotID);
    }
    else
    {
        PItem = PChar->getEquip((SLOTTYPE)equipID);
    }

    if (PItem != nullptr)
    {
        return std::optional<CLuaItem>(PItem);
    }

    return std::nullopt;
}

/************************************************************************
 *  Function: storeWithPorterMoogle()
 *  Purpose : Stores an item with a Porter Moogle
 *  Example : local result = player:storeWithPorterMoogle(slipId, extra, storableItemIds)
 *  Notes   : Sets an 'extra' value so item doesn't appear in inventory
 ************************************************************************/

uint8 CLuaBaseEntity::storeWithPorterMoogle(uint16 slipId, sol::table const& extraTable, sol::table const& storableItemIdsTable)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("CLuaBaseEntity::storeWithPorterMoogle() - Non_PC passed to function.");
        return 0;
    }

    auto* PChar      = (CCharEntity*)m_PBaseEntity;
    auto  slipSlotId = PChar->getStorage(LOC_INVENTORY)->SearchItem(slipId);

    if (slipSlotId == 255)
    {
        return 0;
    }

    auto* slip = PChar->getStorage(LOC_INVENTORY)->GetItem(slipSlotId);

    if (slip == nullptr)
    {
        ShowError("Slip Item was null.");
        return 0;
    }

    auto extraVec  = extraTable.as<std::vector<uint8>>();
    auto extraSize = extraVec.size();
    for (size_t i = 0; i < extraSize; i++)
    {
        auto extra = extraVec[i];
        if ((slip->m_extra[i] & extra) != 0)
        {
            return extra;
        }
        slip->m_extra[i] |= extra;
    }

    auto   storableItemIdsVec  = storableItemIdsTable.as<std::vector<uint16>>();
    auto   storableItemIdsSize = storableItemIdsVec.size();
    uint16 storedItemIds[7];

    for (size_t i = 0; i < storableItemIdsSize; i++)
    {
        auto itemId = storableItemIdsVec[i];
        if (itemId != 0)
        {
            storedItemIds[i] = itemId;
        }
        else
        {
            storedItemIds[i] = 0;
        }
    }

    for (auto const& itemId : storedItemIds)
    {
        if (itemId != 0)
        {
            auto slotId = PChar->getStorage(LOC_INVENTORY)->SearchItem(itemId);
            if (slotId != 255)
            {
                // TODO: Items need to be checked for an in-progress magian trial before storing.
                CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(slotId);
                if (PItem)
                {
                    PItem->setReserve(0);
                    charutils::UpdateItem(PChar, LOC_INVENTORY, slotId, -1);
                }
            }
        }
    }

    char extra[sizeof(slip->m_extra) * 2 + 1];
    _sql->EscapeStringLen(extra, (const char*)slip->m_extra, sizeof(slip->m_extra));

    const char* Query = "UPDATE char_inventory "
                        "SET extra = '%s' "
                        "WHERE charid = %u AND location = %u AND slot = %u";

    _sql->Query(Query, extra, PChar->id, slip->getLocationID(), slip->getSlotID());

    return 0;
}

/************************************************************************
 *  Function: getRetrievableItemsForSlip()
 *  Purpose : Returns listing of 'stored' items as Lua table
 *  Example : local extra = player:getRetrievableItemsForSlip(slipId)
 *  Notes   : See scripts/globals/porter_moogle.lua
 ************************************************************************/

sol::table CLuaBaseEntity::getRetrievableItemsForSlip(uint16 slipId)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return {};
    }

    CCharEntity* PChar      = (CCharEntity*)m_PBaseEntity;
    auto         slipSlotId = PChar->getStorage(LOC_INVENTORY)->SearchItem(slipId);

    if (slipSlotId == 255)
    {
        return {};
    }

    auto* slip = PChar->getStorage(LOC_INVENTORY)->GetItem(slipSlotId);

    if (slip == nullptr)
    {
        ShowError("Slip item was null.");
        return {};
    }

    sol::table table = lua.create_table();
    // TODO Is extra sized defined anywhere?
    for (int i = 0; i < 24; i++)
    {
        table.add(slip->m_extra[i]);
    }

    return table;
}

/************************************************************************
 *  Function: retrieveItemFromSlip()
 *  Purpose : Retrieves an item stored with Porter Moogle
 *  Example : player:retrieveItemFromSlip(slipId, retrievedItemId, extraId, bitmask)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::retrieveItemFromSlip(uint16 slipId, uint16 itemId, uint16 extraId, uint8 extraData)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar      = static_cast<CCharEntity*>(m_PBaseEntity);
    auto  slipSlotId = PChar->getStorage(LOC_INVENTORY)->SearchItem(slipId);

    if (slipSlotId == 255)
    {
        return;
    }

    auto* slip = PChar->getStorage(LOC_INVENTORY)->GetItem(slipSlotId);

    if (slip == nullptr)
    {
        ShowError("Slip item was null.");
        return;
    }

    slip->m_extra[extraId] &= extraData;

    char extra[sizeof(slip->m_extra) * 2 + 1];
    _sql->EscapeStringLen(extra, (const char*)slip->m_extra, sizeof(slip->m_extra));

    const char* Query = "UPDATE char_inventory "
                        "SET extra = '%s' "
                        "WHERE charid = %u AND location = %u AND slot = %u";

    _sql->Query(Query, extra, PChar->id, slip->getLocationID(), slip->getSlotID());

    auto* item = itemutils::GetItem(itemId);
    if (item)
    {
        item->setQuantity(1);
        charutils::AddItem(PChar, LOC_INVENTORY, item);
    }
    else
    {
        ShowError("Failed to get item from item ID");
    }
}

/************************************************************************
 *  Function: getRace()
 *  Purpose : Returns the integer value of the race of the character
 *  Example : player:getRace()
 ************************************************************************/

uint8 CLuaBaseEntity::getRace()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CCharEntity*>(m_PBaseEntity)->look.race;
}

/************************************************************************
 *  Function: getFace()
 *  Purpose : Returns the integer value of the face of a character
 *  Example : player:getFace()
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getFace()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CCharEntity*>(m_PBaseEntity)->look.face;
}

/************************************************************************
 *  Function: getGender()
 *  Purpose : Returns the integer value of the gender of the character
 *  Female: 0, Male: 1
 *  Example : player:getGender()
 ************************************************************************/

uint8 CLuaBaseEntity::getGender()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    return PChar->GetGender();
}

/************************************************************************
 *  Function: getName()
 *  Purpose : Returns the string name of the character
 *  Example : player:getName()
 ************************************************************************/

std::string CLuaBaseEntity::getName()
{
    return m_PBaseEntity->name;
}

/************************************************************************
 *  Function: getPacketName()
 *  Purpose : Returns the string packet name of the character
 *  Example : mob:getPacketName()
 ************************************************************************/

std::string CLuaBaseEntity::getPacketName()
{
    return m_PBaseEntity->packetName;
}

/************************************************************************
 *  Function: renameEntity()
 *  Purpose : Overrides the visible name of the entity.
 *  Example : mob:renameEntity("NewName")
 *  Note    : This will set the packet name of the entity to a name of
 *          : your choosing.
 ************************************************************************/

void CLuaBaseEntity::renameEntity(std::string const& newName, sol::object const& arg2)
{
    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        ShowWarning("Renaming player character entities isn't supported.");
        return;
    }

    auto oldName              = m_PBaseEntity->packetName.empty() ? "<empty>" : m_PBaseEntity->packetName;
    m_PBaseEntity->packetName = newName;
    m_PBaseEntity->updatemask |= UPDATE_NAME | UPDATE_HP;
    m_PBaseEntity->isRenamed = true;

    bool silent = arg2.get_type() == sol::type::boolean ? arg2.as<bool>() : false;
    if (!silent)
    {
        ShowInfo("Renaming %s: %s -> %s", m_PBaseEntity->name, oldName, newName);
    }
}

/************************************************************************
 *  Function: hideName()
 *  Purpose : Hides the name of the entity
 *  Example : mob:hideName()
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::hideName(bool isHidden)
{
    m_PBaseEntity->HideName(isHidden);
}

/************************************************************************
 *  Function: getModelId()
 *  Purpose : Returns the integer value of the entity's Model ID
 *  Example : mob:getModelId()
 *  Notes   :
 ************************************************************************/

uint16 CLuaBaseEntity::getModelId()
{
    return m_PBaseEntity->GetModelId();
}

/************************************************************************
 *  Function: setModelId()
 *  Purpose : Updates the Model ID of the entity
 *  Example : mob:setModelId(1168)
 *  Notes   : Humanoid entities can be passed a slot to change the modelid of that equipment
 *              npc:setModelId(47, 5) -- Vermillion cloak
 ************************************************************************/

void CLuaBaseEntity::setModelId(uint16 modelId, sol::object const& slotObj)
{
    if (m_PBaseEntity->objtype == TYPE_PC || slotObj.is<uint8>())
    {
        SLOTTYPE slot = slotObj.is<uint8>() ? slotObj.as<SLOTTYPE>() : SLOT_MAIN;

        switch (slot)
        {
            case SLOT_MAIN:
                m_PBaseEntity->look.main = modelId;
                break;
            case SLOT_SUB:
                m_PBaseEntity->look.sub = modelId;
                break;
            case SLOT_RANGED:
                m_PBaseEntity->look.ranged = modelId;
                break;
            case SLOT_HEAD:
                m_PBaseEntity->look.head = modelId;
                break;
            case SLOT_BODY:
                m_PBaseEntity->look.body = modelId;
                break;
            case SLOT_HANDS:
                m_PBaseEntity->look.hands = modelId;
                break;
            case SLOT_LEGS:
                m_PBaseEntity->look.legs = modelId;
                break;
            case SLOT_FEET:
                m_PBaseEntity->look.feet = modelId;
                break;
            default:
                break;
        }

        if (m_PBaseEntity->objtype == TYPE_PC)
        {
            auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
            PChar->pushPacket<CCharAppearancePacket>(PChar);
        }
    }
    else
    {
        m_PBaseEntity->SetModelId(modelId);
    }
    m_PBaseEntity->updatemask |= UPDATE_LOOK;
}

/************************************************************************
 *  Function: getCostume()
 *  Purpose : Returns the PC's appearance
 *  Example : player:getCostume()
 ************************************************************************/

uint16 CLuaBaseEntity::getCostume()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    return PChar->m_Costume;
}

/************************************************************************
 *  Function: setCostume()
 *  Purpose : Updates the PC's appearance
 *  Example : player:setCostume( costumeId )
 ************************************************************************/

void CLuaBaseEntity::setCostume(uint16 costume)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (PChar->m_Costume != costume && PChar->status != STATUS_TYPE::SHUTDOWN && PChar->status != STATUS_TYPE::DISAPPEAR)
    {
        PChar->m_Costume = costume;
        PChar->updatemask |= UPDATE_LOOK;
        PChar->pushPacket<CCharUpdatePacket>(PChar);
    }
}

/************************************************************************
 *  Function: getCostume2()
 *  Purpose : Returns the PC's appearance
 *  Example : player:getCostume()
 ************************************************************************/

uint16 CLuaBaseEntity::getCostume2()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    return PChar->m_Costume2;
}

/************************************************************************
 *  Function: setCostume2()
 *  Purpose : Updates the PC's appearance
 *  Example : player:setCostume2( costumeId )
 ************************************************************************/

void CLuaBaseEntity::setCostume2(uint16 costume)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (PChar->m_Costume2 != costume && PChar->status != STATUS_TYPE::SHUTDOWN && PChar->status != STATUS_TYPE::DISAPPEAR)
    {
        PChar->m_Costume2 = costume;
        PChar->updatemask |= UPDATE_LOOK;
        PChar->pushPacket<CCharAppearancePacket>(PChar);
    }
}
/************************************************************************
 *  Function: getAnimation()
 *  Purpose : Returns the assigned default animation of an entity
 *  Example : GetNPCByID(ID.npc.TRAP_DOOR):getAnimation()
 ************************************************************************/

uint8 CLuaBaseEntity::getAnimation()
{
    return m_PBaseEntity->animation;
}

/************************************************************************
 *  Function: setAnimation()
 *  Purpose : Updates an animation for the entity
 *  Example : GetNPCByID(ID.npc.DOOR_OFFSET + 12):setAnimation(xi.anim.OPEN_DOOR)
 *  Notes   : Look at scripts/zones/VeLugannon_Palace/npcs/Monolith.lua
 ************************************************************************/

void CLuaBaseEntity::setAnimation(uint8 animation)
{
    if (m_PBaseEntity->animation != animation)
    {
        m_PBaseEntity->animation = animation;
        m_PBaseEntity->updatemask |= UPDATE_HP;
    }
}

/************************************************************************
 *  Function: getAnimationSub()
 *  Purpose : Returns animation sub for an entity or updates if var supplied
 *  Example :
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getAnimationSub()
{
    return m_PBaseEntity->animationsub;
}

/************************************************************************
 *  Function: setAnimationSub()
 *  Purpose : Returns animation sub for an entity or updates if var supplied
 *  Example :
 *  Notes   : sendUpdate is true by default (false is the edge case.)
 ************************************************************************/

void CLuaBaseEntity::setAnimationSub(uint8 animationsub, sol::object const& sendUpdate)
{
    if (m_PBaseEntity->animationsub != animationsub)
    {
        bool sendPacket = (sendUpdate != sol::lua_nil) ? sendUpdate.as<bool>() : true;

        m_PBaseEntity->animationsub = animationsub;

        if (m_PBaseEntity->objtype == TYPE_PC)
        {
            auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
            if (sendPacket)
            {
                PChar->pushPacket<CCharUpdatePacket>(PChar);
            }
        }
        else if (sendPacket)
        {
            m_PBaseEntity->loc.zone->UpdateEntityPacket(m_PBaseEntity, ENTITY_UPDATE, UPDATE_COMBAT);
        }
    }
}

/************************************************************************
 *  Function: getCallForHelpFlag()
 *  Purpose : Find out if CFH has been called on a mob.
 *  Example : mob:getCallForHelpFlag()
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::getCallForHelpFlag() const
{
    if (auto* PMob = dynamic_cast<CMobEntity*>(m_PBaseEntity))
    {
        return PMob->GetCallForHelpFlag();
    }
    ShowWarning("getCallForHelpFlag called on invalid entity.");
    return false;
}

/************************************************************************
 *  Function: setCallForHelpFlag(cfh)
 *  Purpose : Force-set the CFH flag on a mob.
 *  Example : mob:setCallForHelpFlag(true)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setCallForHelpFlag(bool cfh)
{
    if (auto* PMob = dynamic_cast<CMobEntity*>(m_PBaseEntity))
    {
        PMob->SetCallForHelpFlag(cfh);
        return;
    }
    ShowWarning("setCallForHelpFlag called on invalid entity.");
}

/************************************************************************
 *  Function: getCallForHelpBlocked()
 *  Purpose : Find out if the CFH flag has been blocked for a mob.
 *  Example : mob:getCallForHelpBlocked()
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::getCallForHelpBlocked() const
{
    if (auto* PMob = dynamic_cast<CMobEntity*>(m_PBaseEntity))
    {
        return PMob->m_CallForHelpBlocked;
    }
    ShowWarning("getCallForHelpBlocked called on invalid entity.");
    return false;
}

/************************************************************************
 *  Function: setCallForHelpBlocked(blocked)
 *  Purpose : Block or unblock the m_CallForHelpBlocked flag for a mob.
 *  Example : mob:setCallForHelpBlocked(true)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setCallForHelpBlocked(bool blocked)
{
    if (auto* PMob = dynamic_cast<CMobEntity*>(m_PBaseEntity))
    {
        PMob->m_CallForHelpBlocked = blocked;
        return;
    }
    ShowWarning("setCallForHelpBlocked called on invalid entity.");
}

/************************************************************************
 *  Function: getNation()
 *  Purpose : Returns the integer value of the player's nation
 *  Example : player:getNation()
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getNation()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CCharEntity*>(m_PBaseEntity)->profile.nation;
}

/************************************************************************
 *  Function: setNation()
 *  Purpose : Changes a player's nation allegiance
 *  Example : player:setNation(xi.nation.WINDURST)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setNation(uint8 nation)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->profile.nation = nation;
    charutils::SaveCharNation(PChar);
}

/************************************************************************
 *  Function: getAllegiance()
 *  Purpose : Gets allegiance of entity (mob/player/ballista team)
 *  Example : if target:getAllegiance() == caster:getAllegiance() then
 ************************************************************************/

uint8 CLuaBaseEntity::getAllegiance()
{
    return static_cast<uint8>(m_PBaseEntity->allegiance);
}

/************************************************************************
 *  Function: setAllegiance()
 *  Purpose : Sets allegiance of entity (mob/player/ballista team)
 *  Example : target:setAllegiance(???)
 ************************************************************************/

void CLuaBaseEntity::setAllegiance(uint8 allegiance)
{
    m_PBaseEntity->allegiance = static_cast<ALLEGIANCE_TYPE>(allegiance);
    m_PBaseEntity->updatemask |= UPDATE_HP | UPDATE_NAME;
}

/************************************************************************
 *  Function: getCampaignAllegiance()
 *  Purpose : Returns the integer value of a player's Campaign allegiance
 *  Example : if player:getCampaignAllegiance() > 0 then
 *  Notes   : A return of 0 means the player doesn't have any allegiances
 ************************************************************************/

uint8 CLuaBaseEntity::getCampaignAllegiance()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CCharEntity*>(m_PBaseEntity)->profile.campaign_allegiance;
}

/************************************************************************
 *  Function: setCampaignAllegiance()
 *  Purpose : Affiliates the player with a particular nation in the past
 *  Example : targ:setCampaignAllegiance(nation)
 ************************************************************************/

void CLuaBaseEntity::setCampaignAllegiance(uint8 allegiance)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->profile.campaign_allegiance = allegiance;
    charutils::SaveCampaignAllegiance(PChar);
}

/************************************************************************
 *  Function: isSeekingParty()
 *  Purpose : Returns true if a player is seeking a party
 *  Example : if player:isSeekingParty() then
 ************************************************************************/

bool CLuaBaseEntity::isSeekingParty()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    return (static_cast<CCharEntity*>(m_PBaseEntity)->isSeekingParty());
}

/************************************************************************
 *  Function: getNewPlayer()
 *  Purpose : Returns true if a player is new
 *  Example : if not player:getNewPlayer() then
 ************************************************************************/

bool CLuaBaseEntity::getNewPlayer()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    return !static_cast<CCharEntity*>(m_PBaseEntity)->playerConfig.NewAdventurerOffFlg;
}

/************************************************************************
 *  Function: setNewPlayer()
 *  Purpose : Marks a player as being new and calls charutils to update DB
 *  Example : player:setNewPlayer(1)
 ************************************************************************/

void CLuaBaseEntity::setNewPlayer(bool newplayer)
{
    auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity);

    if (!PChar)
    {
        ShowWarning("CLuaBaseEntity::setNewPlayer() - m_pBaseEntity is not of type Char.");
        return;
    }

    if (newplayer)
    {
        PChar->playerConfig.NewAdventurerOffFlg = false;
    }
    else
    {
        PChar->playerConfig.NewAdventurerOffFlg = true;
    }

    PChar->updatemask |= UPDATE_HP;

    charutils::SavePlayerSettings(PChar);
}

/************************************************************************
 *  Function: getMentor()
 *  Purpose : Returns true if a player is flagged as a mentor
 *  Notes   : Test me!  Changing retval to bool
 ************************************************************************/

bool CLuaBaseEntity::getMentor()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    CCharEntity* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    return PChar->m_mentorUnlocked ? true : false;
}

/************************************************************************
 *  Function: setMentor()
 *  Purpose : Sets the mentor flag for a character
 *  Example : player:setMentor(true)
 ************************************************************************/

void CLuaBaseEntity::setMentor(bool mentor)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    CCharEntity* PChar      = static_cast<CCharEntity*>(m_PBaseEntity);
    PChar->m_mentorUnlocked = mentor;

    charutils::SaveMentorFlag(PChar);
    PChar->updatemask |= UPDATE_HP;
}

/************************************************************************
 *  Function: getGMLevel()
 *  Purpose : Returns the GM level (0-5)
 *  Example : if player:getGMLevel() == 5 then
 ************************************************************************/

uint8 CLuaBaseEntity::getGMLevel()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    return PChar->m_GMlevel;
}

/************************************************************************
 *  Function: setGMLevel()
 *  Purpose : Updates a player's GM status (0-5)
 *  Example : player:setGMLevel(3)
 ************************************************************************/

void CLuaBaseEntity::setGMLevel(uint8 level)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->m_GMlevel = level;
    charutils::SaveCharGMLevel(PChar);
}

/************************************************************************
 *  Function: setVisibleGMLevel()
 *  Purpose : Updates a player's visible GM status (0-7), see https://github.com/atom0s/XiPackets/tree/main/world/server/0x0037
 *  Example : player:setVisibleGMLevel(4)
 ************************************************************************/

void CLuaBaseEntity::setVisibleGMLevel(uint8 level)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->visibleGmLevel = level;
    PChar->updatemask |= UPDATE_HP;
    charutils::SaveCharGMLevel(PChar);
}

/************************************************************************
 *  Function: getVisibleGMLevel()
 *  Purpose : Returns a players visible GM level
 *  Example : player:getVisibleGMLevel()
 ************************************************************************/

uint8 CLuaBaseEntity::getVisibleGMLevel()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    return PChar->visibleGmLevel;
}

/************************************************************************
 *  Function: getGMHidden()
 *  Purpose : Returns true if a GM is currently hidden
 *  Example : if player:getGMHidden() then
 ************************************************************************/

bool CLuaBaseEntity::getGMHidden()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    return PChar->m_isGMHidden;
}

/************************************************************************
 *  Function: setGMHidden()
 *  Purpose : Sets a GM to hidden mode
 *  Example : player:setGMHidden(1)
 ************************************************************************/

void CLuaBaseEntity::setGMHidden(bool isHidden)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar         = static_cast<CCharEntity*>(m_PBaseEntity);
    PChar->m_isGMHidden = isHidden;

    PChar->updatemask |= UPDATE_HP;

    _sql->Query("UPDATE char_flags SET gmHiddenEnabled = %u WHERE charid = %u", isHidden ? 1 : 0, PChar->id);

    if (PChar->loc.zone)
    {
        if (PChar->m_isGMHidden)
        {
            PChar->loc.zone->UpdateCharPacket(PChar, ENTITY_DESPAWN, UPDATE_NONE);
        }
        else
        {
            PChar->loc.zone->UpdateCharPacket(PChar, ENTITY_SPAWN, UPDATE_NONE);
        }
    }
}

/************************************************************************
 *  Function: getWallhack()
 *  Purpose : gets the wallhack variable (true/false) from a target
 *  Example : player:getWallhack()
 ************************************************************************/

bool CLuaBaseEntity::getWallhack()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    return PChar->wallhackEnabled;
}

/************************************************************************
 *  Function: setWallhack()
 *  Purpose : Sets a GM to have wallhacking enabled/disabled
 *  Example : player:setWallhack(1)
 ************************************************************************/

void CLuaBaseEntity::setWallhack(bool enabled)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar            = static_cast<CCharEntity*>(m_PBaseEntity);
    PChar->wallhackEnabled = enabled;
    PChar->updatemask |= UPDATE_HP;
}

/************************************************************************
 *  Function: isJailed()
 *  Purpose : Returns true if a player is a violent felon
 *  Example : if player:isJailed() then
 ************************************************************************/

bool CLuaBaseEntity::isJailed()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    return jailutils::InPrison(static_cast<CCharEntity*>(m_PBaseEntity));
}

/************************************************************************
 *  Function: jail()
 *  Purpose : Locks up a misbehaving Elvaan
 *  Example : player:jail()
 ************************************************************************/

void CLuaBaseEntity::jail()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    jailutils::Add(static_cast<CCharEntity*>(m_PBaseEntity));
}

/************************************************************************
 *  Function: canUseMisc()
 *  Purpose : Returns true if ZONEMISC contains flag being checked.
 *  Example : if player:canUseMisc(xi.zoneMisc.MOUNT) then
 *  Notes   : Checks if specified MISC flag is set in current zone
 ************************************************************************/

bool CLuaBaseEntity::canUseMisc(uint16 misc)
{
    if (m_PBaseEntity->loc.zone == nullptr)
    {
        ShowWarning("Player zone is null.");
        return false;
    }

    return m_PBaseEntity->loc.zone->CanUseMisc(misc);
}

/************************************************************************
 *  Function: getSpeed()
 *  Purpose : Gets a player's current speed
 *  Example : player:getSpeed()
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getSpeed()
{
    return m_PBaseEntity->GetSpeed();
}

/************************************************************************
 *  Function: getBaseSpeed()
 *  Purpose : Gets a player's base speed
 *  Example : player:getBaseSpeed()
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getBaseSpeed()
{
    return m_PBaseEntity->baseSpeed;
}

/************************************************************************
 *  Function: setBaseSpeed()
 *  Purpose : Sets a player's base speed
 *  Example : player:setBaseSpeed(40)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setBaseSpeed(uint8 speedVal)
{
    auto speed = std::min<uint8>(speedVal, 255);

    if (m_PBaseEntity->baseSpeed != speed)
    {
        m_PBaseEntity->baseSpeed = speed;
        m_PBaseEntity->UpdateSpeed();

        if (m_PBaseEntity->objtype == TYPE_PC)
        {
            auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
            PChar->pushPacket<CCharUpdatePacket>(PChar);
        }
        else
        {
            m_PBaseEntity->loc.zone->UpdateEntityPacket(m_PBaseEntity, ENTITY_UPDATE, UPDATE_POS);
        }
    }
}

/************************************************************************
 *  Function: setAnimationSpeed()
 *  Purpose : Sets a player's animation speed
 *  Example : player:setAnimationSpeed(40)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setAnimationSpeed(uint8 speedVal)
{
    auto speed = std::min<uint8>(speedVal, 255);

    if (m_PBaseEntity->animationSpeed != speed)
    {
        m_PBaseEntity->animationSpeed = speed;

        if (m_PBaseEntity->objtype == TYPE_PC)
        {
            auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
            PChar->pushPacket<CCharUpdatePacket>(PChar);
        }
        else
        {
            m_PBaseEntity->loc.zone->UpdateEntityPacket(m_PBaseEntity, ENTITY_UPDATE, UPDATE_POS);
        }
    }
}

/************************************************************************
 *  Function: getPlaytime()
 *  Purpose : Returns a player's total play time, or updates
 *  Example : player:getPlaytime()
 *  Notes   : See scripts/zones/Port_Bastok/Zone.lua for no playtime example
 ************************************************************************/

uint32 CLuaBaseEntity::getPlaytime(sol::object const& shouldUpdate)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    bool  update = (shouldUpdate != sol::lua_nil) ? shouldUpdate.as<bool>() : true;
    auto* PChar  = static_cast<CCharEntity*>(m_PBaseEntity);

    return PChar->GetPlayTime(update);
}

/************************************************************************
 *  Function: getTimeCreated()
 *  Purpose : Get unix timestamp of when character was created
 *  Example : player:getTimeCreated()
 ************************************************************************/

int32 CLuaBaseEntity::getTimeCreated()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    return PChar->GetTimeCreated();
}

/************************************************************************
 *  Function: getMainJob()
 *  Purpose : Returns the integer value of the entity's main job
 *  Example : mob:getMainJob(); player:getMainJob()
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getMainJob()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->GetMJob();
}

/************************************************************************
 *  Function: getSubJob()
 *  Purpose : Returns the integer value of the entity's sub job
 *  Example : mob:getSubJob(); player:getSubJob()
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getSubJob()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->GetSJob();
}

/************************************************************************
 *  Function: changeJob()
 *  Purpose : Changes an entities main job
 *  Example : mob:changeJob(xi.job.RDM); player:changeJob(xi.job.MNK)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::changeJob(uint8 newJob)
{
    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        JOBTYPE prevjob = PChar->GetMJob();

        PChar->resetPetZoningInfo();

        charutils::RemoveAllEquipMods(PChar);
        PChar->jobs.unlocked |= (1 << newJob);
        PChar->SetMJob(newJob);
        charutils::ApplyAllEquipMods(PChar);

        if (newJob == JOB_BLU)
        {
            if (prevjob != JOB_BLU)
            {
                blueutils::LoadSetSpells(PChar);
            }
        }
        else if (PChar->GetSJob() != JOB_BLU)
        {
            blueutils::UnequipAllBlueSpells(PChar);
        }
        puppetutils::LoadAutomaton(PChar);
        charutils::SetStyleLock(PChar, false);
        luautils::CheckForGearSet(PChar); // check for gear set on gear change
        jobpointutils::RefreshGiftMods(PChar);
        charutils::BuildingCharSkillsTable(PChar);
        charutils::CalculateStats(PChar);
        charutils::CheckValidEquipment(PChar);
        PChar->PRecastContainer->ChangeJob();
        charutils::BuildingCharAbilityTable(PChar);
        charutils::BuildingCharTraitsTable(PChar);

        // clang-format off
        PChar->ForParty([](CBattleEntity* PMember)
        {
            ((CCharEntity*)PMember)->PLatentEffectContainer->CheckLatentsPartyJobs();
        });
        // clang-format on

        PChar->UpdateHealth();
        PChar->health.hp = PChar->GetMaxHP();
        PChar->health.mp = PChar->GetMaxMP();

        charutils::SaveCharStats(PChar);
        charutils::SaveCharJob(PChar, PChar->GetMJob());
        charutils::SaveCharExp(PChar, PChar->GetMJob());
        PChar->updatemask |= UPDATE_HP;

        PChar->pushPacket<CCharJobsPacket>(PChar);
        PChar->pushPacket<CCharStatsPacket>(PChar);
        PChar->pushPacket<CCharSkillsPacket>(PChar);
        PChar->pushPacket<CCharRecastPacket>(PChar);
        PChar->pushPacket<CCharAbilitiesPacket>(PChar);
        PChar->pushPacket<CCharUpdatePacket>(PChar);
        PChar->pushPacket<CMenuMeritPacket>(PChar);
        PChar->pushPacket<CMonipulatorPacket1>(PChar);
        PChar->pushPacket<CMonipulatorPacket2>(PChar);
        PChar->pushPacket<CCharSyncPacket>(PChar);
    }
    else if (auto* PMob = dynamic_cast<CMobEntity*>(m_PBaseEntity))
    {
        PMob->SetMJob(newJob);

        // Change weapon type based on new job
        CItemWeapon* PWeapon = new CItemWeapon(0);
        PWeapon->setDelay(4000);
        PWeapon->setBaseDelay(4000);

        switch (newJob)
        {
            case JOB_MNK:
            case JOB_PUP:
                PWeapon->setSkillType(SKILL_HAND_TO_HAND);
                PWeapon->setBaseDelay(8000);
                PWeapon->setDelay(8000);
                break;
            case JOB_THF:
            case JOB_BRD:
            case JOB_RNG:
            case JOB_COR:
                PWeapon->setSkillType(SKILL_DAGGER);
                break;
            case JOB_RDM:
            case JOB_PLD:
            case JOB_BLU:
                PWeapon->setSkillType(SKILL_SWORD);
                break;
            case JOB_RUN:
                PWeapon->setSkillType(SKILL_GREAT_SWORD);
                PWeapon->setDelay(8000);
                PWeapon->setBaseDelay(8000);
                break;
            case JOB_WAR:
            case JOB_BST:
                PWeapon->setSkillType(SKILL_AXE);
                break;
            case JOB_DRK:
                PWeapon->setSkillType(SKILL_SCYTHE);
                PWeapon->setDelay(8000);
                PWeapon->setBaseDelay(8000);
                break;
            case JOB_DRG:
                PWeapon->setSkillType(SKILL_POLEARM);
                PWeapon->setDelay(8000);
                PWeapon->setBaseDelay(8000);
                break;
            case JOB_NIN:
                PWeapon->setSkillType(SKILL_KATANA);
                break;
            case JOB_SAM:
                PWeapon->setSkillType(SKILL_GREAT_KATANA);
                PWeapon->setDelay(8000);
                PWeapon->setBaseDelay(8000);
                break;
            case JOB_WHM:
            case JOB_BLM:
            case JOB_GEO:
                PWeapon->setSkillType(SKILL_CLUB);
                break;
            case JOB_SMN:
                PWeapon->setSkillType(SKILL_STAFF);
                PWeapon->setDelay(8000);
                PWeapon->setBaseDelay(8000);
                break;
            default:
                break;
        }

        PMob->m_Weapons[SLOT_MAIN] = PWeapon;
        mobutils::CalculateMobStats(PMob);
    }
    else
    {
        ShowWarning("CLuaBaseEntity::changeJob() - m_pBaseEntity is not a supported entity.");
        return;
    }
}

/************************************************************************
 *  Function: changesJob()
 *  Purpose : Changes an entities sub job
 *  Example : mob:changesJob(xi.job.RDM); player:changesJob(xi.job.MNK)
 *  Notes   : To Do: Change name to changeSubJob for visual clarity?
 ************************************************************************/

void CLuaBaseEntity::changesJob(uint8 subJob)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->jobs.unlocked |= (1 << subJob);
    PChar->SetSJob(subJob);
    charutils::UpdateSubJob(PChar);

    if (subJob == JOB_BLU)
    {
        blueutils::LoadSetSpells(PChar);
    }
    else
    {
        blueutils::UnequipAllBlueSpells(PChar);
    }

    puppetutils::LoadAutomaton(PChar);
}

/************************************************************************
 *  Function: unlockJob()
 *  Purpose : Unlocks a new job for a player (updates char_jobs.sql)
 *  Example : player:unlockJob(xi.job.SAM)
 *  Notes   : Changes value of job from 0 (locked) to 1(unlocked)
 ************************************************************************/

void CLuaBaseEntity::unlockJob(uint8 JobID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("CLuaBaseEntity::unlockJob() - Non-PC calling function.");
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (JobID < MAX_JOBTYPE)
    {
        PChar->jobs.unlocked |= (1 << JobID);

        if (JobID == JOB_NON)
        {
            JobID = JOB_WAR;
        }
        if (PChar->jobs.job[JobID] == 0)
        {
            PChar->jobs.job[JobID] = 1;
        }

        charutils::SaveCharJob(PChar, static_cast<JOBTYPE>(JobID));
        PChar->pushPacket<CCharJobsPacket>(PChar);
    }
}

/************************************************************************
 *  Function: hasJob()
 *  Purpose : Check to see if JOBTYPE is unlocked
 *  Example : player:hasJob(xi.job.BRD)
 ************************************************************************/

bool CLuaBaseEntity::hasJob(uint8 job)
{
    if (m_PBaseEntity->objtype != TYPE_PC || job >= MAX_JOBTYPE)
    {
        ShowWarning("CLuaBaseEntity::unlockJob() - Non-PC calling function or invalid JOBTYPE");
        return false;
    }

    JOBTYPE JobID = static_cast<JOBTYPE>(job);
    auto*   PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    return (PChar->jobs.unlocked >> JobID) & 1;
}

/************************************************************************
 *  Function: getMainLvl()
 *  Purpose : Returns the main level of entity's current job
 *  Example : player:getMainLvl()
 ************************************************************************/

uint8 CLuaBaseEntity::getMainLvl()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->GetMLevel();
}

/************************************************************************
 *  Function: getSubLvl()
 *  Purpose : Returns the level of entity's current sub job
 *  Example : player:getSubLvl()
 ************************************************************************/

uint8 CLuaBaseEntity::getSubLvl()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->GetSLevel();
}

/************************************************************************
 *  Function: getJobLevel()
 *  Purpose : Return the levle of job specified by JOBTYPE
 *  Example : player:getJobLevel(xi.job.BRD)
 ************************************************************************/

uint8 CLuaBaseEntity::getJobLevel(uint8 JobID)
{
    if (m_PBaseEntity->objtype != TYPE_PC || JobID >= MAX_JOBTYPE)
    {
        ShowWarning("CLuaBaseEntity::getJobLevel() - Non-PC or Invalid JobID passed to function.");
        return 0;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    return PChar->jobs.job[JobID];
}

/************************************************************************
 *  Function: setLevel()
 *  Purpose : Updates the level of the entity's main job
 *  Example : player:setLevel(50)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setLevel(uint8 level)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Attempt to change Main Job level for non-PC (%s).", m_PBaseEntity->getName());
        return;
    }

    if (level > 99)
    {
        ShowWarning("Attempt to set player level (%d) that exceeds maximum.", level);
        return;
    }

    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        charutils::RemoveAllEquipMods(PChar);
        PChar->SetMLevel(level);
        PChar->jobs.job[PChar->GetMJob()] = level;
        PChar->SetSLevel(PChar->jobs.job[PChar->GetSJob()]);
        PChar->jobs.exp[PChar->GetMJob()] = charutils::GetExpNEXTLevel(PChar->jobs.job[PChar->GetMJob()]) - 1;
        charutils::ApplyAllEquipMods(PChar);

        charutils::SetStyleLock(PChar, false);
        blueutils::ValidateBlueSpells(PChar);
        charutils::CalculateStats(PChar);
        charutils::CheckValidEquipment(PChar);
        jobpointutils::RefreshGiftMods(PChar);
        charutils::BuildingCharSkillsTable(PChar);
        charutils::BuildingCharAbilityTable(PChar);
        charutils::BuildingCharWeaponSkills(PChar);
        charutils::BuildingCharTraitsTable(PChar);

        PChar->UpdateHealth();
        PChar->health.hp = PChar->GetMaxHP();
        PChar->health.mp = PChar->GetMaxMP();

        charutils::SaveCharStats(PChar);
        charutils::SaveCharJob(PChar, PChar->GetMJob());
        charutils::SaveCharExp(PChar, PChar->GetMJob());
        PChar->updatemask |= UPDATE_HP;

        PChar->pushPacket<CCharJobsPacket>(PChar);
        PChar->pushPacket<CCharStatsPacket>(PChar);
        PChar->pushPacket<CCharSkillsPacket>(PChar);
        PChar->pushPacket<CCharRecastPacket>(PChar);
        PChar->pushPacket<CCharAbilitiesPacket>(PChar);
        PChar->pushPacket<CCharUpdatePacket>(PChar);
        PChar->pushPacket<CMenuMeritPacket>(PChar);
        PChar->pushPacket<CMonipulatorPacket1>(PChar);
        PChar->pushPacket<CMonipulatorPacket2>(PChar);
        PChar->pushPacket<CCharSyncPacket>(PChar);
    }
}

/************************************************************************
 *  Function: setsLevel()
 *  Purpose : Updates the level of the entity's sub job
 *  Example : player:setsLvl(30)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setsLevel(uint8 slevel)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    if (slevel > 99)
    {
        ShowWarning("Invalid slevel (%d) passed to function.", slevel);
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->jobs.job[PChar->GetSJob()] = slevel;
    PChar->SetSLevel(PChar->jobs.job[PChar->GetSJob()]);
    PChar->jobs.exp[PChar->GetSJob()] = charutils::GetExpNEXTLevel(PChar->jobs.job[PChar->GetSJob()]) - 1;

    charutils::SetStyleLock(PChar, false);
    jobpointutils::RefreshGiftMods(PChar);
    charutils::BuildingCharSkillsTable(PChar);
    charutils::CalculateStats(PChar);
    charutils::CheckValidEquipment(PChar);
    charutils::BuildingCharAbilityTable(PChar);
    charutils::BuildingCharTraitsTable(PChar);

    PChar->UpdateHealth();
    PChar->health.hp = PChar->GetMaxHP();
    PChar->health.mp = PChar->GetMaxMP();

    charutils::SaveCharStats(PChar);
    charutils::SaveCharJob(PChar, PChar->GetMJob());
    charutils::SaveCharJob(PChar, PChar->GetSJob());
    charutils::SaveCharExp(PChar, PChar->GetMJob());

    PChar->pushPacket<CCharJobsPacket>(PChar);
    PChar->pushPacket<CCharStatsPacket>(PChar);
    PChar->pushPacket<CCharSkillsPacket>(PChar);
    PChar->pushPacket<CCharRecastPacket>(PChar);
    PChar->pushPacket<CCharAbilitiesPacket>(PChar);
    PChar->pushPacket<CCharUpdatePacket>(PChar);
    PChar->pushPacket<CMenuMeritPacket>(PChar);
    PChar->pushPacket<CMonipulatorPacket1>(PChar);
    PChar->pushPacket<CMonipulatorPacket2>(PChar);
    PChar->pushPacket<CCharSyncPacket>(PChar);
}

/************************************************************************
 *  Function: getLevelCap()
 *  Purpose : Returns the player's level cap (genkai)
 *  Example : player:getLevelCap()
 ************************************************************************/

uint8 CLuaBaseEntity::getLevelCap()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    return PChar->jobs.genkai;
}

/************************************************************************
 *  Function: setLevelCap()
 *  Purpose : Sets the player's level cap (genkai)
 *  Example : player:setLevelCap(55)
 ************************************************************************/

void CLuaBaseEntity::setLevelCap(uint8 cap)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (PChar->jobs.genkai != cap)
    {
        PChar->jobs.genkai = cap;
        _sql->Query("UPDATE char_jobs SET genkai = %u WHERE charid = %u LIMIT 1", PChar->jobs.genkai, PChar->id);
    }
}

/************************************************************************
 *  Function: levelRestriction()
 *  Purpose : Places a level restriction on the PC and recalculates stats
 *  Example : player:levelRestriction(50)
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::levelRestriction(sol::object const& level)
{
    if (m_PBaseEntity == nullptr || m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("CLuaBaseEntity::levelRestriction() - Entity is null, or not PC.");
        return 0;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if ((level != sol::lua_nil) && level.is<int>())
    {
        PChar->m_LevelRestriction = level.as<uint32>();

        uint8 NewMLevel = 0;

        if (PChar->m_LevelRestriction != 0 && PChar->m_LevelRestriction < PChar->jobs.job[PChar->GetMJob()])
        {
            NewMLevel = PChar->m_LevelRestriction;
        }
        else
        {
            NewMLevel = PChar->jobs.job[PChar->GetMJob()];
        }

        if (PChar->GetMLevel() != NewMLevel)
        {
            if (PChar->PAutomaton)
            {
                // Call each attachment onUnequip handler and zero out localVars tracking applied buffs
                puppetutils::PreLevelRestriction(PChar);
            }
            charutils::RemoveAllEquipMods(PChar);
            PChar->SetMLevel(NewMLevel);
            PChar->SetSLevel(PChar->jobs.job[PChar->GetSJob()]);

            charutils::ApplyAllEquipMods(PChar);
            blueutils::ValidateBlueSpells(PChar);
            jobpointutils::RefreshGiftMods(PChar);
            charutils::BuildingCharSkillsTable(PChar);
            charutils::CalculateStats(PChar);
            charutils::BuildingCharTraitsTable(PChar);
            charutils::BuildingCharAbilityTable(PChar);
            charutils::CheckValidEquipment(PChar);

            PChar->updatemask |= UPDATE_HP;

            // Update the character's Automaton capacity bonus regardless if the pet is out or not
            if (PChar->PAutomaton)
            {
                PChar->PAutomaton->setElementalCapacityBonus(PChar->getMod(Mod::AUTO_ELEM_CAPACITY));
            }

            if (PChar->status != STATUS_TYPE::DISAPPEAR)
            {
                PChar->pushPacket<CCharJobsPacket>(PChar);
                PChar->pushPacket<CCharStatsPacket>(PChar);
                PChar->pushPacket<CCharSkillsPacket>(PChar);
                PChar->pushPacket<CCharRecastPacket>(PChar);
                PChar->pushPacket<CCharAbilitiesPacket>(PChar);
                PChar->pushPacket<CCharSpellsPacket>(PChar);
                PChar->pushPacket<CCharUpdatePacket>(PChar);
                PChar->pushPacket<CCharSyncPacket>(PChar);
            }

            if (PChar->PPet)
            {
                if (PChar->PPet->objtype == TYPE_MOB)
                {
                    // Charmed mobs only detach if they are above the level restriction
                    if (PChar->PPet->GetMLevel() > NewMLevel)
                    {
                        petutils::DetachPet(PChar);
                    }
                    return PChar->m_LevelRestriction;
                }

                CPetEntity* PPet = static_cast<CPetEntity*>(PChar->PPet);

                // Preserve pet's HP and MP
                int32 hp = PPet->health.hp;
                int32 mp = PPet->health.mp;

                // Reset pet to a clean slate
                PPet->StatusEffectContainer->KillAllStatusEffect();
                PPet->restoreModifiers();
                PPet->restoreMobModifiers();
                PPet->TraitList.clear();

                switch (PPet->getPetType())
                {
                    case PET_TYPE::AVATAR:
                        petutils::CalculateAvatarStats(PChar, PPet);
                        break;
                    case PET_TYPE::WYVERN:
                        petutils::CalculateWyvernStats(PChar, PPet);
                        break;
                    case PET_TYPE::JUG_PET:
                        petutils::CalculateJugPetStats(PChar, PPet);
                        break;
                    case PET_TYPE::AUTOMATON:
                        if (isExceedingElementalCapacity())
                        {
                            // Reset Activate if Automaton is full HP
                            if (PPet->health.hp == PPet->GetMaxHP())
                            {
                                resetRecast(RECAST_ABILITY, 205);
                            }

                            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_AUTO_EXCEEDS_CAPACITY);
                            petutils::DespawnPet(PChar);
                            return PChar->m_LevelRestriction;
                        }
                        petutils::CalculateAutomatonStats(PChar, PPet);

                        // Call each attachment onEquip handler and replay maneuvers against the new stats
                        puppetutils::PostLevelRestriction(PChar);
                        break;
                    case PET_TYPE::LUOPAN:
                        petutils::CalculateLuopanStats(PChar, PPet);
                        break;
                    default:
                        petutils::DespawnPet(PChar);
                        return PChar->m_LevelRestriction;
                }

                // Allow global pet script to handle the level restriction
                luautils::OnPetLevelRestriction(PPet);

                // Setup pet with master since traits, abilities and some status effects need to be reapplied
                petutils::SetupPetWithMaster(PChar, PPet);

                // Restore pet's HP and MP to what it was before the stat recalculation
                PPet->health.hp = std::min(hp, PPet->GetMaxHP());
                PPet->health.mp = std::min(mp, PPet->GetMaxMP());
                PPet->updatemask |= UPDATE_HP;
            }
        }
    }

    return PChar->m_LevelRestriction;
}

/************************************************************************
 *  Function: addJobTraits
 *  Purpose : Add job traits
 *  Example : player:addJobTraits(xi.job.WHM, 75)
 ************************************************************************/

void CLuaBaseEntity::addJobTraits(uint8 jobID, uint8 level)
{
    auto* PEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);

    if (PEntity != nullptr)
    {
        battleutils::AddTraits(PEntity, traits::GetTraits(jobID), level);
    }
}

sol::table CLuaBaseEntity::getMonstrosityData()
{
    auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity);
    if (PChar == nullptr)
    {
        return sol::lua_nil;
    }

    bool startsWithMonstrosityData = PChar->m_PMonstrosity != nullptr;
    if (!startsWithMonstrosityData)
    {
        monstrosity::ReadMonstrosityData(PChar);
    }

    auto table = luautils::GetMonstrosityLuaTable(PChar);

    // If we didn't start with Monstrosity data, we should wipe it out now so we
    // don't change modes
    if (!startsWithMonstrosityData)
    {
        PChar->m_PMonstrosity = nullptr;
    }

    return table;
}

void CLuaBaseEntity::setMonstrosityData(sol::table table)
{
    auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity);
    if (PChar == nullptr)
    {
        return;
    }

    bool startsWithMonstrosityData = PChar->m_PMonstrosity != nullptr;

    // NOTE: This will populate m_PMonstrosity if it doesn't exist
    monstrosity::ReadMonstrosityData(PChar);

    luautils::SetMonstrosityLuaTable(PChar, std::move(table));

    monstrosity::WriteMonstrosityData(PChar);

    // If we didn't start with Monstrosity data, we should wipe it out now so we
    // don't change modes
    if (!startsWithMonstrosityData)
    {
        PChar->m_PMonstrosity = nullptr;
    }
    else
    {
        monstrosity::SendFullMonstrosityUpdate(PChar);
    }
}

bool CLuaBaseEntity::getBelligerencyFlag()
{
    auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity);
    if (PChar == nullptr)
    {
        return false;
    }

    if (PChar->m_PMonstrosity == nullptr)
    {
        return false;
    }

    return PChar->m_PMonstrosity->Belligerency;
}

void CLuaBaseEntity::setBelligerencyFlag(bool flag)
{
    auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity);
    if (PChar == nullptr)
    {
        return;
    }

    monstrosity::SetBelligerencyFlag(PChar, flag);
}

auto CLuaBaseEntity::getMonstrositySize() -> uint8
{
    auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity);
    if (PChar == nullptr)
    {
        return 0;
    }

    if (PChar->m_PMonstrosity == nullptr)
    {
        return 0;
    }

    return PChar->m_PMonstrosity->Size;
}

void CLuaBaseEntity::setMonstrosityEntryData(float x, float y, float z, uint8 rot, uint16 zoneId, uint8 mjob, uint8 sjob)
{
    auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity);
    if (PChar == nullptr)
    {
        return;
    }

    bool startsWithMonstrosityData = PChar->m_PMonstrosity != nullptr;
    if (!startsWithMonstrosityData)
    {
        monstrosity::ReadMonstrosityData(PChar);
    }

    PChar->m_PMonstrosity->EntryPos.x        = x;
    PChar->m_PMonstrosity->EntryPos.y        = y;
    PChar->m_PMonstrosity->EntryPos.z        = z;
    PChar->m_PMonstrosity->EntryPos.rotation = rot;
    PChar->m_PMonstrosity->EntryZoneId       = zoneId;
    PChar->m_PMonstrosity->EntryMainJob      = mjob;
    PChar->m_PMonstrosity->EntrySubJob       = sjob;

    monstrosity::WriteMonstrosityData(PChar);

    // If we didn't start with Monstrosity data, we should wipe it out now so we
    // don't change modes
    if (!startsWithMonstrosityData)
    {
        PChar->m_PMonstrosity = nullptr;
    }
}

/************************************************************************
 *  Function: getTitle()
 *  Purpose : Returns the integer value of the player's current title
 *  Example : if player:getTitle()) == xi.title.FAKE_MOUSTACHED_INVESTIGATOR then
 ************************************************************************/

uint16 CLuaBaseEntity::getTitle()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CCharEntity*>(m_PBaseEntity)->profile.title;
}

/************************************************************************
 *  Function: hasTitle()
 *  Purpose : Returns true if a player's current title matches a value
 *  Example : if player:hasTitle(xi.title.AWESOME_SAUCE) then
 ************************************************************************/

bool CLuaBaseEntity::hasTitle(uint16 titleID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    return charutils::hasTitle(static_cast<CCharEntity*>(m_PBaseEntity), titleID) != 0;
}

/************************************************************************
 *  Function: addTitle()
 *  Purpose : Adds a title to the character's profile only (doesn't change current)
 *  Example : player:addTitle(xi.title.BLACK_DRAGON_SLAYER)
 *  Notes   : Use setTitle to both change and add
 ************************************************************************/

void CLuaBaseEntity::addTitle(uint16 titleID)
{
    if (!(m_PBaseEntity->objtype & TYPE_PC))
    {
        ShowError("function call on invalid entity! (name: %s type: %d)", m_PBaseEntity->name, m_PBaseEntity->objtype);
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->profile.title = titleID;
    PChar->pushPacket<CCharStatsPacket>(PChar);

    charutils::addTitle(PChar, titleID);
    charutils::SaveTitles(PChar);
}

/************************************************************************
 *  Function: setTitle()
 *  Purpose : Updates the player's current title and adds to their profile
 *  Example : player:setTitle(xi.title.SOB_SUPERHERO)
 ************************************************************************/

void CLuaBaseEntity::setTitle(uint16 titleID)
{
    if (!(m_PBaseEntity->objtype & TYPE_PC))
    {
        ShowError("function call on invalid entity! (name: %s type: %d)", m_PBaseEntity->name, m_PBaseEntity->objtype);
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    charutils::setTitle(PChar, titleID);
}

/************************************************************************
 *  Function: delTitle()
 *  Purpose : Deletes a title from a character's profile
 *  Example : player:delTitle(xi.title.FODDERCHIEF_FLAYER)
 ************************************************************************/

void CLuaBaseEntity::delTitle(uint16 titleID)
{
    if (!(m_PBaseEntity->objtype & TYPE_PC))
    {
        ShowError("function call on invalid entity! (name: %s type: %d)", m_PBaseEntity->name, m_PBaseEntity->objtype);
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (charutils::delTitle(PChar, titleID))
    {
        if (PChar->profile.title == titleID)
        {
            PChar->profile.title = 0;
        }

        PChar->pushPacket<CCharStatsPacket>(PChar);
        charutils::SaveTitles(PChar);
    }
}

/************************************************************************
 *  Function: getFame()
 *  Purpose : Returns the current fame level of the player
 *  Example : player:getFame(area)
 *  Notes   :
 ************************************************************************/

uint16 CLuaBaseEntity::getFame(sol::object const& areaObj)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    uint8  fameArea = areaObj.is<sol::table>() ? areaObj.as<sol::table>()["fame_area"] : areaObj.as<uint8>();
    uint16 fame     = 0;

    if (fameArea <= 15)
    {
        float fameMultiplier = settings::get<float>("map.FAME_MULTIPLIER");
        auto* PChar          = static_cast<CCharEntity*>(m_PBaseEntity);

        switch (fameArea)
        {
            case 0: // San d'Oria
            case 1: // Bastok
            case 2: // Windurst
                fame = static_cast<uint16>(PChar->profile.fame[fameArea] * fameMultiplier);
                break;
            case 3: // Jeuno
                fame = static_cast<uint16>(PChar->profile.fame[4] + ((PChar->profile.fame[0] + PChar->profile.fame[1] + PChar->profile.fame[2]) * fameMultiplier / 3));
                break;
            case 4: // Selbina / Rabao
                fame = static_cast<uint16>((PChar->profile.fame[0] + PChar->profile.fame[1]) * fameMultiplier / 2);
                break;
            case 5: // Norg
                fame = static_cast<uint16>(PChar->profile.fame[3] * fameMultiplier);
                break;
            // Abyssea
            case 6:  // Konschtat
            case 7:  // Tahrongi
            case 8:  // La Theine
            case 9:  // Misareaux
            case 10: // Vunkerl
            case 11: // Attohwa
            case 12: // Altepa
            case 13: // Grauberg
            case 14: // Uleguerand
                fame = static_cast<uint16>(PChar->profile.fame[fameArea - 1] * fameMultiplier);
                break;
            case 15: // Adoulin
                fame = static_cast<uint16>(PChar->profile.fame[14] * fameMultiplier);
                break;
        }
    }
    else
    {
        ShowError("Lua::getFame: fameArea %i is invalid", fameArea);
    }

    return fame;
}

/************************************************************************
 *  Function: addFame()
 *  Purpose : Adds a specified amount of fame to the player's balance
 *  Example : player:addFame(xi.fameArea.WINDURST, 30)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::addFame(sol::object const& areaObj, uint16 fame)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    uint8 fameArea = areaObj.is<sol::table>() ? areaObj.as<sol::table>()["fame_area"] : areaObj.as<uint8>();

    if (fameArea <= 15)
    {
        auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

        switch (fameArea)
        {
            case 0: // San d'Oria
            case 1: // Bastok
            case 2: // Windurst
                PChar->profile.fame[fameArea] += fame;
                break;
            case 3: // Jeuno
                PChar->profile.fame[4] += fame;
                break;
            case 4: // Selbina / Rabao
                PChar->profile.fame[0] += fame;
                PChar->profile.fame[1] += fame;
                break;
            case 5: // Norg
                PChar->profile.fame[3] += fame;
                break;
            // Abyssea
            case 6:  // Konschtat
            case 7:  // Tahrongi
            case 8:  // La Theine
            case 9:  // Misareaux
            case 10: // Vunkerl
            case 11: // Attohwa
            case 12: // Altepa
            case 13: // Grauberg
            case 14: // Uleguerand
                PChar->profile.fame[fameArea - 1] += fame;
                break;
            case 15: // Adoulin
                PChar->profile.fame[14] += fame;
                break;
        }
        charutils::SaveFame(PChar);
    }
    else
    {
        ShowError("Lua::addFame: fameArea %i is invalid", fameArea);
    }
}

/************************************************************************
 *  Function: setFame()
 *  Purpose : Sets the fame level for a player to a specified amount
 *  Example : player:setFame(xi.fameArea.BASTOK, 1500)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setFame(sol::object const& areaObj, uint16 fame)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    uint8 fameArea = areaObj.is<sol::table>() ? areaObj.as<sol::table>()["fame_area"] : areaObj.as<uint8>();

    if (fameArea <= 15)
    {
        auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

        switch (fameArea)
        {
            case 0: // San d'Oria
            case 1: // Bastok
            case 2: // Windurst
                PChar->profile.fame[fameArea] = fame;
                break;
            case 3: // Jeuno
                PChar->profile.fame[4] = fame;
                break;
            case 4: // Selbina / Rabao
                PChar->profile.fame[0] = fame;
                PChar->profile.fame[1] = fame;
                break;
            case 5: // Norg
                PChar->profile.fame[3] = fame;
                break;
            // Abyssea
            case 6:  // Konschtat
            case 7:  // Tahrongi
            case 8:  // La Theine
            case 9:  // Misareaux
            case 10: // Vunkerl
            case 11: // Attohwa
            case 12: // Altepa
            case 13: // Grauberg
            case 14: // Uleguerand
                PChar->profile.fame[fameArea - 1] = fame;
                break;
            case 15: // Adoulin
                PChar->profile.fame[14] = fame;
                break;
        }

        charutils::SaveFame(PChar);
    }
    else
    {
        ShowError("Lua::setFame: fameArea %i is invalid", fameArea);
    }
}

/************************************************************************
 *  Function: getFameLevel()
 *  Purpose : Returns the player's baseline fame level for an area
 *  Example : player:getFameLevel(TENSHODO)
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getFameLevel(sol::object const& areaObj)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    uint8 fameArea  = areaObj.is<sol::table>() ? areaObj.as<sol::table>()["fame_area"] : areaObj.as<uint8>();
    uint8 fameLevel = 1;

    if (fameArea <= 15)
    {
        uint16 fame = this->getFame(areaObj);

        if (fame >= 613)
        {
            fameLevel = 9;
        }
        else if (fame >= 550)
        {
            fameLevel = 8;
        }
        else if (fame >= 488)
        {
            fameLevel = 7;
        }
        else if (fame >= 425)
        {
            fameLevel = 6;
        }
        else if (fame >= 325)
        {
            fameLevel = 5;
        }
        else if (fame >= 225)
        {
            fameLevel = 4;
        }
        else if (fame >= 125)
        {
            fameLevel = 3;
        }
        else if (fame >= 50)
        {
            fameLevel = 2;
        }

        if ((fameArea >= 6) && (fameArea <= 14) && (fameLevel >= 6))
        {
            fameLevel = 6; // Abyssea areas cap out at level 6 fame.
        }
    }
    else
    {
        ShowError("Lua::getFameLevel: fameArea %i is invalid", fameArea);
    }

    return fameLevel;
}

/************************************************************************
 *  Function: getRank()
 *  Purpose : Returns the rank of a player's current nation
 *  Example : player:getRank(xi.nation.WINDURST)
 ************************************************************************/

uint8 CLuaBaseEntity::getRank(uint8 nation)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    return PChar->profile.rank[nation];
}

/************************************************************************
 *  Function: setRank()
 *  Purpose : Sets the player's nation rank to a specified value
 *  Example : player:setRank(10)
 ************************************************************************/

void CLuaBaseEntity::setRank(uint8 rank)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->profile.rank[PChar->profile.nation] = rank;

    charutils::SaveMissionsList(PChar);
}

/************************************************************************
 *  Function: getRankPoints()
 *  Purpose : Returns the current rank points (rank bar) of a player
 *  Example : player:getRankPoints()
 ************************************************************************/

uint16 CLuaBaseEntity::getRankPoints()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CCharEntity*>(m_PBaseEntity)->profile.rankpoints;
}

/************************************************************************
 *  Function: addRankPoints()
 *  Purpose : Adds a set amount of rank points to the player's balance
 *  Example : player:addRankPoints(10)
 *  Notes   : Like, when you trade crystals
 ************************************************************************/

void CLuaBaseEntity::addRankPoints(uint16 rankPoints)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->profile.rankpoints = std::min<uint16>(PChar->profile.rankpoints + rankPoints, 4000);

    charutils::SaveMissionsList(PChar);
}

/************************************************************************
 *  Function: setRankPoints()
 *  Purpose : Sets the current rank points of a player to a specified value
 *  Example : player:setRankPoints(100)
 *  Notes   : player:setRankPoints(0) is called after switching nations
 ************************************************************************/

void CLuaBaseEntity::setRankPoints(uint16 rankPoints)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    // NOTE: Any value over 4000 currently causes visual defects in the client; therefore, is
    // hard-coded here and in the above function to limit values.
    PChar->profile.rankpoints = std::min<uint16>(rankPoints, 4000);
    charutils::SaveMissionsList(PChar);
}

/************************************************************************
 *  Function: addQuest()
 *  Purpose : Adds a new quest to the character's in-progress quest log
 *  Example : player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LURE_OF_THE_WILDCAT)
 ************************************************************************/

void CLuaBaseEntity::addQuest(uint8 questLogID, uint16 questID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (questLogID < MAX_QUESTAREA && questID < MAX_QUESTID)
    {
        uint8 current = PChar->m_questLog[questLogID].current[questID / 8] & (1 << (questID % 8));

        if (current == 0)
        {
            PChar->m_questLog[questLogID].current[questID / 8] |= (1 << (questID % 8));
            PChar->pushPacket<CQuestMissionLogPacket>(PChar, questLogID, LOG_QUEST_CURRENT);

            charutils::SaveQuestsList(PChar);
        }
    }
    else
    {
        ShowError("Lua::addQuest: questLogID %i or QuestID %i is invalid", questLogID, questID);
    }
}

/************************************************************************
 *  Function: delCurrentQuest()
 *  Purpose : Deletes an accepted quest for the player, but does not remove Completed state
 *  Notes   : This duplicates delQuest with the above exception
 ************************************************************************/

void CLuaBaseEntity::delCurrentQuest(uint8 questLogID, uint16 questID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (questLogID < MAX_QUESTAREA && questID < MAX_QUESTID)
    {
        uint8 current = PChar->m_questLog[questLogID].current[questID / 8] & (1 << (questID % 8));

        if (current != 0)
        {
            PChar->m_questLog[questLogID].current[questID / 8] &= ~(1 << (questID % 8));

            PChar->pushPacket<CQuestMissionLogPacket>(PChar, questLogID, LOG_QUEST_CURRENT);
            PChar->pushPacket<CQuestMissionLogPacket>(PChar, questLogID, LOG_QUEST_COMPLETE);

            charutils::SaveQuestsList(PChar);
        }
    }
    else
    {
        ShowError("Lua::delCurrentQuest: questLogID %i or QuestID %i is invalid", questLogID, questID);
    }
}

/************************************************************************
 *  Function: delQuest()
 *  Purpose : Deletes all records of a quest from a character's quest log
 *  Example : player:delQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT)
 *  Notes   : Doesn't delete any player variables associated with quest
 ************************************************************************/

void CLuaBaseEntity::delQuest(uint8 questLogID, uint16 questID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (questLogID < MAX_QUESTAREA && questID < MAX_QUESTID)
    {
        uint8 current  = PChar->m_questLog[questLogID].current[questID / 8] & (1 << (questID % 8));
        uint8 complete = PChar->m_questLog[questLogID].complete[questID / 8] & (1 << (questID % 8));

        if ((current != 0) || (complete != 0))
        {
            PChar->m_questLog[questLogID].current[questID / 8] &= ~(1 << (questID % 8));
            PChar->m_questLog[questLogID].complete[questID / 8] &= ~(1 << (questID % 8));

            PChar->pushPacket<CQuestMissionLogPacket>(PChar, questLogID, LOG_QUEST_CURRENT);
            PChar->pushPacket<CQuestMissionLogPacket>(PChar, questLogID, LOG_QUEST_COMPLETE);

            charutils::SaveQuestsList(PChar);
        }
    }
    else
    {
        ShowError("Lua::delQuest: questLogID %i or QuestID %i is invalid", questLogID, questID);
    }
}

/************************************************************************
 *  Function: getQuestStatus()
 *  Purpose : Gets the current quest status of the player
 *  Example : player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MAKING_THE_GRADE)
 ************************************************************************/

uint8 CLuaBaseEntity::getQuestStatus(uint8 questLogID, uint16 questID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    if (questLogID < MAX_QUESTAREA && questID < MAX_QUESTID)
    {
        auto* PChar    = static_cast<CCharEntity*>(m_PBaseEntity);
        uint8 current  = PChar->m_questLog[questLogID].current[questID / 8] & (1 << (questID % 8));
        uint8 complete = PChar->m_questLog[questLogID].complete[questID / 8] & (1 << (questID % 8));

        return (complete != 0 ? 2 : (current != 0 ? 1 : 0));
    }
    else
    {
        ShowError("Lua::getQuestStatus: questLogID %i or QuestID %i is invalid", questLogID, questID);
        return 0;
    }
}

/************************************************************************
 *  Function: hasCompletedQuest()
 *  Purpose : Returns true if a player has completed a quest
 *  Example : if (player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_INFINITY)) then
 ************************************************************************/

bool CLuaBaseEntity::hasCompletedQuest(uint8 questLogID, uint16 questID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    if (questLogID < MAX_QUESTAREA && questID < MAX_QUESTID)
    {
        uint8 complete = static_cast<CCharEntity*>(m_PBaseEntity)->m_questLog[questLogID].complete[questID / 8] & (1 << (questID % 8));

        return complete != 0;
    }

    ShowError("Lua::hasCompletedQuest: questLogID %i or QuestID %i is invalid", questLogID, questID);
    return false;
}

/************************************************************************
 *  Function: completeQuest()
 *  Purpose : Completes a current quest for the player
 *  Example : player:completeQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.ONLY_THE_BEST)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::completeQuest(uint8 questLogID, uint16 questID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (questLogID < MAX_QUESTAREA && questID < MAX_QUESTID)
    {
        uint8 complete = PChar->m_questLog[questLogID].complete[questID / 8] & (1 << (questID % 8));

        if (!complete)
        {
            PChar->m_questLog[questLogID].current[questID / 8] &= ~(1 << (questID % 8));
            PChar->m_questLog[questLogID].complete[questID / 8] |= (1 << (questID % 8));

            PChar->pushPacket<CQuestMissionLogPacket>(PChar, questLogID, LOG_QUEST_CURRENT);
            PChar->pushPacket<CQuestMissionLogPacket>(PChar, questLogID, LOG_QUEST_COMPLETE);
            charutils::SaveQuestsList(PChar);
            roeutils::event(ROE_QUEST_COMPLETE, PChar, RoeDatagramList{});
        }
    }
    else
    {
        ShowError("Lua::completeQuest: questLogID %i or QuestID %i is invalid", questLogID, questID);
    }
}

/************************************************************************
 *  Function: addMission()
 *  Purpose : Adds a mission to the player's mission log
 *  Example : player:addMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.JOURNEY_TO_BASTOK)
 *  Notes   : This function no longer accepts tables!
 ************************************************************************/

void CLuaBaseEntity::addMission(uint8 missionLogID, uint16 missionID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        return;
    }

    if (missionLogID < MAX_MISSIONAREA && missionID < MAX_MISSIONID)
    {
        auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

        if (PChar->m_missionLog[missionLogID].current != (missionLogID > 2 ? 0 : std::numeric_limits<uint16>::max()))
        {
            ShowWarning("Lua::addMission: player has a current mission (%d)", missionLogID);
        }

        PChar->m_missionLog[missionLogID].current = missionID;
        PChar->pushPacket<CQuestMissionLogPacket>(PChar, missionLogID, LOG_MISSION_CURRENT);

        charutils::SaveMissionsList(PChar);
    }
    else
    {
        ShowError("Lua::addMission: missionLogID %i or Mission %i is invalid", missionLogID, missionID);
    }
}

/************************************************************************
 *  Function: delMission()
 *  Purpose : Delets a mission from a player's mission log
 *  Example : player:delMission(xi.mission.log_id.TOAU, xi.mission.id.toau.KNIGHT_OF_GOLD)
 *  Notes   : Doesn't delete any player variables associated with mission
 *          : This function no longer accepts tables!
 ************************************************************************/

void CLuaBaseEntity::delMission(uint8 missionLogID, uint16 missionID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    if (missionLogID < MAX_MISSIONAREA && missionID < MAX_MISSIONID)
    {
        auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

        uint16 current  = PChar->m_missionLog[missionLogID].current;
        bool   complete = (missionLogID == MISSION_COP || missionID >= 64) ? false : PChar->m_missionLog[missionLogID].complete[missionID];

        if (current == missionID)
        {
            PChar->m_missionLog[missionLogID].current = missionLogID > 2 ? 0 : -1;
            PChar->pushPacket<CQuestMissionLogPacket>(PChar, missionLogID, LOG_MISSION_CURRENT);
        }
        if (complete)
        {
            PChar->m_missionLog[missionLogID].complete[missionID] = false;
            PChar->pushPacket<CQuestMissionLogPacket>(PChar, missionLogID, LOG_MISSION_COMPLETE);
        }
        charutils::SaveMissionsList(PChar);
    }
    else
    {
        ShowError("Lua::delMission: missionLogID %i or Mission %i is invalid", missionLogID, missionID);
    }
}

/************************************************************************
 *  Function: getCurrentMission()
 *  Purpose : Returns the integer associated with the player's current mission
 *  Example : player:getCurrentMission(xi.mission.log_id.TOAU)
 *  Notes   : Specify the area to pass a Lua table object
 ************************************************************************/

uint16 CLuaBaseEntity::getCurrentMission(sol::object const& missionLogObj)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity);
    if (!PChar)
    {
        return 0;
    }

    uint8  missionLogID = 0;
    uint16 MissionID    = 0;

    if (missionLogObj.is<lua_Number>())
    {
        missionLogID = missionLogObj.as<uint8>();
    }
    else if (missionLogObj.is<sol::table>())
    {
        missionLogID = missionLogObj.as<sol::table>()["mission_log"];
    }

    if (missionLogID < MAX_MISSIONAREA)
    {
        MissionID = PChar->m_missionLog[missionLogID].current;
    }
    else
    {
        ShowError("Lua::getCurrentMission: missionLogID %i is invalid", missionLogID);
    }

    return MissionID;
}

/************************************************************************
 *  Function: hasCompletedMission()
 *  Purpose : Returns true if a player has completed a specified mission
 *  Example : if player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.PRESIDENT_SALAHEEM) then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::hasCompletedMission(uint8 missionLogID, uint16 missionID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    bool complete = false;

    if (missionLogID < MAX_MISSIONAREA && missionID < MAX_MISSIONID)
    {
        auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
        complete    = (missionLogID == MISSION_COP || missionID >= 64) ? missionID < PChar->m_missionLog[missionLogID].current
                                                                       : PChar->m_missionLog[missionLogID].complete[missionID];
    }
    else
    {
        ShowError("Lua::hasCompletedMission: missionLogID %i or Mission %i is invalid", missionLogID, missionID);
    }

    return complete;
}

/************************************************************************
 *  Function: completeMission()
 *  Purpose : Completes a specified mission for the player
 *  Example : player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.THREE_PATHS)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::completeMission(uint8 missionLogID, uint16 missionID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    if (missionLogID < MAX_MISSIONAREA && missionID < MAX_MISSIONID)
    {
        auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

        if (PChar->m_missionLog[missionLogID].current != missionID)
        {
            ShowWarning("Lua::completeMission: can't complete non current mission", missionLogID);
        }
        else
        {
            PChar->m_missionLog[missionLogID].current = missionLogID > 2 ? 0 : std::numeric_limits<uint16>::max();
            if ((missionLogID != MISSION_COP) && (missionID < 64))
            {
                PChar->m_missionLog[missionLogID].complete[missionID] = true;
                PChar->pushPacket<CQuestMissionLogPacket>(PChar, missionLogID, LOG_MISSION_COMPLETE);
            }
            PChar->pushPacket<CQuestMissionLogPacket>(PChar, missionLogID, LOG_MISSION_CURRENT);

            charutils::SaveMissionsList(PChar);
            roeutils::event(ROE_MISSION_COMPLETE, PChar, RoeDatagramList{});
        }
    }
    else
    {
        ShowError("Lua::completeMission: missionLogID %i or Mission %i is invalid", missionLogID, missionID);
    }
}

/************************************************************************
 *  Function: setMissionStatus()
 *  Purpose : Sets mission progress data.
 *  Example : player:setMissionStatus(player:getNation(), 14)
 *  Notes   : setMissionStatus(log id,value[,index 0-7])
 *            If optional index is used, value must be between 0-15.
 ************************************************************************/

void CLuaBaseEntity::setMissionStatus(uint8 missionLogID, sol::object const& arg2Obj, sol::object const& arg3Obj)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    CCharEntity* PChar = (CCharEntity*)m_PBaseEntity;

    if (missionLogID >= MAX_MISSIONAREA)
    {
        ShowError("Lua::setMissionStatus: missionLogID %i is invalid", missionLogID);
        return;
    }

    if (arg3Obj.is<uint8>())
    {
        uint8 missionStatusPos = arg3Obj.as<uint8>();
        if (missionStatusPos > 7)
        {
            ShowError("Lua::setMissionStatus: position %i is invalid", missionStatusPos);
            return;
        }
        uint8 missionStatusValue = arg2Obj.as<uint8>();
        if (missionStatusValue > 0xF)
        {
            ShowError("Lua::setMissionStatus: value %i is invalid", missionStatusValue);
            return;
        }
        uint32 missionStatus = (PChar->m_missionLog[missionLogID].statusUpper << 16) | PChar->m_missionLog[missionLogID].statusLower;
        uint32 mask          = ~(0xF << (4 * missionStatusPos));

        missionStatus &= mask;
        missionStatus |= missionStatusValue << (4 * missionStatusPos);
        PChar->m_missionLog[missionLogID].statusLower = missionStatus;
        PChar->m_missionLog[missionLogID].statusUpper = missionStatus >> 16;
        PChar->pushPacket<CQuestMissionLogPacket>(PChar, missionLogID, LOG_MISSION_CURRENT);
    }
    else
    {
        uint32 missionStatusValue                     = arg2Obj.as<uint32>();
        PChar->m_missionLog[missionLogID].statusLower = missionStatusValue;
        PChar->m_missionLog[missionLogID].statusUpper = missionStatusValue >> 16;
    }

    charutils::SaveMissionsList(PChar);
}

/************************************************************************
 *  Function: getMissionStatus()
 *  Purpose : Gets mission progress data.
 *  Example : player:getMissionStatus(player:getNation())
 *  Notes   : getMissionStatus(log id[,index 0-7])
 ************************************************************************/

uint32 CLuaBaseEntity::getMissionStatus(uint8 missionLogID, sol::object const& missionStatusPosObj)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    CCharEntity* PChar = (CCharEntity*)m_PBaseEntity;
    if (missionLogID < MAX_MISSIONAREA)
    {
        uint32 missionStatus = (PChar->m_missionLog[missionLogID].statusUpper << 16) | PChar->m_missionLog[missionLogID].statusLower;
        if (missionStatusPosObj.is<uint8>())
        {
            uint8 missionStatusPos = missionStatusPosObj.as<uint8>();
            if (missionStatusPos > 7)
            {
                ShowError("Lua::getMissionStatus: position %i is invalid", missionStatusPos);
                return 0;
            }
            return ((missionStatus >> (4 * missionStatusPos)) & 0xF);
        }
        else
        {
            return missionStatus;
        }
    }

    ShowError("Lua::getMissionStatus: missionLogID %i is invalid", missionLogID);
    return 0;
}

/************************************************************************
 *  Function: setEminenceCompleted()
 *  Purpose :
 *  Example : player:setEminenceCompleted(1)
 *  Notes   : optional arg 1 flags for repeat record (1/0) (Does not remove from log)
 *            optional arg 2 can set completion state explicitly (1/0)
 ************************************************************************/

void CLuaBaseEntity::setEminenceCompleted(uint16 recordID, sol::object const& arg1, sol::object const& arg2)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    bool repeat = (arg1 != sol::lua_nil) ? arg1.as<bool>() : false;
    bool status = (arg2 != sol::lua_nil) ? arg2.as<bool>() : true;

    if (repeat)
    {
        roeutils::SetEminenceRecordProgress(PChar, recordID, 0);
    }
    else
    {
        roeutils::DelEminenceRecord(PChar, recordID);
    }

    roeutils::SetEminenceRecordCompletion(PChar, recordID, status);
}

/************************************************************************
 *  Function: getEminenceCompleted()
 *  Purpose : Returns true if eminence is flagged complete for player
 *  Example : player:getEminenceCompleted(1)
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::getEminenceCompleted(uint16 recordID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    return roeutils::GetEminenceRecordCompletion(PChar, recordID);
}

uint16 CLuaBaseEntity::getNumEminenceCompleted()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    return roeutils::GetNumEminenceCompleted(PChar);
}

/************************************************************************
 *  Function: setEminenceProgress(record, progress, total)
 *  Purpose :
 *  Example : player:setEminenceProgress(12, 3, 200)
 *  Notes   : The 3rd param is optional. However, no message will be shown if not given.
 ************************************************************************/

bool CLuaBaseEntity::setEminenceProgress(uint16 recordID, uint32 progress, sol::object const& arg2)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    auto*  PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    uint32 total = arg2.get_type() == sol::type::number ? arg2.as<uint32>() : 0;

    // Determine threshold for sending progress messages
    bool progressNotify{ true };
    if (uint32 threshold = roeutils::RoeSystem.NotifyThresholds[recordID]; threshold > 1)
    {
        uint32 prevStep = roeutils::GetEminenceRecordProgress(PChar, recordID) / threshold;
        uint32 nextStep = progress / threshold;
        progressNotify  = nextStep > prevStep;
    }

    bool result = roeutils::SetEminenceRecordProgress(PChar, recordID, progress);

    if (total && progressNotify)
    {
        PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, recordID, 0, MSGBASIC_ROE_RECORD);
        PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, progress, total, MSGBASIC_ROE_PROGRESS);
    }

    return result;
}

/************************************************************************
 *  Function: getEminenceProgress(record)
 *  Purpose :
 *  Example : player:getEminenceProgress(19)
 *  Notes   : returns nil if player does not have the record.
 ************************************************************************/

std::optional<uint32> CLuaBaseEntity::getEminenceProgress(uint16 recordID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return std::nullopt;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (roeutils::HasEminenceRecord(PChar, recordID))
    {
        return roeutils::GetEminenceRecordProgress(PChar, recordID);
    }

    // TODO: Verify that 0-return is acceptable in previous nil-cases (Its not)
    return std::nullopt;
}

/************************************************************************
 *  Function: hasEminenceRecord(record)
 *  Purpose : Returns true if the record is active
 *  Example : player:hasEminenceRecord(19)
 ************************************************************************/

bool CLuaBaseEntity::hasEminenceRecord(uint16 recordID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    return roeutils::HasEminenceRecord(PChar, recordID);
}

/************************************************************************
 *  Function: triggerRoeEvent(eventID, {["reqName"] = value})
 *  Purpose : Triggers roeutils::event()
 *  Example : player:triggerRoeEvent(19)
 *  Note    : This only supports int/string datagram events at the moment!
 ************************************************************************/

void CLuaBaseEntity::triggerRoeEvent(uint8 eventNum, sol::object const& reqTable)
{
    RoeDatagramList roeEventData({});
    ROE_EVENT       eventID = static_cast<ROE_EVENT>(eventNum);

    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        return;
    }

    if (reqTable.get_type() == sol::type::table)
    {
        for (const auto& kv : reqTable.as<sol::table>())
        {
            if (kv.first.get_type() == sol::type::string)
            {
                if (kv.second.get_type() == sol::type::number)
                {
                    roeEventData.emplace_back(kv.first.as<std::string>(), kv.second.as<uint32>());
                }
                else if (kv.second.get_type() == sol::type::string)
                {
                    roeEventData.emplace_back(kv.first.as<std::string>(), kv.second.as<std::string>());
                }
            }
        }
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    roeutils::event(eventID, PChar, roeEventData);
}

/************************************************************************
 *  Function: setUnityLeader(leaderID)
 *  Purpose : Sets a player's Unity Leader
 *  Example : player:setUnityLeader(4)
 ************************************************************************/

void CLuaBaseEntity::setUnityLeader(uint8 leaderID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    // Update Unity Trust, assumes that values have been cleared
    if (PChar->profile.unity_leader > 0)
    {
        uint8 oldUnity = PChar->profile.unity_leader - 1;
        charutils::delSpell(PChar, ROE_TRUST_ID[oldUnity]);
        charutils::DeleteSpell(PChar, ROE_TRUST_ID[oldUnity]);
    }

    charutils::SetUnityLeader(PChar, leaderID);
    roeutils::UpdateUnityTrust(PChar);
}

/************************************************************************
 *  Function: getUnityLeader()
 *  Purpose : Gets a player's Unity Leader
 *  Example : player:getUnityLeader()
 ************************************************************************/

uint8 CLuaBaseEntity::getUnityLeader()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    return PChar->profile.unity_leader;
}

/************************************************************************
 *  Function: getUnityRank()
 *  Purpose : Gets the current rank of the player's Unity, if a parameter
 *          : is specified, returns the rank of that unity
 *  Example : player:getUnityRank()
 ************************************************************************/

std::optional<uint8> CLuaBaseEntity::getUnityRank(sol::object const& unityObj)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return std::nullopt;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    uint8 unity = (unityObj != sol::lua_nil) ? unityObj.as<uint8>() : PChar->profile.unity_leader;

    if (unity >= 1 && unity <= 11)
    {
        return roeutils::RoeSystem.unityLeaderRank[unity - 1];
    }

    return std::nullopt;
}

/************************************************************************
 *  Function: getClaimedDeedMask()
 *  Purpose : Gets a table of uint32 corresponding to claimed deeds of
 *            heroism rewards.
 *  Example : player:getClaimedDeedMask()
 ************************************************************************/

sol::table CLuaBaseEntity::getClaimedDeedMask()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Attempt to get claimed deed mask for Non-PC.");
        return sol::lua_nil;
    }

    auto* PChar     = static_cast<CCharEntity*>(m_PBaseEntity);
    auto  maskTable = lua.create_table();
    for (uint8 i = 0; i < 5; ++i)
    {
        maskTable.add(PChar->m_claimedDeeds[i]);
    }

    return maskTable;
}

/************************************************************************
 *  Function: toggleReceivedDeedRewards()
 *  Purpose : Sets bit corresponding to showing or hiding received deed rewards
 *  Example : player:toggleReceivedDeedRewards()
 ************************************************************************/

void CLuaBaseEntity::toggleReceivedDeedRewards()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Attempt to toggle hide/show received rewards for Non-PC.");
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    // Bit0 is unused in the 1st and 5th array value.  Packing this setting into
    // the first bit of the first array index.
    PChar->m_claimedDeeds[0] ^= 1;

    const char* query = "UPDATE char_unlocks SET claimed_deeds = '%s' WHERE charid = %u";
    char        buf[sizeof(PChar->m_claimedDeeds) * 2 + 1];

    _sql->EscapeStringLen(buf, (const char*)&PChar->m_claimedDeeds, sizeof(PChar->m_claimedDeeds));
    _sql->Query(query, buf, PChar->id);
}

/************************************************************************
 *  Function: setClaimedDeed()
 *  Purpose : Sets bit corresponding to a deed of heroism reward as claimed
 *  Example : player:setClaimedDeed(1)
 ************************************************************************/

void CLuaBaseEntity::setClaimedDeed(uint16 deedBitNum)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Attempt to set claimed deed mask for Non-PC.");
        return;
    }

    auto* PChar  = static_cast<CCharEntity*>(m_PBaseEntity);
    uint8 index  = deedBitNum / 32;
    uint8 setBit = deedBitNum % 32;

    PChar->m_claimedDeeds[index] |= (1 << setBit);

    const char* query = "UPDATE char_unlocks SET claimed_deeds = '%s' WHERE charid = %u";
    char        buf[sizeof(PChar->m_claimedDeeds) * 2 + 1];

    _sql->EscapeStringLen(buf, (const char*)&PChar->m_claimedDeeds, sizeof(PChar->m_claimedDeeds));
    _sql->Query(query, buf, PChar->id);
}

/************************************************************************
 *  Function: resetClaimedDeeds()
 *  Purpose : Clears existing rewards that can be reset, and increments the reset
 *            value to increase future cost for the player.
 *  Example : player:resetClaimedDeeds()
 ************************************************************************/

void CLuaBaseEntity::resetClaimedDeeds()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Attempt to set claimed deed mask for Non-PC.");
        return;
    }

    auto*  PChar     = static_cast<CCharEntity*>(m_PBaseEntity);
    uint32 numResets = (PChar->m_claimedDeeds[4] >> 18) + 1;

    // First two bits of m_claimedDeeds[3] are not resettable.
    PChar->m_claimedDeeds[3] = PChar->m_claimedDeeds[3] & 0b11;
    PChar->m_claimedDeeds[4] = numResets << 18;

    const char* query = "UPDATE char_unlocks SET claimed_deeds = '%s' WHERE charid = %u";
    char        buf[sizeof(PChar->m_claimedDeeds) * 2 + 1];

    _sql->EscapeStringLen(buf, (const char*)&PChar->m_claimedDeeds, sizeof(PChar->m_claimedDeeds));
    _sql->Query(query, buf, PChar->id);
}

/************************************************************************
 *  Function: setUniqueEvent()
 *  Purpose : Sets and saves unique event tracking value into database
 *  Example : player:setUniqueEvent(xi.uniqueEvent.TUCKER_INTRO_DIALOGUE)
 ************************************************************************/
void CLuaBaseEntity::setUniqueEvent(uint16 uniqueEventId)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Attempt to set Unique Event mask for Non-PC.");
        return;
    }

    auto* PChar  = static_cast<CCharEntity*>(m_PBaseEntity);
    uint8 index  = uniqueEventId / 32;
    uint8 setBit = uniqueEventId % 32;

    PChar->m_uniqueEvents[index] |= (1 << setBit);

    const char* query = "UPDATE char_unlocks SET unique_event = '%s' WHERE charid = %u";
    char        buf[sizeof(PChar->m_uniqueEvents) * 2 + 1];

    _sql->EscapeStringLen(buf, (const char*)&PChar->m_uniqueEvents, sizeof(PChar->m_uniqueEvents));
    _sql->Query(query, buf, PChar->id);
}

/************************************************************************
 *  Function: delUniqueEvent()
 *  Purpose : Removes and saves unique event tracking value into database
 *  Example : player:delUniqueEvent(xi.uniqueEvent.TUCKER_INTRO_DIALOGUE)
 *  NOTE    : This should never be used outside of debugging!
 ************************************************************************/
void CLuaBaseEntity::delUniqueEvent(uint16 uniqueEventId)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Attempt to del from Unique Event mask for Non-PC.");
        return;
    }

    auto* PChar  = static_cast<CCharEntity*>(m_PBaseEntity);
    uint8 index  = uniqueEventId / 32;
    uint8 setBit = uniqueEventId % 32;

    PChar->m_uniqueEvents[index] &= ~(1 << setBit);

    const char* query = "UPDATE char_unlocks SET unique_event = '%s' WHERE charid = %u";
    char        buf[sizeof(PChar->m_uniqueEvents) * 2 + 1];

    _sql->EscapeStringLen(buf, (const char*)&PChar->m_uniqueEvents, sizeof(PChar->m_uniqueEvents));
    _sql->Query(query, buf, PChar->id);
}

/************************************************************************
 *  Function: hasCompletedUniqueEvent()
 *  Purpose : Returns true if the player has seen his event before
 *  Example : if player:hasUniqueEvent(xi.uniqueEvent.TUCKER_INTRO_DIALOGUE) then
 *  NOTE    : This should never be used outside of debugging!
 ************************************************************************/
bool CLuaBaseEntity::hasCompletedUniqueEvent(uint16 uniqueEventId)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Attempt to compare Unique Event mask for Non-PC.");
        return false;
    }

    auto* PChar  = static_cast<CCharEntity*>(m_PBaseEntity);
    uint8 index  = uniqueEventId / 32;
    uint8 setBit = uniqueEventId % 32;

    return PChar->m_uniqueEvents[index] & (1 << setBit);
}

/************************************************************************
 *  Function: addAssault()
 *  Purpose : Adds an assault mission to the player's log
 *  Example : player:addAssault(bit.rshift(option,4))
 *  Notes   : See scripts/zones/Aht_Urhgan_Whitegate/npcs/Famad.lua
 ************************************************************************/

void CLuaBaseEntity::addAssault(uint8 missionID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (PChar->m_assaultLog.current != 0)
    {
        ShowWarning("Lua::addAssault: player has a current assault");
    }

    PChar->m_assaultLog.current = missionID;
    PChar->pushPacket<CQuestMissionLogPacket>(PChar, MISSION_ASSAULT, LOG_MISSION_CURRENT);

    charutils::SaveMissionsList(PChar);
}

/************************************************************************
 *  Function: delAssault()
 *  Purpose : Deletes an assault mission from a player's log
 *  Example : player:delAssault(currentAssault)
 ************************************************************************/

void CLuaBaseEntity::delAssault(uint8 missionID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar   = static_cast<CCharEntity*>(m_PBaseEntity);
    auto  current = static_cast<uint8>(PChar->m_assaultLog.current);

    if (current == missionID)
    {
        PChar->m_assaultLog.current = 0;
        PChar->pushPacket<CQuestMissionLogPacket>(PChar, MISSION_ASSAULT, LOG_MISSION_CURRENT);
    }

    charutils::SaveMissionsList(PChar);
}

/************************************************************************
 *  Function: getCurrentAssault()
 *  Purpose : Returns the current assault mission for the player
 *  Example : local assaultid = player:getCurrentAssault()
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getCurrentAssault()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    return static_cast<uint8>(PChar->m_assaultLog.current);
}

/************************************************************************
 *  Function: hasCompletedAssault()
 *  Purpose : Returns true if a player has completed a specified assault
 *  Example : if v:hasCompletedAssault(v:getCurrentAssault()) then
 *  Notes   : See scripts/zones/Leujaoam_Sanctum/npcs/rune_of_release.lua
 ************************************************************************/

bool CLuaBaseEntity::hasCompletedAssault(uint8 missionID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    return static_cast<CCharEntity*>(m_PBaseEntity)->m_assaultLog.complete[missionID];
}

/************************************************************************
 *  Function: completeAssault()
 *  Purpose : Completes the current assault mission for the player
 *  Example : player:completeAssault(currentAssault)
 *  Notes   : See scripts/zones/Aht_Urhgan_Whitegate/npcs/Rytaal.lua
 ************************************************************************/

void CLuaBaseEntity::completeAssault(uint8 missionID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (PChar->m_assaultLog.current != missionID)
    {
        ShowWarning("Lua::completeAssault: completion of not current assault");
    }

    PChar->m_assaultLog.current             = 0;
    PChar->m_assaultLog.complete[missionID] = true;
    PChar->pushPacket<CQuestMissionLogPacket>(PChar, MISSION_ASSAULT, LOG_MISSION_CURRENT);
    PChar->pushPacket<CQuestMissionLogPacket>(PChar, MISSION_ASSAULT, LOG_MISSION_COMPLETE);

    charutils::SaveMissionsList(PChar);
}

/************************************************************************
 *  Function: addKeyItem()
 *  Purpose : Adds a key item to the player
 *  Example : player:addKeyItem(xi.ki.MOGHANCEMENT_FIRE)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::addKeyItem(uint16 keyItemID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    uint8 table = keyItemID >> 9;

    if (table >= MAX_KEYS_TABLE)
    {
        // Bail out if an invalid keyitem is being added
        ShowWarning("CLuaBaseEntity::addKeyItem() - Attempting to add invalid key item: %d", keyItemID);
        return;
    }

    charutils::addKeyItem(PChar, keyItemID);
    PChar->pushPacket<CKeyItemsPacket>(PChar, static_cast<KEYS_TABLE>(table));

    if (table == 6)
    {
        PChar->pushPacket<CCharMountsPacket>(PChar);
    }

    charutils::SaveKeyItems(PChar);
}

/************************************************************************
 *  Function: hasKeyItem()
 *  Purpose : Returns true if a player has a specified key item
 *  Example : if (player:hasKeyItem(xi.ki.TORN_PAPER)) then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::hasKeyItem(uint16 keyItemID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    return charutils::hasKeyItem(static_cast<CCharEntity*>(m_PBaseEntity), keyItemID) != 0;
}

/************************************************************************
 *  Function: delKeyItem()
 *  Purpose : Deletes a key item from the player
 *  Example : player:delKeyItem(xi.ki.SUNBEAM_FRAGMENT)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::delKeyItem(uint16 keyItemID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    uint8 table = keyItemID >> 9;

    if (table >= MAX_KEYS_TABLE)
    {
        // Bail out if an invalid keyitem is being added
        ShowWarning("CLuaBaseEntity::delKeyItem() - Attempting to delete invalid key item: %d", keyItemID);
        return;
    }

    charutils::delKeyItem(PChar, keyItemID);
    PChar->pushPacket<CKeyItemsPacket>(PChar, static_cast<KEYS_TABLE>(table));

    charutils::SaveKeyItems(PChar);
}

/************************************************************************
 *  Function: seenKeyItem()
 *  Purpose : Returns true if a player has peeked at the key item
 *  Example : if player:seenKeyItem(xi.ki.LETTER_FROM_ROH_LATTEH) then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::seenKeyItem(uint16 keyItemID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    return charutils::seenKeyItem(static_cast<CCharEntity*>(m_PBaseEntity), keyItemID) != 0;
}

/************************************************************************
 *  Function: unseenKeyItem()
 *  Purpose : Restores a key item to unseen status
 *  Example : player:unseenKeyItem(xi.ki.MOGHANCEMENT_FIRE)
 *  Notes   : Some things just can't be unseen... (not implemented though)
 ************************************************************************/

void CLuaBaseEntity::unseenKeyItem(uint16 keyItemID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    uint8 table = keyItemID >> 9;

    if (table >= MAX_KEYS_TABLE)
    {
        // Bail out if an invalid keyitem is being added
        ShowWarning("CLuaBaseEntity::unseenKeyItem() - Attempting to unsee invalid key item: %d", keyItemID);
        return;
    }

    charutils::unseenKeyItem(PChar, keyItemID);
    PChar->pushPacket<CKeyItemsPacket>(PChar, static_cast<KEYS_TABLE>(table));

    charutils::SaveKeyItems(PChar);
}

/************************************************************************
 *  Function: addExp()
 *  Purpose : Adds a set amount of XP to the player
 *  Example : player:addExp(math.random(500,1000))
 *  Notes   : Used in Dynamis Pages, etc
 ************************************************************************/

void CLuaBaseEntity::addExp(uint32 exp)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    charutils::AddExperiencePoints(false, PChar, m_PBaseEntity, exp);
}

/************************************************************************
 *  Function: addCapacityPoints()
 *  Purpose : Adds a set amount of Capacity Points to the player
 *  Example : player:addCapacity(1000)
 *  Notes   : Used for RoE rewards
 ************************************************************************/

void CLuaBaseEntity::addCapacityPoints(uint32 capacity)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    charutils::AddCapacityPoints(PChar, m_PBaseEntity, capacity);
}

/************************************************************************
 *  Function: delExp()
 *  Purpose : Takes XP from a player
 *  Example : player:delExp(amount)
 *  Notes   : Used only in GM command takexp.lua
 ************************************************************************/

void CLuaBaseEntity::delExp(uint32 exp)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    charutils::DelExperiencePoints(PChar, 0, std::clamp<uint16>(exp, 0, 65535));
}

/************************************************************************
 *  Function: getMerit()
 *  Purpose : Checks for the existence of a merit and returns the value
 *  Example : caster:getMerit(xi.merit.DOTON_EFFECT)
 *  Notes   :
 ************************************************************************/

int32 CLuaBaseEntity::getMerit(uint16 merit)
{
    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

        return PChar->PMeritPoints->GetMeritValue(static_cast<MERIT_TYPE>(merit), PChar);
    }

    return 0;
}

/************************************************************************
 *  Function: getMeritCount()
 *  Purpose : Returns the current value of merits a player has
 *  Example : player:getMeritCount()
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getMeritCount()
{
    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

        return PChar->PMeritPoints->GetMeritPoints();
    }

    return 0;
}

/************************************************************************
 *  Function: setMerits()
 *  Purpose : Sets the merit points for a player to a specified amount
 *  Example : player:setMerits(30)
 *  Notes   : Used in GM command and Nomad Moogle for Genkai quest
 ************************************************************************/

void CLuaBaseEntity::setMerits(uint8 numPoints)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->PMeritPoints->SetMeritPoints(numPoints);
    PChar->pushPacket<CMenuMeritPacket>(PChar);
    PChar->pushPacket<CMonipulatorPacket1>(PChar);
    PChar->pushPacket<CMonipulatorPacket2>(PChar);

    charutils::SaveCharExp(PChar, PChar->GetMJob());
}

/************************************************************************
 *  Function: getSpentJobPoints()
 *  Purpose : Returns the total value of all job points spent
 *  Example : player:getSpentJobPoints()
 *  Notes   :
 ************************************************************************/
uint16 CLuaBaseEntity::getSpentJobPoints()
{
    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        CCharEntity* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

        if (PChar->GetMLevel() < 99) // account for Level Sync
        {
            return 0;
        }
        return PChar->PJobPoints->GetJobPointsSpent();
    }

    return 0;
}

/************************************************************************
 *  Function: getJobPointLevel()
 *  Purpose : Returns the current value a specific job point
 *  Example : player:getJobPointLevel(JP_MIGHTY_STRIKES_EFFECT)
 *  Notes   :
 ************************************************************************/
uint8 CLuaBaseEntity::getJobPointLevel(uint16 jpType)
{
    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        CCharEntity* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
        return PChar->PJobPoints->GetJobPointValue(static_cast<JOBPOINT_TYPE>(jpType));
    }

    return 0;
}

/************************************************************************
 *  Function: setCapacityPoints()
 *  Purpose : Sets the capacity points for a player to a specified amount
 *  Example : player:setCapacityPoints(5000)
 *  Notes   : Used in GM command
 ************************************************************************/

void CLuaBaseEntity::setCapacityPoints(uint16 amount)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowDebug("Warning: Attempt to set Capacity Points for non-PC type!");
        return;
    }

    CCharEntity* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->PJobPoints->SetCapacityPoints(amount);
    PChar->pushPacket<CMenuJobPointsPacket>(PChar);
}

/************************************************************************
 *  Function: setJobPoints()
 *  Purpose : Sets the job points for a player to a specified amount
 *  Example : player:setJobPoints(30)
 *  Notes   : Used in GM command
 ************************************************************************/

void CLuaBaseEntity::setJobPoints(uint16 amount)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowDebug("Warning: Attempt to set Job Points for non-PC type!");
        return;
    }

    CCharEntity* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->PJobPoints->SetJobPoints(amount);
    PChar->pushPacket<CMenuJobPointsPacket>(PChar);
}

/************************************************************************
 *  Function: addJobPoints()
 *  Purpose : Adds job points to a player based on job, amount entered
 *  Example : player:addJobPoints(17, 30)
 *  Notes   : Used for GM command
 ************************************************************************/
void CLuaBaseEntity::addJobPoints(uint8 jobID, uint16 amount)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowDebug("Warning: Attempt to add Job Points for non-PC type!");
        return;
    }

    CCharEntity* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->PJobPoints->AddJobPoints(jobID, amount);
    PChar->pushPacket<CMenuJobPointsPacket>(PChar);
}

/************************************************************************
 *  Function: delJobPoints()
 *  Purpose : Deletes job points from a player based on job, amount entered
 *  Example : player:delJobPoints(17, 30)
 *  Notes   : Used in NPC Oboro
 ************************************************************************/
void CLuaBaseEntity::delJobPoints(uint8 jobID, uint16 amount)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowDebug("Warning: Attempt to delete Job Points from non-PC type!");
        return;
    }

    CCharEntity* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->PJobPoints->DelJobPoints(jobID, amount);
    PChar->pushPacket<CMenuJobPointsPacket>(PChar);
}

/************************************************************************
 *  Function: getJobPoints()
 *  Purpose : Gets the jobs points from a player based on a specific job entered
 *  Example : player:getJobPoints(17)
 *  Notes   : Used in NPC Oboro
 ************************************************************************/
uint16 CLuaBaseEntity::getJobPoints(JOBTYPE jobID)
{
    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        CCharEntity* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
        return PChar->PJobPoints->GetJobPointsByJob(jobID);
    }
    return 0;
}

/************************************************************************
 *  Function: masterJob()
 *  Purpose : Fully masters / unlocks player's current job
 *  Example : player:masterJob()
 *  Notes   : Used in GM command
 ************************************************************************/

void CLuaBaseEntity::masterJob()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowDebug("Warning: Attempt to master job for non-PC type!");
        return;
    }

    CCharEntity* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    auto jpCategory = 0x020 * PChar->GetMJob();
    for (auto i = jpCategory; i < jpCategory + 0xA; i++)
    {
        auto points       = PChar->PJobPoints->GetJobPointType((JOBPOINT_TYPE)i);
        auto pointsNeeded = 20 - points->value;
        auto currentJP    = PChar->PJobPoints->GetJobPoints();

        for (auto x = 0; x < pointsNeeded; x++)
        {
            auto cost = JobPointCost(points->value);
            PChar->PJobPoints->SetJobPoints(currentJP + cost);
            PChar->PJobPoints->RaiseJobPoint((JOBPOINT_TYPE)i);
        }
    }

    PChar->pushPacket<CMenuJobPointsPacket>(PChar);
}

/************************************************************************
 *  Function: getGil()
 *  Purpose : Returns the total amount of a gil a player has
 *  Example : player:getGil()
 *  Notes   : Used mostly as a control to make sure player has enough gil
 ************************************************************************/

uint32 CLuaBaseEntity::getGil()
{
    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        CItem* item = static_cast<CCharEntity*>(m_PBaseEntity)->getStorage(LOC_INVENTORY)->GetItem(0);

        if (item == nullptr) // Player has no money
        {
            return 0;
        }
        else if (!item->isType(ITEM_CURRENCY))
        {
            ShowCritical("lua::getGil : Item in currency slot is not gil!");
            return 0;
        }

        return item->getQuantity();
    }

    if (m_PBaseEntity->objtype == TYPE_MOB)
    {
        auto* PMob = dynamic_cast<CMobEntity*>(m_PBaseEntity);
        if (PMob && PMob->CanStealGil())
        {
            return PMob->GetRandomGil();
        }
    }

    return 0;
}

/************************************************************************
 *  Function: addGil()
 *  Purpose : Add a specified amount of gil to the player
 *  Example : player:addGil(500)
 *  Notes   : Use messageSpecial() to display the 'obtained' message
 ************************************************************************/

void CLuaBaseEntity::addGil(int32 gil)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    CItem* item = static_cast<CCharEntity*>(m_PBaseEntity)->getStorage(LOC_INVENTORY)->GetItem(0);

    if (item == nullptr || !item->isType(ITEM_CURRENCY))
    {
        ShowCritical("lua::addGil : No Gil in currency slot");
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    charutils::UpdateItem(PChar, LOC_INVENTORY, 0, gil);
}

/************************************************************************
 *  Function: setGil()
 *  Purpose : Sets a player's current gil to a specified value
 *  Example : player:setGil(1)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setGil(int32 amount)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    CItem* item = static_cast<CCharEntity*>(m_PBaseEntity)->getStorage(LOC_INVENTORY)->GetItem(0);

    if (item == nullptr || !item->isType(ITEM_CURRENCY))
    {
        ShowCritical("lua::setGil : No Gil in currency slot");
        return;
    }

    int32 gil   = amount - item->getQuantity();
    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    charutils::UpdateItem(PChar, LOC_INVENTORY, 0, gil);
}

/************************************************************************
 *  Function: delGil()
 *  Purpose : Takes a specified amount of gil from the player
 *  Example : player:delGil(100)
 *  Notes   : Returns bool on success/fail
 ************************************************************************/

bool CLuaBaseEntity::delGil(int32 gil)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    if (gil < 0)
    {
        ShowError("lua::delGil : Negative Gil (%i) passed to function", gil);
        return false;
    }

    bool result = false;

    CItem* PItem = static_cast<CCharEntity*>(m_PBaseEntity)->getStorage(LOC_INVENTORY)->GetItem(0);

    if (PItem != nullptr && PItem->isType(ITEM_CURRENCY) && (int32)PItem->getQuantity() >= gil)
    {
        auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
        result      = charutils::UpdateItem(PChar, LOC_INVENTORY, 0, -gil) == 0xFFFF;
    }
    else
    {
        ShowCritical("lua::delGil : Not enough Gil in currency slot");
    }

    return result;
}

/************************************************************************
 *  Function: getCurrency()
 *  Purpose : Get a player's current balance of a specified type
 *  Example : player:getCurrency("cruor") -- Must pass a string value
 *  Notes   : See char_points.sql for all currency types
 ************************************************************************/

int32 CLuaBaseEntity::getCurrency(std::string const& currencyType)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    return charutils::GetPoints(PChar, currencyType.c_str());
}

/************************************************************************
 *  Function: addCurrency()
 *  Purpose : Add a specified amount to a player's currency balance
 *  Example : player:addCurrency("traverser_stones",3)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::addCurrency(std::string const& currencyType, int32 amount, sol::object const& maxObj)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    int32 maxPoints = maxObj.get_type() == sol::type::number ? maxObj.as<int32>() : std::numeric_limits<int32>::max();

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    charutils::AddPoints(PChar, currencyType.c_str(), amount, maxPoints);
}

/************************************************************************
 *  Function: setCurrency()
 *  Purpose : Set a player's currency to a specified amount
 *  Example : player:setCurrency("zeni_points",400)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setCurrency(std::string const& currencyType, int32 amount)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    charutils::SetPoints(PChar, currencyType.c_str(), amount);
}

/************************************************************************
 *  Function: delCurrency()
 *  Purpose : Remove a specified amount from a player's currency balance
 *  Example : player:delCurrency("traverser_stones",2)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::delCurrency(std::string const& currencyType, int32 amount)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    charutils::AddPoints(PChar, currencyType.c_str(), -amount);
}

/************************************************************************
 *  Function: getCP()
 *  Purpose : Returns the current amount of conquest points for a player
 *  Example : player:getCP()
 *  Notes   : Current nation only
 ************************************************************************/

int32 CLuaBaseEntity::getCP()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    return charutils::GetPoints(PChar, charutils::GetConquestPointsName(PChar).c_str());
}

/************************************************************************
 *  Function: addCP()
 *  Purpose : Adds a specified amount of conquest points to the player
 *  Example : player:addCP(50)
 *  Notes   : Current nation only
 ************************************************************************/

void CLuaBaseEntity::addCP(int32 cp)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    charutils::AddPoints(PChar, charutils::GetConquestPointsName(PChar).c_str(), cp);
    PChar->pushPacket<CConquestPacket>(PChar);
}

/************************************************************************
 *  Function: delCP()
 *  Purpose : Takes conquest points from a player
 *  Example : player:delCP(2500)
 *  Notes   : Current nation only
 ************************************************************************/

void CLuaBaseEntity::delCP(int32 cp)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    charutils::AddPoints(PChar, charutils::GetConquestPointsName(PChar).c_str(), -cp);
    PChar->pushPacket<CConquestPacket>(PChar);
}

/************************************************************************
 *  Function: getSeals()
 *  Purpose : Returns the current seal balance for a player
 *  Example : player:getSeals(type)
 *  Notes   : 0 = Beast; 1 = Kindred; 2 = KCrest; 3 = HKCrest; 4 = SKCrest
 ************************************************************************/

int32 CLuaBaseEntity::getSeals(uint8 sealType)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto* PChar  = static_cast<CCharEntity*>(m_PBaseEntity);
    int32 amount = 0;

    switch (sealType)
    {
        case 0:
            amount = charutils::GetPoints(PChar, "beastman_seal");
            break;
        case 1:
            amount = charutils::GetPoints(PChar, "kindred_seal");
            break;
        case 2:
            amount = charutils::GetPoints(PChar, "kindred_crest");
            break;
        case 3:
            amount = charutils::GetPoints(PChar, "high_kindred_crest");
            break;
        case 4:
            amount = charutils::GetPoints(PChar, "sacred_kindred_crest");
            break;
        default:
            break;
    }

    return amount;
}

/************************************************************************
 *  Function: addSeals()
 *  Purpose : Adds to the player's seal balance
 *  Example : player:addSeals(amount, type)
 *  Notes   : 0 = Beast; 1 = Kindred; 2 = KCrest; 3 = HKCrest; 4 = SKCrest
 ************************************************************************/

void CLuaBaseEntity::addSeals(int32 points, uint8 sealType)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    switch (sealType)
    {
        case 0:
            charutils::AddPoints(PChar, "beastman_seal", points);
            break;
        case 1:
            charutils::AddPoints(PChar, "kindred_seal", points);
            break;
        case 2:
            charutils::AddPoints(PChar, "kindred_crest", points);
            break;
        case 3:
            charutils::AddPoints(PChar, "high_kindred_crest", points);
            break;
        case 4:
            charutils::AddPoints(PChar, "sacred_kindred_crest", points);
            break;
        default:
            break;
    }
}

/************************************************************************
 *  Function: delSeals()
 *  Purpose : Takes seals from a player's balance
 *  Example : player:delSeals(amount, type)
 *  Notes   : 0 = Beast; 1 = Kindred; 2 = KCrest; 3 = HKCrest; 4 = SKCrest
 ************************************************************************/

void CLuaBaseEntity::delSeals(int32 points, uint8 sealType)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    switch (sealType)
    {
        case 0:
            charutils::AddPoints(PChar, "beastman_seal", -points);
            break;
        case 1:
            charutils::AddPoints(PChar, "kindred_seal", -points);
            break;
        case 2:
            charutils::AddPoints(PChar, "kindred_crest", -points);
            break;
        case 3:
            charutils::AddPoints(PChar, "high_kindred_crest", -points);
            break;
        case 4:
            charutils::AddPoints(PChar, "sacred_kindred_crest", -points);
            break;
        default:
            break;
    }
}

/************************************************************************
 *  Function: getAssaultPoint()
 *  Purpose : Get the player's current assault points balance
 *  Example : player:getAssaultPoint(4)
 *  Notes   :
 ************************************************************************/

int32 CLuaBaseEntity::getAssaultPoint(uint8 region)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto* PChar  = static_cast<CCharEntity*>(m_PBaseEntity);
    int32 points = 0;

    switch (region)
    {
        case 0:
            points = charutils::GetPoints(PChar, "leujaoam_assault_point");
            break;
        case 1:
            points = charutils::GetPoints(PChar, "mamool_assault_point");
            break;
        case 2:
            points = charutils::GetPoints(PChar, "lebros_assault_point");
            break;
        case 3:
            points = charutils::GetPoints(PChar, "periqia_assault_point");
            break;
        case 4:
            points = charutils::GetPoints(PChar, "ilrusi_assault_point");
            break;
        default:
            break;
    }

    return points;
}

/************************************************************************
 *  Function: addAssaultPoint()
 *  Purpose : Add a specified amount of Assault points to a defined region
 *  Example : player:addAssaultPoint(0,300)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::addAssaultPoint(uint8 region, int32 points)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    switch (region)
    {
        case 0:
            charutils::AddPoints(PChar, "leujaoam_assault_point", points);
            break;
        case 1:
            charutils::AddPoints(PChar, "mamool_assault_point", points);
            break;
        case 2:
            charutils::AddPoints(PChar, "lebros_assault_point", points);
            break;
        case 3:
            charutils::AddPoints(PChar, "periqia_assault_point", points);
            break;
        case 4:
            charutils::AddPoints(PChar, "ilrusi_assault_point", points);
            break;
        default:
            break;
    }
}

/************************************************************************
 *  Function: delAssaultPoint()
 *  Purpose : Subtract Assault points from a particular region
 *  Example : player:delAssaultPoint(0,300)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::delAssaultPoint(uint8 region, int32 points)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    switch (region)
    {
        case 0:
            charutils::AddPoints(PChar, "leujaoam_assault_point", -points);
            break;
        case 1:
            charutils::AddPoints(PChar, "mamool_assault_point", -points);
            break;
        case 2:
            charutils::AddPoints(PChar, "lebros_assault_point", -points);
            break;
        case 3:
            charutils::AddPoints(PChar, "periqia_assault_point", -points);
            break;
        case 4:
            charutils::AddPoints(PChar, "ilrusi_assault_point", -points);
            break;
        default:
            break;
    }
}

/************************************************************************
 *  Function: addGuildPoints()
 *  Purpose : Add guild points based on the item in a specified slot ID
 *  Example : player:addGuildPoints(GuildID,SlotID)
 *  Notes   :
 ************************************************************************/

auto CLuaBaseEntity::addGuildPoints(uint8 guildID, uint8 slotID) -> std::tuple<uint8, int16>
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return { 0, 0 };
    }

    CGuild* PGuild = guildutils::GetGuild(guildID);
    auto*   PChar  = static_cast<CCharEntity*>(m_PBaseEntity);

    std::pair<uint8, uint16> gpResult = PGuild->addGuildPoints(PChar, PChar->TradeContainer->getItem(slotID));

    return { gpResult.first, gpResult.second };
}

/************************************************************************
 *  Function: getHP()
 *  Purpose : Returns current Hit Points of an Entity
 *  Example : player:getHP()
 *  Notes   :
 ************************************************************************/

int32 CLuaBaseEntity::getHP()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->health.hp;
}

/************************************************************************
 *  Function: getHPP()
 *  Purpose : Returns current Hit Points Percentage of Entity
 *  Example : player:getHPP()
 *  Notes   : Hit Points / Max Hit Points, rounded up to whole integer
 ************************************************************************/

uint8 CLuaBaseEntity::getHPP()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->GetHPP();
}

/************************************************************************
 *  Function: getMaxHP()
 *  Purpose : Returns the Max Hit Points of an Entity
 *  Example : player:getMaxHP()
 *  Notes   :
 ************************************************************************/

int32 CLuaBaseEntity::getMaxHP()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->GetMaxHP();
}

/************************************************************************
 *  Function: getBaseHP()
 *  Purpose : Returns the Base Hit Points of an Entity
 *  Example : player:getBaseHP()
 *  Notes   :
 ************************************************************************/

int32 CLuaBaseEntity::getBaseHP()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    auto* PEntity = static_cast<CBattleEntity*>(m_PBaseEntity);

    return PEntity->health.maxhp;
}

/************************************************************************
 *  Function: addHP()
 *  Purpose : Adds to the Hit Points of an Entity
 *  Example : player:addHP(500)
 *  Notes   :
 ************************************************************************/

int32 CLuaBaseEntity::addHP(int32 hpAdd)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);

    int32 result = PBattle->addHP(hpAdd);

    // will always remove sleep effect
    PBattle->StatusEffectContainer->DelStatusEffect(EFFECT_SLEEP);
    PBattle->StatusEffectContainer->DelStatusEffect(EFFECT_SLEEP_II);
    PBattle->StatusEffectContainer->DelStatusEffect(EFFECT_LULLABY);

    return result;
}

/************************************************************************
 *  Function: addHPLeaveSleeping()
 *  Purpose : Adds to the Hit Points of an Entity but does not wake it up
 *  Example : player:addHPLeaveSleeping(500)
 *  Notes   :
 ************************************************************************/

int32 CLuaBaseEntity::addHPLeaveSleeping(int32 hpAdd)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);

    return PBattle->addHP(hpAdd);
}

/************************************************************************
 *  Function: setHP()
 *  Purpose : Sets the Hit Points of an Entity
 *  Example : player:setHP(player:getMaxHP())
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setHP(int32 value)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);

    PBattle->health.hp = 0;
    PBattle->addHP(value);
    m_PBaseEntity->updatemask |= UPDATE_HP;

    // When setting the HP to 0 the entity "falls to the ground" so the last attacker needs to be cleared
    if (value == 0)
    {
        PBattle->PLastAttacker = nullptr;
    }
}

/************************************************************************
 *  Function: setMaxHP()
 *  Purpose : Sets the Maximum Hit Points of an Entity
 *  Example : player:setMaxHP(100)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setMaxHP(int32 value)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);

    PBattle->health.maxhp = std::max(1, value);
    PBattle->UpdateHealth();
}

/************************************************************************
 *  Function: restoreHP()
 *  Purpose : Restores the Hit Points of an Entity by a specified amount
 *  Example : player:restoreHP(1000)
 *  Notes   : Returns amount restored if not dead
 ************************************************************************/

int32 CLuaBaseEntity::restoreHP(int32 restoreAmt)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    if (m_PBaseEntity->animation != ANIMATION_DEATH)
    {
        int32 result = static_cast<CBattleEntity*>(m_PBaseEntity)->addHP(restoreAmt);

        return result;
    }

    return 0;
}

/************************************************************************
 *  Function: delHP()
 *  Purpose : Subtracts from the Hit Points of an Entity
 *  Example : player:delHP(500)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::delHP(int32 delAmt)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    static_cast<CBattleEntity*>(m_PBaseEntity)->takeDamage(delAmt);
}

/************************************************************************
 *  Function: takeDamage()
 *  Purpose : Takes damage from the provided attacker. If no attacker is provided then it clears the last attacker.
 *  Example : target:takeDamage(500, attacker=nil, attackType=ATTACK_NONE, damageType=DAMAGE_NONE, flags={wakeUp=true})
 ************************************************************************/

void CLuaBaseEntity::takeDamage(int32 damage, sol::object const& attacker, sol::object const& atkType, sol::object const& dmgType, sol::object const& flags)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    // Attempt to retrieve the attacker
    CBattleEntity* PAttacker = nullptr;
    if (attacker != sol::lua_nil)
    {
        CLuaBaseEntity* PLuaAttacker = attacker.as<CLuaBaseEntity*>();

        if (PLuaAttacker == nullptr || PLuaAttacker->m_PBaseEntity->objtype == TYPE_NPC)
        {
            ShowWarning("CLuaBaseEntity::takeDamage() - PLuaAttacker was null, or was NPC.");
            return;
        }

        PAttacker = dynamic_cast<CBattleEntity*>(PLuaAttacker->m_PBaseEntity);
    }

    CBattleEntity* PDefender = dynamic_cast<CBattleEntity*>(m_PBaseEntity);

    if (!PDefender)
    {
        ShowWarning("CLuaBaseEntity::takeDamage() - Attempt to use non-BattleEntity as PDefender.");
        return;
    }

    // Check for special flags which may prevent damage from waking up the target
    bool wakeUp        = true;
    bool breakBind     = true;
    bool removePetrify = false;

    // TODO: Unused in current code, needs testing; change type to sol::table?
    //       Find a way to make this better! (Optional keys as well?)
    if (flags != sol::lua_nil)
    {
        auto flag_map = flags.as<std::map<std::string, bool>>();

        wakeUp        = flag_map["wakeUp"];
        removePetrify = flag_map["removePetrify"];
        breakBind     = flag_map["breakBind"];
    }

    // Check to see if the target has a nightmare effect active, reset wakeUp accordingly
    // see mobskills/nightmare.lua for full explanation
    if (PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_SLEEP) &&
        PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_SLEEP)->GetTier() > 0)
    {
        // Don't break nightmare sleep from any dmg that doesn't break bind (DoT damage)
        if (breakBind == false)
        {
            wakeUp = false;
        }

        // Diabolos NM/mob ability
        // "Damage will not wake you up from Nightmare, only Cure and Benediction (Benediction will also remove the Bio effect)."
        if (wakeUp == true &&
            PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_SLEEP)->GetTier() > 1)
        {
            wakeUp = false;
        }
    }

    if (PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_PETRIFICATION) &&
        PDefender->StatusEffectContainer->GetStatusEffect(EFFECT_PETRIFICATION)->GetSubPower() == 1)
    {
        removePetrify = true;
    }

    ATTACK_TYPE attackType = (atkType != sol::lua_nil) ? static_cast<ATTACK_TYPE>(atkType.as<uint8>()) : ATTACK_TYPE::NONE;
    DAMAGE_TYPE damageType = (dmgType != sol::lua_nil) ? static_cast<DAMAGE_TYPE>(dmgType.as<uint8>()) : DAMAGE_TYPE::NONE;

    PDefender->takeDamage(damage, PAttacker, attackType, damageType);

    // liberate target when applicable
    if (damage > 0)
    {
        if (wakeUp)
        {
            PDefender->StatusEffectContainer->WakeUp();
        }

        if (removePetrify)
        {
            PDefender->StatusEffectContainer->DelStatusEffect(EFFECT_PETRIFICATION);
        }
    }

    // Bind has a chance to break from all direct attacks, even if they don't deal damage
    if (PAttacker && breakBind)
    {
        battleutils::BindBreakCheck(PAttacker, PDefender);
    }
}

/************************************************************************
 *  Function: hideHP()
 *  Purpose : Toggles the display of the Hit Points bar for a Mob or NPC
 *  Example : mob:hideHP(true)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::hideHP(bool value)
{
    if (m_PBaseEntity->objtype != TYPE_MOB && m_PBaseEntity->objtype != TYPE_NPC)
    {
        ShowWarning("Attempt to hide HP for invalid entity (%s)", m_PBaseEntity->getName());
        return;
    }

    if (m_PBaseEntity->objtype == TYPE_MOB)
    {
        static_cast<CMobEntity*>(m_PBaseEntity)->HideHP(value);
    }
    else if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        static_cast<CNpcEntity*>(m_PBaseEntity)->HideHP(value);
    }
    m_PBaseEntity->updatemask |= UPDATE_HP;
}

int32 CLuaBaseEntity::getDeathType()
{
    return static_cast<CMobEntity*>(m_PBaseEntity)->GetDeathType();
}

void CLuaBaseEntity::setDeathType(int32 value)
{
    ((CMobEntity*)m_PBaseEntity)->SetDeathType(value);
}

/************************************************************************
 *  Function: getMP()
 *  Purpose : Returns the current Mana Points of an entity
 *  Example : player:getMP()
 ************************************************************************/

int32 CLuaBaseEntity::getMP()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->health.mp;
}

/************************************************************************
 *  Function: getMPP()
 *  Purpose : Returns current Mana Points Percentage of Entity
 *  Example : player:getMPP()
 *  Notes   : Mana Points / Max Mana Points, rounded up to whole integer
 ************************************************************************/

uint8 CLuaBaseEntity::getMPP()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->GetMPP();
}

/************************************************************************
 *  Function: getMaxMP()
 *  Purpose : Returns the Max Mana Points of an entity
 *  Example : player:getMaxMP()
 ************************************************************************/

int32 CLuaBaseEntity::getMaxMP()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->GetMaxMP();
}

/************************************************************************
 *  Function: getBaseMP()
 *  Purpose : Returns the Base Mana Points of an entity
 *  Example : player:getBaseMP()
 ************************************************************************/

int32 CLuaBaseEntity::getBaseMP()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    auto* PEntity = static_cast<CBattleEntity*>(m_PBaseEntity);
    return PEntity->health.maxmp;
}

/************************************************************************
 *  Function: addMP()
 *  Purpose : Adds Mana Points to an entity
 *  Example : player:addMP(50)
 ************************************************************************/

int32 CLuaBaseEntity::addMP(int32 amount)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->addMP(amount);
}

/************************************************************************
 *  Function: setMP()
 *  Purpose : Sets the Mana Points of an entity to a specified amount
 *  Example : player:setMP(player:getMaxMP())
 ************************************************************************/

void CLuaBaseEntity::setMP(int32 value)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);

    PBattle->health.mp = 0;
    PBattle->addMP(value);
}

/************************************************************************
 *  Function: setMaxMP()
 *  Purpose : Sets the Maximum Mana Points of an Entity
 *  Example : player:setMaxMP(100)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setMaxMP(int32 value)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);

    PBattle->health.maxmp = std::max(0, value);
    PBattle->UpdateHealth();
}

/************************************************************************
 *  Function: restoreMP()
 *  Purpose : Restores Mana Points to a player
 *  Example : player:restoreMP(player:getMaxHP() - player:getHP())
 *  Notes   : Returns the restored amount if not dead
 ************************************************************************/

int32 CLuaBaseEntity::restoreMP(int32 amount)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    if (m_PBaseEntity->animation != ANIMATION_DEATH)
    {
        return static_cast<CBattleEntity*>(m_PBaseEntity)->addMP(amount);
    }

    return 0;
}

/************************************************************************
 *  Function: delMP()
 *  Purpose : Subtracts Mana Points from an Entity
 *  Example : player:delMP(1000)
 ************************************************************************/

int32 CLuaBaseEntity::delMP(int32 amount)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->addMP(-amount);
}

/************************************************************************
 *  Function: getTP()
 *  Purpose : Returns the current Tactical Points of an Entity
 *  Example : if player:getTP() > 1000 then
 ************************************************************************/

float CLuaBaseEntity::getTP()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);
    return static_cast<float>(PBattle->health.tp);
}

/************************************************************************
 *  Function: addTP()
 *  Purpose : Adds Tactical Points to an Entity
 *  Example : player:addTP(1000) - Icarus Wing
 ************************************************************************/

int16 CLuaBaseEntity::addTP(int16 amount)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->addTP(amount);
}

/************************************************************************
 *  Function: setTP()
 *  Purpose : Sets the Tactical Points of an entity
 *  Example : player:setTP(1000)
 ************************************************************************/

void CLuaBaseEntity::setTP(int16 value)
{
    if (auto* PBattle = dynamic_cast<CBattleEntity*>(m_PBaseEntity))
    {
        PBattle->health.tp = value;
        PBattle->updatemask |= UPDATE_HP;
    }
}

/************************************************************************
 *  Function: delTP()
 *  Purpose : Subtracts Tactical Points from an Entity
 *  Example : player:delTP(50)
 ************************************************************************/

int16 CLuaBaseEntity::delTP(int16 amount)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->addTP(-amount);
}

/************************************************************************
 *  Function: updateHealth()
 *  Purpose : Forces a health update for an Entity
 *  Example : target:updateHealth()
 *  Notes   : Currently only used in Spirit Surge; Health update for
 *  Notes   : Level Sync is handled by CParty::SetSyncTarget
 ************************************************************************/

void CLuaBaseEntity::updateHealth()
{
    if (auto* PBattle = dynamic_cast<CBattleEntity*>(m_PBaseEntity))
    {
        PBattle->UpdateHealth();
    }
    else
    {
        ShowError("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
    }
}

/************************************************************************
 *  Function: getAverageItemLevel()
 *  Purpose : Returns the weighted item level value displayed in stats
 *  Example : target:getAverageItemLevel()
 ************************************************************************/
uint8 CLuaBaseEntity::getAverageItemLevel()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        return 0;
    }

    return charutils::getItemLevelDifference(static_cast<CCharEntity*>(m_PBaseEntity)) + 99;
}

/************************************************************************
 *  Function: capSkill()
 *  Purpose : Caps a particular skill for a PC
 *  Example : player:capSkill(xi.skill.DAGGER)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::capSkill(uint8 skill)
{
    if (skill < MAX_SKILLTYPE)
    {
        auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity);

        if (!PChar)
        {
            ShowWarning("CLuaBaseEntity::capSkill() - m_PBaseEntity is not a player.");
            return;
        }

        // CItemWeapon* PItem = ((CBattleEntity*)m_PBaseEntity)->m_Weapons[SLOT_MAIN];
        /* let's just ignore this part for the moment
        //remove modifiers if valid
        if(skill>=1 && skill<=12 && PItem!=nullptr && PItem->getSkillType()==skill){
            PChar->delModifier(Mod::ATT, PChar->GetSkill(skill));
            PChar->delModifier(Mod::ACC, PChar->GetSkill(skill));
        }
        */
        uint16 maxSkill                   = 10 * battleutils::GetMaxSkill((SKILLTYPE)skill, PChar->GetMJob(), PChar->GetMLevel());
        PChar->RealSkills.skill[skill]    = maxSkill; // set to capped
        PChar->WorkingSkills.skill[skill] = maxSkill / 10;
        PChar->WorkingSkills.skill[skill] |= 0x8000; // set blue capped flag
        PChar->pushPacket<CCharSkillsPacket>(PChar);
        charutils::CheckWeaponSkill(PChar, skill);
        /* and ignore this part
        //reapply modifiers if valid
        if(skill>=1 && skill<=12 && PItem!=nullptr && PItem->getSkillType()==skill){
            PChar->addModifier(Mod::ATT, PChar->GetSkill(skill));
            PChar->addModifier(Mod::ACC, PChar->GetSkill(skill));
        }
        */
        charutils::SaveCharSkills(PChar, skill); // save to db
    }
}

/************************************************************************
 *  Function: capAllSkills()
 *  Purpose : Cap all skills for a PC
 *  Example : player:capAllSkills()
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::capAllSkills()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    for (uint8 i = SKILL_HAND_TO_HAND; i <= SKILL_HANDBELL; ++i) // For SKILL_HAND_TO_HAND (1) - SKILL_HANDBELL (46)
    {
        const char* Query = "INSERT INTO char_skills "
                            "SET "
                            "charid = %u,"
                            "skillid = %u,"
                            "value = %u,"
                            "rank = %u "
                            "ON DUPLICATE KEY UPDATE value = %u, rank = %u";

        _sql->Query(Query, PChar->id, i, 5000, PChar->RealSkills.rank[i], 5000, PChar->RealSkills.rank[i]);

        uint16 maxSkill               = 10 * battleutils::GetMaxSkill(static_cast<SKILLTYPE>(i), PChar->GetMJob(), PChar->GetMLevel());
        PChar->RealSkills.skill[i]    = maxSkill; // set to capped
        PChar->WorkingSkills.skill[i] = maxSkill / 10;
        PChar->WorkingSkills.skill[i] |= 0x8000; // set blue capped flag
    }
    charutils::CheckWeaponSkill(PChar, SKILL_NONE);
    PChar->pushPacket<CCharSkillsPacket>(PChar);
}

/************************************************************************
 *  Function: getSkillLevel()
 *  Purpose : Returns the level for a specified skill of a PC
 *  Example : player:getSkillLevel(xi.skill.ENHANCING_MAGIC)
 *  Notes   :
 ************************************************************************/

uint16 CLuaBaseEntity::getSkillLevel(uint16 skillId)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid entity calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    if (skillId >= MAX_SKILLTYPE)
    {
        ShowWarning("skillId (%d) exceeds MAX_SKILLTYPE.", skillId);
        return 0;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->GetSkill(skillId);
}

/************************************************************************
 *  Function: setSkillLevel()
 *  Purpose : Sets a particular skill for a PC
 *  Example : player:setSkillLevel(xi.skill.ENHANCING_MAGIC, 200)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setSkillLevel(uint8 SkillID, uint16 SkillAmount)
{
    if (m_PBaseEntity->objtype != TYPE_PC || SkillID >= MAX_SKILLTYPE)
    {
        ShowWarning("CLuaBaseEntity::setSkillLevel() - Non-PC or Invalid SkillID passed to function.");
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->RealSkills.skill[SkillID]    = SkillAmount;
    PChar->WorkingSkills.skill[SkillID] = (SkillAmount / 10) * 0x20 + PChar->WorkingSkills.rank[SkillID];

    jobpointutils::RefreshGiftMods(PChar);
    charutils::BuildingCharSkillsTable(PChar);
    charutils::CheckWeaponSkill(PChar, SkillID);
    charutils::SaveCharSkills(PChar, SkillID);

    PChar->pushPacket<CCharSkillsPacket>(PChar);
}

/************************************************************************
 *  Function: getMaxSkillLevel()
 *  Purpose : Returns the Max Skill Level for a PC's current main job
 *  Example : master:getMaxSkillLevel(avatar:getMainLvl(), xi.job.SMN, xi.skill.SUMMONING_MAGIC)
 *  Notes   : Used in Meteor, summons, and some Mob TP moves
 ************************************************************************/

uint16 CLuaBaseEntity::getMaxSkillLevel(uint8 level, uint8 jobId, uint8 skillId)
{
    auto skill = static_cast<SKILLTYPE>(skillId);
    auto job   = static_cast<JOBTYPE>(jobId);

    return battleutils::GetMaxSkill(skill, job, level);
}

/************************************************************************
 *  Function: getSkillRank()
 *  Purpose : Returns the Real Rank for a particular skill
 *  Example : player:getSkillRank(craftID)
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getSkillRank(uint8 rankID)
{
    auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity);
    if (PChar)
    {
        return PChar->RealSkills.rank[rankID];
    }
    return 0;
}

/************************************************************************
 *  Function: setSkillRank()
 *  Purpose : Sets a Skill Rank for a particular skill
 *  Example : player:setSkillRank(xi.skill.DIG, 20)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setSkillRank(uint8 skillID, uint8 newrank)
{
    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        PChar->WorkingSkills.rank[skillID]  = newrank;
        PChar->WorkingSkills.skill[skillID] = (PChar->RealSkills.skill[skillID] / 10) * 0x20 + newrank;
        PChar->RealSkills.rank[skillID]     = newrank;

        jobpointutils::RefreshGiftMods(PChar);
        charutils::BuildingCharSkillsTable(PChar);
        charutils::SaveCharSkills(PChar, skillID);
        PChar->pushPacket<CCharSkillsPacket>(PChar);
    }
}

/************************************************************************
 *  Function: getCharSkillLevel()
 *  Purpose : Returns the level for a particular skill
 *  Example : player:getCharSkillLevel(xi.skill.DIG)
 *  Notes   : Only used for Chocobo Digging currently
 ************************************************************************/

uint16 CLuaBaseEntity::getCharSkillLevel(uint8 skillID)
{
    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

        return PChar->RealSkills.skill[skillID];
    }

    return 0;
}

/************************************************************************
 *  Function: addLearnedWeaponskill()
 *  Purpose : Manually add a new weaponskill for the player using WSID
 *  Example : player:addLearnedWeaponskill(xi.wsUnlock.DECIMATION)
 *  Notes   : Do not see implemented in any script
 ************************************************************************/

void CLuaBaseEntity::addLearnedWeaponskill(uint8 wsUnlockId)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    charutils::addLearnedWeaponskill(PChar, wsUnlockId);
    charutils::BuildingCharWeaponSkills(PChar);
    charutils::SaveLearnedAbilities(PChar);
    PChar->pushPacket<CCharAbilitiesPacket>(PChar);
}

/************************************************************************
 *  Function: hasLearnedWeaponskill()
 *  Purpose : Returns true if a player has learned a particular weaponskill
 *  Example : if player:hasLearnedWeaponskill(xi.wsUnlock.DECIMATION) then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::hasLearnedWeaponskill(uint8 wsUnlockId)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    return (charutils::hasLearnedWeaponskill(static_cast<CCharEntity*>(m_PBaseEntity), wsUnlockId) != 0);
}

/************************************************************************
 *  Function: delLearnedWeaponskill()
 *  Purpose : Removes a learned weaponskill from the player
 *  Example : player:delLearnedWeaponskill(xi.wsUnlock.ASURAN_FISTS)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::delLearnedWeaponskill(uint8 wsUnlockId)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    charutils::delLearnedWeaponskill(PChar, wsUnlockId);
    charutils::BuildingCharWeaponSkills(PChar);
    charutils::SaveLearnedAbilities(PChar);
    PChar->pushPacket<CCharAbilitiesPacket>(PChar);
}

/************************************************************************
 *  Function: trySkillUp()
 *  Purpose : Attempts to increase skill for <skill> based on compared mob <level>
 *  Example : player:trySkillUp(xi.skill.HAND_TO_HAND, 50)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::trySkillUp(uint8 skill, uint8 level, sol::object const& forceSkillUpObj, sol::object const& useSubSkillObj)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        // Do not attempt to skillup for non-PCs
        return;
    }

    bool forceSkillUp = (forceSkillUpObj != sol::lua_nil) ? forceSkillUpObj.as<bool>() : false;
    bool useSubSkill  = (useSubSkillObj != sol::lua_nil) ? forceSkillUpObj.as<bool>() : false;

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    charutils::TrySkillUP(PChar, static_cast<SKILLTYPE>(skill), level, forceSkillUp, useSubSkill);
}

/************************************************************************
 *  Function: addWeaponSkillPoints()
 *  Purpose : Removes a learned weaponskill from the player
 *  Example : player:addWeaponSkillPoints(xi.slot.MAIN, 300)
 *  Notes   : Returns true if points were successfully added.
 ************************************************************************/

bool CLuaBaseEntity::addWeaponSkillPoints(uint8 slotID, uint16 points)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    auto  slot  = static_cast<SLOTTYPE>(slotID);

    return charutils::AddWeaponSkillPoints(PChar, slot, points);
}

/************************************************************************
 *  Function: addLearnedAbility()
 *  Purpose : Adds a new learned ability to the player
 *  Example : target:addLearnedAbility(89) -- Chaos Roll
 *  Notes   : Used exclusively for Corsair Die usage
 ************************************************************************/

void CLuaBaseEntity::addLearnedAbility(uint16 abilityID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (charutils::addLearnedAbility(PChar, abilityID))
    {
        charutils::addAbility(PChar, abilityID);
        charutils::SaveLearnedAbilities(PChar);
        PChar->pushPacket<CCharAbilitiesPacket>(PChar);
        PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, 442);
    }
}

/************************************************************************
 *  Function: hasLearnedAbility()
 *  Purpose : Returns true if player has a particular learned ability
 *  Example : target:hasLearnedAbility(84) -- Healer's Roll
 *  Notes   : Although canLearnAbility is similar, they have distinct diff
 ************************************************************************/

bool CLuaBaseEntity::hasLearnedAbility(uint16 abilityID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    return charutils::hasLearnedAbility(static_cast<CCharEntity*>(m_PBaseEntity), abilityID) != 0;
}

/************************************************************************
 *  Function: canLearnAbility()
 *  Purpose : Returns true if player can learn the ability
 *  Example : if player:canLearnAbility(89) then -- Chaos Roll
 *  Notes   : Purpose doesn't match function, returns uint32 Message,
 *          : not bool type, according to header, 0 is can learn
 ************************************************************************/

uint32 CLuaBaseEntity::canLearnAbility(uint16 abilityID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    uint32 Message = 0;

    if (charutils::hasLearnedAbility(static_cast<CCharEntity*>(m_PBaseEntity), abilityID))
    {
        Message = 444;
    }
    else if (!ability::CanLearnAbility(static_cast<CCharEntity*>(m_PBaseEntity), abilityID))
    {
        Message = 443;
    }

    return Message;
}

/************************************************************************
 *  Function: delLearnedAbility()
 *  Purpose : Removes a learned ability from the player
 *  Example : player:delLearnedAbility(89) -- Chaos Roll
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::delLearnedAbility(uint16 abilityID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (charutils::delLearnedAbility(PChar, abilityID))
    {
        charutils::SaveLearnedAbilities(PChar);
        PChar->pushPacket<CCharAbilitiesPacket>(PChar);
    }
}

/************************************************************************
 *  Function: addSpell()
 *  Purpose : Adds a specified spell to the player
 *  Example : player:addSpell(128)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::addSpell(uint16 spellID, sol::variadic_args va)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    bool silentLog  = va[0].is<bool>() ? va[0].as<bool>() : false;
    bool save       = va[1].is<bool>() ? va[1].as<bool>() : true;
    bool sendUpdate = va[2].is<bool>() ? va[2].as<bool>() : true;

    if (charutils::addSpell(PChar, spellID))
    {
        if (sendUpdate)
        {
            PChar->pushPacket<CCharSpellsPacket>(PChar);
        }

        if (!silentLog)
        {
            PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, 23);
        }

        if (save)
        {
            charutils::SaveSpell(PChar, spellID);
        }
    }
}

/************************************************************************
 *  Function: hasSpell()
 *  Purpose : Returns true if a player has learned a particular spell
 *  Example : if player:hasSpell(125) then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::hasSpell(uint16 spellID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    return charutils::hasSpell(static_cast<CCharEntity*>(m_PBaseEntity), spellID) != 0;
}

/************************************************************************
 *  Function: canLearnSpell()
 *  Purpose : Returns true if a player can learn a particular spell
 *  Example : if player:canLearnSpell(528) then
 *  Notes   : Just like learned ability, message or 0 (for can learn), not bool
 ************************************************************************/

uint32 CLuaBaseEntity::canLearnSpell(uint16 spellID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto*  PChar   = static_cast<CCharEntity*>(m_PBaseEntity);
    uint32 Message = 0;

    if (charutils::hasSpell(PChar, spellID))
    {
        Message = 96;
    }
    else if (!spell::CanUseSpell(PChar, static_cast<SpellID>(spellID)))
    {
        Message = 95;
    }

    return Message;
}

/************************************************************************
 *  Function: delSpell()
 *  Purpose : Deletes a learned spell from a player
 *  Example : player:delSpell(528)
 ************************************************************************/

void CLuaBaseEntity::delSpell(uint16 spellID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (charutils::delSpell(PChar, spellID))
    {
        charutils::DeleteSpell(PChar, spellID);
        PChar->pushPacket<CCharSpellsPacket>(PChar);
    }
}

/************************************************************************
 *  Function: recalculateSkillsTable()
 *  Purpose : Recalculates skill tables to get new values and calculations
 *  Example : target:recalculateSkillsTable()
 *  Notes   : Used exclusively for Scholar abilities
 ************************************************************************/

void CLuaBaseEntity::recalculateSkillsTable()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    charutils::BuildingCharSkillsTable(PChar);
    charutils::BuildingCharWeaponSkills(PChar);

    PChar->pushPacket<CCharSkillsPacket>(PChar);
    PChar->pushPacket<CCharRecastPacket>(PChar);
    PChar->pushPacket<CCharAbilitiesPacket>(PChar);
}

/************************************************************************
 *  Function: recalculateAbilitiesTable()
 *  Purpose : Recalculates ability tables to get new values and calculations
 *  Example : target:recalculateAbilitiesTable()
 *  Notes   : Used exlusively for Scholar abilities and Astral Flow
 ************************************************************************/

void CLuaBaseEntity::recalculateAbilitiesTable()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    charutils::BuildingCharAbilityTable(PChar);
    charutils::BuildingCharTraitsTable(PChar);
    charutils::BuildingCharWeaponSkills(PChar);

    if (PChar->PPet != nullptr && PChar->PPet->objtype == TYPE_PET)
    {
        auto* PPetEntity = static_cast<CPetEntity*>(PChar->PPet);

        charutils::BuildingCharPetAbilityTable(PChar, PPetEntity, PPetEntity->m_PetID);
    }

    PChar->pushPacket<CCharAbilitiesPacket>(PChar);
}

/************************************************************************
 *  Function: getEntitiesInRange()
 *  Purpose : Returns a Lua table of entities within range of the base entity
 *  Example : local players = npc:getEntitiesInRange(target, aoeType, radiusOrigin, distance, findFlags, validTargets)
 *
 *  WARNING : APART FROM THIS ONE EXCEPTION, ALL TARGET AND PATH FINDING SHOULD BE DONE EXCLUSIVELY IN CORE
 *
 *  Notes   : This is primarily made for Dark Ixion's trample, but there may be valid uses for other mob sequences
 *               IN GENERAL, this function should not be used in persistent on-tick logic
 *            if the passed distance is nil or 0 (as well as many other combinations), empty table will be returned
 *            examples
 *      mob:getEntitiesInRange(nearbyPlayer, xi.aoeType.ROUND, xi.aoeRadius.ATTACKER, trampleRange, xi.findFlag.HIT_ALL, xi.targetType.PLAYER + xi.targetType.PLAYER_PARTY)
 *              The parameters should all be enums from xi.aoeType, xi.aoeRadius, xi.findFlag, and xi.targetType
 ************************************************************************/

auto CLuaBaseEntity::getEntitiesInRange(CLuaBaseEntity* PLuaEntityTarget, sol::variadic_args va) -> sol::table
{
    auto* baseEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    auto  entities   = lua.create_table();
    if (!baseEntity || !baseEntity->PAI || !baseEntity->PAI->TargetFind)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return entities;
    }

    auto* PTarget = dynamic_cast<CBattleEntity*>(PLuaEntityTarget->GetBaseEntity());
    if (!PTarget)
    {
        ShowWarning("Invalid target entity in function (%s).", m_PBaseEntity->getName());
        return entities;
    }

    // Reset targetfind
    baseEntity->PAI->TargetFind->reset();

    // Standard targetfind call: AOE_RADIUS::TARGET, distance, flags, PSpell->getValidTarget()
    auto distance = va[2].is<float>() ? va[2].as<float>() : 0;
    if (distance < 0)
    {
        ShowWarning("Invalid distance in function call (%s).", m_PBaseEntity->getName());
        return entities;
    }

    auto findFlags    = va[3].is<uint8>() ? va[3].as<uint8>() : 0;
    auto validTargets = va[4].is<uint16>() ? va[4].as<uint16>() : 0;

    // Mob buff abilities also hit monster's pets
    if (validTargets & TARGET_SELF)
    {
        findFlags |= FINDFLAGS_PET;
    }

    if ((validTargets & TARGET_IGNORE_BATTLEID) == TARGET_IGNORE_BATTLEID)
    {
        findFlags |= FINDFLAGS_IGNORE_BATTLEID;
    }

    auto aoeType      = va[0].is<uint16>() ? va[0].as<uint16>() : 0;
    auto radiusOrigin = static_cast<AOE_RADIUS>(va[1].is<uint8>() ? va[1].as<uint8>() : 0);
    // Targetfind always adds the primary target, ensure that is valid
    if (radiusOrigin == AOE_RADIUS::TARGET || baseEntity->PAI->TargetFind->isWithinRange(&PTarget->loc.p, distance))
    {
        if (aoeType == AOE_TYPE::ROUND)
        {
            baseEntity->PAI->TargetFind->findWithinArea(PTarget, radiusOrigin, distance, findFlags, validTargets);
        }
        else if (aoeType == AOE_TYPE::ROUND || aoeType == AOE_TYPE::CONE)
        {
            float angle = 45.0f;
            baseEntity->PAI->TargetFind->findWithinCone(PTarget, distance, angle, findFlags, validTargets, aoeType);
        }
        else
        {
            if (baseEntity->objtype == TYPE_MOB && PTarget->objtype == TYPE_PC)
            {
                CBattleEntity* PCoverAbilityUser = battleutils::GetCoverAbilityUser(PTarget, baseEntity);
                if (PCoverAbilityUser != nullptr)
                {
                    PTarget = PCoverAbilityUser;
                }
            }

            baseEntity->PAI->TargetFind->findSingleTarget(PTarget, findFlags, validTargets);
        }
    }

    for (auto&& PTargetFound : baseEntity->PAI->TargetFind->m_targets)
    {
        entities.add(CLuaBaseEntity(PTargetFound));
    }

    return entities;
}

/************************************************************************
 *  Function: getParty()
 *  Purpose : Returns a Lua table of party member Entity objects
 *  Example : local party = player:getParty()
 *  Notes   :
 ************************************************************************/

sol::table CLuaBaseEntity::getParty()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return sol::lua_nil;
    }

    // clang-format off
    auto table = lua.create_table();
    ((CBattleEntity*)m_PBaseEntity)->ForParty([&table](CBattleEntity* member)
    {
        table.add(CLuaBaseEntity(member));
    });
    // clang-format on

    return table;
}

/************************************************************************
 *  Function: getPartyWithTrusts()
 *  Purpose : Returns a Lua table of party member and trust Entity objects
 *  Example : local party = player:getPartyWithTrusts()
 *  Notes   : Removed index id, this might break things (idx started at 1)
 ************************************************************************/

sol::table CLuaBaseEntity::getPartyWithTrusts()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return sol::lua_nil;
    }

    // clang-format off
    auto table = lua.create_table();
    ((CCharEntity*)m_PBaseEntity)->ForPartyWithTrusts([&table](CBattleEntity* member)
    {
        table.add(CLuaBaseEntity(member));
    });
    // clang-format on

    return table;
}

/************************************************************************
 *  Function: getPartySize()
 *  Purpose : Returns the count of members in the party
 *  Example : local count = player:getPartySize()
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getPartySize(sol::object const& arg0)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    uint8 allianceparty = (arg0 == sol::lua_nil) ? 0 : arg0.as<uint8>();
    uint8 partysize     = 1;

    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);

    if (PBattle->PParty != nullptr)
    {
        if (allianceparty == 0)
        {
            partysize = static_cast<uint8>(PBattle->PParty->members.size());
        }
        else if (PBattle->PParty->m_PAlliance != nullptr)
        {
            partysize = static_cast<uint8>(PBattle->PParty->m_PAlliance->partyList.at(allianceparty)->members.size());
        }
    }

    return partysize;
}

/************************************************************************
 *  Function: hasPartyJob()
 *  Purpose : Loops over party members and returns true if job is found
 *  Example : if caster:hasPartyJob(xi.job.DRK) then
 *  Notes   : Highly useful for future addition of features
 ************************************************************************/

bool CLuaBaseEntity::hasPartyJob(uint8 job)
{
    if (static_cast<CCharEntity*>(m_PBaseEntity)->PParty != nullptr)
    {
        for (auto const& member : static_cast<CCharEntity*>(m_PBaseEntity)->PParty->members)
        {
            CCharEntity* PTarget = static_cast<CCharEntity*>(member);

            if (PTarget->GetMJob() == job)
            {
                return true;
            }

            for (auto* PTrust : PTarget->PTrusts)
            {
                if (PTrust->GetMJob() == job)
                {
                    return true;
                }
            }
        }
    }

    return false;
}

/************************************************************************
 *  Function: getPartyMember()
 *  Purpose : Returns the object Entity of a Party Member from another Party/Alliance
 *  Example : player:getPartyMember(4?)
 *  Notes   : Passed value is position in party? What is this used for?
 ************************************************************************/

std::optional<CLuaBaseEntity> CLuaBaseEntity::getPartyMember(uint8 member, uint8 allianceparty)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("CLuaBaseEntity::getPartyMember() - NPC calling function.");
        return std::nullopt;
    }

    CBattleEntity* PBattle     = static_cast<CBattleEntity*>(m_PBaseEntity);
    CBattleEntity* PTargetChar = nullptr;

    if (allianceparty == 0 && member == 0)
    {
        PTargetChar = PBattle;
    }
    else if (PBattle->PParty != nullptr)
    {
        if (allianceparty == 0 && member < PBattle->PParty->members.size())
        {
            PTargetChar = PBattle->PParty->members[member];
        }
        else if (PBattle->PParty->m_PAlliance != nullptr &&
                 member <= PBattle->PParty->m_PAlliance->partyList.at(allianceparty)->members.size())
        {
            PTargetChar = PBattle->PParty->m_PAlliance->partyList.at(allianceparty)->members[member];
        }
    }

    if (PTargetChar != nullptr)
    {
        return std::optional<CLuaBaseEntity>(PTargetChar);
    }

    ShowError("Lua::getPartyMember :: Member or Alliance Number is not valid.");
    return std::nullopt;
}

/************************************************************************
 *  Function: getPartyLeader()
 *  Purpose : Returns the entity object of the party leader
 *  Example : local leader = player:getPartyLeader()
 *  Notes   : Todo: also add ability for find Alliance Leader via lua?
 ************************************************************************/

std::optional<CLuaBaseEntity> CLuaBaseEntity::getPartyLeader()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("CLuaBaseEntity::getPartyLeader() - Non-PC called function.");
        return std::nullopt;
    }

    CCharEntity* PChar = (CCharEntity*)m_PBaseEntity;
    if (PChar->PParty)
    {
        CBattleEntity* PLeader = PChar->PParty->GetLeader();
        if (PLeader != nullptr)
        {
            return std::optional<CLuaBaseEntity>(PLeader);
        }
    }

    return std::nullopt;
}

/************************************************************************
 *  Function: forMembersInRange()
 *  Purpose : Apply function to party members within range
 *  Example : target:forMembersInRange(distance, function() end)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::forMembersInRange(float range, sol::function function)
{
    auto* target = (CBattleEntity*)m_PBaseEntity;

    // clang-format off
    target->ForParty([&target, &range, &function](CBattleEntity* member)
    {
        if (target->loc.zone == member->loc.zone && isWithinDistance(target->loc.p, member->loc.p, range))
        {
            function(CLuaBaseEntity(member));
        }
    });
    // clang-format on
}

/************************************************************************
 *  Function: addPartyEffect()
 *  Purpose : Adds effect to members of the entire party
 *  Example : player:addPartyEffect(effect, 1, 2, 3, ...)?
 *  Notes   : Must have at least three members, scales to six max
 ************************************************************************/

void CLuaBaseEntity::addPartyEffect(sol::variadic_args va)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("CLuaBaseEntity::addPartyEffect() - Non-PC called function.");
        return;
    }

    std::vector<uint16> args(7, 0);

    uint8 idx = 0;
    for (auto const& v : va)
    {
        args[idx++] = v.get<uint16>();
    }

    CStatusEffect* PEffect =
        new CStatusEffect(static_cast<EFFECT>(args[0]), args[1], args[2], args[3], args[4], args[5], args[6]);

    CBattleEntity* PEntity = ((CBattleEntity*)m_PBaseEntity);

    // clang-format off
    PEntity->ForParty([PEffect](CBattleEntity* PMember)
    {
        PMember->StatusEffectContainer->AddStatusEffect(PEffect);
    });
    // clang-format on
}

/************************************************************************
 *  Function: hasPartyEffect()
 *  Purpose : Returns true if all members of party have a specified effect
 *  Example : if player:hasPartyEffect(effect) then
 *  Notes   : Currently not used in any script
 ************************************************************************/

bool CLuaBaseEntity::hasPartyEffect(uint16 effectid)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("CLuaBaseEntity::hasPartyEffect() - Non-PC called function.");
        return false;
    }

    CCharEntity* PChar = ((CCharEntity*)m_PBaseEntity);

    if (PChar->PParty != nullptr)
    {
        for (const auto& member : PChar->PParty->members)
        {
            if (member->loc.zone == PChar->loc.zone)
            {
                // Bail out if someone DOESN'T have the desired effect
                if (!member->StatusEffectContainer->HasStatusEffect(static_cast<EFFECT>(effectid)))
                {
                    return false;
                }
            }
        }
    }
    return true;
}

/************************************************************************
 *  Function: removePartyEffect()
 *  Purpose : Deletes specified effect from all party members
 *  Example : player:removePartyEffect(effect)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::removePartyEffect(uint16 effectid)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("CLuaBaseEntity::removePartyEffect() - Non-PC called function.");
        return;
    }

    CCharEntity* PChar = ((CCharEntity*)m_PBaseEntity);

    for (const auto& member : PChar->PParty->members)
    {
        if (member->loc.zone == PChar->loc.zone)
        {
            member->StatusEffectContainer->DelStatusEffect(static_cast<EFFECT>(effectid));
        }
    }
}

/************************************************************************
 *  Function: getAlliance()
 *  Purpose : Returns a Lua table of all members of the alliance
 *  Example : local alliance = player:getAlliance()
 *  Notes   :
 ************************************************************************/

sol::table CLuaBaseEntity::getAlliance()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("CLuaBaseEntity::getAlliance() - NPC passed to function.");
        return lua.create_table();
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    auto table = lua.create_table();

    // clang-format off
    PChar->ForAlliance([&table](CBattleEntity* PMember)
    {
        table.add(CLuaBaseEntity(PMember));
    });
    // clang-format on

    return table;
}

/************************************************************************
 *  Function: getAllianceSize()
 *  Purpose : Returns the number of members in the alliance
 *  Example : local count = player:getAllianceSize()
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getAllianceSize()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("CLuaBaseEntity::getAllianceSize() - NPC passed to function.");
        return 1;
    }

    auto* PBattle      = static_cast<CBattleEntity*>(m_PBaseEntity);
    uint8 alliancesize = 1;

    if (PBattle->PParty != nullptr)
    {
        if (PBattle->PParty->m_PAlliance != nullptr)
        {
            // Reset to use as counter..
            alliancesize = 0;
            for (const CParty* PParty : PBattle->PParty->m_PAlliance->partyList)
            {
                alliancesize += static_cast<uint8>(PParty->members.size());
            }
        }
        else
        {
            return static_cast<uint8>(PBattle->PParty->members.size());
        }
    }

    return alliancesize;
}

/************************************************************************
 *  Function: getLeaderID()
 *  Purpose : Returns the fallback id of the Alliance/Party or player
 *  Example : local leaderid = player:getLeaderID()
 *  Notes   : if the player is in an alliance, returns alliance ID
 *  Notes   : if the player is in a party and no alliance, returns party ID
 *  Notes   : if the player is not in a party, returns player ID
 ************************************************************************/

uint32 CLuaBaseEntity::getLeaderID()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    if (const CCharEntity* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        if (PChar->PParty != nullptr)
        {
            if (PChar->PParty->m_PAlliance != nullptr)
            {
                return PChar->PParty->m_PAlliance->m_AllianceID;
            }

            return PChar->PParty->GetPartyID();
        }

        return PChar->id;
    }

    return 0;
}

/************************************************************************
 *  Function: getPartyLastMemberJoinedTime()
 *  Purpose : Get the epoch time point in seconds that the last PC joined the party (if any)
 *  Example : seconds_since_last_member_joined = os.time() - player:getPartyLastMemberJoinedTime()
 *  Notes   :
 ************************************************************************/

uint32 CLuaBaseEntity::getPartyLastMemberJoinedTime()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (PChar->PParty != nullptr)
    {
        return PChar->PParty->GetTimeLastMemberJoined();
    }

    return 0;
}

/************************************************************************
 *  Function: reloadParty()
 *  Purpose : Display a new party in the event of alliance form/disband
 *  Example : Creates/Destroys the other parties being displayed
 *  Notes   : Only a function of the core at the moment - future plans?
 ************************************************************************/

void CLuaBaseEntity::reloadParty()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    static_cast<CCharEntity*>(m_PBaseEntity)->ReloadPartyInc();
}

/************************************************************************
 *  Function: disableLevelSync()
 *  Purpose : Disables...wait for it...Level Sync
 *  Example : target:disableLevelSync()
 *  Notes   : Only used in scripts/effects/level_sync.lua
 ************************************************************************/

void CLuaBaseEntity::disableLevelSync()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (PChar->PParty)
    {
        if (PChar->PParty->GetSyncTarget() == PChar)
        {
            PChar->PParty->SetSyncTarget("", MsgStd::LevelSyncRemoveLeftParty);
        }
        else
        {
            PChar->PParty->DisableSync();
        }
    }

    PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, std::make_unique<CCharSyncPacket>(PChar));
}

/************************************************************************
 *  Function: isLevelSync()
 *  Purpose :
 *  Example : player:isLevelSync()
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isLevelSync()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (PChar->PParty)
    {
        return PChar->PParty->GetSyncTarget() && PChar->PParty->GetSyncTarget() != PChar;
    }

    return false;
}

/************************************************************************
 *  Function: checkSoloPartyAlliance()
 *  Purpose : Checks if Entity is solo, in a party, or in an alliance
 *  Example : local popularityCheck = player:checkSoloPartyAlliance()
 *  Notes   : Returns 0 (Solo), 1 (Party), or 2 (Alliance)
 ************************************************************************/

uint8 CLuaBaseEntity::checkSoloPartyAlliance()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    uint8 SoloPartyAlliance = 0;

    if (PChar->PParty != nullptr)
    {
        SoloPartyAlliance = 1;
        if (PChar->PParty->m_PAlliance != nullptr)
        {
            SoloPartyAlliance = 2;
        }
    }

    return SoloPartyAlliance;
}

/************************************************************************
 *  Function: checkKillCredit()
 *  Purpose : Used to determine if kill counts towards regimes/etc.
 *  Example : if player:checkKillCredit(mob) then
 *          : optionally specify lv diff and distance e.g.
 *          : player:checkKillCredit(mob, 15, 100)
 *  Notes   : Returns true if player is in range of sync target upon kill
 *  Notes   : and the mob is able to give exp to the members
 ************************************************************************/

bool CLuaBaseEntity::checkKillCredit(CLuaBaseEntity* PLuaBaseEntity, sol::object const& minRange)
{
    if (m_PBaseEntity->objtype != TYPE_PC || (PLuaBaseEntity && PLuaBaseEntity->GetBaseEntity()->objtype != TYPE_MOB))
    {
        ShowWarning("CLuaBaseEntity::checkKillCredit() - Non-PC type calling function, or PLuaBaseEntity is not a MOB.");
        return false;
    }

    CCharEntity* PChar  = static_cast<CCharEntity*>(m_PBaseEntity);
    CMobEntity*  PMob   = static_cast<CMobEntity*>(PLuaBaseEntity->GetBaseEntity());
    float        range  = minRange.is<float>() ? minRange.as<float>() : 100;
    bool         credit = false;

    if (charutils::CheckMob(PMob->m_HiPCLvl, PMob->GetMLevel()) > EMobDifficulty::TooWeak && distance(PMob->loc.p, PChar->loc.p) < range && !PMob->GetCallForHelpFlag())
    {
        if (PChar->PParty && PChar->PParty->GetSyncTarget())
        {
            if (distance(PMob->loc.p, PChar->PParty->GetSyncTarget()->loc.p) < range && PChar->PParty->GetSyncTarget()->health.hp)
            {
                credit = true;
            }
        }
        else
        {
            credit = true;
        }
    }

    return credit;
}

/************************************************************************
 *  Function: checkDifficulty()
 *  Purpose : Checks the mobs difficulty
 *  Example : local difficulty = player:checkDifficulty(mob)
 *  Notes   : Returns a value based on the enum EMobDifficulty
 ************************************************************************/
uint8 CLuaBaseEntity::checkDifficulty(CLuaBaseEntity* PLuaBaseEntity)
{
    CMobEntity*  PMob  = dynamic_cast<CMobEntity*>(PLuaBaseEntity->GetBaseEntity());
    CCharEntity* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity);

    if (PChar && PMob)
    {
        return (uint8)charutils::CheckMob((PChar->GetMLevel()), (PMob->GetMLevel()));
    }

    ShowError("Value is not valid");
    return 0;
}

/************************************************************************
 *  Function: getInstance()
 *  Purpose : Get the instance object that the Entity is part of
 *  Example : local instance = door:getInstance()
 *  Notes   :
 ************************************************************************/

std::optional<CLuaInstance> CLuaBaseEntity::getInstance()
{
    if (m_PBaseEntity->PInstance)
    {
        return std::optional<CLuaInstance>(m_PBaseEntity->PInstance);
    }

    return std::nullopt;
}

/************************************************************************
 *  Function: setInstance()
 *  Purpose : Registers a character for an established instance
 *  Example : player:setInstance()
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setInstance(CLuaInstance* PLuaInstance)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    CInstance*   PInstance   = PLuaInstance->GetInstance();
    CCharEntity* PChar       = dynamic_cast<CCharEntity*>(m_PBaseEntity);
    m_PBaseEntity->PInstance = PInstance;

    if (PInstance && PChar)
    {
        PInstance->RegisterChar(PChar);
    }
}

/************************************************************************
 *  Function: createInstance()
 *  Purpose : Creates a new instance for a PC
 *  Example : player:createInstance(player:getCurrentAssault())
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::createInstance(uint16 instanceID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    if (!instanceutils::IsValidInstanceID(instanceID))
    {
        ShowError("CLuaBaseEntity::createInstance: Invalid instanceID: %d", instanceID);
        return;
    }

    instanceutils::LoadInstance(instanceID, static_cast<CCharEntity*>(m_PBaseEntity));
}

/************************************************************************
 *  Function: instanceEntry()
 *  Purpose : Creates an instance entry packet for the player
 *  Example : player:instanceEntry(target,1)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::instanceEntry(CLuaBaseEntity* PLuaBaseEntity, uint32 response)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    CBaseEntity* PTarget = PLuaBaseEntity->m_PBaseEntity;

    static_cast<CCharEntity*>(m_PBaseEntity)->pushPacket<CInstanceEntryPacket>(PTarget, response);
}

/************************************************************************
 *  Function: getConfrontationEffect()
 *  Purpose : None yet
 *  Example :
 *  Notes   : Not moved to scripts
 ************************************************************************/

uint16 CLuaBaseEntity::getConfrontationEffect()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->StatusEffectContainer->GetConfrontationEffect();
}

/************************************************************************
 *  Function: copyConfrontationEffect()
 *  Purpose : None yet
 *  Example :
 *  Notes   : Not moved to scripts
 ************************************************************************/

uint16 CLuaBaseEntity::copyConfrontationEffect(uint16 targetID)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    auto*  PEntity = static_cast<CBattleEntity*>(m_PBaseEntity->GetEntity(targetID, TYPE_PC | TYPE_MOB));
    uint16 power   = 0;

    if (PEntity && PEntity->StatusEffectContainer->GetConfrontationEffect())
    {
        static_cast<CBattleEntity*>(m_PBaseEntity)->StatusEffectContainer->CopyConfrontationEffect(PEntity);
        power = PEntity->StatusEffectContainer->GetConfrontationEffect();
    }

    return power;
}

/************************************************************************
 *  Function: getBattlefield()
 *  Purpose : Returns a Battlefield Instance Object to the entity
 *  Example : local battlefield = player:getBattlefield()
 *  Notes   : Used to check if entity is inside a battlefield
 ************************************************************************/

std::optional<CLuaBattlefield> CLuaBaseEntity::getBattlefield()
{
    auto* PBattlefield = m_PBaseEntity->PBattlefield;

    if (PBattlefield)
    {
        return std::optional<CLuaBattlefield>(PBattlefield);
    }

    return std::nullopt;
}

/************************************************************************
 *  Function: getBattlefieldID()
 *  Purpose : Returns the integer ID for the battlefield, -1 if not found
 *  Example : local battlefieldId = player:getBattlefieldID()
 *  Notes   :
 ************************************************************************/

int32 CLuaBaseEntity::getBattlefieldID()
{
    return m_PBaseEntity->PBattlefield ? m_PBaseEntity->PBattlefield->GetID() : -1;
}

/************************************************************************
 *  Function: registerBattlefield()
 *  Purpose : Attempts to register an existing battlefield or create a new one.
 *  Example : local returnCode = player:registerBattlefield(id, area, initiatorId)
 *  Notes   : Returns BATTLEFIELD_RETURNCODE (see scripts/globals/battlefield.lua or src/map/battlefield.h)
 ************************************************************************/

uint8 CLuaBaseEntity::registerBattlefield(sol::object const& arg0, sol::object const& arg1, sol::object const& arg2, sol::object const& arg3)
{
    if (m_PBaseEntity->loc.zone->m_BattlefieldHandler == nullptr)
    {
        ShowWarning("m_BattlefieldHandler was null for %s.", m_PBaseEntity->getName());
        return BATTLEFIELD_RETURN_CODE_BATTLEFIELD_FULL;
    }

    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return BATTLEFIELD_RETURN_CODE_BATTLEFIELD_FULL;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    auto* PZone = PChar->loc.zone == nullptr ? zoneutils::GetZone(PChar->loc.destination) : PChar->loc.zone;

    if (PZone == nullptr)
    {
        ShowWarning("PZone was null for ZoneID %d.", PChar->loc.destination);
        return BATTLEFIELD_RETURN_CODE_BATTLEFIELD_FULL;
    }

    // TODO: Verify what happens if -1 makes it to the cast below
    if (arg0 == sol::lua_nil)
    {
        ShowError("CLuaBaseEntity::registerBattlefield() - Battlefield State was < 0.  Investigate!");
        return BATTLEFIELD_RETURN_CODE_BATTLEFIELD_FULL; // For safety, if we hit this condition, return battlefield full.
    }

    BattlefieldRegistration registration;
    registration.id        = arg0.as<int>();
    registration.area      = (arg1 != sol::lua_nil) ? arg1.as<uint8>() : 1;
    registration.initiator = (arg2 != sol::lua_nil) ? arg2.as<uint32>() : 0;

    if (arg3 != sol::lua_nil)
    {
        sol::table battlefield  = arg3.as<sol::table>();
        registration.maxPlayers = battlefield["maxPlayers"];
        registration.levelCap   = battlefield["levelCap"];
        registration.timeLimit  = std::chrono::seconds(battlefield.get<int32>("timeLimit"));
        registration.isMission  = battlefield.get_or("isMission", false);

        if (registration.isMission && settings::get<uint8>("map.LV_CAP_MISSION_BCNM") == 0)
        {
            registration.levelCap = settings::get<uint8>("main.MAX_LEVEL");
        }

        registration.showTimer = battlefield.get_or("showTimer", true);
        registration.rules |= battlefield.get<bool>("allowSubjob") ? RULES_ALLOW_SUBJOBS : 0;
        registration.rules |= battlefield.get<bool>("canLoseExp") ? RULES_LOSE_EXP : 0;
    }

    return PZone->m_BattlefieldHandler->RegisterBattlefield(PChar, registration);
}

bool CLuaBaseEntity::battlefieldAtCapacity(int battlefieldID)
{
    if (m_PBaseEntity->loc.zone->m_BattlefieldHandler == nullptr)
    {
        ShowWarning("m_BattlefieldHandler was null for %s.", m_PBaseEntity->getName());
        return true;
    }

    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return true;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    auto* PZone = PChar->loc.zone == nullptr ? zoneutils::GetZone(PChar->loc.destination) : PChar->loc.zone;

    if (!PZone || PZone->m_BattlefieldHandler == nullptr)
    {
        ShowWarning("CLuaBaseEntity::battlefieldAtCapacity() - Battlefield Handler is null.");
        return true; // NOTE: We were previously breaking here, so return full in this case.
    }

    bool full = false;
    if (PZone->m_BattlefieldHandler->ReachedMaxCapacity(battlefieldID))
    {
        full = true;
    }

    return full;
}

/************************************************************************
 *  Function: enterBattlefield(area)
 *  Purpose : Places an entity into a battlefield they are registered for (or tries enter a specific area if not full)
 *  Example : player:enterBattlefield(area)
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::enterBattlefield(sol::object const& area)
{
    if (m_PBaseEntity->objtype != TYPE_PC || m_PBaseEntity->loc.zone->m_BattlefieldHandler == nullptr)
    {
        ShowWarning("CLuaBaseEntity::enterBattlefield() - Non-PC calling function, or Battlefield Handler is null.");
        return false;
    }

    CBattlefield* PBattlefield = nullptr;
    if (area == sol::lua_nil)
    {
        PBattlefield = m_PBaseEntity->loc.zone->m_BattlefieldHandler->GetBattlefield(m_PBaseEntity, true);
    }
    else
    {
        PBattlefield = m_PBaseEntity->loc.zone->m_BattlefieldHandler->GetBattlefieldByArea(area.as<uint8>());
    }

    return PBattlefield ? PBattlefield->InsertEntity(m_PBaseEntity, true) : false;
}

/************************************************************************
 *  Function: leaveBattlefield()
 *  Purpose : Removes an entity from battlefield and removes battlefield status
 *  Example : player:leaveBattlefield(leaveCode)
 *  Notes   : leaveCode can be found in scripts/globals/battlefield.lua or src/map/battlefield.h
 ************************************************************************/

bool CLuaBaseEntity::leaveBattlefield(uint8 leavecode)
{
    if (m_PBaseEntity->objtype == TYPE_NPC || m_PBaseEntity->loc.zone->m_BattlefieldHandler == nullptr)
    {
        ShowWarning("CLuaBaseEntity::leaveBattlefield() - NPC calling function, or Battlefield Handler is null.");
        return false;
    }

    return m_PBaseEntity->loc.zone->m_BattlefieldHandler->RemoveFromBattlefield(m_PBaseEntity, m_PBaseEntity->PBattlefield, leavecode);
}

/************************************************************************
 *  Function: isInDynamis()
 *  Purpose : Returns true if an entity is in Dynamis
 *  Example : if player:isInDynamis() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isInDynamis()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return false;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->isInDynamis();
}

/************************************************************************
 *  Function: setEnteredBattlefield()
 *  Purpose : Sets if the player has entered the battlefield or not
 *  Example : player:setEnteredBattlefield(true)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setEnteredBattlefield(bool entered)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_BATTLEFIELD))
    {
        CBattlefield::setPlayerEntered(PChar, entered);
    }
}

/************************************************************************
 *  Function: hasEnteredBattlefield()
 *  Purpose : Checks if the player has entered the battlefield or not
 *  Example : if player:hasEnteredBattlefield() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::hasEnteredBattlefield()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    return CBattlefield::hasPlayerEntered(PChar);
}

/************************************************************************
 *  Function: isAlive()
 *  Purpose : Returns true if an Entity is alive
 *  Example : if mob:isAlive() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isAlive()
{
    if (auto* PBattle = dynamic_cast<CBattleEntity*>(m_PBaseEntity))
    {
        return PBattle->isAlive();
    }

    ShowError("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
    return false;
}

/************************************************************************
 *  Function: isDead()
 *  Purpose : Returns true if an Entity is dead
 *  Example : if pet:isDead() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isDead()
{
    if (auto* PBattle = dynamic_cast<CBattleEntity*>(m_PBaseEntity))
    {
        return PBattle->isDead();
    }

    ShowError("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
    return false;
}

/************************************************************************
 *  Function: hasRaiseTractorMenu()
 *  Purpose : Returns true if player has Raise or Tractor menu. Used to block casting on players with menu.
 *  Example : if target:hasRaiseTractorMenu() then
 ************************************************************************/
bool CLuaBaseEntity::hasRaiseTractorMenu()
{
    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        if (PChar->m_hasTractor == 0 && PChar->m_hasRaise == 0)
        {
            return false;
        }
    }

    return true;
}

/************************************************************************
 *  Function: sendRaise()
 *  Purpose : Updates the m_hasRaise private member with the Raise Level
 *  Example : target:sendRaise(1) -- 2, 3 or 4 for R2, R3, Arise
 *  Notes   : Sending the Raise menu is handled by CDeathState::Update
 ************************************************************************/

void CLuaBaseEntity::sendRaise(uint8 raiseLevel)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (raiseLevel == 0 || raiseLevel > 4)
    {
        ShowDebug("lua::sendRaise raise value is not valid!");
    }
    else if (PChar->m_hasTractor == 0 && PChar->m_hasRaise == 0)
    {
        PChar->m_hasRaise = raiseLevel;
        if (raiseLevel == 4)
        {
            PChar->m_hasArise = true;
        }
        PChar->pushPacket<CRaiseTractorMenuPacket>(PChar, TYPE_RAISE);
    }
}

/************************************************************************
 *  Function: sendReraise()
 *  Purpose : Updates the m_hasRaise private member with the Reraise Level
 *  Example : target:sendReraise(effect:getPower())
 *  Notes   : Sending the Reraise menu is handled by CDeathState::Update
 ************************************************************************/

void CLuaBaseEntity::sendReraise(uint8 raiseLevel)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (raiseLevel == 0 || raiseLevel > 4)
    {
        ShowDebug("lua::sendRaise raise value is not valide!");
    }
    else if (PChar->m_hasRaise == 0)
    {
        PChar->m_hasRaise = raiseLevel;
    }
}

/************************************************************************
 *  Function: sendTractor()
 *  Purpose : Sends a Tractor request to a PC
 *  Example : target:sendTractor(caster:getXPos(), caster:getYPos(), caster:getZPos()
 *  Notes   : Sets position to Tractor to, Tractor available flag, and shows menu to PC
 ************************************************************************/

void CLuaBaseEntity::sendTractor(float xPos, float yPos, float zPos, uint8 rotation)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (PChar->m_hasTractor == 0 && PChar->m_hasRaise == 0)
    {
        PChar->m_hasTractor = 1;

        PChar->m_StartActionPos.x        = xPos;
        PChar->m_StartActionPos.y        = yPos;
        PChar->m_StartActionPos.z        = zPos;
        PChar->m_StartActionPos.rotation = rotation;

        PChar->pushPacket<CRaiseTractorMenuPacket>(PChar, TYPE_TRACTOR);
    }
}

/************************************************************************
 *  Function: allowSendRaisePrompt()
 *  Purpose : Allows the raise prompt to be sent again to client
 *            if for example player was moved while dead (thus removing the prompt)
 *  Example : player:allowSendRaisePrompt()
 ************************************************************************/

void CLuaBaseEntity::allowSendRaisePrompt()
{
    if (m_PBaseEntity == nullptr || m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowError("m_PBaseEntity is null or not a Player.");
        return;
    }

    if (m_PBaseEntity->PAI->IsCurrentState<CDeathState>())
    {
        auto deathState = static_cast<CDeathState*>(m_PBaseEntity->PAI->GetCurrentState());
        deathState->allowSendRaise();
    }
}

/************************************************************************
 *  Function: countdown()
 *  Purpose : Starts or clears a visible countdown bar for player
 *  Example : player:countdown(60)
 *  Notes   : Using 0 or no argument removes the countdown bar from the player
 ************************************************************************/
void CLuaBaseEntity::countdown(sol::object const& secondsObj)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    CCharEntity* PChar  = (CCharEntity*)m_PBaseEntity;
    auto         packet = std::make_unique<CObjectiveUtilityPacket>();

    if (secondsObj.is<uint32>())
    {
        packet->addCountdown(secondsObj.as<uint32>());
    }

    PChar->pushPacket(std::move(packet));
}

/************************************************************************
 *  Function: objectiveUtility()
 *  Purpose : Manages countdown, progress bars, battle fence, help text
 *  Example :
        local objective = {
            -- countdown = 1800, -- countdown duration with default warning (60s)
            countdown = {
                duration = 3600, -- countdown length in seconds
                warning = 300 -- remaining duration after which the timer starts flashing red
            },
            bars = {
                [1] = {
                    title = "Izzat", -- bar title, empty string hides bar
                    value = 100 -- % bar progress
                },
            },
            scoreboard = { -- Yorcia Alluvion Skirmish
                marchlandScore = 0,
                strongholdScore = 0,
                marchlandProgress = 50180,
                marchlandProgressMax = 50180,
                strongholdProgress = 500180,
                strongholdProgressMax = 500180,
                strongholdNameOverride = 0
            },
            fence = {
                pos = {x = 0.000, y = 0.000}, -- center of fence
                radius = 25.00, -- radius from pos in yalms
                render = 25.00, -- distance from fence it becomes visible
                blue = true -- optional, turns default red fence bars blue
            },
            help = {
                title = 1, -- string index from ROM\333\16.DAT
                description = 62 -- same as above, must be 19 or higher
            }
        }
        player:objectiveUtility(objective)
 *  Notes   : Bars and scoreboard are mutually exclusive.
        Can have up to 6 bars. Many of these items are optional.
        Calling without arguments will clear everything.
 ************************************************************************/
void CLuaBaseEntity::objectiveUtility(sol::object const& obj)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    CCharEntity* PChar  = (CCharEntity*)m_PBaseEntity;
    auto         packet = std::make_unique<CObjectiveUtilityPacket>();

    if (obj.is<sol::table>())
    {
        sol::object countdownObj = obj.as<sol::table>()["countdown"];
        if (countdownObj.valid())
        {
            if (countdownObj.is<sol::table>())
            {
                uint32 duration = countdownObj.as<sol::table>().get<uint32>("duration");
                uint32 warning  = countdownObj.as<sol::table>().get_or<uint32>("warning", 0);
                packet->addCountdown(duration, warning);
            }
            else if (countdownObj.is<uint32>())
            {
                packet->addCountdown(countdownObj.as<uint32>());
            }
        }

        sol::object barsObj = obj.as<sol::table>()["bars"];
        if (barsObj.valid() && barsObj.is<sol::table>())
        {
            std::vector<std::pair<std::string, uint32>> bars;
            for (uint8 i = 1; i <= 6; ++i)
            {
                sol::object barObj = barsObj.as<sol::table>()[i];
                if (barObj.valid() && barObj.is<sol::table>())
                {
                    std::string barTitle = barObj.as<sol::table>().get<std::string>("title");
                    uint32      barValue = barObj.as<sol::table>().get<uint32>("value");
                    bars.emplace_back(barTitle, barValue);
                }
                else
                {
                    bars.emplace_back("", 0);
                }
            }
            packet->addBars(std::move(bars));
        }

        sol::object scoreboardObj = obj.as<sol::table>()["scoreboard"];
        if (scoreboardObj.valid() && scoreboardObj.is<sol::table>())
        {
            std::pair<int32, int32> score = {
                static_cast<int32>(scoreboardObj.as<sol::table>().get_or<uint32>("marchlandScore", 0)),
                static_cast<int32>(scoreboardObj.as<sol::table>().get_or<uint32>("strongholdScore", 0))
            };
            std::vector<uint32> data = {
                scoreboardObj.as<sol::table>().get_or<uint32>("marchlandProgress", 0),
                scoreboardObj.as<sol::table>().get_or<uint32>("marchlandProgressMax", 0),
                scoreboardObj.as<sol::table>().get_or<uint32>("strongholdProgress", 0),
                scoreboardObj.as<sol::table>().get_or<uint32>("strongholdProgressMax", 0),
                scoreboardObj.as<sol::table>().get_or<uint32>("marchlandNameOverride", 0),
                scoreboardObj.as<sol::table>().get_or<uint32>("strongholdNameOverride", 0),
            };
            packet->addScoreboard(score, data);
        }

        sol::object fenceObj = obj.as<sol::table>()["fence"];
        if (fenceObj.valid() && fenceObj.is<sol::table>())
        {
            sol::object fencePosObj = fenceObj.as<sol::table>()["pos"];
            float       posX        = 0.000;
            float       posY        = 0.000;
            if (fencePosObj.valid() && fencePosObj.is<sol::table>())
            {
                posX = fencePosObj.as<sol::table>().get<float>("x");
                posY = fencePosObj.as<sol::table>().get<float>("y");
            }

            float radius = fenceObj.as<sol::table>().get_or<float>("radius", 0.00);
            float render = fenceObj.as<sol::table>().get_or<float>("render", 25.00);
            bool  blue   = fenceObj.as<sol::table>().get_or<bool, std::string, bool>("blue", false);

            packet->addFence(posX, posY, radius, render, blue);
        }

        sol::object helpObj = obj.as<sol::table>()["help"];
        if (helpObj.valid() && helpObj.is<sol::table>())
        {
            uint16 title       = helpObj.as<sol::table>().get<uint16>("title");
            uint16 description = helpObj.as<sol::table>().get<uint16>("description");
            packet->addHelpText(title, description);
        }
    }

    PChar->pushPacket(std::move(packet));
}

/************************************************************************
 *  Function: enableEntities()
 *  Purpose : Enables/disables the list of given special hidden entities for just the target char
 *  Example : player:enableEntities({ 17207972, 17207973})
 *  Notes   : Default is all off, so sending the ID enables the special entity
 ************************************************************************/
void CLuaBaseEntity::enableEntities(sol::object const& obj)
{
    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        if (obj.is<std::vector<uint32>>())
        {
            PChar->pushPacket<CEntityEnableList>(obj.as<std::vector<uint32>>());
        }
    }
    else
    {
        ShowWarning(fmt::format("enableEntities called on invalid type ({})", m_PBaseEntity->name).c_str());
    }
}

/************************************************************************
 *  Function: independentAnimation()
 *  Purpose : Play an animation independent of action messages
 *  Example : player:independentAnimation(player, 251, 4) -- Plays little hearts
 *  Notes   :
 ************************************************************************/
void CLuaBaseEntity::independentAnimation(CLuaBaseEntity* PTarget, uint16 animId, uint8 mode)
{
    m_PBaseEntity->loc.zone->PushPacket(m_PBaseEntity, CHAR_INRANGE_SELF, std::make_unique<CIndependentAnimationPacket>(m_PBaseEntity, PTarget->GetBaseEntity(), animId, mode));
}

/************************************************************************
 *  Function: engage()
 *  Purpose : Instructs a Battle Entity to engage in combat
 *  Example : pet:engage(target)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::engage(uint16 requestedTarget)
{
    auto* PBattle = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (PBattle && requestedTarget > 0)
    {
        PBattle->PAI->Engage(requestedTarget);
    }
}

/************************************************************************
 *  Function: isEngaged()
 *  Purpose : Returns true if an Entity is engaged in battle
 *  Example : if mob:isEngaged() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isEngaged()
{
    return m_PBaseEntity->PAI->IsEngaged();
}

/************************************************************************
 *  Function: disengage()
 *  Purpose : Instructs the Battle Entity to disengage from combat
 *  Example : mob:disengage()
 *  Notes   : Used for Mobs and Pets
 ************************************************************************/

void CLuaBaseEntity::disengage()
{
    if (auto* PBattle = dynamic_cast<CBattleEntity*>(m_PBaseEntity))
    {
        PBattle->PAI->Disengage();
    }
    else
    {
        ShowError("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
    }
}

/************************************************************************
 *  Function: timer()
 *  Purpose : Inserts a pre-defined Lua fuction into the queue and executes
 *          : once a defined amount of time has expired (pauses Lua execution)
 *  Example : npc:timer(respawnTime * 1000, function(npc)
 *  Notes   : See scripts/zones/Nyzul_Isle/mobs/Raubahn.lua
 ************************************************************************/

void CLuaBaseEntity::timer(int ms, sol::function func)
{
    m_PBaseEntity->PAI->QueueAction(queueAction_t(ms, false, std::move(func)));
}

/************************************************************************
 *  Function: queue()
 *  Purpose : Queues a Lua function
 *  Example :
 *  Notes   : For instance, Sic can be used before a Pet reaches 100% TP.
 *          : Once the Pet reaches 100%, it will use it's Special Ability.
 *          : See scripts/actions/abilities/sic.lua for how the Special
 *          : Ability is delayed until 100% (essentially loops into Action Queue)
 ************************************************************************/

void CLuaBaseEntity::queue(int ms, sol::function func)
{
    m_PBaseEntity->PAI->QueueAction(queueAction_t(ms, true, std::move(func)));
}

/************************************************************************
 *  Function: addRecast()
 *  Purpose : Manually adds a cooldown for a particular Ability
 *  Example : automaton:addRecast(xi.recast.ABILITY, skill:getID(), 180)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::addRecast(uint8 recastCont, uint16 recastID, uint32 duration)
{
    CBattleEntity* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (PBattleEntity)
    {
        RECASTTYPE recastContainer = static_cast<RECASTTYPE>(recastCont);

        PBattleEntity->PRecastContainer->Add(recastContainer, recastID, duration);
        if (PBattleEntity->objtype == TYPE_PC)
        {
            CCharEntity* PChar = (CCharEntity*)m_PBaseEntity;
            PChar->pushPacket<CCharSkillsPacket>(PChar);
            PChar->pushPacket<CCharRecastPacket>(PChar);
        }
    }
}

/************************************************************************
 *  Function: hasRecast()
 *  Purpose : Checks to see if a particular Ability is on cooldown
 *  Example : automaton:hasRecast(xi.recast.ABILITY, skill:getID(), recast)
 *  Notes   : Recast parameter is optional to check charges
 ************************************************************************/

bool CLuaBaseEntity::hasRecast(uint8 rType, uint16 recastID, sol::object const& arg2)
{
    bool  hasRecast     = false;
    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);

    if (PBattleEntity)
    {
        RECASTTYPE recastContainer = static_cast<RECASTTYPE>(rType);
        uint32     recast          = (arg2 != sol::lua_nil) ? arg2.as<uint32>() : 0;

        hasRecast = PBattleEntity->PRecastContainer->HasRecast(recastContainer, recastID, recast);
    }

    return hasRecast;
}

/************************************************************************
 *  Function: resetRecast()
 *  Purpose : Resets the cooldown for a specified Ability to 0
 *  Example : player:resetRecast(xi.recast.ABILITY, 231)
 *  Notes   : Must call the particular container (Ability Container in above example)
 *          : I imagine the Magic container can be specified?
 ************************************************************************/

void CLuaBaseEntity::resetRecast(uint8 rType, uint16 recastID)
{
    // only reset for players
    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        auto*      PChar           = static_cast<CCharEntity*>(m_PBaseEntity);
        RECASTTYPE recastContainer = static_cast<RECASTTYPE>(rType);

        if (PChar->PRecastContainer->Has(recastContainer, recastID))
        {
            PChar->PRecastContainer->Del(recastContainer, recastID);
            PChar->PRecastContainer->Add(recastContainer, recastID, 0);
        }

        PChar->pushPacket<CCharSkillsPacket>(PChar);
        PChar->pushPacket<CCharRecastPacket>(PChar);
    }
}

/************************************************************************
 *  Function: resetRecasts()
 *  Purpose : Resets all Ability cooldowns to 0 for an Entity
 *  Example : target:resetRecasts()
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::resetRecasts()
{
    // only reset for players
    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

        PChar->PRecastContainer->Del(RECAST_MAGIC);
        PChar->PRecastContainer->Del(RECAST_ABILITY);
        PChar->pushPacket<CCharSkillsPacket>(PChar);
        PChar->pushPacket<CCharRecastPacket>(PChar);
    }
}

/************************************************************************
 *  Function: addListener()
 *  Purpose : Instructs the Event Handler to monitor for an Event, then
 *            execute a prepared Lua function once the Event has occurred
 *  Example : See: scripts/mixins/families/chigoe.lua
 *  Notes   : Function along with statements must be passed in L3
 ************************************************************************/

void CLuaBaseEntity::addListener(std::string const& eventName, std::string const& identifier, sol::function const& func)
{
    m_PBaseEntity->PAI->EventHandler.addListener(eventName, func, identifier);
}

/************************************************************************
 *  Function: removeListener()
 *  Purpose : Instructs the Event Handler to stop monitoring for an Event
 *  Example : pet:removeListener("AUTO_PATTERN_READER_TICK")
 *  Notes   : Used heavily in PUP Ability scripts
 ************************************************************************/

void CLuaBaseEntity::removeListener(std::string const& identifier)
{
    m_PBaseEntity->PAI->EventHandler.removeListener(identifier);
}

/************************************************************************
 *  Function: triggerListener()
 *  Purpose : Instructs Lua to execute an Event Function once a Trigger has
 *            been identified by the Event Handler
 *  Example : mob:triggerListener("AERN_RERAISE", mob, curr_reraise + 1)
 *  Notes   : Manually triggered through Aern scripts for some reason
 ************************************************************************/

void CLuaBaseEntity::triggerListener(std::string const& eventName, sol::variadic_args args)
{
    m_PBaseEntity->PAI->EventHandler.triggerListener(eventName, sol::as_args(args));
}

/************************************************************************
 *  Function: hasListener()
 *  Purpose : true/false of whether or not the Event Handler is monitoring
 *          : for a particular Event
 *  Example : if mob:hasListener("COMBAT_TICK") then ...
 *  Notes   : This uses the event name, not the unique identifier!
 *          : This is just for the presence of an event in general, not a specific one
 ************************************************************************/

bool CLuaBaseEntity::hasListener(std::string const& eventName)
{
    return m_PBaseEntity->PAI->EventHandler.hasListener(eventName);
}

/************************************************************************
 *  Function: getEntity()
 *  Purpose : Returns the object of the Entity targeted
 *  Example : local new_target = mob:getEntity(targetid)
 *  Notes   : Currently used in Assault Missions and some Mobs
 ************************************************************************/

std::optional<CLuaBaseEntity> CLuaBaseEntity::getEntity(uint16 targetID)
{
    auto* PEntity{ m_PBaseEntity->GetEntity(targetID) };
    if (PEntity)
    {
        return std::optional<CLuaBaseEntity>(PEntity);
    }

    return std::nullopt;
}

/************************************************************************
 *  Function: canChangeState()
 *  Purpose : Returns true if a mob isn't even in it's final form, bro
 *  Example : if mob:canChangeState() then
 *  Notes   : Only used in scripts/mixins/abyssea_nm.lua currently
 ************************************************************************/

bool CLuaBaseEntity::canChangeState()
{
    return m_PBaseEntity->PAI->CanChangeState();
}

/************************************************************************
 *  Function: wakeUp()
 *  Purpose : Removes any Sleep Effect from the Entity's Status Effect Container
 *  Example : target:wakeUp()
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::wakeUp()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    auto* PEntity = static_cast<CBattleEntity*>(m_PBaseEntity);

    PEntity->StatusEffectContainer->DelStatusEffect(EFFECT_SLEEP);
    PEntity->StatusEffectContainer->DelStatusEffect(EFFECT_SLEEP_II);
    PEntity->StatusEffectContainer->DelStatusEffect(EFFECT_LULLABY);
}

/************************************************************************
 *  Function: setBattleID()
 *  Purpose : Sets the battle ID on the entity. Only entities with the same battle ID can interact with each other.
 *  Example : target:setBattleID(1)
 *  Notes   : Default value for battle ID is 0.
 ************************************************************************/

void CLuaBaseEntity::setBattleID(uint16 battleID)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    auto* PEntity = static_cast<CBattleEntity*>(m_PBaseEntity);
    PEntity->setBattleID(battleID);
}

/************************************************************************
 *  Function: getBattleID()
 *  Purpose : Gets the battle ID on the entity
 *  Example : target:getBattleID()
 *  Notes   :
 ************************************************************************/

uint16 CLuaBaseEntity::getBattleID()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    auto* PEntity = static_cast<CBattleEntity*>(m_PBaseEntity);
    return PEntity->getBattleID();
}

/************************************************************************
 *  Function: recalculateStats()
 *  Purpose : Recalculate the total Stats for a PC (force update)
 *  Example : target:recalculateStats()
 *  Notes   : See scripts/effects/obliviscence.lua
 ************************************************************************/

void CLuaBaseEntity::recalculateStats()
{
    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        auto* PChar{ static_cast<CCharEntity*>(m_PBaseEntity) };

        jobpointutils::RefreshGiftMods(PChar);
        charutils::BuildingCharSkillsTable(PChar);
        charutils::CalculateStats(PChar);
        charutils::BuildingCharTraitsTable(PChar);
        charutils::CheckValidEquipment(PChar);
        charutils::BuildingCharAbilityTable(PChar);

        PChar->UpdateHealth();

        PChar->pushPacket<CCharJobsPacket>(PChar);
        PChar->pushPacket<CCharStatsPacket>(PChar);
        PChar->pushPacket<CCharSkillsPacket>(PChar);
        PChar->pushPacket<CCharRecastPacket>(PChar);
        PChar->pushPacket<CCharAbilitiesPacket>(PChar);
        PChar->pushPacket<CCharUpdatePacket>(PChar);
        PChar->pushPacket<CMenuMeritPacket>(PChar);
        PChar->pushPacket<CMonipulatorPacket1>(PChar);
        PChar->pushPacket<CMonipulatorPacket2>(PChar);
        PChar->pushPacket<CCharSyncPacket>(PChar);
    }
}

/************************************************************************
 *  Function: checkImbuedItems()
 *  Purpose : Returns true if an Imbued Item is found in a PC's inventory
 *  Example : if v:checkImbuedItems() then
 *  Notes   : See scripts/zones/Alzadaal_Undersea_Ruins/npcs/_20t.lua
 ************************************************************************/

bool CLuaBaseEntity::checkImbuedItems()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    auto* PChar{ static_cast<CCharEntity*>(m_PBaseEntity) };

    for (uint8 LocID = 0; LocID < CONTAINER_ID::MAX_CONTAINER_ID; ++LocID)
    {
        bool found = false;
        // clang-format off
        PChar->getStorage(LocID)->ForEachItem([&found](CItem* PItem)
        {
            if (PItem->getID() >= 5365 && PItem->getID() <= 5384)
            {
                found = true;
            }
        });
        // clang-format on

        if (found)
        {
            return true;
        }
    }

    return false;
}

/************************************************************************
 *  Function: isDualWielding()
 *  Purpose : Returns true if entity is wielding two weapons
 *  Example : if player:isDualWielding() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isDualWielding()
{
    CBattleEntity* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (PBattleEntity)
    {
        return PBattleEntity->m_dualWield;
    }
    else
    {
        ShowError("lua::isDualWielding :: NPCs don't wield weapons!");
    }

    return false;
}

/************************************************************************
 *  Function: isUsingH2H()
 *  Purpose : Returns true if entity is using H2H
 *  Example : if player:isDualWielding() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isUsingH2H()
{
    CCharEntity* PCharEntity   = dynamic_cast<CCharEntity*>(m_PBaseEntity);
    CMobEntity*  PBattleEntity = dynamic_cast<CMobEntity*>(m_PBaseEntity);

    if (PCharEntity)
    {
        CItemWeapon* PMainWeapon = dynamic_cast<CItemWeapon*>(PCharEntity->getEquip(SLOT_MAIN));

        if (PMainWeapon)
        {
            if (PMainWeapon->getSkillType() == SKILLTYPE::SKILL_HAND_TO_HAND)
            {
                return true;
            }
        }
        else // bare handed
        {
            return true;
        }
    }
    else if (PBattleEntity)
    {
        CItemWeapon* PWeapon = dynamic_cast<CItemWeapon*>(PBattleEntity->m_Weapons[SLOT_MAIN]);
        if (PWeapon && PWeapon->getSkillType() == SKILLTYPE::SKILL_HAND_TO_HAND)
        {
            return true;
        }
    }

    return false;
}

/************************************************************************
 *  Function: getBaseWeaponDelay(bool offhand)
 *  Purpose : Returns the unmodified base delay of an PCs's melee attack without any form of delay reduction
 *  Example : local delay = player:getBaseWeaponDelay(false)
 *  Notes   :
 ************************************************************************/

uint16 CLuaBaseEntity::getBaseWeaponDelay(uint16 slot)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }
    CCharEntity* PCharEntity = dynamic_cast<CCharEntity*>(m_PBaseEntity);

    if (PCharEntity)
    {
        CItemWeapon* PWeapon = dynamic_cast<CItemWeapon*>(PCharEntity->getEquip(static_cast<SLOTTYPE>(slot)));

        if (PWeapon)
        {
            return PWeapon->getBaseDelay();
        }
    }

    return 0;
}

/************************************************************************
 *  Function: getBaseDelay()
 *  Purpose : Returns the unmodified base delay of an entity's melee attack without any form of delay reduction
 *  Example : local delay = player:getBaseDelay()
 *  Notes   :
 ************************************************************************/

uint16 CLuaBaseEntity::getBaseDelay()
{
    CCharEntity*   PCharEntity   = dynamic_cast<CCharEntity*>(m_PBaseEntity);
    CBattleEntity* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    uint16         baseDelay     = 480; // h2h "unequipped" base delay

    if (PCharEntity)
    {
        CItemWeapon* PMainWeapon = dynamic_cast<CItemWeapon*>(PCharEntity->getEquip(SLOT_MAIN));
        CItemWeapon* PSubWeapon  = dynamic_cast<CItemWeapon*>(PCharEntity->getEquip(SLOT_SUB));

        if (PMainWeapon)
        {
            if (PMainWeapon->getSkillType() == SKILLTYPE::SKILL_HAND_TO_HAND)
            {
                baseDelay = PMainWeapon->getBaseDelay(); // h2h items include 480 base delay
            }
            else
            {
                baseDelay = PMainWeapon->getBaseDelay();
                if (PSubWeapon)
                {
                    baseDelay += PSubWeapon->getBaseDelay();
                }
            }
        }
    }
    else if (PBattleEntity)
    {
        CItemWeapon* PWeapon = dynamic_cast<CItemWeapon*>(PBattleEntity->m_Weapons[SLOT_MAIN]);
        if (PWeapon)
        {
            baseDelay = std::round(PWeapon->getBaseDelay() * 60.0 / 1000.0); // there is some precision loss that results in delays of 319.98 instead of 320, etc, so round to nearest.
        }
    }

    return baseDelay;
}

/************************************************************************
 *  Function: getBaseRangedDelay()
 *  Purpose : Returns the unmodified base delay of an entity's ranged attack without any form of delay reduction
 *  Example : local delay = player:getBaseRangedDelay()
 *  Notes   :
 ************************************************************************/

uint16 CLuaBaseEntity::getBaseRangedDelay()
{
    CCharEntity*   PCharEntity   = dynamic_cast<CCharEntity*>(m_PBaseEntity);
    CBattleEntity* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    uint16         baseDelay     = 0; // return 0 if not able to actually ranged attack

    if (PCharEntity)
    {
        CItemWeapon* PRangedWeapon = dynamic_cast<CItemWeapon*>(PCharEntity->getEquip(SLOT_RANGED));
        CItemWeapon* PAmmo         = dynamic_cast<CItemWeapon*>(PCharEntity->getEquip(SLOT_AMMO));

        if (PRangedWeapon && PRangedWeapon->isRanged())
        {
            if (PRangedWeapon->isThrowing()) // Throwing, like Chakram/Boomerang in ranged slot
            {
                baseDelay = PRangedWeapon->getBaseDelay();
            }
            else if (PAmmo) // Bow/gun etc, but only valid if Ammo is equipped.
            {
                baseDelay = PRangedWeapon->getBaseDelay() + PAmmo->getBaseDelay();
            }
        }
        else if (PAmmo && PAmmo->isRanged()) // Throwing, Pebble/Shuriken in ammo slot
        {
            baseDelay = PAmmo->getBaseDelay();
        }
    }
    else if (PBattleEntity)
    {
        baseDelay = 260; // TODO: There does not seem to be a real way to get the delay of a ranged attack of a non-PC.
                         // 260 delay is derived from a Goblin Hunter using a ranged attack, using Dark Seal Absorb TP to reverse the delay.
                         // The cast gave back 40 TP, which is half of 80 TP due to 50% dAGI penalty being maxed out.
    }

    return baseDelay;
}

/************************************************************************
 *  Function: checkLiementAbsorb()
 *  Purpose : Returns 1.0 if Liement is not up or didn't absorb, -1.0 or less if it did
 *  Example : liementAbsorbPct = player:checkLiementAbsorb(xi.damageType.FIRE)
 *  Notes   :
 ************************************************************************/

float CLuaBaseEntity::checkLiementAbsorb(uint16 damageType)
{
    CBattleEntity* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (PBattleEntity)
    {
        return battleutils::CheckLiementAbsorb(PBattleEntity, (DAMAGE_TYPE)damageType);
    }

    return 1.0f;
}

/************************************************************************
 *  Function: getCE()
 *  Purpose : Returns the current Cumulative Enmity a Mob has against an Entity
 *  Example : local playerCE = target:getCE(player)
 *  Notes   : See Ventriloquy and Atonement
 ************************************************************************/

int32 CLuaBaseEntity::getCE(CLuaBaseEntity const* target)
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to get CE for invalid entity type (%s).", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CMobEntity*>(m_PBaseEntity)->PEnmityContainer->GetCE(static_cast<CBattleEntity*>(target->GetBaseEntity()));
}

/************************************************************************
 *  Function: getVE()
 *  Purpose : Returns the current Volatile Enmity a Mob has against an Entity
 *  Example : local playerVE = target:getVE(player)
 *  Notes   : See Ventriloquy and Atonement
 ************************************************************************/

int32 CLuaBaseEntity::getVE(CLuaBaseEntity const* target)
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to get VE for invalid entity type (%s).", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CMobEntity*>(m_PBaseEntity)->PEnmityContainer->GetVE(static_cast<CBattleEntity*>(target->GetBaseEntity()));
}

/************************************************************************
 *  Function: setCE()
 *  Purpose : Sets a specified amount of Cumulative Enmity against an Entity
 *  Example : target:setCE(player, newEnmity)
 *  Notes   : See Enmity Douse and Ventriloquy
 ************************************************************************/

void CLuaBaseEntity::setCE(CLuaBaseEntity* target, uint16 amount)
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to set CE for invalid entity type (%s).", m_PBaseEntity->getName());
        return;
    }

    static_cast<CMobEntity*>(m_PBaseEntity)->PEnmityContainer->SetCE(static_cast<CBattleEntity*>(target->GetBaseEntity()), amount);
}

/************************************************************************
 *  Function: setVE()
 *  Purpose : Sets a specified amount of Volatile Enmity against an Entity
 *  Example : target:setVE(player, newEnmity)
 *  Notes   : See Enmity Douse and Ventriloquy
 ************************************************************************/

void CLuaBaseEntity::setVE(CLuaBaseEntity* target, uint16 amount)
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to set VE for invalid entity type (%s).", m_PBaseEntity->getName());
        return;
    }

    static_cast<CMobEntity*>(m_PBaseEntity)->PEnmityContainer->SetVE(static_cast<CBattleEntity*>(target->GetBaseEntity()), amount);
}

/************************************************************************
 *  Function: addEnmity()
 *  Purpose : Adds CE and VE Enmity to the Mobs Enmity table against that Entity
 *  Example : target:addEnmity(automaton, 450, 900)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::addEnmity(CLuaBaseEntity* PEntity, int32 CE, int32 VE)
{
    auto* PMob = static_cast<CMobEntity*>(m_PBaseEntity);

    if (m_PBaseEntity->objtype == TYPE_PC || m_PBaseEntity->objtype == TYPE_PET || (m_PBaseEntity->objtype == TYPE_MOB && PMob->isCharmed))
    {
        if (PEntity && PEntity->GetBaseEntity() && PEntity->GetBaseEntity()->objtype == TYPE_MOB)
        {
            static_cast<CMobEntity*>(PEntity->GetBaseEntity())->PEnmityContainer->UpdateEnmity(static_cast<CBattleEntity*>(m_PBaseEntity), CE, VE);
        }
    }
    else if (m_PBaseEntity->objtype == TYPE_MOB)
    {
        if (PEntity != nullptr && (CE > 0 || VE > 0) && PEntity->GetBaseEntity()->objtype != TYPE_NPC)
        {
            PMob->PEnmityContainer->UpdateEnmity(static_cast<CBattleEntity*>(PEntity->GetBaseEntity()), CE, VE);
        }
    }
}

/************************************************************************
 *  Function: lowerEnmity()
 *  Purpose : Lowers Enmity towards an Entity by a specified percent
 *  Example : mob:lowerEnmity(target, 45)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::lowerEnmity(CLuaBaseEntity* PEntity, uint8 percent)
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to lower enmnity for invalid entity type (%s).", m_PBaseEntity->getName());
        return;
    }

    if (PEntity != nullptr && PEntity->GetBaseEntity()->objtype != TYPE_NPC)
    {
        static_cast<CMobEntity*>(m_PBaseEntity)->PEnmityContainer->LowerEnmityByPercent(static_cast<CBattleEntity*>(PEntity->GetBaseEntity()), percent, nullptr);
    }
}

/************************************************************************
 *  Function: updateEnmity()
 *  Purpose : Unlike updateClaim(), this function only causes a mob to fight the target
 *  Example : mob:updateEnmity(target)
 *  Notes   : Mob will engage an entity, but be unclaimed until acted upon
 ************************************************************************/

void CLuaBaseEntity::updateEnmity(CLuaBaseEntity* PEntity)
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to update enmity for invalid entity type (%s).", m_PBaseEntity->getName());
        return;
    }

    if (PEntity != nullptr && PEntity->GetBaseEntity()->objtype != TYPE_NPC)
    {
        m_PBaseEntity->PAI->Engage(PEntity->GetBaseEntity()->targid);
    }
}

/************************************************************************
 *  Function: transferEnmity()
 *  Purpose : Used to transfer an amount of Enmity from one Entity to another
 *  Example : target:transferEnmity(player, 50, 20.6)
 *  Notes   : See scripts/actions/abilities/accomplice.lua
 ************************************************************************/

void CLuaBaseEntity::transferEnmity(CLuaBaseEntity* entity, uint8 percent, float range)
{
    CBaseEntity* PEntity = entity->GetBaseEntity();

    auto* PIterEntity = [&]() -> CCharEntity*
    {
        if (m_PBaseEntity->objtype == TYPE_PC)
        {
            return static_cast<CCharEntity*>(m_PBaseEntity);
        }
        else if (m_PBaseEntity->objtype == TYPE_PET)
        {
            auto* PMaster = static_cast<CPetEntity*>(m_PBaseEntity)->PMaster;
            if (PMaster->objtype == TYPE_PC)
            {
                return static_cast<CCharEntity*>(PMaster);
            }
        }
        else if (PEntity->objtype == TYPE_PC)
        {
            return static_cast<CCharEntity*>(PEntity);
        }
        else if (PEntity->objtype == TYPE_PET)
        {
            auto* PMaster = static_cast<CPetEntity*>(PEntity)->PMaster;
            if (PMaster->objtype == TYPE_PC)
            {
                return static_cast<CCharEntity*>(PMaster);
            }
        }
        return nullptr;
    }();

    if (PIterEntity)
    {
        FOR_EACH_PAIR_CAST_SECOND(CMobEntity*, PMob, PIterEntity->SpawnMOBList)
        {
            if (isWithinDistance(PMob->loc.p, PEntity->loc.p, range))
            {
                battleutils::TransferEnmity(static_cast<CBattleEntity*>(PEntity), static_cast<CBattleEntity*>(m_PBaseEntity), PMob, percent);
            }
        }
    }
}

/************************************************************************
 *  Function: updateEnmityFromDamage()
 *  Purpose : Generates Enmity from moves that damage the Mob
 *  Example : target:updateEnmityFromDamage(player, damage)
 *  Notes   : Used in most Weaponskills and damaging abilities scripts
 ************************************************************************/

void CLuaBaseEntity::updateEnmityFromDamage(CLuaBaseEntity* PEntity, int32 damage)
{
    auto* PBaseMob = static_cast<CMobEntity*>(m_PBaseEntity);

    // This is a mob attacking a target and losing enmity from doing damage
    if (m_PBaseEntity->objtype == TYPE_PC || m_PBaseEntity->objtype == TYPE_PET || (m_PBaseEntity->objtype == TYPE_MOB && PBaseMob->isCharmed))
    {
        if (PEntity->GetBaseEntity() && PEntity->GetBaseEntity()->objtype == TYPE_MOB)
        {
            static_cast<CMobEntity*>(PEntity->GetBaseEntity())->PEnmityContainer->UpdateEnmityFromAttack(static_cast<CBattleEntity*>(m_PBaseEntity), damage);
        }
    }
    // This is a mob being attacked and gaining enmity on the attacker
    else if (m_PBaseEntity->objtype == TYPE_MOB)
    {
        if (PEntity->GetBaseEntity() && damage > 0 && PEntity->GetBaseEntity()->objtype != TYPE_NPC)
        {
            PBaseMob->PEnmityContainer->UpdateEnmityFromDamage(static_cast<CBattleEntity*>(PEntity->GetBaseEntity()), damage);
        }
    }
}

/************************************************************************
 *  Function: updateEnmityFromCure()
 *  Purpose : Generates Enmity from use of Cure spells/abilities
 *  Example : caster:updateEnmityFromCure(target, final)
 *  Notes   : Used in nearly all Cure scripts and abilities which heal
 ************************************************************************/

void CLuaBaseEntity::updateEnmityFromCure(CLuaBaseEntity* PEntity, int32 amount, sol::object const& optionalFixedCE, sol::object const& optionalFixedVE)
{
    int32 fixedCE = optionalFixedCE.is<int32>() ? optionalFixedCE.as<int32>() : 0;
    int32 fixedVE = optionalFixedVE.is<int32>() ? optionalFixedVE.as<int32>() : 0;

    if (amount < 0)
    {
        ShowWarning("Received negative cure amount.");
        return;
    }

    // clang-format off
    auto* PCurer = [&]() -> CBattleEntity*
    {
        if (m_PBaseEntity->objtype == TYPE_PC || m_PBaseEntity->objtype == TYPE_TRUST)
        {
            return static_cast<CBattleEntity*>(m_PBaseEntity);
        }
        else if (m_PBaseEntity->objtype == TYPE_PET && static_cast<CPetEntity*>(m_PBaseEntity)->getPetType() != PET_TYPE::AUTOMATON)
        {
            auto* PMaster = static_cast<CPetEntity*>(m_PBaseEntity)->PMaster;
            if (PMaster->objtype == TYPE_PC)
            {
                return static_cast<CCharEntity*>(PMaster);
            }
        }
        return nullptr;
    }();
    // clang-format on

    if (PEntity != nullptr && PCurer)
    {
        battleutils::GenerateCureEnmity(PCurer, static_cast<CBattleEntity*>(PEntity->GetBaseEntity()), amount, fixedCE, fixedVE);
    }
}

/************************************************************************
 *  Function: resetEnmity()
 *  Purpose : Used to clear all Enmity from the target
 *  Example : mob:resetEnmity(target)
 *  Notes   : Used in Mob special abilities which reset Enmity
 ************************************************************************/

void CLuaBaseEntity::resetEnmity(CLuaBaseEntity* PEntity)
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to reset enmnity for invalid entity type (%s).", m_PBaseEntity->getName());
        return;
    }

    if (PEntity != nullptr && PEntity->GetBaseEntity()->objtype != TYPE_NPC)
    {
        static_cast<CMobEntity*>(m_PBaseEntity)->PEnmityContainer->LowerEnmityByPercent(static_cast<CBattleEntity*>(PEntity->GetBaseEntity()), 100, nullptr);
    }
}

/************************************************************************
 *  Function: updateClaim()
 *  Purpose : Marks a Mob as claimed once popped by a Player
 *  Example : mob:updateClaim(player)
 *  Notes   : Used mostly in QM (???) scripts
 ************************************************************************/

void CLuaBaseEntity::updateClaim(sol::object const& entity)
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        return;
    }

    if ((entity == sol::lua_nil) || !entity.is<CLuaBaseEntity*>())
    {
        static_cast<CMobEntity*>(m_PBaseEntity)->m_OwnerID.clean();
        static_cast<CMobEntity*>(m_PBaseEntity)->updatemask |= UPDATE_STATUS;
        return;
    }

    CLuaBaseEntity* PEntity = entity.as<CLuaBaseEntity*>();

    if (PEntity != nullptr && PEntity->GetBaseEntity()->objtype != TYPE_NPC)
    {
        battleutils::ClaimMob(static_cast<CMobEntity*>(m_PBaseEntity), static_cast<CBattleEntity*>(PEntity->GetBaseEntity()));
    }
}

/************************************************************************
 *  Function: hasEnmity()
 *  Purpose : Check if a an entity is on any mob's enmity list or is supertanked by
 *  Example : if player:hasEnmity() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::hasEnmity()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return false;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->hasEnmityEXPENSIVE();
}

/************************************************************************
 *  Function: getNotorietyList()
 *  Purpose : Return a list of mobs that hold enmity towards the player
 *  Example : local list = player:getNotorietyList()
 *  Notes   : Key removed from table, this might break things
 ************************************************************************/

sol::table CLuaBaseEntity::getNotorietyList()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return sol::lua_nil;
    }

    auto& notorietyContainer = static_cast<CBattleEntity*>(m_PBaseEntity)->PNotorietyContainer;

    auto table = lua.create_table();
    for (auto* entry : *notorietyContainer)
    {
        table.add(CLuaBaseEntity(entry));
    }

    return table;
}

/************************************************************************
 *  Function: setClaimable(...)
 *  Purpose : sets m_IsClaimable for a mob
 *  Example : mob:setClaimable(false)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setClaimable(bool claimable)
{
    if (auto* PMob = dynamic_cast<CMobEntity*>(m_PBaseEntity))
    {
        PMob->m_IsClaimable = claimable;
        return;
    }
    ShowError("lua::setClaimable called on invalid entity");
}

/************************************************************************
 *  Function: getClaimable(...)
 *  Purpose : Returns whether or not a mob is claimable
 *  Example : local claimable = mob:getClaimable()
 *  Notes   : Defaults to true, as in the CMobEntity constructor
 ************************************************************************/

bool CLuaBaseEntity::getClaimable()
{
    if (auto* PMob = dynamic_cast<CMobEntity*>(m_PBaseEntity))
    {
        return PMob->m_IsClaimable;
    }
    ShowError("lua::getClaimable called on invalid entity");
    return true;
}

/************************************************************************
 *  Function: clearEnmityForEntity(...)
 *  Purpose :
 *  Example : mob:clearEnmityForEntity(player)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::clearEnmityForEntity(CLuaBaseEntity* PEntity)
{
    if (auto* PMob = dynamic_cast<CMobEntity*>(m_PBaseEntity))
    {
        PMob->PEnmityContainer->Clear(PEntity->getID());
        return;
    }
    ShowError("lua::clearEnmityForEntity called on invalid entity");
}

/************************************************************************
 *  Function: addStatusEffect(effect, power, tick, duration, subtype, subpower, tier)
 *  Purpose : Adds a specified Status Effect to the Entity
 *  Example : target:addStatusEffect(xi.effect.ACCURACY_DOWN, 20, 3, 60)
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::addStatusEffect(sol::variadic_args va)
{
    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleEntity)
    {
        return false;
    }

    if (va[0].is<CLuaStatusEffect>())
    {
        auto PStatusEffect = va[0].as<CLuaStatusEffect>();
        return PBattleEntity->StatusEffectContainer->AddStatusEffect(new CStatusEffect(*PStatusEffect.GetStatusEffect()));
    }
    else
    {
        if (va.size() < 4)
        {
            return false;
        }

        // Mandatory
        auto effectID   = va[0].as<EFFECT>();                      // The same
        auto effectIcon = va[0].as<uint16>();                      // The same
        auto power      = static_cast<uint16>(va[1].as<double>()); // Can come in as a lua_number, capture as double and truncate
        auto tick       = static_cast<uint32>(va[2].as<double>());
        auto duration   = static_cast<uint32>(va[3].as<double>());

        // Optional
        auto subType         = va[4].is<uint32>() ? va[4].as<uint32>() : 0;
        auto subPower        = va[5].is<uint16>() ? va[5].as<uint16>() : 0;
        auto tier            = va[6].is<uint16>() ? va[6].as<uint16>() : 0;
        auto sourceType      = va[7].is<EffectSourceType>() ? va[7].as<EffectSourceType>() : EffectSourceType::SOURCE_NONE;
        auto sourceTypeParam = va[8].is<uint16>() ? va[8].as<uint16>() : 0;

        CStatusEffect* PEffect = new CStatusEffect(effectID,
                                                   effectIcon,
                                                   power,
                                                   tick,
                                                   duration,
                                                   subType,
                                                   subPower,
                                                   tier);

        if (sourceType != EffectSourceType::SOURCE_NONE && sourceTypeParam > 0)
        {
            PEffect->SetSource(sourceType, sourceTypeParam);
        }

        if (PEffect->GetStatusID() == EFFECT_FOOD)
        {
            int16 durationModifier = PBattleEntity->getMod(Mod::FOOD_DURATION);
            if (durationModifier)
            {
                PEffect->SetDuration((uint32)(PEffect->GetDuration() + PEffect->GetDuration() * (durationModifier / 100.0f)));
            }
        }

        return PBattleEntity->StatusEffectContainer->AddStatusEffect(PEffect);
    }
}

/************************************************************************
 *  Function: addStatusEffectEx()
 *  Purpose : Adds an instance (or 'battle') Status Effect to the Entity
 *  Example : target:addStatusEffectEx(xi.effect.MOUNTED, xi.effect.MOUNTED, 0, 0, 900, true)
 *  Notes   : For instance, Chocobo status, Fireflights, Teleport
 ************************************************************************/

bool CLuaBaseEntity::addStatusEffectEx(sol::variadic_args va)
{
    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleEntity)
    {
        return false;
    }

    if (va.size() < 5)
    {
        return false;
    }

    bool silent = false;
    if (va[va.size() - 1].is<bool>()) // Is last argument a bool?
    {
        silent = va[va.size() - 1].as<bool>();
    }

    // Mandatory
    auto effectID   = va[0].as<EFFECT>();
    auto effectIcon = va[1].as<uint16>();
    auto power      = static_cast<uint16>(va[2].as<double>()); // Can come in as a lua_number, capture as double and truncate
    auto tick       = static_cast<uint32>(va[3].as<double>());
    auto duration   = static_cast<uint32>(va[4].as<double>());

    // Optional
    auto subType    = va[5].is<uint32>() ? va[5].as<uint32>() : 0;
    auto subPower   = va[6].is<uint16>() ? va[6].as<uint16>() : 0;
    auto tier       = va[7].is<uint16>() ? va[7].as<uint16>() : 0;
    auto effectFlag = va[8].is<uint32>() ? va[8].as<uint32>() : 0;

    CStatusEffect* PEffect =
        new CStatusEffect(effectID,
                          effectIcon,
                          power,
                          tick,
                          duration,
                          subType,
                          subPower,
                          tier,
                          effectFlag); // Effect Flag (i.e in lua xi.effectFlag.AURA will make this an aura effect)

    return ((CBattleEntity*)m_PBaseEntity)->StatusEffectContainer->AddStatusEffect(PEffect, silent);
}

/************************************************************************
 *  Function: getStatusEffect()
 *  Purpose : Returns the Object of a specified Status ID
 *  Example : local debilitation = target:getStatusEffect(xi.effect.DEBILITATION)
 *  Notes   : Can specify Power of the Effect as an option or the Source (will use power if both specified)
 ************************************************************************/

std::optional<CLuaStatusEffect> CLuaBaseEntity::getStatusEffect(uint16 StatusID, sol::object const& SubType, sol::object const& SourceType, sol::object const& SourceTypeParam)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return std::nullopt;
    }
    if (SubType != sol::lua_nil && SourceType != sol::lua_nil)
    {
        ShowWarning("Cannot specify both SubType and SourceType.");
        return std::nullopt;
    }

    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleEntity)
    {
        return std::nullopt;
    }

    CStatusEffect* PStatusEffect   = nullptr;
    auto           effect_StatusID = static_cast<EFFECT>(StatusID);

    if (SubType != sol::lua_nil)
    {
        auto uint16_SubType = SubType.as<uint16>();
        PStatusEffect       = PBattleEntity->StatusEffectContainer->GetStatusEffect(effect_StatusID, uint16_SubType);
    }
    else if (SourceType != sol::lua_nil && SourceTypeParam != sol::lua_nil)
    {
        auto EffectSourceType_SourceType = SourceType.as<EffectSourceType>();
        auto uint16_SourceTypeParam      = SourceTypeParam.as<uint16>();
        PStatusEffect                    = PBattleEntity->StatusEffectContainer->GetStatusEffectBySource(effect_StatusID, EffectSourceType_SourceType, uint16_SourceTypeParam);
    }
    else
    {
        PStatusEffect = PBattleEntity->StatusEffectContainer->GetStatusEffect(effect_StatusID);
    }

    if (PStatusEffect)
    {
        return std::optional<CLuaStatusEffect>(PStatusEffect);
    }

    return std::nullopt;
}

/************************************************************************
 *  Function: getStatusEffects()
 *  Purpose : Returns a Lua table of all Status Effects an Entity has
 *  Example : local effects = caster:getStatusEffects() -- can iterate over table
 *  Notes   : Currently only used to check for Snake Eyes in ability.lua
 ************************************************************************/

sol::table CLuaBaseEntity::getStatusEffects()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return sol::lua_nil;
    }

    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleEntity)
    {
        return {};
    }

    auto table = lua.create_table();
    // clang-format off
    static_cast<CBattleEntity*>(m_PBaseEntity)->StatusEffectContainer->ForEachEffect(
    [&table](CStatusEffect* PEffect)
    {
        table.add(CLuaStatusEffect(PEffect));
    });
    // clang-format on

    return table;
}

/************************************************************************
 *  Function: getStatusEffectElement()
 *  Purpose : Returns the Element associated with a Status Effect
 *  Example : local element = mob:getStatusEffectElement(typeEffect)
 *  Notes   : For instnace, Bind = Ice, Slow = Earth
 ************************************************************************/

int16 CLuaBaseEntity::getStatusEffectElement(uint16 statusId)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return effects::GetEffectElement(statusId);
}

/************************************************************************
 *  Function: canGainStatusEffect()
 *  Purpose : Returns true if an Entity can gain a Status Effect
 *  Example : if target:canGainStatusEffect(xi.effect.STR_DOWN) then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::canGainStatusEffect(uint16 effect, sol::object const& powerObj)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return false;
    }

    uint16 power = powerObj.is<uint16>() ? powerObj.as<uint16>() : 0;

    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleEntity)
    {
        return false;
    }

    CStatusEffect statusEffect(static_cast<EFFECT>(effect), 0, power, 0, 0);

    return PBattleEntity->StatusEffectContainer->CanGainStatusEffect(&statusEffect);
}

/************************************************************************
 *  Function: hasStatusEffect()
 *  Purpose : Returns true if an Entity has a specific Status Effect active
 *  Example : if player:hasStatusEffect(xi.effect.REFRESH) then
 *  Notes   : More specific in scope than hasStatusEffectByFlag()
 ************************************************************************/

bool CLuaBaseEntity::hasStatusEffect(uint16 StatusID, sol::object const& SubType)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return false;
    }

    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleEntity)
    {
        return false;
    }

    bool hasEffect       = false;
    auto effect_StatusID = static_cast<EFFECT>(StatusID);

    if (SubType != sol::lua_nil)
    {
        auto uint16_SubType = SubType.as<uint16>();
        hasEffect           = PBattleEntity->StatusEffectContainer->HasStatusEffect(effect_StatusID, uint16_SubType);
    }
    else
    {
        hasEffect = PBattleEntity->StatusEffectContainer->HasStatusEffect(effect_StatusID);
    }

    return hasEffect;
}

/************************************************************************
 *  Function: hasStatusEffectByFlag()
 *  Purpose : Returns true if an Entity has a Status Effect of a specified Flag
 *  Example : if target:hasStatusEffectByFlag(xi.effectFlag.INVISIBLE) then
 *  Notes   : More broad in scope than hasStatusEffect()
 ************************************************************************/

bool CLuaBaseEntity::hasStatusEffectByFlag(uint16 StatusID)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleEntity)
    {
        return 0;
    }

    auto effect_StatusID = static_cast<EFFECT>(StatusID);
    return PBattleEntity->StatusEffectContainer->HasStatusEffectByFlag(effect_StatusID);
}

/************************************************************************
 *  Function: countEffect()
 *  Purpose : Returns the number of Effects an Entity has in their container
 *  Example : if target:countEffect() > 3 then
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::countEffect(uint16 StatusID)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleEntity)
    {
        return 0;
    }

    auto effect_StatusID = static_cast<EFFECT>(StatusID);
    return PBattleEntity->StatusEffectContainer->GetEffectsCount(effect_StatusID);
}

/************************************************************************
 *  Function: countEffectWithFlag(EFFECTFLAG)
 *  Purpose : Returns the number of Effects an Entity has in their container that matches the provided flag
 *  Example : if target:countEffectWithFlag(xi.effectFlag.DISPELABLE) > 3 then
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::countEffectWithFlag(uint32 flag)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleEntity)
    {
        return 0;
    }

    auto effectFlag = static_cast<EFFECTFLAG>(flag);
    return PBattleEntity->StatusEffectContainer->GetEffectsCountWithFlag(effectFlag);
}

/************************************************************************
 *  Function: delStatusEffect()
 *  Purpose : Deletes a specified Effect from the Entity's Status Effect Container
 *  Example : target:delStatusEffect(xi.effect.RERAISE)
 *  Notes   : Can specify Power of the Effect as an option or the Source (will use power if both specified)
 ************************************************************************/

bool CLuaBaseEntity::delStatusEffect(uint16 StatusID, sol::object const& SubType, sol::object const& SourceType, sol::object const& SourceTypeParam)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return false;
    }
    if (SubType != sol::lua_nil && SourceType != sol::lua_nil)
    {
        ShowWarning("Cannot specify both SubType and SourceType.");
        return false;
    }

    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleEntity)
    {
        return false;
    }

    bool result = false;

    auto effect_StatusID = static_cast<EFFECT>(StatusID);

    if (SubType != sol::lua_nil)
    {
        auto uint16_SubType = SubType.as<uint16>();
        result              = PBattleEntity->StatusEffectContainer->DelStatusEffect(effect_StatusID, uint16_SubType);
    }
    else if (SourceType != sol::lua_nil && SourceTypeParam != sol::lua_nil)
    {
        auto EffectSourcetype_SourceType = SourceType.as<EffectSourceType>();
        auto uint16_SourceTypeParam      = SourceTypeParam.as<uint16>();
        result                           = PBattleEntity->StatusEffectContainer->DelStatusEffectBySource(effect_StatusID, EffectSourcetype_SourceType, uint16_SourceTypeParam);
    }
    else
    {
        result = PBattleEntity->StatusEffectContainer->DelStatusEffect(effect_StatusID);
    }

    return result;
}

/************************************************************************
 *  Function: delStatusEffectsByFlag()
 *  Purpose : Removes all Status Effects of a specified flag
 *  Example : target:delEffectsByFlag(xi.effectFlag.DEATH)
 *  Notes   : Used for removal of multiple effects with matching flag
 ************************************************************************/

void CLuaBaseEntity::delStatusEffectsByFlag(uint32 flag, sol::object const& silent)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleEntity)
    {
        return;
    }

    bool bool_silent = silent.is<bool>() ? silent.as<bool>() : false;

    PBattleEntity->StatusEffectContainer->DelStatusEffectsByFlag(static_cast<EFFECTFLAG>(flag), bool_silent);
}

/************************************************************************
 *  Function: delStatusEffectSilent()
 *  Purpose : Removes a Status Effect from the Entity without showing a message
 *  Example : target:delStatusEffectSilent(xi.effect.SANDSTORM)
 *  Notes   : Used specifically for Status Effects that are not supposed to show a message once worn
 ************************************************************************/

bool CLuaBaseEntity::delStatusEffectSilent(uint16 StatusID)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return false;
    }

    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleEntity)
    {
        return false;
    }

    auto effect_StatusID = static_cast<EFFECT>(StatusID);
    return PBattleEntity->StatusEffectContainer->DelStatusEffectSilent(effect_StatusID);
}

/************************************************************************
 *  Function: eraseStatusEffect()
 *  Purpose : Removes an Erasable Status Effect from the Entity's Status Effect Container
 *  Example : target:eraseStatusEffect()
 *  Notes   : Can specify which type to remove, if Erasable
 ************************************************************************/

uint16 CLuaBaseEntity::eraseStatusEffect()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleEntity)
    {
        return 0;
    }

    auto effect = PBattleEntity->StatusEffectContainer->EraseStatusEffect();
    return static_cast<uint16>(effect);
}

/************************************************************************
 *  Function: eraseAllStatusEffect()
 *  Purpose : Removes an Erasable Status Effect from the Entity's Status Effect Container
 *  Example : target:eraseAllStatusEffect() -- Benediction
 *  Notes   : Can specify which type to remove, if Erasable
 ************************************************************************/

uint8 CLuaBaseEntity::eraseAllStatusEffect()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleEntity)
    {
        return 0;
    }

    return PBattleEntity->StatusEffectContainer->EraseAllStatusEffect();
}

/************************************************************************
 *  Function: dispelStatusEffect()
 *  Purpose : Removes a Dispelable Status Effect from the Entity's Status Effect Container
 *  Example : target:dispelStatusEffect()
 *  Notes   : Can specify which type to remove, if Dispelable
 ************************************************************************/

int32 CLuaBaseEntity::dispelStatusEffect(sol::object const& flagObj)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleEntity)
    {
        return 0;
    }

    uint32 flag = flagObj.is<uint32>() ? flagObj.as<uint32>() : (uint32)EFFECTFLAG_DISPELABLE;

    return PBattleEntity->StatusEffectContainer->DispelStatusEffect(static_cast<EFFECTFLAG>(flag));
}

/************************************************************************
 *  Function: dispelAllStatusEffect()
 *  Purpose : Removes all Status Effects from an Entity
 *  Example : target:dispelAllStatusEffect()
 *  Notes   : Can specify which types to remove, if Dispelable
 ************************************************************************/

uint8 CLuaBaseEntity::dispelAllStatusEffect(sol::object const& flagObj)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleEntity)
    {
        return 0;
    }

    uint32 flag = flagObj.is<uint32>() ? flagObj.as<uint32>() : (uint32)EFFECTFLAG_DISPELABLE;

    return PBattleEntity->StatusEffectContainer->DispelAllStatusEffect(static_cast<EFFECTFLAG>(flag));
}

/************************************************************************
 *  Function: stealStatusEffect()
 *  Purpose : Removes a dispellable status effect from one Entity and transfers it to the other
 *  Example : target:stealStatusEffect()
 *  Notes   :
 ************************************************************************/

uint16 CLuaBaseEntity::stealStatusEffect(CLuaBaseEntity* PTargetEntity, sol::object const& flagObj)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleEntity)
    {
        return 0;
    }

    auto* PTargetBattleEntity = dynamic_cast<CBattleEntity*>(PTargetEntity->GetBaseEntity());
    if (!PTargetBattleEntity)
    {
        return 0;
    }

    uint32 flag = flagObj.is<uint32>() ? flagObj.as<uint32>() : (uint32)EFFECTFLAG_DISPELABLE;

    if (CStatusEffect* PStatusEffect = PTargetBattleEntity->StatusEffectContainer->StealStatusEffect(static_cast<EFFECTFLAG>(flag)))
    {
        PBattleEntity->StatusEffectContainer->AddStatusEffect(PStatusEffect);
        return PStatusEffect->GetStatusID();
    }
    else
    {
        return 0;
    }
}

/************************************************************************
 *  Function: addMod()
 *  Purpose : Adds a Mod to the Entity
 *  Example : target:addMod(xi.mod.INT, 10)
 *  Notes   : If Mod ID already exists, adds the amount to existing amount
 ************************************************************************/

void CLuaBaseEntity::addMod(uint16 type, int16 amount)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleEntity)
    {
        return;
    }

    PBattleEntity->addModifier(static_cast<Mod>(type), amount);
}

/************************************************************************
 *  Function: getMod()
 *  Purpose : Returns the integer value of a specified Mod on the Entity
 *  Example : if target:getMod(xi.mod.MND) > 10 then
 *  Notes   :
 ************************************************************************/

int16 CLuaBaseEntity::getMod(uint16 modID)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->getMod(static_cast<Mod>(modID));
}

/************************************************************************
 *  Function: setMod()
 *  Purpose : Sets a specified Mod and Amount for the Entity
 *  Example : target:setMod(xi.mod.STR, 20)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setMod(uint16 modID, int16 value)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    static_cast<CBattleEntity*>(m_PBaseEntity)->setModifier(static_cast<Mod>(modID), value);
}

/************************************************************************
 *  Function: delMod()
 *  Purpose : Removes a specified Mod and amount from the Entity
 *  Example : target:delMod(xi.mod.STR,4)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::delMod(uint16 modID, int16 value)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    static_cast<CBattleEntity*>(m_PBaseEntity)->delModifier(static_cast<Mod>(modID), value);
}

/************************************************************************
 *  Function: printAllMods()
 *  Purpose : Prints all mods that have a non-zero value
 *  Example : target:printAllMods()
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::printAllMods()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    const auto longestEnumLength = [&]()
    {
        std::size_t longest = 0U;
        for (auto modId : magic_enum::enum_values<Mod>())
        {
            if (auto length = magic_enum::enum_name(modId).size(); length > longest)
            {
                longest = length;
            }
        }
        return longest;
    }();

    auto* PEntity = static_cast<CBattleEntity*>(m_PBaseEntity);
    ShowInfo(fmt::format("{}'s ({}) mods:", PEntity->getName(), PEntity->id).c_str());
    for (const auto& modId : magic_enum::enum_values<Mod>())
    {
        if (const auto& value = PEntity->getMod(modId); value != 0)
        {
            ShowInfo(fmt::format("| {:<{}} | {:<8} |", magic_enum::enum_name(modId), longestEnumLength, value).c_str());
        }
    };
}

/************************************************************************
 *  Function: addLatent()
 *  Purpose : Adds the specified latent to the player
 *  Example : player:addLatent(xi.latent.LATENT_HP_UNDER_PERCENT, 95, xi.mod.REGEN, 1)
 ************************************************************************/

void CLuaBaseEntity::addLatent(uint16 condID, uint16 conditionValue, uint16 mID, int16 modValue)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    LATENT conditionID = static_cast<LATENT>(condID);
    Mod    modID       = static_cast<Mod>(mID);

    static_cast<CCharEntity*>(m_PBaseEntity)->PLatentEffectContainer->AddLatentEffect(conditionID, conditionValue, modID, modValue);
}

/************************************************************************
 *  Function: delLatent()
 *  Purpose : Removes the specified latent to the player. Returns if successfully removed or not.
 *  Example : player:delLatent(xi.latent.LATENT_HP_UNDER_PERCENT, 95, xi.mod.REGEN, 1)
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::delLatent(uint16 condID, uint16 conditionValue, uint16 mID, int16 modValue)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    LATENT conditionID = static_cast<LATENT>(condID);
    Mod    modID       = static_cast<Mod>(mID);

    return static_cast<CCharEntity*>(m_PBaseEntity)->PLatentEffectContainer->DelLatentEffect(conditionID, conditionValue, modID, modValue);
}

/************************************************************************
 *  Function: hasAllLatentsActive()
 *  Purpose : Returns false if any latents for the slot are not active
 *  Example : player:hasAllLatentsActive(xi.slot.NECK)
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::hasAllLatentsActive(uint8 slot)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    return static_cast<CCharEntity*>(m_PBaseEntity)->PLatentEffectContainer->HasAllLatentsActive(slot);
}

/************************************************************************
 *  Function: getMaxGearMod()
 *  Purpose : Returns the highest integer value of a specified Mod on all equiped items
 *  Example : local maxValue = player:getMaxGearMod(xi.mod.GEOMANCY_BONUS)
 *  Notes   :
 ************************************************************************/

int16 CLuaBaseEntity::getMaxGearMod(Mod modId)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid Entity (Non-PC: %s) calling function.", m_PBaseEntity->getName());

        return 0;
    }

    return static_cast<CCharEntity*>(m_PBaseEntity)->getMaxGearMod(static_cast<Mod>(modId));
}

/************************************************************************
 *  Function: fold()
 *  Purpose : Removes the most recent Phantom Roll or Bust effect
 *  Example : target:fold()
 *  Notes   : Calls the Fold member of CStatusEffectContainer for calculation
 ************************************************************************/

void CLuaBaseEntity::fold()
{
    if (auto* PEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity))
    {
        PEntity->StatusEffectContainer->Fold(PEntity->id);
    }
    else
    {
        ShowError("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
    }
}

/************************************************************************
 *  Function: doWildCard()
 *  Purpose : Executes the Wild Card two hour for a COR
 *  Example : caster:doWildCard(target,total)
 *  Notes   : Calls the DoWildCardToEntity member of battleutils
 ************************************************************************/

void CLuaBaseEntity::doWildCard(CLuaBaseEntity* PEntity, uint8 total)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    battleutils::DoWildCardToEntity(static_cast<CCharEntity*>(m_PBaseEntity), static_cast<CCharEntity*>(PEntity->m_PBaseEntity), total);
}

/************************************************************************
 *  Function: doRandomDeal()
 *  Purpose : Executes the Random Deal job ability
 *  Example : player:doRandomDeal(target)
 *  Notes   : Calls the DoRandomDealToEntity function of battleutils
 ************************************************************************/
bool CLuaBaseEntity::doRandomDeal(CLuaBaseEntity* PTarget)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    if (!PTarget || !PTarget->m_PBaseEntity)
    {
        ShowWarning("Invalid entity type passed as target (%s).", m_PBaseEntity->getName());
        return false;
    }

    if (auto PBattleTarget = dynamic_cast<CBattleEntity*>(PTarget->m_PBaseEntity))
    {
        return battleutils::DoRandomDealToEntity(static_cast<CCharEntity*>(m_PBaseEntity), PBattleTarget);
    }

    return false;
}

/************************************************************************
 *  Function: addCorsairRoll()
 *  Purpose : Adds the Corsair Roll to the Target's Status Effect Container
 *  Example : target:addCorsairRoll(caster:getMainJob(), caster:getMerit(xi.merit.BUST_DURATION), xi.effect.CHAOS_ROLL, effectpower, 0, duration, caster:getID(),
 *total, MOD_ATTP) Notes   : Returns true if success (Is range a factor?)
 ************************************************************************/

bool CLuaBaseEntity::addCorsairRoll(uint8 casterJob, uint8 bustDuration, uint16 effectID, uint16 power, uint32 tick, uint32 duration, sol::object const& arg6, sol::object const& arg7, sol::object const& arg8)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return false;
    }

    CStatusEffect* PEffect = new CStatusEffect(static_cast<EFFECT>(effectID),                  // Effect ID
                                               effectID,                                       // Effect Icon (Associated with ID)
                                               power,                                          // Power
                                               tick,                                           // Tick
                                               duration,                                       // Duration
                                               (arg6 != sol::lua_nil) ? arg6.as<uint32>() : 0, // SubType or 0
                                               (arg7 != sol::lua_nil) ? arg7.as<uint16>() : 0, // SubPower or 0
                                               (arg8 != sol::lua_nil) ? arg8.as<uint16>() : 0  // Tier or 0
    );

    uint8 maxRolls = 2;

    if (casterJob != JOB_COR)
    {
        maxRolls = 1;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->StatusEffectContainer->ApplyCorsairEffect(PEffect, maxRolls, bustDuration);
}

/************************************************************************
 *  Function: hasCorsairEffect()
 *  Purpose : Returns true if the Entity has Corsair Effect
 *  Example : if target:hasCorsairEffect() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::hasCorsairEffect()
{
    if (auto* PEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity))
    {
        return PEntity->StatusEffectContainer->HasCorsairEffect(PEntity->id);
    }

    ShowError("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
    return false;
}

/************************************************************************
 *  Function: hasBustEffect()
 *  Purpose : Returns true if an Entity has a Bust Effect of a specified type
 *  Example : if target:hasBustEffect(effect) then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::hasBustEffect(uint16 id)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return false;
    }

    auto* PBattleEntity = static_cast<CBattleEntity*>(m_PBaseEntity);
    return PBattleEntity->StatusEffectContainer->HasBustEffect(static_cast<EFFECT>(id));
}

/************************************************************************
 *  Function: numBustEffects()
 *  Purpose : Returns the count of how many Bust Effects are in the Entity's container
 *  Example : if player:numBustEffects() == 2 then
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::numBustEffects()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    auto* PBattleEntity = static_cast<CBattleEntity*>(m_PBaseEntity);
    return PBattleEntity->StatusEffectContainer->GetEffectsCount(EFFECT_BUST);
}

/************************************************************************
 *  Function: healingWaltz()
 *  Purpose : Executes the Healing Waltz effect on Status Effect Container
 *  Example : target:healingWaltz()
 *  Notes   : Erases one random effect if it's 'Waltzable'
 ************************************************************************/

uint16 CLuaBaseEntity::healingWaltz()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    auto* PBattleEntity = static_cast<CBattleEntity*>(m_PBaseEntity);
    return static_cast<uint16>(PBattleEntity->StatusEffectContainer->HealingWaltz());
}

/************************************************************************
 *  Function: addBardSong()
 *  Purpose : Adds a song effect to Player(s') Status Effect Container(s); returns true if sucess
 *  Example : target:addBardSong(caster, xi.effect.BALLAD, power, 0, duration, caster:getID(), 0, 1)
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::addBardSong(CLuaBaseEntity* PEntity, uint16 effectID, uint16 power, uint16 tick, uint16 duration, uint16 subType, uint16 subPower, uint16 tier)
{
    auto* PBattle = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattle)
    {
        ShowError("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    CStatusEffect* PEffect = new CStatusEffect(static_cast<EFFECT>(effectID), // Effect ID
                                               effectID,                      // Effect Icon (Associated with ID)
                                               power,                         // Power
                                               tick,                          // Tick
                                               duration,                      // Duration
                                               subType,                       // SubType
                                               subPower,                      // SubPower
                                               tier                           // Tier
    );

    uint8 maxSongs = 2;

    if (PEntity && PEntity->m_PBaseEntity && PEntity->m_PBaseEntity->objtype == TYPE_PC)
    {
        CCharEntity* PCaster = static_cast<CCharEntity*>(PEntity->m_PBaseEntity);
        CItemWeapon* PItem   = static_cast<CItemWeapon*>(PCaster->getEquip(SLOT_RANGED));

        if (PItem == nullptr || PItem->getID() == 65535 ||
            !(PItem->getSkillType() == SKILL_STRING_INSTRUMENT || PItem->getSkillType() == SKILL_WIND_INSTRUMENT))
        {
            maxSongs = 1;
        }

        maxSongs += PCaster->getMod(Mod::MAXIMUM_SONGS_BONUS);
    }

    return PBattle->StatusEffectContainer->ApplyBardEffect(PEffect, maxSongs);
}

/************************************************************************
 *  Function: charm()
 *  Purpose : Charms an entity target
 *  Example : mob:charm(target)
 *  Notes: optional parameter specifying the duration in seconds
 *         (default duration of 0 implies duration is controlled
 *         by the status effect charm, which is the case for charmed players)
 ************************************************************************/

void CLuaBaseEntity::charm(CLuaBaseEntity const* target, sol::object const& p0)
{
    auto* PBattle = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattle)
    {
        ShowError("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto charmDuration = std::chrono::seconds(p0 != sol::lua_nil ? p0.as<uint32>() : 0);
    battleutils::applyCharm(PBattle, static_cast<CBattleEntity*>(target->GetBaseEntity()), charmDuration);
}

/************************************************************************
 *  Function: uncharm()
 *  Purpose : Removes charm from an entity
 *  Example : target:uncharm()
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::uncharm()
{
    if (auto* PBattle = dynamic_cast<CBattleEntity*>(m_PBaseEntity))
    {
        battleutils::unCharm(PBattle);
    }
    else
    {
        ShowError("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
    }
}

/************************************************************************
 *  Function: addBurden()
 *  Purpose : Adds a Burden to a Target
 *  Example : local overload = target:addBurden(xi.magic.ele.EARTH - 1, burden)
 *  Notes   : Used for Automation abilities
 *  TODO    : Make these multiple casts easier to read
 ************************************************************************/

uint8 CLuaBaseEntity::addBurden(uint8 element, uint8 burden)
{
    if (((CBattleEntity*)m_PBaseEntity)->PPet && ((CPetEntity*)((CBattleEntity*)m_PBaseEntity)->PPet)->getPetType() == PET_TYPE::AUTOMATON)
    {
        return ((CAutomatonEntity*)((CBattleEntity*)m_PBaseEntity)->PPet)->addBurden(element, burden);
    }

    return 0;
}

/************************************************************************
 *  Function: getOverloadChance()
 *  Purpose : Gets percentage chance of overload for automaton element
 *  Example : local overload = target:getOverloadChance(xi.magic.ele.EARTH - 1)
 *  Notes   : Used for Automation abilities
 *  TODO    : Make these multiple casts easier to read
 ************************************************************************/
uint8 CLuaBaseEntity::getOverloadChance(uint8 element)
{
    if (((CBattleEntity*)m_PBaseEntity)->PPet && ((CPetEntity*)((CBattleEntity*)m_PBaseEntity)->PPet)->getPetType() == PET_TYPE::AUTOMATON)
    {
        return ((CAutomatonEntity*)((CBattleEntity*)m_PBaseEntity)->PPet)->getOverloadChance(element);
    }

    return 0;
}

/************************************************************************
 *  Function: setStatDebilitation()
 *  Purpose : Updates the private member m_StatsDebilitation in CCharEntity
 *  Example : target:setStatDebilitation(power)
 *  Notes   : Used only through scripts/effects/debilitation.lua
 ************************************************************************/

void CLuaBaseEntity::setStatDebilitation(uint16 statDebil)
{
    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        auto* PChar{ static_cast<CCharEntity*>(m_PBaseEntity) };
        PChar->m_StatsDebilitation = statDebil;
        PChar->pushPacket<CCharJobsPacket>(PChar);
    }
}

/************************************************************************
 *  Function: getStat()
 *  Purpose : Returns a particular stat for an Entity
 *  Example : caster:getStat(xi.mod.INT)
 *  Notes   : weaponSlot param is used only for ATT (optional and defaults to SLOT_MAIN)
 ************************************************************************/

uint16 CLuaBaseEntity::getStat(uint16 statId, sol::variadic_args va)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    auto*  PEntity = static_cast<CBattleEntity*>(m_PBaseEntity);
    uint16 value   = 0;

    switch (static_cast<Mod>(statId))
    {
        case Mod::STR:
            value = PEntity->STR();
            break;
        case Mod::DEX:
            value = PEntity->DEX();
            break;
        case Mod::VIT:
            value = PEntity->VIT();
            break;
        case Mod::AGI:
            value = PEntity->AGI();
            break;
        case Mod::INT:
            value = PEntity->INT();
            break;
        case Mod::MND:
            value = PEntity->MND();
            break;
        case Mod::CHR:
            value = PEntity->CHR();
            break;
        case Mod::ATT:
        {
            SLOTTYPE weaponSlot = va[0].is<uint32>() ? va[0].as<SLOTTYPE>() : SLOTTYPE::SLOT_MAIN;
            value               = PEntity->ATT(weaponSlot);
        }
        break;
        case Mod::RATT:
        {
            SKILLTYPE skill = SKILL_NONE;

            if (PEntity->objtype == TYPE_PET && static_cast<CPetEntity*>(PEntity)->getPetType() == PET_TYPE::AUTOMATON)
            {
                skill = SKILLTYPE::SKILL_AUTOMATON_RANGED;
                value = PEntity->RATT(skill);
            }
            else
            {
                CItemWeapon* PWeapon = dynamic_cast<CItemWeapon*>(PEntity->m_Weapons[SLOTTYPE::SLOT_RANGED]);
                if (PWeapon)
                {
                    value = PEntity->RATT(PWeapon->getSkillType());
                }
                else
                {
                    value = PEntity->RATT(SKILL_MARKSMANSHIP); // TODO: does this edge case exist? will mobs or trusts hit this?
                }
            }
        }
        break;
        case Mod::DEF:
            value = PEntity->DEF();
            break;
        case Mod::EVA:
            value = PEntity->EVA();
            break;
        // TODO: support getStat for ACC/RACC/RATT
        default:
            // We should probably show a warning here
            break;
    }

    return value;
}

/************************************************************************
 *  Function: getACC()
 *  Purpose : Returns the  Accuracy of an Entity
 *  Example : player:getACC()
 *  Notes   : Uses the ACC member of CBattleEntity for calculation
 ************************************************************************/

uint16 CLuaBaseEntity::getACC()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    auto* PEntity = static_cast<CBattleEntity*>(m_PBaseEntity);
    return PEntity->ACC(0, 0); // (attackNumber = 0, offsetAcc = 0)
}

/************************************************************************
 *  Function: getEVA()
 *  Purpose : Returns the Evasion of an Entity
 *  Example : player:getEVA()
 *  Notes   : Uses the EVA member of CBattleEntity for calculation
 ************************************************************************/

uint16 CLuaBaseEntity::getEVA()
{
    if (auto* PEntity = static_cast<CBattleEntity*>(m_PBaseEntity))
    {
        return PEntity->EVA();
    }

    ShowError("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
    return 0;
}

/************************************************************************
 *  Function: getRACC()
 *  Purpose : Calculates and returns the Ranged Accuracy of a Weapon euipped in the Ranged slot
 *  Example : player:getRACC()
 *  Notes   : TODO: The calculation is already a public member of battleentity, shouldn't have two calculations, just call (CBattleEntity*)m_PBaseEntity)->RACC
 *            and return result
 ************************************************************************/

int CLuaBaseEntity::getRACC()
{
    auto* PEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PEntity)
    {
        ShowError("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto* weapon = dynamic_cast<CItemWeapon*>(PEntity->m_Weapons[SLOT_RANGED]);
    if (weapon == nullptr)
    {
        ShowDebug("lua::getRACC weapon in ranged slot is nullptr!");
        return 0;
    }

    int skill = PEntity->GetSkill(weapon->getSkillType());
    int acc   = skill;

    if (skill > 200)
    {
        acc = (int)(200 + (skill - 200) * 0.9);
    }

    acc += PEntity->getMod(Mod::RACC);
    acc += PEntity->AGI() / 2;
    acc = acc + std::min<int16>(((100 + PEntity->getMod(Mod::FOOD_RACCP)) * acc / 100), PEntity->getMod(Mod::FOOD_RACC_CAP));

    return acc;
}

/************************************************************************
 *  Function: getRATT()
 *  Purpose : Returns the Ranged Attack value of an equipped Ranged weapon
 *  Example : player:getRATT()
 *  Notes   : Calls the RATT member function of CBattleEntity for calculation
 ************************************************************************/

uint16 CLuaBaseEntity::getRATT()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    auto* weapon = dynamic_cast<CItemWeapon*>(static_cast<CBattleEntity*>(m_PBaseEntity)->m_Weapons[SLOT_RANGED]);

    if (weapon == nullptr)
    {
        ShowDebug("lua::getRATT weapon in ranged slot is nullptr!");
        return 0;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->RATT(weapon->getSkillType(), weapon->getILvlSkill());
}

/************************************************************************
 *  Function: getILvlMacc()
 *  Purpose : Returns the Magic Accuracy value of an equipped Main Weapon
 *  Example : caster:getILvlMacc()
 *  Notes   : Value of m_iLvlMacc (private member of CItemWeapon)
 ************************************************************************/

uint16 CLuaBaseEntity::getILvlMacc()
{
    auto* PBattle = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattle)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    if (auto* weapon = dynamic_cast<CItemWeapon*>(PBattle->m_Weapons[SLOT_MAIN]))
    {
        return weapon->getILvlMacc();
    }

    return 0;
}

/************************************************************************
 *  Function: getILvlSkill()
 *  Purpose : Returns the Weapon Skill Bonus value of an equipped Main Weapon
 *  Example : player:getILvlSkill()
 *  Notes   : Value of m_iLvlSkill (private member of CItemWeapon)
 ************************************************************************/

uint16 CLuaBaseEntity::getILvlSkill()
{
    auto* PBattle = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattle)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    if (auto* weapon = dynamic_cast<CItemWeapon*>(PBattle->m_Weapons[SLOT_MAIN]))
    {
        return weapon->getILvlSkill();
    }

    return 0;
}

/************************************************************************
 *  Function: getILvlParry()
 *  Purpose : Returns the parry skill Bonus value of an equipped Main Weapon
 *  Example : player:getILvlParry()
 *  Notes   : Value of m_iLvlParry (private member of CItemWeapon)
 ************************************************************************/

uint16 CLuaBaseEntity::getILvlParry()
{
    auto* PBattle = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattle)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    if (auto* weapon = dynamic_cast<CItemWeapon*>(PBattle->m_Weapons[SLOT_MAIN]))
    {
        return weapon->getILvlParry();
    }

    return 0;
}

/************************************************************************
 *  Function: isSpellAoE()
 *  Purpose : Returns true if a specified spell is AoE
 *  Example : if caster:isSpellAoE(spell:getID()) then
 *  Notes   : Only found in scripts/globals/magic.lua
 ************************************************************************/

bool CLuaBaseEntity::isSpellAoE(uint16 spellId)
{
    auto* PBattle = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattle)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return false;
    }

    CSpell* PSpell = spell::GetSpell(static_cast<SpellID>(spellId));
    if (PSpell != nullptr)
    {
        return battleutils::GetSpellAoEType(PBattle, PSpell) > 0;
    }

    return false;
}

/************************************************************************
 *  Function: physicalDmgTaken()
 *  Purpose : Returns the value of Physical Damage taken after calculation
 *  Example : dmg = target:physicalDmgTaken(dmg, damageType)
 *  Notes   : Passes argument to PhysicalDmgTaken member of battleutils.
 *            DamageType is optional and defaults to weapon type if not provided.
 ************************************************************************/

int32 CLuaBaseEntity::physicalDmgTaken(double damage, sol::variadic_args va)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    DAMAGE_TYPE damageType = va[0].is<uint32>() ? va[0].as<DAMAGE_TYPE>() : DAMAGE_TYPE::NONE;

    return battleutils::PhysicalDmgTaken(static_cast<CBattleEntity*>(m_PBaseEntity), static_cast<int32>(damage), damageType);
}

/************************************************************************
 *  Function: magicDmgTaken()
 *  Purpose : Returns the value of Magic Damage taken after calculation
 *  Example : dmg = target:magicDmgTaken(dmg)
 *  Notes   : Passes argument to MagicDmgTaken member of battleutils
 ************************************************************************/

int32 CLuaBaseEntity::magicDmgTaken(double damage, sol::variadic_args va)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    ELEMENT elementType = va[0].is<uint32>() ? va[0].as<ELEMENT>() : ELEMENT_NONE;

    return battleutils::MagicDmgTaken(static_cast<CBattleEntity*>(m_PBaseEntity), static_cast<int32>(damage), elementType);
}

/************************************************************************
 *  Function: rangedDmgTaken()
 *  Purpose : Returns the value of Ranged Damage taken after calculation
 *  Example : dmg = target:rangedDmgTaken(dmg)
 *  Notes   : Passes argument to RangedDmgTaken member of battleutils
 ************************************************************************/

int32 CLuaBaseEntity::rangedDmgTaken(double damage, sol::variadic_args va)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    DAMAGE_TYPE damageType = va[0].is<uint32>() ? va[0].as<DAMAGE_TYPE>() : DAMAGE_TYPE::NONE;

    return battleutils::RangedDmgTaken(static_cast<CBattleEntity*>(m_PBaseEntity), static_cast<int32>(damage), damageType);
}

/************************************************************************
 *  Function: breathDmgTaken()
 *  Purpose : Returns the value of Breath Damage taken after calculation
 *  Example : local dmg = target:breathDmgTaken(dmg)
 *  Notes   : Passes argument to BreathDmgTaken member of battleutils
 ************************************************************************/

int32 CLuaBaseEntity::breathDmgTaken(double damage)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return battleutils::BreathDmgTaken(static_cast<CBattleEntity*>(m_PBaseEntity), static_cast<int32>(damage));
}

/************************************************************************
 *  Function: handleAfflatusMiseryDamage()
 *  Purpose : Passes an argument to the HandleAfflatusMiseryDamage member of battleutils
 *  Example : target:handleAfflatusMiseryDamage(dmg)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::handleAfflatusMiseryDamage(double damage)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    battleutils::HandleAfflatusMiseryDamage(static_cast<CBattleEntity*>(m_PBaseEntity), static_cast<int32>(damage));
}

/************************************************************************
 *  Function: isWeaponTwoHanded()
 *  Purpose : Returns true if the Weapon in the Main Slot is two-handed
 *  Example : if player:isWeaponTwoHanded() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isWeaponTwoHanded()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return false;
    }

    auto* weapon = dynamic_cast<CItemWeapon*>(static_cast<CBattleEntity*>(m_PBaseEntity)->m_Weapons[SLOT_MAIN]);

    if (weapon == nullptr)
    {
        ShowDebug("lua::getWeaponDmg weapon in main slot is nullptr!");
        return 0;
    }

    return weapon->isTwoHanded();
}

/************************************************************************
 *  Function: getWeaponDmg()
 *  Purpose : Returns the real damage value of a Weapon in the Main slot
 *  Example : local weaponDamage = attacker:getWeaponDmg()
 *  Notes   : Also used in Mob damage calculations
 ************************************************************************/

uint16 CLuaBaseEntity::getWeaponDmg()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    uint16 weaponDamage = 0;

    // TODO: Determine if trusts and player fellows use mob or player damage formula
    if (m_PBaseEntity->objtype == TYPE_MOB ||
        m_PBaseEntity->objtype == TYPE_PET)
    {
        auto* PMob   = static_cast<CMobEntity*>(m_PBaseEntity);
        weaponDamage = mobutils::GetWeaponDamage(PMob, SLOT_MAIN);
    }
    else
    {
        weaponDamage = static_cast<CBattleEntity*>(m_PBaseEntity)->GetMainWeaponDmg();
    }

    return weaponDamage;
}

/************************************************************************
 *  Function: getWeaponDmgRank()
 *  Purpose : Returns the damage rating for the Weapon in the Main slot
 *  Example : attacker:getWeaponDmgRank()
 *  Notes   : Primarily used in fSTR calculation in scripts/globals/weaponskills.lua
 ************************************************************************/

uint16 CLuaBaseEntity::getWeaponDmgRank()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->GetMainWeaponRank();
}

/************************************************************************
 *  Function: getOffhandDmg()
 *  Purpose : Returns the damage rating for the Weapon in the Offhand slot
 *  Example : if player:getOffhandDmg() > 0 then
 *  Notes   : Mainly used to add an extra TP Hit in Weaponskills
 ************************************************************************/

uint16 CLuaBaseEntity::getOffhandDmg()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->GetSubWeaponDmg();
}

/************************************************************************
 *  Function: getOffhandDmgRank()
 *  Purpose : Returns the damage rank for the weapon in the Offhand slot
 *  Example : player:getOffhandDmgRank()
 *  Notes   : Not currently being used in any script calculation
 ************************************************************************/

uint16 CLuaBaseEntity::getOffhandDmgRank()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->GetSubWeaponRank();
}

/************************************************************************
 *  Function: getRangedDmg()
 *  Purpose : Returns the damage rating for the weapon in the Ranged slot
 *  Example : local dmg = (2 * player:getRangedDmg() + player:getAmmoDmg())
 *  Notes   :
 ************************************************************************/

uint16 CLuaBaseEntity::getRangedDmg()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->GetRangedWeaponDmg();
}

/************************************************************************
 *  Function: getRangedDmgRank()
 *  Purpose : Used in determining fSTR caculcation in weaponskills.lua
 *  Example : attacker:getRangedDmgRank()
 *  Notes   :
 ************************************************************************/

uint16 CLuaBaseEntity::getRangedDmgRank()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->GetRangedWeaponRank();
}

/************************************************************************
 *  Function: getAmmoDmg()
 *  Purpose : Returns the damage rating for the weapon in Ammo slot
 *  Example : local dmg = (2 * player:getRangedDmg() + player:getAmmoDmg()
 *  Notes   :
 ************************************************************************/

uint16 CLuaBaseEntity::getAmmoDmg()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);
    auto* weapon  = dynamic_cast<CItemWeapon*>(PBattle->m_Weapons[SLOT_AMMO]);

    if (weapon == nullptr)
    {
        ShowDebug("lua::getAmmoDmg weapon in ammo slot is nullptr!");
        return 0;
    }

    return weapon->getDamage();
}

/************************************************************************
 *  Function: getWeaponHitCount(false)
 *  Purpose : Gets the number of hits from a weapon
 *  Example : local numMainHandHits = player:getWeaponHitCount(false)
 ************************************************************************/

uint16 CLuaBaseEntity::getWeaponHitCount(bool offhand)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    if (CCharEntity* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        CItemWeapon* PMain = dynamic_cast<CItemWeapon*>(PChar->getEquip(SLOT_MAIN));
        CItemWeapon* PSub  = dynamic_cast<CItemWeapon*>(PChar->getEquip(SLOT_SUB));

        if (offhand && PSub)
        {
            return PSub->getHitCount();
        }
        else if (PMain)
        {
            return PMain->getHitCount();
        }
    }

    return 0;
}

/************************************************************************
 *  Function: removeAmmo()
 *  Purpose : Expends one item in the ammo slot (arrow,bullet, etc)
 *  Example : player:removeAmmo()
 *  Notes   : Ammo consumed is calculated in charentity.cpp and passed to battleutils
 ************************************************************************/

void CLuaBaseEntity::removeAmmo()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    battleutils::RemoveAmmo(static_cast<CCharEntity*>(m_PBaseEntity));
}

/************************************************************************
 *  Function: getWeaponSkillLevel()
 *  Purpose : Returns the player's skill level for the weapon in a slot
 *  Example : caster:getWeaponSkillLevel(xi.slot.RANGED)
 *  Notes   : Mainly used to determine String/Wind level, but can be used for others
 ************************************************************************/

uint16 CLuaBaseEntity::getWeaponSkillLevel(uint8 slotID)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        if (slotID > 3)
        {
            ShowWarning("Invalid slotID (%d) passed to function.", slotID);
            return 0;
        }

        auto* PChar   = static_cast<CCharEntity*>(m_PBaseEntity);
        auto* PWeapon = dynamic_cast<CItemWeapon*>(PChar->m_Weapons[slotID]);

        if ((PWeapon != nullptr) && PWeapon->isType(ITEM_WEAPON))
        {
            return PChar->GetSkill(PWeapon->getSkillType());
        }
    }

    return 0;
}

/************************************************************************
 *  Function: getWeaponDamageType()
 *  Purpose : Returns the primary type of a weapon in a slot
 *  Example : if attacker:getWeaponDamageType(xi.slot.MAIN) == xi.damageType.PIERCING then
 *  Notes   : Used to identify which damage type is the weapon
 ************************************************************************/

uint16 CLuaBaseEntity::getWeaponDamageType(uint8 slotID)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    if (slotID <= 3)
    {
        auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);
        auto* PWeapon = dynamic_cast<CItemWeapon*>(PBattle->m_Weapons[slotID]);

        if (PWeapon)
        {
            return static_cast<uint16>(PWeapon->getDmgType());
        }
    }

    ShowError("lua::getWeaponDamageType :: Invalid slot specified!");
    return 0;
}

/************************************************************************
 *  Function: getWeaponSkillType()
 *  Purpose : Returns the primary type of a weapon in a slot
 *  Example : if attacker:getWeaponSkillType(xi.slot.MAIN) == xi.skill.HAND_TO_HAND then
 *  Notes   : Used to identify which type of weapon it is (Katana, Sword, etc)
 ************************************************************************/

uint8 CLuaBaseEntity::getWeaponSkillType(uint8 slotID)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    if (slotID <= 3)
    {
        auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);
        auto* PWeapon = dynamic_cast<CItemWeapon*>(PBattle->m_Weapons[slotID]);

        if (PWeapon)
        {
            return PWeapon->getSkillType();
        }
        else
        {
            // nothing in offhand or non-weapon (shield/grip)
            return 0;
        }
    }

    ShowError("lua::getWeaponSkillType :: Invalid slot specified!");
    return 0;
}

/************************************************************************
 *  Function: getWeaponSubSkillType()
 *  Purpose : Returns the integer value of the Weapon's Sub Type
 *  Example : if player:getWeaponSubSkillType(xi.slot.RANGED) == 10 then
 *  Notes   : Mainly used to differentiate between ammo and ranged equipment
 ************************************************************************/

uint8 CLuaBaseEntity::getWeaponSubSkillType(uint8 slotID)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    if (slotID <= 3)
    {
        auto  slot    = static_cast<SLOTTYPE>(slotID);
        auto* PChar   = static_cast<CCharEntity*>(m_PBaseEntity);
        auto* PWeapon = dynamic_cast<CItemWeapon*>(PChar->getEquip(slot));

        if (PWeapon)
        {
            return PWeapon->getSubSkillType();
        }
    }

    ShowError("lua::getWeaponSubskillType :: Invalid slot specified!");
    return 0;
}

/************************************************************************
*  Function: getWSSkillchainProp()
*  Purpose : For the current weaponskill in use, returns the properties of Primary,
             Secondary, and Tertiary skillchains associated with that weaponskill
*  Example : attacker:getWSSkillchainProp()
*  Notes   : Used in determining Obi/Gorget bonuses (scripts/globals/weaponskills.lua)
************************************************************************/

auto CLuaBaseEntity::getWSSkillchainProp() -> std::tuple<uint8, uint8, uint8>
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return { 0, 0, 0 };
    }

    auto* state = dynamic_cast<CWeaponSkillState*>(m_PBaseEntity->PAI->GetCurrentState());

    if (state)
    {
        return {
            state->GetSkill()->getPrimarySkillchain(),
            state->GetSkill()->getSecondarySkillchain(),
            state->GetSkill()->getTertiarySkillchain()
        };
    }

    return { 0, 0, 0 }; // TODO: Verify this condition to make sure failed case is acceptable
}

/************************************************************************
 *  Function: takeWeaponskillDamage()
 *  Purpose : Calls Battle Utils to calculate final weapon skill damage against a foe
 *  Example : defender:takeWeaponskillDamage(attacker, finaldmg, attackType, damageType, slot, primary, tpHitsLanded, (extraHitsLanded * 10) + bonusTP,
 *targetTPMult) Notes   : Global function of same name in weaponskills.lua, calls this member function from within
 ************************************************************************/

int32 CLuaBaseEntity::takeWeaponskillDamage(CLuaBaseEntity* attacker, int32 damage, uint8 atkType, uint8 dmgType, uint8 slot, bool primary,
                                            float tpMultiplier, uint16 bonusTP, float targetTPMultiplier)
{
    auto* PBattleDefender = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleDefender)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto* PBattleAttacker = dynamic_cast<CBattleEntity*>(attacker->m_PBaseEntity);
    if (!PBattleAttacker)
    {
        ShowWarning("Invalid entity type passed as Attacker (%s).", m_PBaseEntity->getName());
        return 0;
    }

    ATTACK_TYPE attackType = static_cast<ATTACK_TYPE>(atkType);
    DAMAGE_TYPE damageType = static_cast<DAMAGE_TYPE>(dmgType);

    return battleutils::TakeWeaponskillDamage(PBattleAttacker, PBattleDefender, damage, attackType, damageType, slot,
                                              primary, tpMultiplier, bonusTP, targetTPMultiplier);
}

/************************************************************************
 *  Function: int32 TakeSpellDamage()
 *  Purpose : Calls Battle Utils to calculate final spell damage against a foe
 *  Example : target:takeSpellDamage(caster, spell, finaldmg, attackType, damageType)
 *  Notes   : Global function of same name in bluemagic.lua, calls this member function from within
 ************************************************************************/

int32 CLuaBaseEntity::takeSpellDamage(CLuaBaseEntity* caster, CLuaSpell* spell, int32 damage, uint8 atkType, uint8 dmgType)
{
    auto* PBattleDefender = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleDefender)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto* PBattleAttacker = dynamic_cast<CBattleEntity*>(caster->m_PBaseEntity);
    if (!PBattleAttacker)
    {
        ShowWarning("Invalid entity type passed as Attacker (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto*       PSpell     = spell->GetSpell();
    ATTACK_TYPE attackType = static_cast<ATTACK_TYPE>(atkType);
    DAMAGE_TYPE damageType = static_cast<DAMAGE_TYPE>(dmgType);

    return battleutils::TakeSpellDamage(PBattleDefender, PBattleAttacker, PSpell, damage, attackType, damageType);
}

/************************************************************************
 *  Function: int32 TakeSwipeLungeDamage()
 *  Purpose : Applies damage to target from Swipe/Lunge
 *  Example : target:takeSwipeLungeDamage(caster, spell, finaldmg, attackType, damageType)
 *  Notes   :
 ************************************************************************/

int32 CLuaBaseEntity::takeSwipeLungeDamage(CLuaBaseEntity* caster, int32 damage, uint8 atkType, uint8 dmgType)
{
    auto* PBattleDefender = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleDefender)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto* PBattleAttacker = dynamic_cast<CBattleEntity*>(caster->m_PBaseEntity);
    if (!PBattleAttacker)
    {
        ShowWarning("Invalid entity type passed as Attacker (%s).", m_PBaseEntity->getName());
        return 0;
    }

    ATTACK_TYPE attackType = static_cast<ATTACK_TYPE>(atkType);
    DAMAGE_TYPE damageType = static_cast<DAMAGE_TYPE>(dmgType);

    return battleutils::TakeSwipeLungeDamage(PBattleDefender, PBattleAttacker, damage, attackType, damageType);
}

/************************************************************************
 *  Function: checkDamageCap()
 *  Purpose : Checks to see if the mob has a damage cap value
 *  Example : target:checkDamageCap(damage)
 *  Notes   : This is used for mobs like Suttung that have a damage cap
 ************************************************************************/

int32 CLuaBaseEntity::checkDamageCap(int32 damage)
{
    if (auto* PBattle = dynamic_cast<CBattleEntity*>(m_PBaseEntity))
    {
        return battleutils::CheckAndApplyDamageCap(damage, PBattle);
    }

    ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
    return 0;
}

/************************************************************************
 *  Function: spawnPet()
 *  Purpose : Spawns a pet if a few correct conditions are met
 *  Example : caster:spawnPet(xi.petId.CARBUNCLE)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::spawnPet(sol::object const& arg0)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("CLuaBaseEntity::spawnPet() - NPC calling function.");
        return;
    }

    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
        if ((arg0 != sol::lua_nil) && arg0.is<int>())
        {
            uint32 petId = arg0.as<uint32>();
            if (petId == PETID_HARLEQUINFRAME)
            {
                if (((CCharEntity*)m_PBaseEntity)->PAutomaton)
                {
                    petId = static_cast<uint32>(PETID_HARLEQUINFRAME) + static_cast<uint32>(PChar->PAutomaton->getFrame()) - 0x20;
                }
                else
                {
                    ShowError("CLuaBaseEntity::spawnPet : PetID is nullptr");
                }
            }

            // Note: arg1 of SpawnPet below was arg0 and not petId
            petutils::SpawnPet(static_cast<CBattleEntity*>(m_PBaseEntity), petId, false);
        }
        else
        {
            ShowError("CLuaBaseEntity::spawnPet : PetID is nullptr");
        }
    }
    else if (m_PBaseEntity->objtype == TYPE_MOB)
    {
        auto* PMob = static_cast<CMobEntity*>(m_PBaseEntity);

        if (PMob->PPet == nullptr)
        {
            ShowError("lua_baseentity::spawnPet PMob (%d) trying to spawn pet but its nullptr", PMob->id);
            return;
        }

        CMobEntity* PPet = static_cast<CMobEntity*>(PMob->PPet);

        // if a number is given its an avatar or elemental spawn
        if ((arg0 != sol::lua_nil) && arg0.is<int>())
        {
            petutils::SpawnMobPet(PMob, arg0.as<uint32>());
        }

        // always spawn on master
        PPet->m_SpawnPoint = nearPosition(PMob->loc.p, 2.2f, static_cast<float>(M_PI));

        // setup AI
        PPet->Spawn();
    }
}

/************************************************************************
 *  Function: spawnTrust()
 *  Purpose : Spawns a Trust if a few correct conditions are met
 *  Example : caster:spawnTrust(spell:getID())
 ************************************************************************/

std::optional<CLuaBaseEntity> CLuaBaseEntity::spawnTrust(uint16 trustId)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return std::nullopt;
    }

    return CLuaBaseEntity(trustutils::SpawnTrust(static_cast<CCharEntity*>(m_PBaseEntity), trustId));
}

/************************************************************************
 *  Function: clearTrusts()
 *  Purpose :
 *  Example : caster:clearTrusts()
 ************************************************************************/

void CLuaBaseEntity::clearTrusts()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    static_cast<CCharEntity*>(m_PBaseEntity)->ClearTrusts();
}

/************************************************************************
 *  Function: getTrustID()
 *  Purpose :
 *  Example : trust:getTrustID()
 ************************************************************************/

uint32 CLuaBaseEntity::getTrustID()
{
    if (m_PBaseEntity->objtype != TYPE_TRUST)
    {
        ShowWarning("Invalid Entity calling function (%s).", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CTrustEntity*>(m_PBaseEntity)->m_TrustID;
}

/************************************************************************
 *  Function: trustPartyMessage()
 *  Purpose :
 *  Example : mob:trustPartyMessage(message_id)
 ************************************************************************/

void CLuaBaseEntity::trustPartyMessage(uint32 message_id)
{
    if (m_PBaseEntity->objtype != TYPE_TRUST)
    {
        ShowWarning("Invalid Entity calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PTrust = static_cast<CTrustEntity*>(m_PBaseEntity);
    if (auto* PMaster = dynamic_cast<CCharEntity*>(PTrust->PMaster))
    {
        // clang-format off
        PMaster->ForParty([&](CBattleEntity* PMember)
        {
            auto* PCharMember = static_cast<CCharEntity*>(PMember);
            PCharMember->pushPacket<CMessageCombatPacket>(PTrust, PMember, message_id, 0, 711);
        });
        // clang-format on
    }
}

/************************************************************************
 *  Function: addGambit(targetSelector, conditionsTable, actionsTable, retry)
 *  conditionsTable: { condition, arg1 }
 *  actionsTable: { reactionType, selector, selectorArg }
 *  Purpose  : Adds a behavior to the gambit system with an arbitrary number of predicates and reactions
 *  Examples : trust:addGambit(ai.t.CASTER, {
 *                  { ai.c.NOT_STATUS, xi.effect.REFRESH },
 *                  { ai.c.NOT_STATUS, xi.effect.SUBLIMATION_ACTIVATED },
 *            }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.REFRESH })
 *            trust:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.HASTE }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.HASTE })
 *            trust:addGambit(ai.t.TARGET, { ai.c.NOT_STATUS, xi.effect.FLASH }, {
 *                  { ai.r.JA, ai.s.SPECIFIC, xi.ja.DIVINE_EMBLEM },
 *                  { ai.r.MA, ai.s.SPECIFIC, xi.magic.spellFamily.FLASH } })
 *  Notes   : Adds a behavior to the gambit system
 ************************************************************************/

std::string CLuaBaseEntity::addGambit(uint16 targ, sol::table const& predicates, sol::table const& reactions, sol::object const& retry)
{
    const auto* PTrust = dynamic_cast<CTrustEntity*>(m_PBaseEntity);
    if (!PTrust)
    {
        ShowWarning("Invalid Entity calling function (%s).", m_PBaseEntity->getName());
        return {};
    }

    using namespace gambits;
    Gambit_t g;

    const auto targetSelector = static_cast<G_TARGET>(targ);

    auto extractPredicates = [](sol::table const& conditionsTable) -> std::vector<PredicateGroup_t>
    {
        std::vector<PredicateGroup_t> predicateGroups;

        if (conditionsTable.get_type() == sol::type::table)
        {
            // Check if we're dealing with a table of conditions
            // { { condition, arg1 }, { condition, arg1 } }
            if (conditionsTable.get<sol::optional<sol::table>>(1))
            {
                // Iterate over each table in the main table
                for (const auto& conditionEntry : conditionsTable)
                {
                    std::vector<Predicate_t> wrappedPredicates;
                    G_LOGIC                  logic = G_LOGIC::AND; // Predicates are AND by default, all must be true

                    auto conditionTable = conditionEntry.second.as<sol::table>();
                    // Check if we're dealing with conditions wrapped in a logic operator
                    // { ai.l.OR({ condition, arg1 }, { condition, arg1 }) }
                    //
                    // The logic function will wrap the conditions in a table
                    // { logic = ai.l.OR, conditions = { { condition, arg1 }, { condition, arg1 } } }
                    if (conditionTable["logic"].valid())
                    {
                        logic                 = static_cast<G_LOGIC>(conditionTable.get<uint16>("logic"));
                        auto nestedPredicates = conditionTable.get<sol::table>("conditions");
                        for (const auto& predicateDefinitionPair : nestedPredicates)
                        {
                            const sol::table& predicateTable = predicateDefinitionPair.second.as<sol::table>();
                            auto              predicateType  = static_cast<G_CONDITION>(predicateTable.get<uint16>(1));
                            auto              predicateArg   = predicateTable.get<uint32>(2);
                            wrappedPredicates.emplace_back(predicateType, predicateArg);
                        }
                        predicateGroups.emplace_back(logic, wrappedPredicates);
                    }
                    else
                    {
                        // Else we're dealing with unwrapped predicates, assumed to be AND together:
                        // { { condition, arg1 }, { condition, arg1 } }
                        auto predicateType = static_cast<G_CONDITION>(conditionTable.get<uint16>(1));
                        auto predicateArg  = conditionTable.get<uint32>(2);
                        wrappedPredicates.emplace_back(predicateType, predicateArg);
                    }
                    predicateGroups.emplace_back(logic, wrappedPredicates);
                }
            }
            else if (conditionsTable.size() == 2)
            {
                // Single predicate
                // { condition, arg1 }
                auto condition     = static_cast<G_CONDITION>(conditionsTable.get<uint16>(1));
                auto condition_arg = conditionsTable.get<uint32>(2);
                predicateGroups.emplace_back(G_LOGIC::AND, std::vector<Predicate_t>{ { condition, condition_arg } });
            }
        }
        return predicateGroups;
    };

    auto extractReactions = [](sol::table const& reactionsTable) -> std::vector<Action_t>
    {
        std::vector<Action_t> actions;

        if (reactionsTable.get_type() == sol::type::table)
        {
            // Process table of reactions
            // { { reactionType, selector, selectorArg }, { reactionType, selector, selectorArg } }
            if (reactionsTable.get<sol::optional<sol::table>>(1))
            {
                for (const auto& reactionDefinitionPair : reactionsTable)
                {
                    auto reactionTable       = reactionDefinitionPair.second.as<sol::table>();
                    auto reactionType        = static_cast<G_REACTION>(reactionTable.get<uint16>(1));
                    auto reactionSelector    = static_cast<G_SELECT>(reactionTable.get<uint16>(2));
                    auto reactionSelectorArg = reactionTable.get<uint32>(3);
                    actions.emplace_back(reactionType, reactionSelector, reactionSelectorArg);
                }
            }
            else if (reactionsTable.size() == 3)
            {
                // Single reaction
                // { reactionType, selector, selectorArg }
                auto reactionType        = static_cast<G_REACTION>(reactionsTable.get<uint16>(1));
                auto reactionSelector    = static_cast<G_SELECT>(reactionsTable.get<uint16>(2));
                auto reactionSelectorArg = reactionsTable.get<uint32>(3);
                actions.emplace_back(reactionType, reactionSelector, reactionSelectorArg);
            }
        }
        return actions;
    };

    g.predicate_groups = extractPredicates(predicates);
    g.actions          = extractReactions(reactions);

    // Optional
    const uint16 retryDelay = (retry != sol::lua_nil) ? retry.as<uint16>() : 0;
    const auto*  controller = static_cast<CTrustController*>(PTrust->PAI->GetController());

    g.retry_delay     = retryDelay;
    g.target_selector = targetSelector;
    g.identifier      = controller->m_GambitsContainer->NewGambitIdentifier(g);

    return controller->m_GambitsContainer->AddGambit(g);
}

/************************************************************************
 *  Function: removeGambit()
 *  Purpose :
 *  Example : trust:removeGambit(id)
 *  Notes   : Removes a behavior from the gambit system, using the id returned
 *          : from addGambit
 ************************************************************************/

void CLuaBaseEntity::removeGambit(std::string const& id)
{
    const auto* PTrust = dynamic_cast<CTrustEntity*>(m_PBaseEntity);
    if (!PTrust)
    {
        ShowWarning("Invalid Entity calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* controller = static_cast<CTrustController*>(PTrust->PAI->GetController());

    controller->m_GambitsContainer->RemoveGambit(id);
}

/************************************************************************
 *  Function: removeAllGambits()
 *  Purpose :
 *  Example : trust:removeAllGambits()
 *  Notes   : Removes all gambits from a trust.
 ************************************************************************/

void CLuaBaseEntity::removeAllGambits()
{
    const auto* PTrust = dynamic_cast<CTrustEntity*>(m_PBaseEntity);
    if (!PTrust)
    {
        ShowWarning("Invalid Entity calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* controller = static_cast<CTrustController*>(PTrust->PAI->GetController());

    controller->m_GambitsContainer->RemoveAllGambits();
}

/************************************************************************
 *  Function: setTrustTPSkillSettings(trigger, select, value)
 *  Purpose :
 *  Example : mob:setTrustTPSkillSettings(ai.tp.CLOSER_UNTIL_TP, ai.s.HIGHEST, 1500)
 *  Notes   : value is optional TP Value
 ************************************************************************/

void CLuaBaseEntity::setTrustTPSkillSettings(uint16 trigger, uint16 select, sol::object const& value)
{
    if (m_PBaseEntity->objtype != TYPE_TRUST)
    {
        ShowWarning("Invalid Entity calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    using namespace gambits;

    // Optional
    uint16 tp_value = (value != sol::lua_nil) ? value.as<uint16>() : 0;

    auto* trust      = static_cast<CTrustEntity*>(m_PBaseEntity);
    auto* controller = static_cast<CTrustController*>(trust->PAI->GetController());

    controller->m_GambitsContainer->tp_trigger = static_cast<G_TP_TRIGGER>(trigger);
    controller->m_GambitsContainer->tp_select  = static_cast<G_SELECT>(select);
    controller->m_GambitsContainer->tp_value   = tp_value;
}

/************************************************************************
 *  Function: despawnPet()
 *  Purpose : Despawns a Pet Entity
 *  Example : target:despawnPet()
 *  Notes   : Upon death or dismissal or similar
 ************************************************************************/

void CLuaBaseEntity::despawnPet()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);

    if (PBattle->PPet != nullptr)
    {
        petutils::DespawnPet(PBattle);
    }
}

/************************************************************************
 *  Function: hasValidJugPetItem()
 *  Purpose : Returns true if subSkill Type is of sufficient value
 *  Example : if player:hasValidJugPetItem() then
 *  Notes   : Solely used for determining Call Beast activation
 ************************************************************************/

bool CLuaBaseEntity::hasValidJugPetItem()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    CItemWeapon* PItem = static_cast<CItemWeapon*>(static_cast<CCharEntity*>(m_PBaseEntity)->getEquip(SLOT_AMMO));

    if (PItem != nullptr && PItem->getSubSkillType() >= SUBSKILL_SHEEP && PItem->getSubSkillType() <= SUBSKILL_TOLOI)
    {
        return true;
    }

    return false;
}

/************************************************************************
 *  Function: hasPet()
 *  Purpose : Returns true if an entity has a pet spawned
 *  Example : if target:hasPet() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::hasPet()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return false;
    }

    auto* PTarget = static_cast<CBattleEntity*>(m_PBaseEntity);

    return PTarget->PPet != nullptr && PTarget->PPet->status != STATUS_TYPE::DISAPPEAR;
}

/************************************************************************
 *  Function: hasJugPet()
 *  Purpose : Returns true if player has a jug pet
 *  Example : if player:hasJugPet() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::hasJugPet()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid Entity (%s) calling function.", m_PBaseEntity->getName());
        return false;
    }

    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);

    if (hasPet())
    {
        return static_cast<CPetEntity*>(PBattle->PPet)->getPetType() == PET_TYPE::JUG_PET;
    }

    return false;
}

/************************************************************************
 *  Function: getPet()
 *  Purpose : Returns the Entity Object of a Pet-type entity
 *  Example : local pet = getPet()
 *  Notes   :
 ************************************************************************/

std::optional<CLuaBaseEntity> CLuaBaseEntity::getPet()
{
    auto* PBattle = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattle)
    {
        ShowWarning("Invalid Entity (%s) calling function.", m_PBaseEntity->getName());
        return std::nullopt;
    }

    if (PBattle->PPet != nullptr)
    {
        return std::optional<CLuaBaseEntity>(PBattle->PPet);
    }

    return std::nullopt;
}

/************************************************************************
 *  Function: getPetID()
 *  Purpose : Returns the Pet ID of an entity
 *  Example : local PetID = pet:getPetID()
 *  Notes   :
 ************************************************************************/

uint32 CLuaBaseEntity::getPetID()
{
    if (m_PBaseEntity->objtype == TYPE_PET)
    {
        return static_cast<CPetEntity*>(m_PBaseEntity)->m_PetID;
    }

    return 0;
}

/************************************************************************
 *  Function: isAutomaton()
 *  Purpose : Returns true if entity is an automaton
 *  Example : local isAutomaton = pet:isAutomaton()
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isAutomaton()
{
    if (m_PBaseEntity->objtype == TYPE_PET)
    {
        uint32 petID = static_cast<CPetEntity*>(m_PBaseEntity)->m_PetID;
        if (petID >= PETID_HARLEQUINFRAME && petID <= PETID_STORMWAKERFRAME)
        {
            return true;
        }
    }

    return false;
}

/************************************************************************
 *  Function: isAvatar()
 *  Purpose : Returns true if entity is an avatar
 *  Example : local isAvatar = pet:isAvatar()
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isAvatar()
{
    if (m_PBaseEntity->objtype == TYPE_PET)
    {
        uint32 petID = static_cast<CPetEntity*>(m_PBaseEntity)->m_PetID;
        if ((petID >= PETID_CARBUNCLE && petID <= PETID_CAIT_SITH) || petID == PETID_SIREN)
        {
            return true;
        }
    }

    return false;
}

/************************************************************************
 *  Function: getPetElement()
 *  Purpose : Returns the elemental affinity of a pet entity
 *  Example : pet:getPetElement()
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getPetElement()
{
    auto* PBattle = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattle)
    {
        ShowWarning("Invalid Entity (%s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    if (PBattle->PPet)
    {
        return static_cast<CPetEntity*>(PBattle->PPet)->m_Element;
    }

    return 0;
}

/************************************************************************
 *  Function: setPet()
 *  Purpose : Sets Pet outside of DB interaction
 *  Example : mob:setPet(mobObject)
 ************************************************************************/

void CLuaBaseEntity::setPet(sol::object const& petObj)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        return;
    }

    CBattleEntity*  PTarget        = static_cast<CBattleEntity*>(m_PBaseEntity);
    CLuaBaseEntity* PLuaBaseEntity = petObj.is<CLuaBaseEntity*>() ? petObj.as<CLuaBaseEntity*>() : nullptr;

    if (PLuaBaseEntity == nullptr)
    {
        if (PTarget->PPet)
        {
            PTarget->PPet->PMaster = nullptr;
            PTarget->PPet          = nullptr;
        }
        return;
    }

    CBattleEntity* pet = dynamic_cast<CBattleEntity*>(PLuaBaseEntity->GetBaseEntity());
    if (pet)
    {
        PTarget->PPet = pet;
        pet->PMaster  = PTarget;
    }

    return;
}

// Returns the minimum level of the pet, such as level 23 for Courier Carrie or 0 if non applicable.
uint8 CLuaBaseEntity::getMinimumPetLevel()
{
    CPetEntity* PPet = dynamic_cast<CPetEntity*>(m_PBaseEntity);

    if (PPet)
    {
        Pet_t* petInfo = petutils::GetPetInfo(PPet->m_PetID);
        if (petInfo)
        {
            return petInfo->minLevel;
        }
    }
    else
    {
        ShowWarning("Non-CPetEntity called this function");
    }

    return 0;
}

/************************************************************************
 *  Function: getMaster()
 *  Purpose : Returns the Entity object for a pet's master
 *  Example : local master = pet:petMaster()
 *  Notes   :
 ************************************************************************/

std::optional<CLuaBaseEntity> CLuaBaseEntity::getMaster()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return std::nullopt;
    }

    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);

    if (PBattle->PMaster != nullptr)
    {
        CBaseEntity* PMaster = PBattle->PMaster;
        return std::optional<CLuaBaseEntity>(PMaster);
    }

    return std::nullopt;
}

/************************************************************************
 *  Function: getPetName()
 *  Purpose : Returns the string name of a pet (empty string if not a pet)
 *  Example : local hairball = pet:getPetName()
 *  Notes   :
 ************************************************************************/

auto CLuaBaseEntity::getPetName() -> const std::string
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return {};
    }

    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);

    if (PBattle->PPet)
    {
        return PBattle->PPet->name;
    }

    ShowWarning("PPet does not exist.");
    return {}; // Check this!
}

/************************************************************************
 *  Function: setPetName()
 *  Purpose : Passes a string to name a new pet
 *  Example : player:setPetName(xi.petType.WYVERN, xi.petName.ROVER)
 *  Notes   : Updates char_pet.sql
 ************************************************************************/

void CLuaBaseEntity::setPetName(uint8 pType, uint16 value, sol::object const& arg2)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    PET_TYPE petType = static_cast<PET_TYPE>(pType);

    if (arg2 == sol::lua_nil)
    {
        if (petType == PET_TYPE::WYVERN)
        {
            _sql->Query("INSERT INTO char_pet SET charid = %u, wyvernid = %u ON DUPLICATE KEY UPDATE wyvernid = %u", m_PBaseEntity->id, value, value);
        }
        else if (petType == PET_TYPE::AUTOMATON)
        {
            _sql->Query("INSERT INTO char_pet SET charid = %u, automatonid = %u ON DUPLICATE KEY UPDATE automatonid = %u", m_PBaseEntity->id, value,
                        value);
            if (static_cast<CCharEntity*>(m_PBaseEntity)->PAutomaton != nullptr)
            {
                puppetutils::LoadAutomaton(static_cast<CCharEntity*>(m_PBaseEntity));
            }
        }
    }
    else if (arg2.is<int>())
    {
        if (petType == PET_TYPE::CHOCOBO)
        {
            uint32 chocoboname1 = value & 0x0000FFFF;
            uint32 chocoboname2 = arg2.as<uint32>() << 16;

            uint32 nameValue = chocoboname1 + chocoboname2;

            _sql->Query("INSERT INTO char_pet SET charid = %u, chocoboid = %u ON DUPLICATE KEY UPDATE chocoboid = %u", m_PBaseEntity->id, nameValue,
                        nameValue);
        }
    }
}

void CLuaBaseEntity::registerChocobo(uint32 value)
{
    if (m_PBaseEntity == nullptr || m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid Entity");
        return;
    }

    auto* PChar           = static_cast<CCharEntity*>(m_PBaseEntity);
    PChar->m_FieldChocobo = value;
    _sql->Query("UPDATE char_pet SET field_chocobo = %u WHERE charid = %u", value, PChar->id);
}

/************************************************************************
 *  Function: petAttack()
 *  Purpose : Engages a pet with a target
 *  Example : pet:petAttack(target)
 *  Notes   : Sic
 ************************************************************************/

void CLuaBaseEntity::petAttack(CLuaBaseEntity* PEntity)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    if (static_cast<CBattleEntity*>(m_PBaseEntity)->PPet != nullptr)
    {
        petutils::AttackTarget(static_cast<CBattleEntity*>(m_PBaseEntity), static_cast<CBattleEntity*>(PEntity->GetBaseEntity()));
    }
}

/************************************************************************
 *  Function: petAbility()
 *  Purpose : Manually inserts the use of a pet ability into the queue
 *  Example : pet:petAbility(ABILITY)
 *  Notes   : If I had to guess, it's not coded
 ************************************************************************/

void CLuaBaseEntity::petAbility(uint16 abilityID)
{
    ShowWarning("CLuaBaseEntity::petAbility() - Non-implemented function called with parameter %d", abilityID);
}

/************************************************************************
 *  Function: petRetreat()
 *  Purpose : Disengages a pet from battle, returns to master
 *  Example : player:petRetreat()
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::petRetreat()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);

    if (PBattle->PPet != nullptr)
    {
        petutils::RetreatToMaster(PBattle);
    }
}

/************************************************************************
 *  Function: familiar()
 *  Purpose : Increases the power of the entities pet
 *  Example : mob:familiar()
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::familiar()
{
    auto* PBattle = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattle)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    if (PBattle->PPet != nullptr)
    {
        petutils::Familiar(PBattle->PPet);
    }
}

/************************************************************************
 *  Function: addPetMod()
 *  Purpose : Adds a specified mod and power to a pet
 *  Example : target:addPetMod(xi.mod.HP, 20)
 *  Notes   : Adds on top of existing values?
 ************************************************************************/

void CLuaBaseEntity::addPetMod(uint16 modID, int16 amount)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    static_cast<CBattleEntity*>(m_PBaseEntity)->addPetModifier(static_cast<Mod>(modID), PetModType::All, amount);
}

/************************************************************************
 *  Function: setPetMod()
 *  Purpose : Sets a specified mod and power for a pet
 *  Example : target:setPetMod(xi.mod.HP, 20)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setPetMod(uint16 modID, int16 amount)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    static_cast<CBattleEntity*>(m_PBaseEntity)->setPetModifier(static_cast<Mod>(modID), PetModType::All, amount);
}

/************************************************************************
 *  Function: delPetMod()
 *  Purpose : Removes a specified mod and power from a pet
 *  Example : target:delPetMod(xi.mod.HP, 20)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::delPetMod(uint16 modID, int16 amount)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    static_cast<CBattleEntity*>(m_PBaseEntity)->delPetModifier(static_cast<Mod>(modID), PetModType::All, amount);
}

/************************************************************************
 *  Function: hasAttachment()
 *  Purpose : Returns true if PC has attachment
 *  Example : if player:hasAttachment() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::hasAttachment(uint16 itemID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    CItem* PItem = itemutils::GetItem(itemID);
    return puppetutils::HasAttachment(static_cast<CCharEntity*>(m_PBaseEntity), PItem);
}

/************************************************************************
 *  Function: getAutomatonName()
 *  Purpose : Returns the string name of the automation pet
 *  Example : local name = pet:getAutomatonName()
 *  Notes   :
 ************************************************************************/

auto CLuaBaseEntity::getAutomatonName() -> std::string
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return {};
    }

    const char* Query = "SELECT name FROM "
                        "char_pet LEFT JOIN pet_name ON automatonid = id "
                        "WHERE charid = %u";

    int32 ret = _sql->Query(Query, m_PBaseEntity->id);

    if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
    {
        return _sql->GetStringData(0);
    }

    return {}; // TODO: Verify this case
}

/************************************************************************
 *  Function: getAutomatonFrame()
 *  Purpose : Returns the integer value of frame being used for automation
 *  Example : local frame = pet:getAutomatonFrame()
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getAutomatonFrame()
{
    if (m_PBaseEntity->objtype != TYPE_PET || static_cast<CPetEntity*>(m_PBaseEntity)->getPetType() != PET_TYPE::AUTOMATON)
    {
        ShowWarning("CLuaBaseEntity::getAutomatonFrame() - No automaton passed to function, or master does not have an automaton.");
        return 0;
    }

    auto* PAutomaton = static_cast<CAutomatonEntity*>(m_PBaseEntity);
    return static_cast<uint8>(PAutomaton->getFrame());
}

/************************************************************************
 *  Function: setAutomatonFrame(frameItemID)
 *  Purpose : Sets the provided frame on the automaton
 *  Example : player:setAutomatonFrame(xi.item.VALOREDGE_FRAME)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setAutomatonFrame(uint8 frameItemID)
{
    auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity);

    if (PChar == nullptr)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    if (PChar->PAutomaton)
    {
        puppetutils::setFrame(PChar, frameItemID - 0x2000);
        PChar->pushPacket<CCharJobExtraPacket>(PChar, true);
        PChar->pushPacket<CCharJobExtraPacket>(PChar, false);
        puppetutils::SaveAutomaton(PChar);
    }
}

/************************************************************************
 *  Function: getAutomatonHead()
 *  Purpose : Returns the integer value of the (active?) automation head
 *  Example : local head = pet:getAutomatonHead()
 *  Notes   : Currently unscripted
 ************************************************************************/

uint8 CLuaBaseEntity::getAutomatonHead()
{
    if (m_PBaseEntity->objtype != TYPE_PET || static_cast<CPetEntity*>(m_PBaseEntity)->getPetType() != PET_TYPE::AUTOMATON)
    {
        ShowWarning("CLuaBaseEntity::getAutomatonFrame() - No automaton passed to function, or master does not have an automaton.");
        return 0;
    }

    auto* PAutomaton = static_cast<CAutomatonEntity*>(m_PBaseEntity);
    return static_cast<uint8>(PAutomaton->getHead());
}

/************************************************************************
 *  Function: setAutomatonHead(headItemID)
 *  Purpose : Sets the automaton head to the specified item
 *  Example : player:setAutomatonHead(xi.item.VALOREDGE_HEAD)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setAutomatonHead(uint8 headItemID)
{
    auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity);

    if (PChar == nullptr)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    if (PChar->PAutomaton)
    {
        puppetutils::setHead(PChar, headItemID - 0x2000);
        PChar->pushPacket<CCharJobExtraPacket>(PChar, true);
        PChar->pushPacket<CCharJobExtraPacket>(PChar, false);
        puppetutils::SaveAutomaton(PChar);
    }
}

/************************************************************************
 *  Function: unlockAttachment()
 *  Purpose : Makes new attachment frames available to the Puppetmaster
 *  Example : player:unlockAttachment(8224) -- Harlequin Frame
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::unlockAttachment(uint16 itemID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    CItem* PItem = itemutils::GetItem(itemID);
    return puppetutils::UnlockAttachment(static_cast<CCharEntity*>(m_PBaseEntity), PItem);
}

/************************************************************************
 *  Function: getActiveManeuverCount()
 *  Purpose : Get the amount of active maneuvers for an automation
 *  Example : if target:getActiveManeuverCount() == 3 then
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getActiveManeuverCount()
{
    auto* PEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PEntity)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return PEntity->StatusEffectContainer->GetActiveManeuverCount();
}

/************************************************************************
 *  Function: removeOldestManeuver()
 *  Purpose : Removes the oldest maneuver in an automation set (FIFO)
 *  Example : target:removeOldestManeuver()
 *  Notes   : Often used if (target:getActiveManeuverCount() == 3)
 ************************************************************************/

void CLuaBaseEntity::removeOldestManeuver()
{
    auto* PEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PEntity)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    PEntity->StatusEffectContainer->RemoveOldestManeuver();
}

/************************************************************************
 *  Function: removeAllManeuvers()
 *  Purpose : Removes all maneuvers from an automation
 *  Example : target:removeAllManeuvers()
 *  Notes   : Often used if (overload ~= 0)
 ************************************************************************/

void CLuaBaseEntity::removeAllManeuvers()
{
    auto* PEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PEntity)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    PEntity->StatusEffectContainer->RemoveAllManeuvers();
}

/************************************************************************
 *  Function: getAttachment(slotId)
 *  Purpose : Gets the attachment of an automaton in the slot specified
 *  Example : pet:getAttachment(1)
 ************************************************************************/

std::optional<CLuaItem> CLuaBaseEntity::getAttachment(uint8 slotId)
{
    auto* PAutomaton = dynamic_cast<CAutomatonEntity*>(m_PBaseEntity);

    if (PAutomaton == nullptr)
    {
        ShowWarning("Invalid Entity accessing function.");
        return std::nullopt;
    }

    uint8 slotItem = PAutomaton->getAttachment(slotId);
    if (slotItem != 0)
    {
        return CLuaItem(itemutils::GetItemPointer(0x2100 + slotItem)); // TODO: Stop storing by offset
    }

    return std::nullopt;
}

/************************************************************************
 *  Function: setAttachment(attachmentItemID, slotID)
 *  Purpose : Sets the attachment of an automaton in the slot specified
 *  Example : player:setAttachment(8465, 0)
 ************************************************************************/

void CLuaBaseEntity::setAttachment(uint8 attachmentItemID, uint8 slotID)
{
    auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity);

    if (PChar == nullptr)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }
    if (PChar->PAutomaton)
    {
        puppetutils::setAttachment(PChar, slotID, attachmentItemID - 0x2100);
        PChar->pushPacket<CCharJobExtraPacket>(PChar, true);
        PChar->pushPacket<CCharJobExtraPacket>(PChar, false);
        puppetutils::SaveAutomaton(PChar);
    }
}

/************************************************************************
 *  Function: getAttachments()
 *  Purpose : Returns a table of attachment items equipped by an Automaton
 *  Example : pet:getAttachments()
 ************************************************************************/

sol::table CLuaBaseEntity::getAttachments()
{
    auto* PAutomaton = dynamic_cast<CAutomatonEntity*>(m_PBaseEntity);

    if (PAutomaton == nullptr)
    {
        ShowWarning("Invalid Entity accessing function.");
        return sol::lua_nil;
    }

    auto attachmentTable = lua.create_table();
    for (uint8 attachmentSlot = 0; attachmentSlot < 12; ++attachmentSlot)
    {
        uint8 attachmentItemId = PAutomaton->getAttachment(attachmentSlot);

        if (attachmentItemId != 0)
        {
            attachmentTable[attachmentSlot] = CLuaItem(itemutils::GetItemPointer(0x2100 + attachmentItemId));
        }
    }

    return attachmentTable;
}

/************************************************************************
 *  Function: updateAttachments()
 *  Purpose : Updates all of the attachments
 *  Example : master:updateAttachments()
 *  Notes   : Called when Optic Fiber has changed.
 ************************************************************************/

void CLuaBaseEntity::updateAttachments()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PEntity = static_cast<CCharEntity*>(m_PBaseEntity);
    puppetutils::UpdateAttachments(PEntity);
}

/************************************************************************
 *  Function: reduceBurden()
 *  Purpose : Reduces individual burden values based on percentage decrease
 *  Example : master:reduceBurden(50)
 *  Notes   : Used by Cooldown ability, optional arg is static decrease
 *            after percentage is applied.
 ************************************************************************/

void CLuaBaseEntity::reduceBurden(float percentReduction, sol::object const& intReductionObj)
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    auto* PEntity    = static_cast<CCharEntity*>(m_PBaseEntity);
    auto* PAutomaton = dynamic_cast<CAutomatonEntity*>(PEntity->PPet);

    if (!PAutomaton)
    {
        return;
    }

    std::array<uint8, 8> burden = PAutomaton->getBurden();
    for (int i = 0; i < 8; i++)
    {
        uint8 intReduction = (intReductionObj != sol::lua_nil) ? intReductionObj.as<uint8>() : 0;

        burden[i] = (uint8)std::max(0.f, burden[i] * (1 - ((percentReduction / 100) - PEntity->PJobPoints->GetJobPointValue(JP_COOLDOWN_EFFECT))) - intReduction);
    }

    PAutomaton->setBurdenArray(burden);
}

/************************************************************************
 *  Function: isExceedingElementalCapacity()
 *  Purpose : Checks if the automaton elemental capacity is being exceeded.
 *  Example : if master:isExceedingElementalCapacity() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isExceedingElementalCapacity()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return false;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (!PChar->PAutomaton)
    {
        return false;
    }

    for (uint8 i = 0; i < 8; ++i)
    {
        if (PChar->PAutomaton->getElementCapacity(i) > PChar->PAutomaton->getElementMax(i))
        {
            return true;
        }
    }

    return false;
}

/************************************************************************
 *  Function: getAllRuneEffects()
 *  Purpose : Returns a sol::table with all rune effects
 *  Example : local runeEffects = player:getAllRuneEffects()
 *  Notes   :
 ************************************************************************/

auto CLuaBaseEntity::getAllRuneEffects() -> sol::table
{
    auto* PEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PEntity)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return sol::lua_nil;
    }

    std::vector<EFFECT> runeEffectList = PEntity->StatusEffectContainer->GetAllRuneEffects();
    auto                table          = lua.create_table();
    for (const auto& runeEffect : runeEffectList)
    {
        table.add(runeEffect);
    }

    return table;
}

/************************************************************************
 *  Function: getActiveRunes()
 *  Purpose : Returns the number of active runes
 *  Example : local num = player:getActiveRunes()
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getActiveRuneCount()
{
    auto* PEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PEntity)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return PEntity->StatusEffectContainer->GetActiveRuneCount();
}

/************************************************************************
 *  Function: getHighestRuneEffect()
 *  Purpose : Returns the effect ID of the strongest Rune Effect
 *  Example : local highestEffect = player:getHighestRuneEffect()
 *  Notes   :
 ************************************************************************/

uint16 CLuaBaseEntity::getHighestRuneEffect()
{
    auto* PEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PEntity)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return PEntity->StatusEffectContainer->GetHighestRuneEffect();
}

/************************************************************************
 *  Function: getNewestRuneEffect()
 *  Purpose : Returns the effect ID of the most recent Rune Effect
 *  Example : local newestEffect = player:getNewestRuneEffect()
 *  Notes   :
 ************************************************************************/

uint16 CLuaBaseEntity::getNewestRuneEffect()
{
    auto* PEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PEntity)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return PEntity->StatusEffectContainer->GetNewestRuneEffect();
}

/************************************************************************
 *  Function: removeOldestRune()
 *  Purpose : Removes the oldest rune (if available)
 *  Example : player:removeOldestRune()
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::removeOldestRune()
{
    auto* PEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PEntity)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    PEntity->StatusEffectContainer->RemoveOldestRune();
}

/************************************************************************
 *  Function: removeNewestRune()
 *  Purpose : Removes the newest rune (if available)
 *  Example : player:removeNewestRune()
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::removeNewestRune()
{
    auto* PEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PEntity)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    PEntity->StatusEffectContainer->RemoveNewestRune();
}

/************************************************************************
 *  Function: removeAllRunes()
 *  Purpose : Removes all runes (if available)
 *  Example : player:removeAllRunes()
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::removeAllRunes()
{
    auto* PEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PEntity)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return;
    }

    PEntity->StatusEffectContainer->RemoveAllRunes();
}

/************************************************************************
 *  Function: setMobLevel()
 *  Purpose : Updates the monsters level and recalculates stats
 *  Example : mob:setMobLevel(125)
 *  Notes   : CalculateStats will refill mobs hp/mp as well
 ************************************************************************/

void CLuaBaseEntity::setMobLevel(uint8 level)
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to set mob level for invalid entity type (%s, %d).", m_PBaseEntity->getName(), level);
        return;
    }

    if (auto* PMob = dynamic_cast<CMobEntity*>(m_PBaseEntity))
    {
        PMob->SetMLevel(level);
        PMob->SetSLevel(level);

        // Remove traits, because they were calculated in the previous CalculateMobStats and are NOT saved, so they must be recalculated.
        PMob->TraitList.clear();

        mobutils::CalculateMobStats(PMob);
        mobutils::GetAvailableSpells(PMob);
    }
}

/************************************************************************
 *  Function: getEcosystem()
 *  Purpose : Returns integer value of system associated with an Entity
 *  Example : if pet:getEcosystem() ~= xi.ecosystem.AVATAR then -- Not an avatar
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getEcosystem()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);
    return static_cast<uint8>(PBattle->m_EcoSystem);
}

/************************************************************************
 *  Function: getSuperFamily()
 *  Purpose : Returns the integer value of the associated Mob SuperFamily
 *  Example : if mob:getSuperFamily() == 123 then
 *  Notes   : To Do: Enumerate Mob Families in global script
 ************************************************************************/

uint16 CLuaBaseEntity::getSuperFamily()
{
    auto* entity = dynamic_cast<CMobEntity*>(m_PBaseEntity);

    if (!entity)
    {
        ShowWarning("CLuaBaseEntity::getSuperFamily() -  m_pBaseEntity is not a Mob.");
        return 0;
    }

    return entity->m_SuperFamily;
}

/************************************************************************
 *  Function: getFamily()
 *  Purpose : Returns the integer value of the associated Mob Family
 *  Example : if mob:getFamily() == 123 then
 *  Notes   : To Do: Enumerate Mob Families in global script
 ************************************************************************/

uint16 CLuaBaseEntity::getFamily()
{
    auto* entity = dynamic_cast<CMobEntity*>(m_PBaseEntity);

    if (!entity)
    {
        ShowWarning("CLuaBaseEntity::getFamily() -  m_pBaseEntity is not a Mob.");
        return 0;
    }

    return entity->m_Family;
}

/************************************************************************
 *  Function: isMobType()
 *  Purpose : Returns true if a Mob is of a specified type (if !Mob->false)
 *  Example : if mob:isMobType(MOBTYPE_NOTORIOUS) then
 *  Notes   : Oddly, this is only being used to check if Mob is NM...?
 *  Notes   : To Do: This isn't the intended function for NM checks...
 ************************************************************************/

bool CLuaBaseEntity::isMobType(uint8 mobType)
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        return false;
    }

    CMobEntity* PMob = static_cast<CMobEntity*>(m_PBaseEntity);

    return PMob->m_Type & mobType;
}

/************************************************************************
 *  Function: isUndead()
 *  Purpose : Returns true if Entity is Undead
 *  Example : if target:isUndead() then
 ************************************************************************/

bool CLuaBaseEntity::isUndead()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return false;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->m_EcoSystem == ECOSYSTEM::UNDEAD;
}

/************************************************************************
 *  Function: isNM()
 *  Purpose : Returns true if Mob is a Notorious Monster
 *  Example : if mob:isNM() then
 ************************************************************************/

bool CLuaBaseEntity::isNM()
{
    if (m_PBaseEntity->objtype == TYPE_MOB && static_cast<CMobEntity*>(m_PBaseEntity)->m_Type & MOBTYPE_NOTORIOUS)
    {
        return true;
    }

    return false;
}

/************************************************************************
 *  Function: getModelSize()
 *  Purpose : Returns the Model Size of the entity
 *  Example : local size = mob:getModelSize()
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getModelSize()
{
    auto* PEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PEntity)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return PEntity->m_ModelRadius;
}

/************************************************************************
 *  Function: getMeleeRange()
 *  Purpose : Returns the melee range of the entity
 *  Example : distance(player, mob) > mob:getMeleeRange()
 *  Notes   :
 ************************************************************************/

float CLuaBaseEntity::getMeleeRange()
{
    auto* PEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PEntity)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return PEntity->GetMeleeRange();
}

/************************************************************************
 *  Function: setMeleeRange()
 *  Purpose : Sets the maximum melee range for a mob
 *  Example : mob:setMeleeRange(12.0)
 *  Notes   : This affects the distance players can hit the mob from
 ************************************************************************/
void CLuaBaseEntity::setMeleeRange(float range)
{
    // Only valid for mobs
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempt to set melee range for non-mob entity (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PMob = static_cast<CMobEntity*>(m_PBaseEntity);

    // Ensure that the cast to MobEntity worked properly and we dont have a NULL PTR
    if (!PMob)
    {
        ShowWarning("Error casting to CMobEntity in CLuaBaseEntity::setMeleeRange()");
        return;
    }

    // Account for zero/negative values and set to default melee range value
    if (range < 3.0f)
    {
        range = 3.0f;
    }
    else
    {
        // Ensure that the range has a precision of .1
        range = ((float)((int)(range * 10))) / 10;
    }

    // Update the melee range
    PMob->m_ModelRadius = range;

    return;
}

/************************************************************************
 *  Function: setMobFlags()
 *  Purpose : Manually set Mob flags
 *  Example : player:setMobFlags(flags, targ:getID())
 *  Example : mob:setMobFlags(flags)
 *  Notes   : Used for changing Ul'xzomit babies' size and through !setmobflags command
 ************************************************************************/

void CLuaBaseEntity::setMobFlags(uint32 flags, sol::object const& mobId)
{
    if (m_PBaseEntity->objtype != TYPE_MOB && m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Attempt to set Mob Flags for invalid entity (%s)", m_PBaseEntity->getName());
        return;
    }

    if (mobId != sol::lua_nil)
    {
        auto* PMob = static_cast<CMobEntity*>(zoneutils::GetEntity(mobId.as<uint32>(), TYPE_MOB));
        if (PMob == nullptr)
        {
            ShowError("Could not find a monster with id %u to use for setMobFlags.", mobId.as<uint32>());
            return;
        }
        PMob->setEntityFlags(flags);
        PMob->updatemask |= UPDATE_HP;
    }
    else if (m_PBaseEntity->objtype == TYPE_MOB)
    {
        auto* PMob = static_cast<CMobEntity*>(m_PBaseEntity);
        PMob->setEntityFlags(flags);
        PMob->updatemask |= UPDATE_HP;
    }
    else
    {
        auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
        auto* PMob  = static_cast<CMobEntity*>(PChar->GetEntity(PChar->m_TargID, TYPE_MOB));

        if (PMob == nullptr)
        {
            ShowError("Must target a monster to use for setMobFlags ");
            return;
        }

        PMob->setEntityFlags(flags);
        PMob->updatemask |= UPDATE_HP;
    }
}

/************************************************************************
 *  Function: getMobFlags()
 *  Purpose : Get Mob flags
 *  Example : Not in use in scripts
 *  Notes   : Currently only used through !getMobFlags command
 ************************************************************************/
uint32 CLuaBaseEntity::getMobFlags()
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to get mob flags for invalid entity type (%s).", m_PBaseEntity->getName());
        return 0;
    }

    if (auto* PMob = dynamic_cast<CMobEntity*>(m_PBaseEntity))
    {
        return PMob->getEntityFlags();
    }

    return 0;
}

/************************************************************************
 *  Function: setNpcFlags()
 *  Purpose : Manually set NPC Entity Flags
 *  Example : npc:setNpcFlags(1)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setNpcFlags(uint32 flags)
{
    if (m_PBaseEntity->objtype != TYPE_NPC)
    {
        return;
    }

    auto* PNpc = static_cast<CNpcEntity*>(m_PBaseEntity);

    if (PNpc != nullptr)
    {
        PNpc->setEntityFlags(flags);
        PNpc->updatemask |= UPDATE_HP;
    }
}

/************************************************************************
 *  Function: spawn()
 *  Purpose : Forces a mob to spawn with optional Despawn/Respawn values
 *  Example : mob:spawn(60,3600); mob:spawn()
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::spawn(sol::object const& despawnSec, sol::object const& respawnSec)
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to spawn invalid entity type (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PMob = static_cast<CMobEntity*>(m_PBaseEntity);

    if (despawnSec != sol::lua_nil)
    {
        PMob->SetDespawnTime(std::chrono::seconds(despawnSec.as<uint32>()));
    }

    if (respawnSec != sol::lua_nil)
    {
        PMob->m_RespawnTime  = respawnSec.as<uint32>() * 1000;
        PMob->m_AllowRespawn = true;
    }
    else
    {
        if (!PMob->PAI->IsSpawned())
        {
            PMob->Spawn();
        }
        else
        {
            ShowDebug("SpawnMob: %u <%s> is already spawned", PMob->id, PMob->getName());
        }
    }
}

/************************************************************************
 *  Function: isSpawned()
 *  Purpose : Returns true if a Mob or NPC is spawned or visible
 *  Example : if mob:isSpawned() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isSpawned()
{
    CMobEntity* PMobEntity = dynamic_cast<CMobEntity*>(m_PBaseEntity);

    if (PMobEntity)
    {
        return static_cast<CMobEntity*>(m_PBaseEntity)->PAI->IsSpawned();
    }
    else if (CNpcEntity* PNpcEntity = dynamic_cast<CNpcEntity*>(m_PBaseEntity))
    {
        return PNpcEntity->status != STATUS_TYPE::DISAPPEAR;
    }
    else
    {
        ShowError("CLuaBaseEntity::isSpawned() called on entity that is not a CMobEntity or CNpcEntity.");
    }
    return false;
}

/************************************************************************
 *  Function: getSpawnPos()
 *  Purpose : Returns the spawn position for a Mob in a Lua table
 *  Example : local spawn = mob:getSpawnPos()
 *  Notes   : x = spawn.x; y = spawn.y, etc
 ************************************************************************/

auto CLuaBaseEntity::getSpawnPos() -> sol::table
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Calling entity is not a Mob (%s).", m_PBaseEntity->getName());
        return {};
    }

    auto* PMob = static_cast<CMobEntity*>(m_PBaseEntity);
    auto  pos  = lua.create_table();

    pos["x"]   = PMob->m_SpawnPoint.x;
    pos["y"]   = PMob->m_SpawnPoint.y;
    pos["z"]   = PMob->m_SpawnPoint.z;
    pos["rot"] = PMob->m_SpawnPoint.rotation;

    return pos;
}

/************************************************************************
 *  Function: setSpawn()
 *  Purpose : Manually set the next spawn position for a Mob
 *  Example : mob:setSpawn(-100,243,0,123)
 *  Notes   : Removed table support.  Unpack!
 ************************************************************************/

void CLuaBaseEntity::setSpawn(float x, float y, float z, sol::object const& rot)
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to set spawn for invalid entity type (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PMob = static_cast<CMobEntity*>(m_PBaseEntity);

    PMob->m_SpawnPoint.x        = x;
    PMob->m_SpawnPoint.y        = y;
    PMob->m_SpawnPoint.z        = z;
    PMob->m_SpawnPoint.rotation = (rot != sol::lua_nil) ? rot.as<uint8>() : 0;
}

/************************************************************************
 *  Function: getRespawnTime()
 *  Purpose : Returns the remaining respawn time for a Mob
 *  Example : if nm:getRespawnTime() == 0 then
 *  Notes   : Used in mobs.lua...and directly in Charybdis
 ************************************************************************/

uint32 CLuaBaseEntity::getRespawnTime()
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to get respawn time for invalid entity type (%s).", m_PBaseEntity->getName());
        return 0;
    }

    CMobEntity* PMob = static_cast<CMobEntity*>(m_PBaseEntity);

    if (PMob->m_AllowRespawn)
    {
        return PMob->m_RespawnTime;
    }

    return 0;
}

/************************************************************************
 *  Function: setRespawnTime()
 *  Purpose : Setting the respawn time for a Mob
 *  Example : mob:setRespawnTime(math.random(3600, 7200))
 *  Notes   : Haven't seen the second argument option being used
 *
 * Note: Removed optional (and unused) parameter 2:
 *      if (!lua_isnil(L, 2) && lua_isboolean(L, 2) && lua_toboolean(L, 2))
        { // set optional parameter to true to only modify the timer
            return 0;
        }
 ************************************************************************/

void CLuaBaseEntity::setRespawnTime(uint32 seconds)
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to set respawn time for invalid entity type (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PMob = static_cast<CMobEntity*>(m_PBaseEntity);

    PMob->m_RespawnTime = seconds * 1000;
    if (PMob->PAI->IsCurrentState<CRespawnState>())
    {
        PMob->PAI->GetCurrentState()->ResetEntryTime();
    }

    PMob->m_AllowRespawn = true;
}

/************************************************************************
 *  Function: instantiateMob()
 *  Purpose : Used for spawning a new mob - is this for Monstrosity prep?
 *  Example : None available
 *  Notes   : Not currently implemented
 ************************************************************************/

void CLuaBaseEntity::instantiateMob(uint32 groupID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    CMobEntity* newMob = mobutils::InstantiateAlly(groupID, m_PBaseEntity->getZone());

    newMob->loc.p        = m_PBaseEntity->loc.p;
    newMob->m_SpawnPoint = newMob->loc.p;
    newMob->Spawn();
}

/************************************************************************
 *  Function: hasTrait()
 *  Purpose : Returns true if a battle entity has an active trait
 *  Example : if target:hasTrait(15) then -- Double Attack
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::hasTrait(uint16 traitID)
{
    CBattleEntity* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (PBattleEntity)
    {
        return PBattleEntity->hasTrait(traitID);
    }

    return false;
}

/************************************************************************
 *  Function: hasImmunity()
 *  Purpose : Returns true if a Mob is immune to a specified type of spell
 *  Example : if target:hasImmunity(64) then
 *  Notes   : Arguments are dec to bin, so powers of 2 (max 256) -- Listed in mobentity.h
 ************************************************************************/

bool CLuaBaseEntity::hasImmunity(uint32 immunityID)
{
    auto* PEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PEntity)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return false;
    }

    return PEntity->hasImmunity(immunityID);
}

/************************************************************************
 *  Function: addImmunity()
 *  Purpose : Adds any immunity
 *  Example : mob:addImmunity(xi.immunity.SILENCE)
 ************************************************************************/

void CLuaBaseEntity::addImmunity(uint32 immunityID)
{
    auto PEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (PEntity)
    {
        PEntity->m_Immunity |= immunityID;
    }
}

/************************************************************************
 *  Function: delImmunity()
 *  Purpose : Delete any immunity
 *  Example : mob:delImmunity(xi.immunity.SILENCE)
 ************************************************************************/

void CLuaBaseEntity::delImmunity(uint32 immunityID)
{
    auto PEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (PEntity)
    {
        PEntity->m_Immunity &= ~immunityID;
    }
}

/************************************************************************
 *  Function: setAggressive()
 *  Purpose : Toggle a Mob to an aggressive or passive state
 *  Example : mob:setAggressive(true)
 ************************************************************************/

void CLuaBaseEntity::setAggressive(bool aggressive)
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to set aggressive for invalid entity type (%s).", m_PBaseEntity->getName());
        return;
    }

    static_cast<CMobEntity*>(m_PBaseEntity)->m_Aggro = aggressive;
}

/************************************************************************
 *  Function: setTrueDetection()
 *  Purpose : Toggle True Detection on or off for a Mob
 *  Example : mob:setTrueDetection(true)
 ************************************************************************/

void CLuaBaseEntity::setTrueDetection(bool truedetection)
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to set true detection for invalid entity type (%s).", m_PBaseEntity->getName());
        return;
    }

    static_cast<CMobEntity*>(m_PBaseEntity)->m_TrueDetection = truedetection;
}

/************************************************************************
 *  Function: setUnkillable()
 *  Purpose : Set a Mob to unkillable or not
 *  Example : mob:setUnkillable(true)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setUnkillable(bool unkillable)
{
    if (auto* PBattle = dynamic_cast<CBattleEntity*>(m_PBaseEntity))
    {
        PBattle->m_unkillable = unkillable;
    }
}

/************************************************************************
 *  Function: setUntargetable()
 *  Purpose : Sets a target's untargetable flag.
 *  Example : target:setUntargetable(true)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setUntargetable(bool untargetable)
{
    if (m_PBaseEntity->objtype != TYPE_MOB && m_PBaseEntity->objtype != TYPE_NPC)
    {
        ShowWarning("Attempt to set untargetable for invalid entity (%s)", m_PBaseEntity->getName());
        return;
    }

    if (m_PBaseEntity->objtype == TYPE_MOB)
    {
        static_cast<CMobEntity*>(m_PBaseEntity)->SetUntargetable(untargetable);
    }
    else if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        static_cast<CNpcEntity*>(m_PBaseEntity)->SetUntargetable(untargetable);
    }

    m_PBaseEntity->updatemask |= UPDATE_HP;
}

/************************************************************************
 *  Function: getUntargetable()
 *  Purpose : Returns true if a Mob or NPC is setUntargetable (Not True)
 *  Example : if target:setUntargetable() then
 *  Notes   : This does not return a value, but instead sets state!
 ************************************************************************/

bool CLuaBaseEntity::getUntargetable()
{
    if (m_PBaseEntity->objtype != TYPE_MOB && m_PBaseEntity->objtype != TYPE_NPC)
    {
        ShowWarning("Attempt to get untargetable for invalid entity (%s)", m_PBaseEntity->getName());
        return false;
    }

    if (m_PBaseEntity->objtype == TYPE_MOB)
    {
        return static_cast<CMobEntity*>(m_PBaseEntity)->GetUntargetable();
    }
    else if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        return static_cast<CNpcEntity*>(m_PBaseEntity)->GetUntargetable();
    }

    return false;
}

/************************************************************************
 *  Function: setIsAggroable()
 *  Purpose : Sets is a mob can be aggroed by other mobs. Requires it to be in the player allegiance.
 *  Example : target:isAggroable(true)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setIsAggroable(bool isAggroable)
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to set is Aggroable for invalid entity type (%s).", m_PBaseEntity->getName());
        return;
    }

    static_cast<CMobEntity*>(m_PBaseEntity)->m_isAggroable = isAggroable;
}

/************************************************************************
 *  Function: IsAggroable()
 *  Purpose : Returns true if a Mob can be aggroed
 *  Example : if target:isAggroable() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isAggroable()
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to get is aggroable for invalid entity type (%s).", m_PBaseEntity->getName());
        return false;
    }

    return static_cast<CMobEntity*>(m_PBaseEntity)->m_isAggroable;
}

/************************************************************************
 *  Function: setDelay()
 *  Purpose : Override default delay settings for a Mob
 *  Example : mob:setDelay(2400)
 ************************************************************************/

void CLuaBaseEntity::setDelay(uint16 delay)
{
    if (!(m_PBaseEntity->objtype & TYPE_MOB))
    {
        ShowError("function call on invalid entity! (name: %s type: %d)", m_PBaseEntity->name, m_PBaseEntity->objtype);
        return;
    }

    auto* PMobEntity = static_cast<CMobEntity*>(m_PBaseEntity);
    if (auto* PItemWeapon = dynamic_cast<CItemWeapon*>(PMobEntity->m_Weapons[SLOT_MAIN]))
    {
        PItemWeapon->setDelay(delay);
    }
}

/************************************************************************
 *  Function: setDamage()
 *  Purpose : Override default damage settings for a Mob
 *  Example : mob:setDamage(40)
 ************************************************************************/

void CLuaBaseEntity::setDamage(uint16 damage)
{
    if (!(m_PBaseEntity->objtype & TYPE_MOB))
    {
        ShowError("function call on invalid entity! (name: %s type: %d)", m_PBaseEntity->name, m_PBaseEntity->objtype);
        return;
    }

    auto* PMobEntity = static_cast<CMobEntity*>(m_PBaseEntity);
    if (auto* PItemWeapon = dynamic_cast<CItemWeapon*>(PMobEntity->m_Weapons[SLOT_MAIN]))
    {
        PItemWeapon->setDamage(damage);
    }
}

/************************************************************************
 *  Function: hasSpellList()
 *  Purpose : Returns true if a Mob has spells to cast
 *  Example : if mob:hasSpellList() then
 ************************************************************************/

bool CLuaBaseEntity::hasSpellList()
{
    if (m_PBaseEntity->objtype & TYPE_NPC || m_PBaseEntity->objtype & TYPE_PC)
    {
        ShowError("function call on invalid entity! (name: %s type: %d)", m_PBaseEntity->name, m_PBaseEntity->objtype);
        return false;
    }

    return static_cast<CMobEntity*>(m_PBaseEntity)->SpellContainer->HasSpells();
}

/************************************************************************
 *  Function: setSpellList()
 *  Purpose : Specify a spell list for a Mob to use
 *  Example : mob:setSpellList(118 + DayOfTheWeek)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setSpellList(uint16 spellList)
{
    if (m_PBaseEntity->objtype & TYPE_NPC || m_PBaseEntity->objtype & TYPE_PC)
    {
        ShowError("function call on invalid entity! (name: %s type: %d)", m_PBaseEntity->name, m_PBaseEntity->objtype);
        return;
    }

    mobutils::SetSpellList(static_cast<CMobEntity*>(m_PBaseEntity), spellList);
}

/************************************************************************
 *  Function: setAutoAttackEnabled()
 *  Purpose : Enables/disabled auto-attack for a Mob
 *  Example : mob:setAutoAttackEnabled(false)
 *  Notes   : See scripts/zones/Throne_Room/mobs/Shadow_Lord.lua
 ************************************************************************/

void CLuaBaseEntity::setAutoAttackEnabled(bool state)
{
    if (m_PBaseEntity->objtype & TYPE_NPC || m_PBaseEntity->objtype & TYPE_PC)
    {
        ShowError("function call on invalid entity! (name: %s type: %d)", m_PBaseEntity->name, m_PBaseEntity->objtype);
        return;
    }

    m_PBaseEntity->PAI->GetController()->SetAutoAttackEnabled(state);
}

/************************************************************************
 *  Function: setMagicCastingEnabled()
 *  Purpose : Used to enable/disable the casting of spells for a Mob
 *  Example : mob:setMagicCastingEnabled(false)
 *  Notes   : Used primarily for Mob behavior and battle control
 ************************************************************************/

void CLuaBaseEntity::setMagicCastingEnabled(bool state)
{
    if (m_PBaseEntity->objtype & TYPE_NPC || m_PBaseEntity->objtype & TYPE_PC)
    {
        ShowError("function call on invalid entity! (name: %s type: %d)", m_PBaseEntity->name, m_PBaseEntity->objtype);
        return;
    }

    m_PBaseEntity->PAI->GetController()->SetMagicCastingEnabled(state);
}

/************************************************************************
 *  Function: setMobAbilityEnabled()
 *  Purpose : Used primarily to clear queue for special ability to be used
 *  Example : mob:setMobAbilityEnabled(false)
 *  Notes   : See Bahamut.lua
 ************************************************************************/

void CLuaBaseEntity::setMobAbilityEnabled(bool state)
{
    if (m_PBaseEntity->objtype & TYPE_NPC || m_PBaseEntity->objtype & TYPE_PC)
    {
        ShowError("function call on invalid entity! (name: %s type: %d)", m_PBaseEntity->name, m_PBaseEntity->objtype);
        return;
    }

    m_PBaseEntity->PAI->GetController()->SetWeaponSkillEnabled(state);
}

/************************************************************************
 *  Function: setMobSkillAttack()
 *  Purpose : Used mainly so Mobs don't respawn in flight?
 *  Example : mob:setMobSkillAttack(0)
 *  Notes   : Used in Ouryu, Jormungand, Tiamat, etc
 ************************************************************************/

void CLuaBaseEntity::setMobSkillAttack(int16 listId)
{
    if (m_PBaseEntity->objtype & TYPE_NPC || m_PBaseEntity->objtype & TYPE_PC)
    {
        ShowError("function call on invalid entity! (name: %s type: %d)", m_PBaseEntity->name, m_PBaseEntity->objtype);
        return;
    }

    static_cast<CMobEntity*>(m_PBaseEntity)->setMobMod(MOBMOD_ATTACK_SKILL_LIST, listId);
}

/************************************************************************
 *  Function: getMobMod()
 *  Purpose : Returns the power value of a Mob Mod in effect
 *  Example : mob:getMobMod(xi.mobMod.MUG_GIL)
 *  Notes   :
 ************************************************************************/

int16 CLuaBaseEntity::getMobMod(uint16 mobModID)
{
    if (m_PBaseEntity->objtype & TYPE_NPC || m_PBaseEntity->objtype & TYPE_PC)
    {
        ShowError("function call on invalid entity! (name: %s type: %d)", m_PBaseEntity->name, m_PBaseEntity->objtype);
        return MOBMOD_NONE;
    }

    return static_cast<CMobEntity*>(m_PBaseEntity)->getMobMod(mobModID);
}

/************************************************************************
 *  Function: addMobMod()
 *  Purpose : Applies a Mob Mod with a specified amount
 *  Example : mob:addMobMod(xi.mobMod.MUG_GIL, 100)
 *  Notes   : Currently not being used in any script
 ************************************************************************/

void CLuaBaseEntity::addMobMod(uint16 mobModID, int16 value)
{
    if (m_PBaseEntity->objtype & TYPE_NPC || m_PBaseEntity->objtype & TYPE_PC)
    {
        ShowError("function call on invalid entity! (name: %s type: %d)", m_PBaseEntity->name, m_PBaseEntity->objtype);
        return;
    }

    static_cast<CMobEntity*>(m_PBaseEntity)->addMobMod(mobModID, value);
}

/************************************************************************
 *  Function: setMobMod()
 *  Purpose : Applies a Mob Mod of a specified magnitude
 *  Example : mob:setMobMod(xi.mobMod.MUG_GIL, 100)
 *  Notes   : Interesting note - this is being used for superlinking too
 ************************************************************************/

void CLuaBaseEntity::setMobMod(uint16 mobModID, int16 value)
{
    if (m_PBaseEntity->objtype & TYPE_NPC || m_PBaseEntity->objtype & TYPE_PC)
    {
        ShowError("function call on invalid entity! (name: %s type: %d)", m_PBaseEntity->name, m_PBaseEntity->objtype);
        return;
    }

    static_cast<CMobEntity*>(m_PBaseEntity)->setMobMod(mobModID, value);
}

/************************************************************************
 *  Function: delMobMod()
 *  Purpose : Removes a Mob Mod
 *  Example : mob:delMobMod(xi.mobMod.MUG_GIL, 100)
 *  Notes   : Currently not being used in any script
 ************************************************************************/

void CLuaBaseEntity::delMobMod(uint16 mobModID, int16 value)
{
    if (m_PBaseEntity->objtype & TYPE_NPC || m_PBaseEntity->objtype & TYPE_PC)
    {
        ShowError("function call on invalid entity! (name: %s type: %d)", m_PBaseEntity->name, m_PBaseEntity->objtype);
        return;
    }

    static_cast<CMobEntity*>(m_PBaseEntity)->addMobMod(mobModID, -value);
}

/************************************************************************
 *  Function: getBattleTime()
 *  Purpose : Returns the time the Mob has been engaged in seconds
 *  Example : if mob:getBattleTime() == 3600 then -- 1 Hour
 *  Notes   :
 ************************************************************************/

uint32 CLuaBaseEntity::getBattleTime()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<uint32>(std::chrono::duration_cast<std::chrono::seconds>(((CBattleEntity*)m_PBaseEntity)->GetBattleTime()).count());
}

/************************************************************************
 *  Function: getBehavior()
 *  Purpose : Returns the current Mob behavior
 *  Example : mob:getBehavior()
 *  Notes   : Currently used in bitwise calculations for high-tier NM's
 ************************************************************************/

uint16 CLuaBaseEntity::getBehavior()
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to get behavior for invalid entity type (%s).", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CMobEntity*>(m_PBaseEntity)->m_Behavior;
}

/************************************************************************
 *  Function: setBehavior()
 *  Purpose : Sets a particular behavior for a Mob
 *  Example : mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
 *  Notes   : Currently used in bitwise calculations for high-tier NM's
 ************************************************************************/

void CLuaBaseEntity::setBehavior(uint16 behavior)
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to set behavior for invalid entity type (%s).", m_PBaseEntity->getName());
        return;
    }

    static_cast<CMobEntity*>(m_PBaseEntity)->m_Behavior = behavior;
}

/************************************************************************
 *  Function: getLink()
 *  Purpose : Returns if the current Mob can link or not
 *  Example : mob:getLink()
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getLink()
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to get link for invalid entity type (%s).", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CMobEntity*>(m_PBaseEntity)->m_Link;
}

/************************************************************************
 *  Function: setLink()
 *  Purpose : Sets whether the mob can link or not
 *  Example : mob:setLink(1)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setLink(uint8 link)
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to set link for invalid entity type (%s).", m_PBaseEntity->getName());
        return;
    }

    static_cast<CMobEntity*>(m_PBaseEntity)->m_Link = link;
}

/************************************************************************
 *  Function: getRoamFlags()
 *  Purpose : Returns the current mob roam flags
 *  Example : mob:getRoamFlags()
 ************************************************************************/

uint16 CLuaBaseEntity::getRoamFlags()
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to get roam flags for invalid entity type (%s).", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CMobEntity*>(m_PBaseEntity)->m_roamFlags;
}

/************************************************************************
 *  Function: setRoamFlags()
 *  Purpose : Sets roam flags for a mob
 *  Example : mob:setRoamFlags(bit.bor(mob:getRoamFlags(), xi.roamFlag.STEALTH))
 ************************************************************************/

void CLuaBaseEntity::setRoamFlags(uint16 newRoamFlags)
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to set roam flags for invalid entity type (%s).", m_PBaseEntity->getName());
        return;
    }

    static_cast<CMobEntity*>(m_PBaseEntity)->m_roamFlags = newRoamFlags;
}

/************************************************************************
 *  Function: getTarget()
 *  Purpose : Return Battle Target entity
 *  Example : mob:getTarget(); pet:getTarget(); if not v:getTarget() then
 *  Notes   :
 ************************************************************************/

std::optional<CLuaBaseEntity> CLuaBaseEntity::getTarget()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return std::nullopt;
    }

    auto* PBattleTarget{ m_PBaseEntity->GetEntity(static_cast<CBattleEntity*>(m_PBaseEntity)->GetBattleTargetID()) };

    if (PBattleTarget)
    {
        return std::optional<CLuaBaseEntity>(PBattleTarget);
    }

    return std::nullopt;
}

/************************************************************************
 *  Function: updateTarget()
 *  Purpose : Direct's Mob's attention to the PC with highest Enmity
 *  Example : mob:updateTarget()
 *  Notes   : Not in scripts, but can be called to force an Enmity check?
 ************************************************************************/

void CLuaBaseEntity::updateTarget()
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to update target for invalid entity type (%s).", m_PBaseEntity->getName());
        return;
    }

    auto*          PMobEntity = static_cast<CMobEntity*>(m_PBaseEntity);
    CBattleEntity* PTarget    = PMobEntity->PEnmityContainer->GetHighestEnmity();

    if (PTarget)
    {
        PMobEntity->PAI->ChangeTarget(PTarget->targid);
    }
}

/************************************************************************
 *  Function: getEnmityList()
 *  Purpose : Returns a Lua table list of PC's with active enmity
 *  Example : local targets = mob:getEnmityList()
 *  Notes   : Used in Tame and special Mob abilities
 ************************************************************************/

sol::table CLuaBaseEntity::getEnmityList()
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to get enmity list for invalid entity type (%s).", m_PBaseEntity->getName());
        return sol::lua_nil;
    }

    EnmityList_t* enmityList = ((CMobEntity*)m_PBaseEntity)->PEnmityContainer->GetEnmityList();

    if (enmityList)
    {
        auto table = lua.create_table();
        for (auto const& member : *enmityList)
        {
            if (member.second.PEnmityOwner)
            {
                auto subTable = lua.create_table();

                subTable["entity"]   = CLuaBaseEntity(member.second.PEnmityOwner);
                subTable["ce"]       = member.second.CE;
                subTable["ve"]       = member.second.VE;
                subTable["active"]   = member.second.active;
                subTable["tameable"] = ((CMobEntity*)m_PBaseEntity)->PEnmityContainer->IsTameable();

                table.add(subTable);
            }
        }

        return table;
    }

    return {};
}

/************************************************************************
 *  Function: getTrickAttackChar()
 *  Purpose : Returns the character who is eligible for Trick Attack to be applied against
 *  Example : local taChar = player:getTrickAttackChar(target)
 *  Notes   : For some reason, only used in Jump/High-Jump?
 ************************************************************************/

std::optional<CLuaBaseEntity> CLuaBaseEntity::getTrickAttackChar(CLuaBaseEntity* PLuaBaseEntity)
{
    if (CBattleEntity* PMob = dynamic_cast<CBattleEntity*>(PLuaBaseEntity->GetBaseEntity()))
    {
        CBattleEntity* taTarget = battleutils::getAvailableTrickAttackChar((CBattleEntity*)m_PBaseEntity, PMob);
        if (taTarget)
        {
            return std::optional<CLuaBaseEntity>(taTarget);
        }
    }

    return std::nullopt;
}

/************************************************************************
 *  Function: actionQueueEmpty()
 *  Purpose : Returns true if a Mob's action queue is empty
 *  Example : if mob:actionQueueEmpty() then
 *  Notes   : See: scripts/zones/Temenos/mobs/Proto-Ultima.lua
 ************************************************************************/

bool CLuaBaseEntity::actionQueueEmpty()
{
    return m_PBaseEntity->PAI->QueueEmpty();
}

/************************************************************************
 *  Function: castSpell()
 *  Purpose : Prompts an NPC or Mob entity to cast a specified spell
 *  Example : mob:castSpell(spell)
 *  Notes   : Currently only used by a few select mobs
 ************************************************************************/

void CLuaBaseEntity::castSpell(sol::object const& spell, sol::object const& entity)
{
    if (spell != sol::lua_nil)
    {
        SpellID spellid = spell.as<SpellID>();
        uint16  targid  = 0;

        if (entity != sol::lua_nil)
        {
            CLuaBaseEntity* PLuaBaseEntity = entity.as<CLuaBaseEntity*>();
            if (PLuaBaseEntity->m_PBaseEntity)
            {
                targid = PLuaBaseEntity->m_PBaseEntity->targid;
            }
        }

        // clang-format off
        m_PBaseEntity->PAI->QueueAction(queueAction_t(0ms, true,
        [targid, spellid](auto PEntity)
        {
            CMobEntity* PMobEntity = dynamic_cast<CMobEntity*>(PEntity);

            // Always delete recast of spell if mob
            if (PMobEntity)
            {
                PMobEntity->PRecastContainer->Del(RECAST_MAGIC, static_cast<uint16>(spellid));
            }

            if (targid)
            {
                PEntity->PAI->Cast(targid, spellid);
            }
            else if (PMobEntity)
            {
                PEntity->PAI->Cast(PMobEntity->GetBattleTargetID(), spellid);
            }
        }));
        // clang-format on
    }
    else
    {
        // clang-format off
        m_PBaseEntity->PAI->QueueAction(queueAction_t(0ms, true,
        [](auto PEntity)
        {
            if (dynamic_cast<CMobEntity*>(PEntity))
            {
                static_cast<CMobController*>(PEntity->PAI->GetController())->TryCastSpell();
            }
        }));
        // clang-format on
    }
}

/************************************************************************
 *  Function: useJobAbility()
 *  Purpose : Instruct a Mob to use a specified Job Ability
 *  Example : wyvern:useJobAbility(xi.jobAbility.SUPER_CLIMB, wyvern) -- Specifying pet to use
 *  Notes   : Inserts directly into queue stack with 0ms delay,
 *  and checks queue for immediate use.
 ************************************************************************/

void CLuaBaseEntity::useJobAbility(uint16 skillID, sol::object const& pet)
{
    CBattleEntity* PTarget{ nullptr };

    if ((pet != sol::lua_nil) && pet.is<CLuaBaseEntity*>())
    {
        CLuaBaseEntity* PLuaBaseEntity = pet.as<CLuaBaseEntity*>();
        PTarget                        = static_cast<CBattleEntity*>(PLuaBaseEntity->m_PBaseEntity);
    }

    // clang-format off
    m_PBaseEntity->PAI->QueueAction(queueAction_t(0ms, true, [PTarget, skillID](auto PEntity)
    {
        if (PTarget)
        {
            PEntity->PAI->Ability(PTarget->targid, skillID);
        }
        else if (dynamic_cast<CMobEntity*>(PEntity))
        {
            PEntity->PAI->Ability(static_cast<CMobEntity*>(PEntity)->GetBattleTargetID(), skillID);
        }
    }));
    // clang-format on

    // Check queue immediately in case of 0 ms delay abilities
    m_PBaseEntity->PAI->checkQueueImmediately();
}

/************************************************************************
 *  Function: useMobAbility()
 *  Purpose : Uses a specified Mob Ability or the next one ready in the que
 *  Example : automation:useMobAbility(2132, automation) --Specifying pet
 *  Notes   : Use single variable (Ability ID only) for base entity only
 ************************************************************************/

void CLuaBaseEntity::useMobAbility(sol::variadic_args va)
{
    if (m_PBaseEntity->objtype != TYPE_TRUST && m_PBaseEntity->objtype != TYPE_MOB && m_PBaseEntity->objtype != TYPE_PET)
    {
        ShowWarning("Entity is not a Trust, Mob, or Pet (%s).", m_PBaseEntity->getName());
        return;
    }

    if (va.size() == 0)
    {
        // clang-format off
        m_PBaseEntity->PAI->QueueAction(queueAction_t(0ms, true, [](auto PEntity)
        {
            if (dynamic_cast<CMobEntity*>(PEntity))
            {
                static_cast<CMobController*>(PEntity->PAI->GetController())->MobSkill();
            }
        }));
        // clang-format on
        return;
    }

    auto           skillid{ va.get<uint16>(0) };
    CBattleEntity* PTarget{ nullptr };
    auto*          PMobSkill{ battleutils::GetMobSkill(skillid) };

    if (!PMobSkill)
    {
        return;
    }

    if (va.size() == 2)
    {
        CLuaBaseEntity* PLuaBaseEntity = va.get<CLuaBaseEntity*>(1);
        PTarget                        = PLuaBaseEntity ? (CBattleEntity*)PLuaBaseEntity->m_PBaseEntity : nullptr;
    }

    // clang-format off
    m_PBaseEntity->PAI->QueueAction(queueAction_t(0ms, true, [PTarget, skillid, PMobSkill](auto PEntity)
    {
        auto mobObj = dynamic_cast<CMobEntity*>(PEntity);

        // has both a valid target (specified by user and mob)
        if (PTarget && mobObj)
        {
            float currentDistance = distance(mobObj->loc.p, PTarget->loc.p);
            if (currentDistance <= PMobSkill->getDistance())
            {
                PEntity->PAI->MobSkill(PTarget->targid, skillid);
            }
        }
        // does not have a specified target so default to current battle target
        else if (mobObj)
        {
            if (PMobSkill->getValidTargets() & TARGET_ENEMY)
            {
                auto defaultTarget = mobObj->GetBattleTarget();
                if (defaultTarget)
                {
                    // check distance from player or mob will use TP move and 'lock' itself
                    float currentDistance = distance(mobObj->loc.p, defaultTarget->loc.p);
                    if (currentDistance <= PMobSkill->getDistance())
                    {
                        PEntity->PAI->MobSkill(defaultTarget->targid, skillid);
                    }
                }
            }
            else if (PMobSkill->getValidTargets() & TARGET_SELF)
            {
                PEntity->PAI->MobSkill(PEntity->targid, skillid);
            }
        }
    }));
    // clang-format on
}

/************************************************************************
 *  Function: getAbilityDistance()
 *  Purpose : Returns the distance for a specified ability from mob_skills
 *  Example : mob:getAbilityDistance(740)
 *  Notes   : Uses Ability ID Only
 ************************************************************************/
float CLuaBaseEntity::getAbilityDistance(uint16 skillID)
{
    auto* PMobSkill = battleutils::GetMobSkill(skillID);

    if (PMobSkill == nullptr)
    {
        ShowWarning("Invalid SkillID (%d) returned null, returning 0 for distance.", skillID);
        return 0.0f;
    }

    return PMobSkill->getDistance();
}

/************************************************************************
 *  Function: hasTPMoves()
 *  Purpose : Returns true if a Mob has TP moves in its skill list
 *  Example : if mob:hasTPMoves() then
 ************************************************************************/

bool CLuaBaseEntity::hasTPMoves()
{
    if ((m_PBaseEntity->objtype == TYPE_NPC) || (m_PBaseEntity->objtype == TYPE_PC))
    {
        ShowWarning("Non-Mob passed into function.");
        return false;
    }

    uint16 familyID = 0;

    if (m_PBaseEntity->objtype & TYPE_PET)
    {
        familyID = static_cast<CPetEntity*>(m_PBaseEntity)->m_Family;
    }
    else if (m_PBaseEntity->objtype & TYPE_MOB)
    {
        familyID = static_cast<CMobEntity*>(m_PBaseEntity)->m_Family;
    }
    const std::vector<uint16>& MobSkills = battleutils::GetMobSkillList(familyID);

    return !MobSkills.empty();
}

/************************************************************************
 *  Function: drawIn()
 *  Purpose : Draws in the target, or current target if not specified
 *  Example : mob:drawIn()     mob:drawIn(player)
 *  Notes   : Draws in a player even if within the draw-in leash
 ************************************************************************/
void CLuaBaseEntity::drawIn(sol::variadic_args va)
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowError("Attempting to draw-in from non-mob entity: %s", m_PBaseEntity->getName());
        return;
    }

    auto mobObj = dynamic_cast<CMobEntity*>(m_PBaseEntity);

    if (va.size() == 0)
    {
        auto defaultTarget = mobObj->GetBattleTarget();

        if (defaultTarget == nullptr)
        {
            return;
        }
        battleutils::DrawIn(defaultTarget, mobObj->loc.p, 0, 0);
        return;
    }

    CLuaBaseEntity* PLuaBaseEntity = va.get<CLuaBaseEntity*>(0);
    float           offset         = va.get<float>(1);
    float           degrees        = va.get<float>(2);

    if (!PLuaBaseEntity)
    {
        ShowError("Attempt to draw-in non-valid target.");
        return;
    }

    CBaseEntity*   PBaseEntity = PLuaBaseEntity->m_PBaseEntity;
    CBattleEntity* PTarget     = nullptr;

    if (PBaseEntity)
    {
        PTarget = dynamic_cast<CBattleEntity*>(PBaseEntity);
    }

    if (PTarget)
    {
        battleutils::DrawIn(PTarget, mobObj->loc.p, offset, degrees);
    }

    return;
}

/************************************************************************
 *  Function: weaknessTrigger()
 *  Purpose : Triggers the weakness of a mob to an active state
 *  Example : mob:weaknessTrigger(1)
 *  Notes   : Used in scripts/mixins/abyssea_nm.lua
 ************************************************************************/

void CLuaBaseEntity::weaknessTrigger(uint8 level)
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to trigger weakness for invalid entity type (%s).", m_PBaseEntity->getName());
        return;
    }

    mobutils::WeaknessTrigger(m_PBaseEntity, static_cast<WeaknessType>(level));
}

/************************************************************************
 *  Function: restoreFromChest()
 *  Purpose : adding effects for restore chests in abyssea
 *  Example : player:restoreFromChest(npc,0)
 *  1 = restore HP effect, 2 = restore MP effect
 ************************************************************************/

void CLuaBaseEntity::restoreFromChest(CLuaBaseEntity* PLuaBaseEntity, uint32 restoreType)
{
    CCharEntity* PChar = (CCharEntity*)m_PBaseEntity;

    if (PLuaBaseEntity != nullptr)
    {
        CBaseEntity* PTarget = PLuaBaseEntity->GetBaseEntity();

        uint16 animationID  = 0;
        int    messageParam = 0;
        int    messageID    = 0;
        int    addedHP      = 0;
        int    addedMP      = 0;

        if (PChar->animation != ANIMATION_DEATH)
        {
            addedHP = PChar->GetMaxHP() - PChar->health.hp;
            addedMP = PChar->GetMaxMP() - PChar->health.mp;

            switch (restoreType)
            {
                case 1:
                    messageParam = addedHP;
                    messageID    = 587;
                    animationID  = 772;
                    break;
                case 2:
                    messageParam = addedMP;
                    messageID    = 588;
                    animationID  = 773;
                    break;
            }

            action_t Action;
            Action.id              = PTarget->id;
            Action.actiontype      = ACTION_MOBABILITY_FINISH;
            actionList_t& list     = Action.getNewActionList();
            list.ActionTargetID    = PChar->id;
            actionTarget_t& target = list.getNewActionTarget();
            target.animation       = animationID;
            target.messageID       = messageID;
            target.param           = messageParam;
            PTarget->loc.zone->PushPacket(PTarget, CHAR_INRANGE, std::make_unique<CActionPacket>(Action));
        }
    }
}

/************************************************************************
 *  Function: hasPreventActionEffect()
 *  Purpose : Returns true if a non-NPC entity has a preventative status effect
 *  Example : if not pet:hasPreventActionEffect() then
 *  Notes   : Used in scripts/actions/abilities/stay.lua
 ************************************************************************/

bool CLuaBaseEntity::hasPreventActionEffect()
{
    if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        ShowWarning("Invalid Entity (NPC: %s) calling function.", m_PBaseEntity->getName());
        return false;
    }

    return static_cast<CBattleEntity*>(m_PBaseEntity)->StatusEffectContainer->HasPreventActionEffect();
}

/************************************************************************
 *  Function: stun()
 *  Purpose : Stuns an entity for a specified amount of time (in ms)
 *  Example : mob:stun(5000) -- Stun for 5 seconds
 *  Notes   : To Do: Change to seconds for standardization?
 ************************************************************************/

void CLuaBaseEntity::stun(uint32 milliseconds)
{
    m_PBaseEntity->PAI->Inactive(std::chrono::milliseconds(milliseconds), false);
}

/************************************************************************
 *  Function: untargetableAndUnactionable()
 *  Purpose : Puts an entity into a stun state
 *            Also disallows them from being targed as part of a check in PAI->TargetFind
 *  Example : mob:stun(5000) -- Stun for 5 seconds
 *  Notes   : To Do: Change to seconds for standardization?
 ************************************************************************/

void CLuaBaseEntity::untargetableAndUnactionable(uint32 milliseconds)
{
    m_PBaseEntity->PAI->Untargetable(std::chrono::milliseconds(milliseconds), false);
}

void CLuaBaseEntity::tryHitInterrupt(CLuaBaseEntity* attacker)
{
    if (attacker)
    {
        auto* defenderBattle = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
        auto* attackerBattle = dynamic_cast<CBattleEntity*>(attacker->GetBaseEntity());

        if (defenderBattle && attackerBattle)
        {
            defenderBattle->TryHitInterrupt(attackerBattle);
        }
    }
}

/************************************************************************
 *  Function: getPool()
 *  Purpose : Returns a Mob's Pool ID integer
 *  Example : if mob:getPool() = 4006 then
 *  Notes   :
 ************************************************************************/

uint32 CLuaBaseEntity::getPool()
{
    if (m_PBaseEntity->objtype == TYPE_MOB || m_PBaseEntity->objtype == TYPE_TRUST)
    {
        CMobEntity* PMob = static_cast<CMobEntity*>(m_PBaseEntity);
        return PMob->m_Pool;
    }

    return 0;
}

/************************************************************************
 *  Function: getDropID()
 *  Purpose : Returns the integer Drop ID assigned to a Mob
 *  Example : local DropID = mob:getDropID()
 ************************************************************************/

uint32 CLuaBaseEntity::getDropID()
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to get drop id for invalid entity type (%s).", m_PBaseEntity->getName());
        return 0;
    }

    return static_cast<CMobEntity*>(m_PBaseEntity)->m_DropID;
}

/************************************************************************
 *  DEPRECATED: Use target:addListener("ITEM_DROPS", ...) instead.
 *  Function: setDropID()
 *  Purpose : Permanently changes the Drop ID assigned to a Mob
 *  Example : target:setDropID(2408)
 *  Notes   : Useful for situations where drops only occur from conditions
 ************************************************************************/

void CLuaBaseEntity::setDropID(uint32 dropID)
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to set drop id for invalid entity type (%s).", m_PBaseEntity->getName());
        return;
    }

    auto* PMob = static_cast<CMobEntity*>(m_PBaseEntity);

    PMob->m_DropID = dropID;
}

/************************************************************************
 *  Function: addTreasure()
 *  Purpose : Manually adds treasure to a party's treasure pool
 *  Example : targ:addTreasure(itemId, dropper)
 ************************************************************************/

void CLuaBaseEntity::addTreasure(uint16 itemID, sol::object const& arg1, sol::object const& arg2)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowWarning("Invalid entity type calling function (%s).", m_PBaseEntity->getName());
        return;
    }

    CCharEntity* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (itemID == 0)
    {
        return;
    }

    if (PChar->PTreasurePool != nullptr)
    {
        if ((arg1 != sol::lua_nil) && arg1.is<CLuaBaseEntity*>())
        {
            uint16 droprate = (arg2 != sol::lua_nil) ? arg2.as<uint16>() : 1000;

            // The specified PEntity can be a Mob or NPC
            CLuaBaseEntity* PLuaBaseEntity = arg1.as<CLuaBaseEntity*>();
            CBaseEntity*    PEntity        = PLuaBaseEntity->GetBaseEntity();

            charutils::DistributeItem(PChar, PEntity, itemID, droprate);
        }
        else // Entity can be nullptr - this is intentional
        {
            uint16 droprate = (arg1 != sol::lua_nil) ? arg1.as<uint16>() : 1000;

            charutils::DistributeItem(PChar, nullptr, itemID, droprate);
        }
    }
}

/************************************************************************
 *  Function: getStealItem()
 *  Purpose : Used to return the Item ID of a mob's item which can be stolen
 *  Example : local steamItem = target:getStealItem()
 *  Notes   : Used only in Thief quest and Maat
 ************************************************************************/

uint16 CLuaBaseEntity::getStealItem()
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to get steal item for invalid entity type (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto* PMob = dynamic_cast<CMobEntity*>(m_PBaseEntity);

    if (PMob)
    {
        DropList_t* PDropList = itemutils::GetDropList(PMob->m_DropID);

        if (PDropList && !PMob->m_ItemStolen)
        {
            // Steal item randomly selected from steal drop table
            std::vector<uint16> items;

            for (DropItem_t const& drop : PDropList->Items)
            {
                if (drop.DropType == DROP_STEAL)
                {
                    items.emplace_back(drop.ItemID);
                }
            }

            if (!items.empty())
            {
                return xirand::GetRandomElement(items);
            }
        }
    }

    return 0;
}

/************************************************************************
 *  Function: getDespoilItem()
 *  Purpose : Used to return the Item ID of a mob's item which can be despoiled
 *  Example : local despoilItem = target:getDespoilItem()
 *  Notes   : Defaults to getStealItem() if no despoil item exists
 ************************************************************************/

uint16 CLuaBaseEntity::getDespoilItem()
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to get despoil item for invalid entity type (%s).", m_PBaseEntity->getName());
        return 0;
    }

    auto* PMob = dynamic_cast<CMobEntity*>(m_PBaseEntity);

    if (PMob)
    {
        DropList_t* PDropList = itemutils::GetDropList(PMob->m_DropID);

        if (PDropList && !PMob->m_ItemStolen)
        {
            for (DropItem_t const& drop : PDropList->Items)
            {
                if (drop.DropType == DROP_DESPOIL)
                {
                    return drop.ItemID;
                }
            }
        }
    }

    return this->getStealItem();
}

/************************************************************************
 *  Function: getDespoilDebuff()
 *  Purpose : Used to get a status effect id to apply to a mob on successful despoil
 *  Example : local effect = player:getDespoilDebuff()
 *  Notes   : Check what happens if 0 is returned instead of nil
 ************************************************************************/

uint16 CLuaBaseEntity::getDespoilDebuff(uint16 itemID)
{
    return luautils::GetDespoilDebuff(itemID);
}

/************************************************************************
 *  Function: itemStolen()
 *  Purpose : Flags a mob's item as stolen, returns true upon update
 *  Example : target:itemStolen()
 *  Notes   : Used in scripts/actions/abilities/steal.lua
 ************************************************************************/

bool CLuaBaseEntity::itemStolen()
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        ShowWarning("Attempting to flag stolen item for invalid entity type (%s).", m_PBaseEntity->getName());
        return false;
    }

    static_cast<CMobEntity*>(m_PBaseEntity)->m_ItemStolen = true;
    return true;
}

/************************************************************************
 *  Function: getTHlevel()
 *  Purpose : Return mob's current Treasure Hunter tier
 *  Example : local TH = target:getTHlevel()
 ************************************************************************/

int16 CLuaBaseEntity::getTHlevel()
{
    if (m_PBaseEntity->objtype == TYPE_MOB)
    {
        CMobEntity* PMob = static_cast<CMobEntity*>(m_PBaseEntity);
        return PMob->m_THLvl;
    }
    return 0;
}

/************************************************************************
 *  Function: setTHlevel()
 *  Purpose : set mob's Treasure Hunter tier
 *  Example : target:setTHlevel(5)
 ************************************************************************/

void CLuaBaseEntity::setTHlevel(int16 newLevel)
{
    if (m_PBaseEntity->objtype == TYPE_MOB)
    {
        CMobEntity* PMob = static_cast<CMobEntity*>(m_PBaseEntity);
        PMob->m_THLvl    = newLevel;
    }
}

/************************************************************************
 *  Function: getAvailableTraverserStones()
 *  Purpose : Returns the number of Traverser Stones available for claim
 *  Note: Does not yet account for KI reduction
 ************************************************************************/

uint32 CLuaBaseEntity::getAvailableTraverserStones()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        return 0;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    return charutils::getAvailableTraverserStones(PChar);
}

/************************************************************************
 *  Function: getTraverserEpoch()
 *  Purpose : Returns the number of Traverser Stones claimed by the player
 ************************************************************************/

time_t CLuaBaseEntity::getTraverserEpoch()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        return 0;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    return charutils::getTraverserEpoch(PChar);
}

/************************************************************************
 *  Function: setTraverserEpoch()
 *  Purpose : Returns the number of Traverser Stones claimed by the player
 ************************************************************************/

void CLuaBaseEntity::setTraverserEpoch()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    charutils::setTraverserEpoch(PChar);
}

/************************************************************************
 *  Function: getClaimedTraverserStones()
 *  Purpose : Returns the number of Traverser Stones claimed by the player
 ************************************************************************/

uint32 CLuaBaseEntity::getClaimedTraverserStones()
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        return 0;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    return charutils::getClaimedTraverserStones(PChar);
}

/************************************************************************
 *  Function: addClaimedTraverserStones()
 *  Purpose : Increments number of Traverser Stones claimed by the player
 ************************************************************************/

void CLuaBaseEntity::addClaimedTraverserStones(uint16 numStones)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    charutils::addClaimedTraverserStones(PChar, numStones);
}

/************************************************************************
 *  Function: setClaimedTraverserStones()
 *  Purpose : Sets number of Traverser Stones claimed by the player.
 ************************************************************************/

void CLuaBaseEntity::setClaimedTraverserStones(uint16 totalStones)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        return;
    }

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    charutils::setClaimedTraverserStones(PChar, totalStones);
}

/************************************************************************
 *  Function: getHistory()
 *  Purpose : Gets a single entry of character history statistics
 *  Example : player:getHistory(xi.history.enemiesDefeated) -- Returns the relevant stat
 *  Notes   : This will return whatever is cached at runtime, not the contents of the db!
 ************************************************************************/

uint32 CLuaBaseEntity::getHistory(uint8 index)
{
    uint32 outStat = 0;
    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
        switch (index)
        {
            case ENEMIES_DEFEATED:
                outStat = PChar->m_charHistory.enemiesDefeated;
                break;
            case TIMES_KNOCKED_OUT:
                outStat = PChar->m_charHistory.timesKnockedOut;
                break;
            case MH_ENTRANCES:
                outStat = PChar->m_charHistory.mhEntrances;
                break;
            case JOINED_PARTIES:
                outStat = PChar->m_charHistory.joinedParties;
                break;
            case JOINED_ALLIANCES:
                outStat = PChar->m_charHistory.joinedAlliances;
                break;
            case SPELLS_CAST:
                outStat = PChar->m_charHistory.spellsCast;
                break;
            case ABILITIES_USED:
                outStat = PChar->m_charHistory.abilitiesUsed;
                break;
            case WS_USED:
                outStat = PChar->m_charHistory.wsUsed;
                break;
            case ITEMS_USED:
                outStat = PChar->m_charHistory.itemsUsed;
                break;
            case CHATS_SENT:
                outStat = PChar->m_charHistory.chatsSent;
                break;
            case NPC_INTERACTIONS:
                outStat = PChar->m_charHistory.npcInteractions;
                break;
            case BATTLES_FOUGHT:
                outStat = PChar->m_charHistory.battlesFought;
                break;
            case GM_CALLS:
                outStat = PChar->m_charHistory.gmCalls;
                break;
            case DISTANCE_TRAVELLED:
                outStat = PChar->m_charHistory.distanceTravelled;
                break;
            default:
                break;
        }
    }
    return outStat;
}

auto CLuaBaseEntity::getChocoboRaisingInfo() -> sol::table
{
    ShowDebug("Getting Raising Chocobo Info (%s)", m_PBaseEntity->name);

    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowDebug("Called on invalid entity");
        return sol::lua_nil;
    }

    // Check to see if the user already has a chocobo
    {
        const char* Query = "SELECT \
            charid, \
            first_name, \
            last_name, \
            sex, \
            UNIX_TIMESTAMP(`created`), \
            last_update_age, \
            stage, \
            location, \
            color, \
            dominant_gene, \
            recessive_gene, \
            strength, \
            endurance, \
            discernment, \
            receptivity, \
            affection, \
            energy, \
            satisfaction, \
            conditions, \
            ability1, \
            ability2, \
            personality, \
            weather_preference, \
            hunger, \
            care_plan, \
            held_item \
            FROM char_chocobos WHERE charid = %u";

        int32 ret = _sql->Query(Query, m_PBaseEntity->id);

        if (ret == SQL_ERROR)
        {
            ShowDebug("SELECT Query failed");
            return sol::lua_nil;
        }

        if (_sql->NumRows() == 0)
        {
            ShowDebug("No Raised Chocobo information found");
            return sol::lua_nil;
        }

        if (_sql->NextRow() == SQL_SUCCESS)
        {
            auto table = lua.create_table();

            table["charid"]          = _sql->GetUIntData(0);
            table["first_name"]      = _sql->GetStringData(1);
            table["last_name"]       = _sql->GetStringData(2);
            table["sex"]             = _sql->GetUIntData(3);
            table["created"]         = _sql->GetUIntData(4);
            table["last_update_age"] = _sql->GetUIntData(5);
            table["stage"]           = _sql->GetUIntData(6);
            table["location"]        = _sql->GetUIntData(7);
            table["color"]           = _sql->GetUIntData(8);

            table["dominant_gene"]  = _sql->GetUIntData(9);
            table["recessive_gene"] = _sql->GetUIntData(10);

            table["strength"]    = _sql->GetUIntData(11);
            table["endurance"]   = _sql->GetUIntData(12);
            table["discernment"] = _sql->GetUIntData(13);
            table["receptivity"] = _sql->GetUIntData(14);

            table["affection"]          = _sql->GetUIntData(15);
            table["energy"]             = _sql->GetUIntData(16);
            table["satisfaction"]       = _sql->GetUIntData(17);
            table["conditions"]         = _sql->GetUIntData(18);
            table["ability1"]           = _sql->GetUIntData(19);
            table["ability2"]           = _sql->GetUIntData(20);
            table["personality"]        = _sql->GetUIntData(21);
            table["weather_preference"] = _sql->GetUIntData(22);
            table["hunger"]             = _sql->GetUIntData(23);

            table["care_plan"] = _sql->GetUIntData(24);
            table["held_item"] = _sql->GetUIntData(25);

            return table;
        }
    }

    return sol::lua_nil;
}

bool CLuaBaseEntity::setChocoboRaisingInfo(sol::table const& table)
{
    ShowDebug("Setting Raising Chocobo Info (%s)", m_PBaseEntity->name);

    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowDebug("Called on invalid entity");
        return false;
    }

    const char* Query = "REPLACE INTO char_chocobos SET \
                                charid = %u, \
                                first_name = '%s', \
                                last_name = '%s', \
                                sex = %u, \
                                created = FROM_UNIXTIME(%u), \
                                last_update_age = %u, \
                                stage = %u, \
                                location = %u, \
                                color = %u, \
                                dominant_gene = %u, \
                                recessive_gene = %u, \
                                strength = %u, \
                                endurance = %u, \
                                discernment = %u, \
                                receptivity = %u, \
                                affection = %u, \
                                energy = %u, \
                                satisfaction = %u, \
                                conditions = %u, \
                                ability1 = %u, \
                                ability2 = %u, \
                                personality = %u, \
                                weather_preference = %u, \
                                hunger = %u, \
                                care_plan = %u, \
                                held_item = %u";

    int32 ret = _sql->Query(Query,
                            m_PBaseEntity->id,
                            table.get_or<std::string>("first_name", "Chocobo"),
                            table.get_or<std::string>("last_name", "Chocobo"),
                            table.get_or<uint32>("sex", 0),
                            table.get_or<uint32>("created", 0),
                            table.get_or<uint32>("last_update_age", 0),
                            table.get_or<uint32>("stage", 1),
                            table.get_or<uint32>("location", 0),
                            table.get_or<uint32>("color", 0),
                            table.get_or<uint32>("dominant_gene", 0),
                            table.get_or<uint32>("recessive_gene", 0),
                            table.get_or<uint32>("strength", 0),
                            table.get_or<uint32>("endurance", 0),
                            table.get_or<uint32>("discernment", 0),
                            table.get_or<uint32>("receptivity", 0),
                            table.get_or<uint32>("affection", 0),
                            table.get_or<uint32>("energy", 0),
                            table.get_or<uint32>("satisfaction", 0),
                            table.get_or<uint32>("conditions", 0),
                            table.get_or<uint32>("ability1", 0),
                            table.get_or<uint32>("ability2", 0),
                            table.get_or<uint32>("personality", 0),
                            table.get_or<uint32>("weather_preference", 0),
                            table.get_or<uint32>("hunger", 0),
                            table.get_or<uint32>("care_plan", 0),
                            table.get_or<uint32>("held_item", 0));

    if (ret == SQL_ERROR)
    {
        ShowDebug("REPLACE Query failed");
        return false;
    }

    return true;
}

bool CLuaBaseEntity::deleteRaisedChocobo()
{
    ShowDebug("Deleting Raising Chocobo (%s)", m_PBaseEntity->name);

    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        ShowDebug("Called on invalid entity");
        return false;
    }

    int32 ret = _sql->Query("DELETE FROM char_chocobos WHERE charid = %u", m_PBaseEntity->id);
    if (ret == SQL_ERROR)
    {
        ShowDebug("DELETE Query failed");
        return false;
    }

    return true;
}

void CLuaBaseEntity::clearActionQueue()
{
    if (m_PBaseEntity->PAI)
    {
        m_PBaseEntity->PAI->ClearActionQueue();
    }
}

void CLuaBaseEntity::clearTimerQueue()
{
    if (m_PBaseEntity->PAI)
    {
        m_PBaseEntity->PAI->ClearTimerQueue();
    }
}

void CLuaBaseEntity::setMannequinPose(uint16 itemID, uint8 race, uint8 pose)
{
    TracyZoneScoped;

    // Find the item in the player inventory and update the extra values
    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        for (uint8 i = 0; i < CONTAINER_ID::MAX_CONTAINER_ID; ++i)
        {
            if (auto slot = PChar->getStorage(i)->SearchItem(itemID); slot != ERROR_SLOTID)
            {
                auto* item = PChar->getStorage(i)->GetItem(slot);
                if (item && item->getID() == itemID && item->isMannequin())
                {
                    if (auto* PMannequin = dynamic_cast<CItemFurnishing*>(item))
                    {
                        PMannequin->setMannequinRace(race);
                        PMannequin->setMannequinPose(pose);

                        // Include the update into the database
                        char        extra[sizeof(PMannequin->m_extra) * 2 + 1];
                        const char* fmtQuery = "UPDATE char_inventory  \
                               SET extra = '%s' \
                               WHERE charid = %u AND itemId = %u";

                        _sql->EscapeStringLen(extra, (const char*)PMannequin->m_extra, sizeof(PMannequin->m_extra));
                        if (_sql->Query(fmtQuery, extra, PChar->id, PMannequin->getID()) == SQL_ERROR)
                        {
                            ShowError("lua_baseentity::setMannequinPose: Cannot insert item to database");
                        }
                    }
                    return; // We can exit here, since we found a matching mannequin and they can have only one of each
                }
            }
        }
    }
}

uint8 CLuaBaseEntity::getMannequinPose(uint16 itemID)
{
    TracyZoneScoped;

    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        for (uint8 i = 0; i < CONTAINER_ID::MAX_CONTAINER_ID; ++i)
        {
            if (auto slot = PChar->getStorage(i)->SearchItem(itemID); slot != ERROR_SLOTID)
            {
                auto* item = PChar->getStorage(i)->GetItem(slot);
                if (item && item->getID() == itemID && item->isMannequin())
                {
                    if (auto* PMannequin = dynamic_cast<CItemFurnishing*>(item))
                    {
                        return PMannequin->getMannequinPose();
                    }
                }
            }
        }
    }

    return 0;
}

// Fishing Contest Utilities

void CLuaBaseEntity::submitContestFish(uint32 score)
{
    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        fishingcontest::SubmitFish(PChar, score);
    }
}

void CLuaBaseEntity::withdrawContestFish()
{
    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        fishingcontest::WithdrawFish(PChar);
    }
}

uint32 CLuaBaseEntity::getContestScore()
{
    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        FishingContestEntry* PEntry = fishingcontest::GetPlayerEntry(PChar);
        if (PEntry != nullptr)
        {
            return PEntry->score;
        }
    }

    return 0;
}

uint8 CLuaBaseEntity::getContestRank()
{
    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        FishingContestEntry* PEntry = fishingcontest::GetPlayerEntry(PChar);
        if (PEntry != nullptr)
        {
            return PEntry->contestRank;
        }
    }

    return 0;
}

auto CLuaBaseEntity::getContestRewardStatus() -> sol::table
{
    auto reward = lua.create_table();

    // Default values for lua script
    reward["rank"]  = 0;
    reward["share"] = 0;

    if (auto PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        std::string Query = "SELECT contestrank, share "
                            "FROM   fishing_contest_entries "
                            "WHERE  charid = (?) "
                            "AND    claimed != 1";

        auto ret = db::preparedStmt(Query, PChar->id);
        if (ret && ret->rowsCount() > 0 && ret->next())
        {
            reward["rank"]  = ret->get<uint8>("contestrank");
            reward["share"] = ret->get<uint8>("share");
        }
    }

    return reward;
}

auto CLuaBaseEntity::getContestRankHistory() -> sol::table
{
    auto table = lua.create_table();

    // Default values
    table["rank1"]     = 0;
    table["rank2"]     = 0;
    table["rank3"]     = 0;
    table["rank4to10"] = 0;

    if (auto PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        FishingContestHistory history = fishingcontest::GetFishingContestHistory(PChar);
        table["rank1"]                = history.rank1;
        table["rank2"]                = history.rank2;
        table["rank3"]                = history.rank3;
        table["rank4to10"]            = history.rank4;
    }

    return table;
}

void CLuaBaseEntity::claimContestReward()
{
    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        fishingcontest::ClaimContestReward(PChar);
    }
}

void CLuaBaseEntity::addPacketMod(uint16 packetId, uint16 offset, uint8 value)
{
    TracyZoneScoped;

    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        ShowInfo(fmt::format("Adding Packet Mod ({}): 0x{:04X}: 0x{:04X}: 0x{:02X}",
                             PChar->name, packetId, offset, value));
        PacketMods[PChar->id][packetId].emplace_back(std::make_pair(offset, value));
    }
}

void CLuaBaseEntity::clearPacketMods()
{
    TracyZoneScoped;

    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        PacketMods[PChar->id].clear();
    }
}

//==========================================================//

void CLuaBaseEntity::Register()
{
    SOL_USERTYPE("CBaseEntity", CLuaBaseEntity);

    // Messaging System
    SOL_REGISTER("showText", CLuaBaseEntity::showText);
    SOL_REGISTER("messageText", CLuaBaseEntity::messageText);
    SOL_REGISTER("printToPlayer", CLuaBaseEntity::printToPlayer);
    SOL_REGISTER("printToArea", CLuaBaseEntity::printToArea);
    SOL_REGISTER("messageBasic", CLuaBaseEntity::messageBasic);
    SOL_REGISTER("messageName", CLuaBaseEntity::messageName);
    SOL_REGISTER("messagePublic", CLuaBaseEntity::messagePublic);
    SOL_REGISTER("messageSpecial", CLuaBaseEntity::messageSpecial);
    SOL_REGISTER("messageSystem", CLuaBaseEntity::messageSystem);
    SOL_REGISTER("messageCombat", CLuaBaseEntity::messageCombat);
    SOL_REGISTER("messageStandard", CLuaBaseEntity::messageStandard);
    SOL_REGISTER("customMenu", CLuaBaseEntity::customMenu);

    // Variables
    SOL_REGISTER("getCharVar", CLuaBaseEntity::getCharVar);
    SOL_REGISTER("setCharVar", CLuaBaseEntity::setCharVar);
    SOL_REGISTER("setCharVarExpiration", CLuaBaseEntity::setCharVarExpiration);
    SOL_REGISTER("getVar", CLuaBaseEntity::getCharVar); // Compatibility binding
    SOL_REGISTER("setVar", CLuaBaseEntity::setCharVar); // Compatibility binding
    SOL_REGISTER("incrementCharVar", CLuaBaseEntity::incrementCharVar);
    SOL_REGISTER("setVolatileCharVar", CLuaBaseEntity::setVolatileCharVar);
    SOL_REGISTER("getLocalVars", CLuaBaseEntity::getLocalVars);
    SOL_REGISTER("getLocalVar", CLuaBaseEntity::getLocalVar);
    SOL_REGISTER("setLocalVar", CLuaBaseEntity::setLocalVar);
    SOL_REGISTER("clearLocalVarsWithPrefix", CLuaBaseEntity::clearLocalVarsWithPrefix);
    SOL_REGISTER("resetLocalVars", CLuaBaseEntity::resetLocalVars);
    SOL_REGISTER("clearVarsWithPrefix", CLuaBaseEntity::clearVarsWithPrefix);
    SOL_REGISTER("getLastOnline", CLuaBaseEntity::getLastOnline);

    // Packets, Events, and Flags
    SOL_REGISTER("injectPacket", CLuaBaseEntity::injectPacket);
    SOL_REGISTER("injectActionPacket", CLuaBaseEntity::injectActionPacket);
    SOL_REGISTER("entityVisualPacket", CLuaBaseEntity::entityVisualPacket);
    SOL_REGISTER("entityAnimationPacket", CLuaBaseEntity::entityAnimationPacket);
    SOL_REGISTER("sendDebugPacket", CLuaBaseEntity::sendDebugPacket);

    SOL_REGISTER("startEvent", CLuaBaseEntity::startEvent);
    SOL_REGISTER("startCutscene", CLuaBaseEntity::startCutscene);
    SOL_REGISTER("startOptionalCutscene", CLuaBaseEntity::startOptionalCutscene);
    SOL_REGISTER("startEventString", CLuaBaseEntity::startEventString);
    SOL_REGISTER("updateEvent", CLuaBaseEntity::updateEvent);
    SOL_REGISTER("updateEventString", CLuaBaseEntity::updateEventString);
    SOL_REGISTER("getEventTarget", CLuaBaseEntity::getEventTarget);
    SOL_REGISTER("isInEvent", CLuaBaseEntity::isInEvent);
    SOL_REGISTER("release", CLuaBaseEntity::release);
    SOL_REGISTER("startSequence", CLuaBaseEntity::startSequence);
    SOL_REGISTER("didGetMessage", CLuaBaseEntity::didGetMessage);
    SOL_REGISTER("resetGotMessage", CLuaBaseEntity::resetGotMessage);

    SOL_REGISTER("getMoghouseFlag", CLuaBaseEntity::getMoghouseFlag);
    SOL_REGISTER("setMoghouseFlag", CLuaBaseEntity::setMoghouseFlag);
    SOL_REGISTER("needToZone", CLuaBaseEntity::needToZone);

    // Object Identification
    SOL_REGISTER("getID", CLuaBaseEntity::getID);
    SOL_REGISTER("getTargID", CLuaBaseEntity::getTargID);
    SOL_REGISTER("getCursorTarget", CLuaBaseEntity::getCursorTarget);

    SOL_REGISTER("getObjType", CLuaBaseEntity::getObjType);
    SOL_REGISTER("isPC", CLuaBaseEntity::isPC);
    SOL_REGISTER("isNPC", CLuaBaseEntity::isNPC);
    SOL_REGISTER("isMob", CLuaBaseEntity::isMob);
    SOL_REGISTER("isPet", CLuaBaseEntity::isPet);
    SOL_REGISTER("isTrust", CLuaBaseEntity::isTrust);
    SOL_REGISTER("isFellow", CLuaBaseEntity::isFellow);
    SOL_REGISTER("isAlly", CLuaBaseEntity::isAlly);

    // AI and Control
    SOL_REGISTER("initNpcAi", CLuaBaseEntity::initNpcAi);
    SOL_REGISTER("resetAI", CLuaBaseEntity::resetAI);
    SOL_REGISTER("getStatus", CLuaBaseEntity::getStatus);
    SOL_REGISTER("setStatus", CLuaBaseEntity::setStatus);
    SOL_REGISTER("getCurrentAction", CLuaBaseEntity::getCurrentAction);
    SOL_REGISTER("canUseAbilities", CLuaBaseEntity::canUseAbilities);

    SOL_REGISTER("lookAt", CLuaBaseEntity::lookAt);
    SOL_REGISTER("facePlayer", CLuaBaseEntity::facePlayer);
    SOL_REGISTER("clearTargID", CLuaBaseEntity::clearTargID);

    SOL_REGISTER("atPoint", CLuaBaseEntity::atPoint);
    SOL_REGISTER("pathTo", CLuaBaseEntity::pathTo);
    SOL_REGISTER("pathThrough", CLuaBaseEntity::pathThrough);
    SOL_REGISTER("isFollowingPath", CLuaBaseEntity::isFollowingPath);
    SOL_REGISTER("clearPath", CLuaBaseEntity::clearPath);
    SOL_REGISTER("continuePath", CLuaBaseEntity::continuePath);
    SOL_REGISTER("checkDistance", CLuaBaseEntity::checkDistance);
    SOL_REGISTER("wait", CLuaBaseEntity::wait);
    SOL_REGISTER("follow", CLuaBaseEntity::follow);
    SOL_REGISTER("hasFollowTarget", CLuaBaseEntity::hasFollowTarget);
    SOL_REGISTER("unfollow", CLuaBaseEntity::unfollow);
    SOL_REGISTER("setCarefulPathing", CLuaBaseEntity::setCarefulPathing);

    SOL_REGISTER("openDoor", CLuaBaseEntity::openDoor);
    SOL_REGISTER("closeDoor", CLuaBaseEntity::closeDoor);
    SOL_REGISTER("setElevator", CLuaBaseEntity::setElevator);

    SOL_REGISTER("addPeriodicTrigger", CLuaBaseEntity::addPeriodicTrigger);
    SOL_REGISTER("showNPC", CLuaBaseEntity::showNPC);
    SOL_REGISTER("hideNPC", CLuaBaseEntity::hideNPC);
    SOL_REGISTER("updateNPCHideTime", CLuaBaseEntity::updateNPCHideTime);

    SOL_REGISTER("getWeather", CLuaBaseEntity::getWeather);
    SOL_REGISTER("setWeather", CLuaBaseEntity::setWeather);

    // PC Instructions
    SOL_REGISTER("changeMusic", CLuaBaseEntity::changeMusic);
    SOL_REGISTER("sendMenu", CLuaBaseEntity::sendMenu);
    SOL_REGISTER("sendGuild", CLuaBaseEntity::sendGuild);
    SOL_REGISTER("openSendBox", CLuaBaseEntity::openSendBox);
    SOL_REGISTER("leaveGame", CLuaBaseEntity::leaveGame);
    SOL_REGISTER("sendEmote", CLuaBaseEntity::sendEmote);

    // Location and Positioning
    SOL_REGISTER("getWorldAngle", CLuaBaseEntity::getWorldAngle);
    SOL_REGISTER("getFacingAngle", CLuaBaseEntity::getFacingAngle);
    SOL_REGISTER("isFacing", CLuaBaseEntity::isFacing);
    SOL_REGISTER("isInfront", CLuaBaseEntity::isInfront);
    SOL_REGISTER("isBehind", CLuaBaseEntity::isBehind);
    SOL_REGISTER("isBeside", CLuaBaseEntity::isBeside);

    SOL_REGISTER("getZone", CLuaBaseEntity::getZone);
    SOL_REGISTER("getZoneID", CLuaBaseEntity::getZoneID);
    SOL_REGISTER("getZoneName", CLuaBaseEntity::getZoneName);
    SOL_REGISTER("hasVisitedZone", CLuaBaseEntity::hasVisitedZone);
    SOL_REGISTER("getPreviousZone", CLuaBaseEntity::getPreviousZone);
    SOL_REGISTER("getCurrentRegion", CLuaBaseEntity::getCurrentRegion);
    SOL_REGISTER("getContinentID", CLuaBaseEntity::getContinentID);
    SOL_REGISTER("isInMogHouse", CLuaBaseEntity::isInMogHouse);

    SOL_REGISTER("getPos", CLuaBaseEntity::getPos);
    SOL_REGISTER("showPosition", CLuaBaseEntity::showPosition);
    SOL_REGISTER("getXPos", CLuaBaseEntity::getXPos);
    SOL_REGISTER("getYPos", CLuaBaseEntity::getYPos);
    SOL_REGISTER("getZPos", CLuaBaseEntity::getZPos);
    SOL_REGISTER("getRotPos", CLuaBaseEntity::getRotPos);
    SOL_REGISTER("setPos", CLuaBaseEntity::setPos);
    SOL_REGISTER("setRotation", CLuaBaseEntity::setRotation);

    SOL_REGISTER("warp", CLuaBaseEntity::warp);
    SOL_REGISTER("teleport", CLuaBaseEntity::teleport);
    SOL_REGISTER("addTeleport", CLuaBaseEntity::addTeleport);
    SOL_REGISTER("getTeleport", CLuaBaseEntity::getTeleport);
    SOL_REGISTER("getTeleportTable", CLuaBaseEntity::getTeleportTable);
    SOL_REGISTER("hasTeleport", CLuaBaseEntity::hasTeleport);
    SOL_REGISTER("setTeleportMenu", CLuaBaseEntity::setTeleportMenu);
    SOL_REGISTER("getTeleportMenu", CLuaBaseEntity::getTeleportMenu);
    SOL_REGISTER("setHomePoint", CLuaBaseEntity::setHomePoint);
    SOL_REGISTER("resetPlayer", CLuaBaseEntity::resetPlayer);

    SOL_REGISTER("goToEntity", CLuaBaseEntity::goToEntity);
    SOL_REGISTER("gotoPlayer", CLuaBaseEntity::gotoPlayer);
    SOL_REGISTER("bringPlayer", CLuaBaseEntity::bringPlayer);

    // Items
    SOL_REGISTER("getEquipID", CLuaBaseEntity::getEquipID);
    SOL_REGISTER("getEquippedItem", CLuaBaseEntity::getEquippedItem);
    SOL_REGISTER("hasEquipped", CLuaBaseEntity::hasEquipped);
    SOL_REGISTER("hasItem", CLuaBaseEntity::hasItem);
    SOL_REGISTER("getItemCount", CLuaBaseEntity::getItemCount);
    SOL_REGISTER("addItem", CLuaBaseEntity::addItem);
    SOL_REGISTER("delItem", CLuaBaseEntity::delItem);
    SOL_REGISTER("delContainerItems", CLuaBaseEntity::delContainerItems);
    SOL_REGISTER("addUsedItem", CLuaBaseEntity::addUsedItem);
    SOL_REGISTER("addTempItem", CLuaBaseEntity::addTempItem);
    SOL_REGISTER("getWornUses", CLuaBaseEntity::getWornUses);
    SOL_REGISTER("incrementItemWear", CLuaBaseEntity::incrementItemWear);
    SOL_REGISTER("findItem", CLuaBaseEntity::findItem);

    SOL_REGISTER("createShop", CLuaBaseEntity::createShop);
    SOL_REGISTER("addShopItem", CLuaBaseEntity::addShopItem);
    SOL_REGISTER("getCurrentGPItem", CLuaBaseEntity::getCurrentGPItem);
    SOL_REGISTER("breakLinkshell", CLuaBaseEntity::breakLinkshell);
    SOL_REGISTER("addLinkpearl", CLuaBaseEntity::addLinkpearl);

    SOL_REGISTER("addSoulPlate", CLuaBaseEntity::addSoulPlate);

    // Trading
    SOL_REGISTER("getContainerSize", CLuaBaseEntity::getContainerSize);
    SOL_REGISTER("changeContainerSize", CLuaBaseEntity::changeContainerSize);
    SOL_REGISTER("getFreeSlotsCount", CLuaBaseEntity::getFreeSlotsCount);
    SOL_REGISTER("confirmTrade", CLuaBaseEntity::confirmTrade);
    SOL_REGISTER("tradeComplete", CLuaBaseEntity::tradeComplete);
    SOL_REGISTER("getTrade", CLuaBaseEntity::getTrade);

    // Equipping
    SOL_REGISTER("canEquipItem", CLuaBaseEntity::canEquipItem);
    SOL_REGISTER("equipItem", CLuaBaseEntity::equipItem);
    SOL_REGISTER("unequipItem", CLuaBaseEntity::unequipItem);

    SOL_REGISTER("setEquipBlock", CLuaBaseEntity::setEquipBlock);
    SOL_REGISTER("lockEquipSlot", CLuaBaseEntity::lockEquipSlot);
    SOL_REGISTER("unlockEquipSlot", CLuaBaseEntity::unlockEquipSlot);
    SOL_REGISTER("hasSlotEquipped", CLuaBaseEntity::hasSlotEquipped);

    SOL_REGISTER("getShieldSize", CLuaBaseEntity::getShieldSize);
    SOL_REGISTER("getShieldDefense", CLuaBaseEntity::getShieldDefense);

    SOL_REGISTER("addGearSetMod", CLuaBaseEntity::addGearSetMod);
    SOL_REGISTER("clearGearSetMods", CLuaBaseEntity::clearGearSetMods);

    // Storing
    SOL_REGISTER("getStorageItem", CLuaBaseEntity::getStorageItem);
    SOL_REGISTER("storeWithPorterMoogle", CLuaBaseEntity::storeWithPorterMoogle);
    SOL_REGISTER("getRetrievableItemsForSlip", CLuaBaseEntity::getRetrievableItemsForSlip);
    SOL_REGISTER("retrieveItemFromSlip", CLuaBaseEntity::retrieveItemFromSlip);

    // Player Appearance
    SOL_REGISTER("getRace", CLuaBaseEntity::getRace);
    SOL_REGISTER("getFace", CLuaBaseEntity::getFace);
    SOL_REGISTER("getGender", CLuaBaseEntity::getGender);
    SOL_REGISTER("getName", CLuaBaseEntity::getName);
    SOL_REGISTER("getPacketName", CLuaBaseEntity::getPacketName);
    SOL_REGISTER("renameEntity", CLuaBaseEntity::renameEntity);
    SOL_REGISTER("hideName", CLuaBaseEntity::hideName);
    SOL_REGISTER("getModelId", CLuaBaseEntity::getModelId);
    SOL_REGISTER("setModelId", CLuaBaseEntity::setModelId);
    SOL_REGISTER("getCostume", CLuaBaseEntity::getCostume);
    SOL_REGISTER("setCostume", CLuaBaseEntity::setCostume);
    SOL_REGISTER("getCostume2", CLuaBaseEntity::getCostume2);
    SOL_REGISTER("setCostume2", CLuaBaseEntity::setCostume2);
    SOL_REGISTER("getAnimation", CLuaBaseEntity::getAnimation);
    SOL_REGISTER("setAnimation", CLuaBaseEntity::setAnimation);
    SOL_REGISTER("getAnimationSub", CLuaBaseEntity::getAnimationSub);
    SOL_REGISTER("setAnimationSub", CLuaBaseEntity::setAnimationSub);
    SOL_REGISTER("getCallForHelpFlag", CLuaBaseEntity::getCallForHelpFlag);
    SOL_REGISTER("setCallForHelpFlag", CLuaBaseEntity::setCallForHelpFlag);
    SOL_REGISTER("getCallForHelpBlocked", CLuaBaseEntity::getCallForHelpBlocked);
    SOL_REGISTER("setCallForHelpBlocked", CLuaBaseEntity::setCallForHelpBlocked);

    // Player Status
    SOL_REGISTER("getNation", CLuaBaseEntity::getNation);
    SOL_REGISTER("setNation", CLuaBaseEntity::setNation);
    SOL_REGISTER("getAllegiance", CLuaBaseEntity::getAllegiance);
    SOL_REGISTER("setAllegiance", CLuaBaseEntity::setAllegiance);
    SOL_REGISTER("getCampaignAllegiance", CLuaBaseEntity::getCampaignAllegiance);
    SOL_REGISTER("setCampaignAllegiance", CLuaBaseEntity::setCampaignAllegiance);

    SOL_REGISTER("isSeekingParty", CLuaBaseEntity::isSeekingParty);
    SOL_REGISTER("getNewPlayer", CLuaBaseEntity::getNewPlayer);
    SOL_REGISTER("setNewPlayer", CLuaBaseEntity::setNewPlayer);
    SOL_REGISTER("getMentor", CLuaBaseEntity::getMentor);
    SOL_REGISTER("setMentor", CLuaBaseEntity::setMentor);

    SOL_REGISTER("getGMLevel", CLuaBaseEntity::getGMLevel);
    SOL_REGISTER("setGMLevel", CLuaBaseEntity::setGMLevel);
    SOL_REGISTER("setVisibleGMLevel", CLuaBaseEntity::setVisibleGMLevel);
    SOL_REGISTER("getVisibleGMLevel", CLuaBaseEntity::getVisibleGMLevel);
    SOL_REGISTER("getGMHidden", CLuaBaseEntity::getGMHidden);
    SOL_REGISTER("setGMHidden", CLuaBaseEntity::setGMHidden);
    SOL_REGISTER("getWallhack", CLuaBaseEntity::getWallhack);
    SOL_REGISTER("setWallhack", CLuaBaseEntity::setWallhack);

    SOL_REGISTER("isJailed", CLuaBaseEntity::isJailed);
    SOL_REGISTER("jail", CLuaBaseEntity::jail);

    SOL_REGISTER("canUseMisc", CLuaBaseEntity::canUseMisc);

    SOL_REGISTER("getSpeed", CLuaBaseEntity::getSpeed);
    SOL_REGISTER("getBaseSpeed", CLuaBaseEntity::getBaseSpeed);
    SOL_REGISTER("setBaseSpeed", CLuaBaseEntity::setBaseSpeed);
    SOL_REGISTER("setAnimationSpeed", CLuaBaseEntity::setAnimationSpeed);

    SOL_REGISTER("getPlaytime", CLuaBaseEntity::getPlaytime);
    SOL_REGISTER("getTimeCreated", CLuaBaseEntity::getTimeCreated);

    // Player Jobs and Levels
    SOL_REGISTER("getMainJob", CLuaBaseEntity::getMainJob);
    SOL_REGISTER("getSubJob", CLuaBaseEntity::getSubJob);
    SOL_REGISTER("changeJob", CLuaBaseEntity::changeJob);
    SOL_REGISTER("changesJob", CLuaBaseEntity::changesJob);
    SOL_REGISTER("unlockJob", CLuaBaseEntity::unlockJob);
    SOL_REGISTER("hasJob", CLuaBaseEntity::hasJob);

    SOL_REGISTER("getMainLvl", CLuaBaseEntity::getMainLvl);
    SOL_REGISTER("getSubLvl", CLuaBaseEntity::getSubLvl);
    SOL_REGISTER("getJobLevel", CLuaBaseEntity::getJobLevel);
    SOL_REGISTER("setLevel", CLuaBaseEntity::setLevel);
    SOL_REGISTER("setsLevel", CLuaBaseEntity::setsLevel);
    SOL_REGISTER("getLevelCap", CLuaBaseEntity::getLevelCap);
    SOL_REGISTER("setLevelCap", CLuaBaseEntity::setLevelCap);
    SOL_REGISTER("levelRestriction", CLuaBaseEntity::levelRestriction);
    SOL_REGISTER("addJobTraits", CLuaBaseEntity::addJobTraits);

    // Monstrosity
    SOL_REGISTER("getMonstrosityData", CLuaBaseEntity::getMonstrosityData);
    SOL_REGISTER("setMonstrosityData", CLuaBaseEntity::setMonstrosityData);
    SOL_REGISTER("getBelligerencyFlag", CLuaBaseEntity::getBelligerencyFlag);
    SOL_REGISTER("setBelligerencyFlag", CLuaBaseEntity::setBelligerencyFlag);
    SOL_REGISTER("getMonstrositySize", CLuaBaseEntity::getMonstrositySize);
    SOL_REGISTER("setMonstrosityEntryData", CLuaBaseEntity::setMonstrosityEntryData);

    // Player Titles and Fame
    SOL_REGISTER("getTitle", CLuaBaseEntity::getTitle);
    SOL_REGISTER("hasTitle", CLuaBaseEntity::hasTitle);
    SOL_REGISTER("addTitle", CLuaBaseEntity::addTitle);
    SOL_REGISTER("setTitle", CLuaBaseEntity::setTitle);
    SOL_REGISTER("delTitle", CLuaBaseEntity::delTitle);

    SOL_REGISTER("getFame", CLuaBaseEntity::getFame);
    SOL_REGISTER("addFame", CLuaBaseEntity::addFame);
    SOL_REGISTER("setFame", CLuaBaseEntity::setFame);
    SOL_REGISTER("getFameLevel", CLuaBaseEntity::getFameLevel);

    SOL_REGISTER("getRank", CLuaBaseEntity::getRank);
    SOL_REGISTER("setRank", CLuaBaseEntity::setRank);
    SOL_REGISTER("getRankPoints", CLuaBaseEntity::getRankPoints);
    SOL_REGISTER("addRankPoints", CLuaBaseEntity::addRankPoints);
    SOL_REGISTER("setRankPoints", CLuaBaseEntity::setRankPoints);

    SOL_REGISTER("addQuest", CLuaBaseEntity::addQuest);
    SOL_REGISTER("delCurrentQuest", CLuaBaseEntity::delCurrentQuest);
    SOL_REGISTER("delQuest", CLuaBaseEntity::delQuest);
    SOL_REGISTER("getQuestStatus", CLuaBaseEntity::getQuestStatus);
    SOL_REGISTER("hasCompletedQuest", CLuaBaseEntity::hasCompletedQuest);
    SOL_REGISTER("completeQuest", CLuaBaseEntity::completeQuest);

    SOL_REGISTER("addMission", CLuaBaseEntity::addMission);
    SOL_REGISTER("delMission", CLuaBaseEntity::delMission);
    SOL_REGISTER("getCurrentMission", CLuaBaseEntity::getCurrentMission);
    SOL_REGISTER("hasCompletedMission", CLuaBaseEntity::hasCompletedMission);
    SOL_REGISTER("completeMission", CLuaBaseEntity::completeMission);
    SOL_REGISTER("setMissionStatus", CLuaBaseEntity::setMissionStatus);
    SOL_REGISTER("getMissionStatus", CLuaBaseEntity::getMissionStatus);
    SOL_REGISTER("getEminenceCompleted", CLuaBaseEntity::getEminenceCompleted);
    SOL_REGISTER("getNumEminenceCompleted", CLuaBaseEntity::getNumEminenceCompleted);
    SOL_REGISTER("setEminenceCompleted", CLuaBaseEntity::setEminenceCompleted);
    SOL_REGISTER("getEminenceProgress", CLuaBaseEntity::getEminenceProgress);
    SOL_REGISTER("setEminenceProgress", CLuaBaseEntity::setEminenceProgress);
    SOL_REGISTER("hasEminenceRecord", CLuaBaseEntity::hasEminenceRecord);
    SOL_REGISTER("triggerRoeEvent", CLuaBaseEntity::triggerRoeEvent);
    SOL_REGISTER("setUnityLeader", CLuaBaseEntity::setUnityLeader);
    SOL_REGISTER("getUnityLeader", CLuaBaseEntity::getUnityLeader);
    SOL_REGISTER("getUnityRank", CLuaBaseEntity::getUnityRank);
    SOL_REGISTER("getClaimedDeedMask", CLuaBaseEntity::getClaimedDeedMask);
    SOL_REGISTER("toggleReceivedDeedRewards", CLuaBaseEntity::toggleReceivedDeedRewards);
    SOL_REGISTER("setClaimedDeed", CLuaBaseEntity::setClaimedDeed);
    SOL_REGISTER("resetClaimedDeeds", CLuaBaseEntity::resetClaimedDeeds);

    SOL_REGISTER("setUniqueEvent", CLuaBaseEntity::setUniqueEvent);
    SOL_REGISTER("delUniqueEvent", CLuaBaseEntity::delUniqueEvent);
    SOL_REGISTER("hasCompletedUniqueEvent", CLuaBaseEntity::hasCompletedUniqueEvent);

    SOL_REGISTER("addAssault", CLuaBaseEntity::addAssault);
    SOL_REGISTER("delAssault", CLuaBaseEntity::delAssault);
    SOL_REGISTER("getCurrentAssault", CLuaBaseEntity::getCurrentAssault);
    SOL_REGISTER("hasCompletedAssault", CLuaBaseEntity::hasCompletedAssault);
    SOL_REGISTER("completeAssault", CLuaBaseEntity::completeAssault);

    SOL_REGISTER("addKeyItem", CLuaBaseEntity::addKeyItem);
    SOL_REGISTER("delKeyItem", CLuaBaseEntity::delKeyItem);
    SOL_REGISTER("hasKeyItem", CLuaBaseEntity::hasKeyItem);
    SOL_REGISTER("seenKeyItem", CLuaBaseEntity::seenKeyItem);
    SOL_REGISTER("unseenKeyItem", CLuaBaseEntity::unseenKeyItem);

    // Player Points
    SOL_REGISTER("addExp", CLuaBaseEntity::addExp);
    SOL_REGISTER("delExp", CLuaBaseEntity::delExp);
    SOL_REGISTER("getMerit", CLuaBaseEntity::getMerit);
    SOL_REGISTER("getMeritCount", CLuaBaseEntity::getMeritCount);
    SOL_REGISTER("setMerits", CLuaBaseEntity::setMerits);

    SOL_REGISTER("getSpentJobPoints", CLuaBaseEntity::getSpentJobPoints);
    SOL_REGISTER("getJobPointLevel", CLuaBaseEntity::getJobPointLevel);
    SOL_REGISTER("addCapacityPoints", CLuaBaseEntity::addCapacityPoints);
    SOL_REGISTER("setCapacityPoints", CLuaBaseEntity::setCapacityPoints);
    SOL_REGISTER("setJobPoints", CLuaBaseEntity::setJobPoints);
    SOL_REGISTER("addJobPoints", CLuaBaseEntity::addJobPoints);
    SOL_REGISTER("delJobPoints", CLuaBaseEntity::delJobPoints);
    SOL_REGISTER("getJobPoints", CLuaBaseEntity::getJobPoints);
    SOL_REGISTER("masterJob", CLuaBaseEntity::masterJob);

    SOL_REGISTER("getGil", CLuaBaseEntity::getGil);
    SOL_REGISTER("addGil", CLuaBaseEntity::addGil);
    SOL_REGISTER("setGil", CLuaBaseEntity::setGil);
    SOL_REGISTER("delGil", CLuaBaseEntity::delGil);

    SOL_REGISTER("getCP", CLuaBaseEntity::getCP);
    SOL_REGISTER("addCP", CLuaBaseEntity::addCP);
    SOL_REGISTER("delCP", CLuaBaseEntity::delCP);

    SOL_REGISTER("getSeals", CLuaBaseEntity::getSeals);
    SOL_REGISTER("addSeals", CLuaBaseEntity::addSeals);
    SOL_REGISTER("delSeals", CLuaBaseEntity::delSeals);

    SOL_REGISTER("getCurrency", CLuaBaseEntity::getCurrency);
    SOL_REGISTER("addCurrency", CLuaBaseEntity::addCurrency);
    SOL_REGISTER("setCurrency", CLuaBaseEntity::setCurrency);
    SOL_REGISTER("delCurrency", CLuaBaseEntity::delCurrency);

    SOL_REGISTER("getAssaultPoint", CLuaBaseEntity::getAssaultPoint);
    SOL_REGISTER("addAssaultPoint", CLuaBaseEntity::addAssaultPoint);
    SOL_REGISTER("delAssaultPoint", CLuaBaseEntity::delAssaultPoint);

    SOL_REGISTER("addGuildPoints", CLuaBaseEntity::addGuildPoints);

    // Health and Status
    SOL_REGISTER("getHP", CLuaBaseEntity::getHP);
    SOL_REGISTER("getHPP", CLuaBaseEntity::getHPP);
    SOL_REGISTER("getMaxHP", CLuaBaseEntity::getMaxHP);
    SOL_REGISTER("getBaseHP", CLuaBaseEntity::getBaseHP);
    SOL_REGISTER("addHP", CLuaBaseEntity::addHP);
    SOL_REGISTER("addHPLeaveSleeping", CLuaBaseEntity::addHPLeaveSleeping);

    SOL_REGISTER("setHP", CLuaBaseEntity::setHP);
    SOL_REGISTER("setMaxHP", CLuaBaseEntity::setMaxHP);
    SOL_REGISTER("restoreHP", CLuaBaseEntity::restoreHP);
    SOL_REGISTER("delHP", CLuaBaseEntity::delHP);
    SOL_REGISTER("takeDamage", CLuaBaseEntity::takeDamage);
    SOL_REGISTER("hideHP", CLuaBaseEntity::hideHP);
    SOL_REGISTER("getDeathType", CLuaBaseEntity::getDeathType);
    SOL_REGISTER("setDeathType", CLuaBaseEntity::setDeathType);

    SOL_REGISTER("getMP", CLuaBaseEntity::getMP);
    SOL_REGISTER("getMPP", CLuaBaseEntity::getMPP);
    SOL_REGISTER("getMaxMP", CLuaBaseEntity::getMaxMP);
    SOL_REGISTER("getBaseMP", CLuaBaseEntity::getBaseMP);
    SOL_REGISTER("addMP", CLuaBaseEntity::addMP);
    SOL_REGISTER("setMP", CLuaBaseEntity::setMP);
    SOL_REGISTER("setMaxMP", CLuaBaseEntity::setMaxMP);
    SOL_REGISTER("restoreMP", CLuaBaseEntity::restoreMP);
    SOL_REGISTER("delMP", CLuaBaseEntity::delMP);

    SOL_REGISTER("getTP", CLuaBaseEntity::getTP);
    SOL_REGISTER("addTP", CLuaBaseEntity::addTP);
    SOL_REGISTER("setTP", CLuaBaseEntity::setTP);
    SOL_REGISTER("delTP", CLuaBaseEntity::delTP);

    SOL_REGISTER("updateHealth", CLuaBaseEntity::updateHealth);
    SOL_REGISTER("getAverageItemLevel", CLuaBaseEntity::getAverageItemLevel);

    // Skills and Abilities
    SOL_REGISTER("capSkill", CLuaBaseEntity::capSkill);
    SOL_REGISTER("capAllSkills", CLuaBaseEntity::capAllSkills);
    SOL_REGISTER("getSkillLevel", CLuaBaseEntity::getSkillLevel);
    SOL_REGISTER("setSkillLevel", CLuaBaseEntity::setSkillLevel);
    SOL_REGISTER("getMaxSkillLevel", CLuaBaseEntity::getMaxSkillLevel);
    SOL_REGISTER("getSkillRank", CLuaBaseEntity::getSkillRank);
    SOL_REGISTER("setSkillRank", CLuaBaseEntity::setSkillRank);
    SOL_REGISTER("getCharSkillLevel", CLuaBaseEntity::getCharSkillLevel);

    SOL_REGISTER("addLearnedWeaponskill", CLuaBaseEntity::addLearnedWeaponskill);
    SOL_REGISTER("hasLearnedWeaponskill", CLuaBaseEntity::hasLearnedWeaponskill);
    SOL_REGISTER("delLearnedWeaponskill", CLuaBaseEntity::delLearnedWeaponskill);
    SOL_REGISTER("trySkillUp", CLuaBaseEntity::trySkillUp);

    SOL_REGISTER("addWeaponSkillPoints", CLuaBaseEntity::addWeaponSkillPoints);

    SOL_REGISTER("addLearnedAbility", CLuaBaseEntity::addLearnedAbility);
    SOL_REGISTER("hasLearnedAbility", CLuaBaseEntity::hasLearnedAbility);
    SOL_REGISTER("canLearnAbility", CLuaBaseEntity::canLearnAbility);
    SOL_REGISTER("delLearnedAbility", CLuaBaseEntity::delLearnedAbility);

    SOL_REGISTER("addSpell", CLuaBaseEntity::addSpell);
    SOL_REGISTER("hasSpell", CLuaBaseEntity::hasSpell);
    SOL_REGISTER("canLearnSpell", CLuaBaseEntity::canLearnSpell);
    SOL_REGISTER("delSpell", CLuaBaseEntity::delSpell);

    SOL_REGISTER("recalculateSkillsTable", CLuaBaseEntity::recalculateSkillsTable);
    SOL_REGISTER("recalculateAbilitiesTable", CLuaBaseEntity::recalculateAbilitiesTable);
    SOL_REGISTER("getEntitiesInRange", CLuaBaseEntity::getEntitiesInRange);

    // Parties and Alliances
    SOL_REGISTER("getParty", CLuaBaseEntity::getParty);
    SOL_REGISTER("getPartyWithTrusts", CLuaBaseEntity::getPartyWithTrusts);
    SOL_REGISTER("getPartySize", CLuaBaseEntity::getPartySize);
    SOL_REGISTER("hasPartyJob", CLuaBaseEntity::hasPartyJob);
    SOL_REGISTER("getPartyMember", CLuaBaseEntity::getPartyMember);
    SOL_REGISTER("getPartyLeader", CLuaBaseEntity::getPartyLeader);
    SOL_REGISTER("getLeaderID", CLuaBaseEntity::getLeaderID);
    SOL_REGISTER("getPartyLastMemberJoinedTime", CLuaBaseEntity::getPartyLastMemberJoinedTime);
    SOL_REGISTER("forMembersInRange", CLuaBaseEntity::forMembersInRange);

    SOL_REGISTER("addPartyEffect", CLuaBaseEntity::addPartyEffect);
    SOL_REGISTER("hasPartyEffect", CLuaBaseEntity::hasPartyEffect);
    SOL_REGISTER("removePartyEffect", CLuaBaseEntity::removePartyEffect);

    SOL_REGISTER("getAlliance", CLuaBaseEntity::getAlliance);
    SOL_REGISTER("getAllianceSize", CLuaBaseEntity::getAllianceSize);

    SOL_REGISTER("reloadParty", CLuaBaseEntity::reloadParty);
    SOL_REGISTER("disableLevelSync", CLuaBaseEntity::disableLevelSync);
    SOL_REGISTER("isLevelSync", CLuaBaseEntity::isLevelSync);

    SOL_REGISTER("checkSoloPartyAlliance", CLuaBaseEntity::checkSoloPartyAlliance);

    SOL_REGISTER("checkKillCredit", CLuaBaseEntity::checkKillCredit);

    SOL_REGISTER("checkDifficulty", CLuaBaseEntity::checkDifficulty);

    // Instances
    SOL_REGISTER("getInstance", CLuaBaseEntity::getInstance);
    SOL_REGISTER("setInstance", CLuaBaseEntity::setInstance);
    SOL_REGISTER("createInstance", CLuaBaseEntity::createInstance);
    SOL_REGISTER("instanceEntry", CLuaBaseEntity::instanceEntry);

    SOL_REGISTER("getConfrontationEffect", CLuaBaseEntity::getConfrontationEffect);
    SOL_REGISTER("copyConfrontationEffect", CLuaBaseEntity::copyConfrontationEffect);

    // Battlefields
    SOL_REGISTER("getBattlefield", CLuaBaseEntity::getBattlefield);
    SOL_REGISTER("getBattlefieldID", CLuaBaseEntity::getBattlefieldID);
    SOL_REGISTER("registerBattlefield", CLuaBaseEntity::registerBattlefield);
    SOL_REGISTER("battlefieldAtCapacity", CLuaBaseEntity::battlefieldAtCapacity);
    SOL_REGISTER("enterBattlefield", CLuaBaseEntity::enterBattlefield);
    SOL_REGISTER("leaveBattlefield", CLuaBaseEntity::leaveBattlefield);
    SOL_REGISTER("isInDynamis", CLuaBaseEntity::isInDynamis);
    SOL_REGISTER("setEnteredBattlefield", CLuaBaseEntity::setEnteredBattlefield);
    SOL_REGISTER("hasEnteredBattlefield", CLuaBaseEntity::hasEnteredBattlefield);

    // Battle Utilities
    SOL_REGISTER("isAlive", CLuaBaseEntity::isAlive);
    SOL_REGISTER("isDead", CLuaBaseEntity::isDead);
    SOL_REGISTER("hasRaiseTractorMenu", CLuaBaseEntity::hasRaiseTractorMenu);

    SOL_REGISTER("sendRaise", CLuaBaseEntity::sendRaise);
    SOL_REGISTER("sendReraise", CLuaBaseEntity::sendReraise);
    SOL_REGISTER("sendTractor", CLuaBaseEntity::sendTractor);
    SOL_REGISTER("allowSendRaisePrompt", CLuaBaseEntity::allowSendRaisePrompt);

    SOL_REGISTER("countdown", CLuaBaseEntity::countdown);
    SOL_REGISTER("objectiveUtility", CLuaBaseEntity::objectiveUtility);
    SOL_REGISTER("enableEntities", CLuaBaseEntity::enableEntities);
    SOL_REGISTER("independentAnimation", CLuaBaseEntity::independentAnimation);

    SOL_REGISTER("engage", CLuaBaseEntity::engage);
    SOL_REGISTER("isEngaged", CLuaBaseEntity::isEngaged);
    SOL_REGISTER("disengage", CLuaBaseEntity::disengage);
    SOL_REGISTER("timer", CLuaBaseEntity::timer);
    SOL_REGISTER("queue", CLuaBaseEntity::queue);
    SOL_REGISTER("addRecast", CLuaBaseEntity::addRecast);
    SOL_REGISTER("hasRecast", CLuaBaseEntity::hasRecast);
    SOL_REGISTER("resetRecast", CLuaBaseEntity::resetRecast);
    SOL_REGISTER("resetRecasts", CLuaBaseEntity::resetRecasts);

    SOL_REGISTER("addListener", CLuaBaseEntity::addListener);
    SOL_REGISTER("removeListener", CLuaBaseEntity::removeListener);
    SOL_REGISTER("triggerListener", CLuaBaseEntity::triggerListener);
    SOL_REGISTER("hasListener", CLuaBaseEntity::hasListener);

    SOL_REGISTER("getEntity", CLuaBaseEntity::getEntity);
    SOL_REGISTER("canChangeState", CLuaBaseEntity::canChangeState);

    SOL_REGISTER("wakeUp", CLuaBaseEntity::wakeUp);

    SOL_REGISTER("setBattleID", CLuaBaseEntity::setBattleID);
    SOL_REGISTER("getBattleID", CLuaBaseEntity::getBattleID);

    SOL_REGISTER("recalculateStats", CLuaBaseEntity::recalculateStats);
    SOL_REGISTER("checkImbuedItems", CLuaBaseEntity::checkImbuedItems);

    SOL_REGISTER("isDualWielding", CLuaBaseEntity::isDualWielding);
    SOL_REGISTER("isUsingH2H", CLuaBaseEntity::isUsingH2H);
    SOL_REGISTER("getBaseWeaponDelay", CLuaBaseEntity::getBaseWeaponDelay);
    SOL_REGISTER("getBaseDelay", CLuaBaseEntity::getBaseDelay);
    SOL_REGISTER("getBaseRangedDelay", CLuaBaseEntity::getBaseRangedDelay);

    SOL_REGISTER("checkLiementAbsorb", CLuaBaseEntity::checkLiementAbsorb);

    // Enmity
    SOL_REGISTER("getCE", CLuaBaseEntity::getCE);
    SOL_REGISTER("getVE", CLuaBaseEntity::getVE);
    SOL_REGISTER("setCE", CLuaBaseEntity::setCE);
    SOL_REGISTER("setVE", CLuaBaseEntity::setVE);
    SOL_REGISTER("addEnmity", CLuaBaseEntity::addEnmity);
    SOL_REGISTER("lowerEnmity", CLuaBaseEntity::lowerEnmity);
    SOL_REGISTER("updateEnmity", CLuaBaseEntity::updateEnmity);
    SOL_REGISTER("transferEnmity", CLuaBaseEntity::transferEnmity);
    SOL_REGISTER("updateEnmityFromDamage", CLuaBaseEntity::updateEnmityFromDamage);
    SOL_REGISTER("updateEnmityFromCure", CLuaBaseEntity::updateEnmityFromCure);
    SOL_REGISTER("resetEnmity", CLuaBaseEntity::resetEnmity);
    SOL_REGISTER("updateClaim", CLuaBaseEntity::updateClaim);
    SOL_REGISTER("hasEnmity", CLuaBaseEntity::hasEnmity);
    SOL_REGISTER("getNotorietyList", CLuaBaseEntity::getNotorietyList);
    SOL_REGISTER("setClaimable", CLuaBaseEntity::setClaimable);
    SOL_REGISTER("getClaimable", CLuaBaseEntity::getClaimable);
    SOL_REGISTER("clearEnmityForEntity", CLuaBaseEntity::clearEnmityForEntity);

    // Status Effects
    SOL_REGISTER("addStatusEffect", CLuaBaseEntity::addStatusEffect);
    SOL_REGISTER("addStatusEffectEx", CLuaBaseEntity::addStatusEffectEx);
    SOL_REGISTER("getStatusEffect", CLuaBaseEntity::getStatusEffect);
    SOL_REGISTER("getStatusEffects", CLuaBaseEntity::getStatusEffects);
    SOL_REGISTER("getStatusEffectElement", CLuaBaseEntity::getStatusEffectElement);
    SOL_REGISTER("canGainStatusEffect", CLuaBaseEntity::canGainStatusEffect);
    SOL_REGISTER("hasStatusEffect", CLuaBaseEntity::hasStatusEffect);
    SOL_REGISTER("hasStatusEffectByFlag", CLuaBaseEntity::hasStatusEffectByFlag);
    SOL_REGISTER("countEffect", CLuaBaseEntity::countEffect);
    SOL_REGISTER("countEffectWithFlag", CLuaBaseEntity::countEffectWithFlag);

    SOL_REGISTER("delStatusEffect", CLuaBaseEntity::delStatusEffect);
    SOL_REGISTER("delStatusEffectsByFlag", CLuaBaseEntity::delStatusEffectsByFlag);
    SOL_REGISTER("delStatusEffectSilent", CLuaBaseEntity::delStatusEffectSilent);
    SOL_REGISTER("eraseStatusEffect", CLuaBaseEntity::eraseStatusEffect);
    SOL_REGISTER("eraseAllStatusEffect", CLuaBaseEntity::eraseAllStatusEffect);
    SOL_REGISTER("dispelStatusEffect", CLuaBaseEntity::dispelStatusEffect);
    SOL_REGISTER("dispelAllStatusEffect", CLuaBaseEntity::dispelAllStatusEffect);
    SOL_REGISTER("stealStatusEffect", CLuaBaseEntity::stealStatusEffect);

    SOL_REGISTER("addMod", CLuaBaseEntity::addMod);
    SOL_REGISTER("getMod", CLuaBaseEntity::getMod);
    SOL_REGISTER("setMod", CLuaBaseEntity::setMod);
    SOL_REGISTER("delMod", CLuaBaseEntity::delMod);
    SOL_REGISTER("printAllMods", CLuaBaseEntity::printAllMods);
    SOL_REGISTER("getMaxGearMod", CLuaBaseEntity::getMaxGearMod);

    SOL_REGISTER("addLatent", CLuaBaseEntity::addLatent);
    SOL_REGISTER("delLatent", CLuaBaseEntity::delLatent);
    SOL_REGISTER("hasAllLatentsActive", CLuaBaseEntity::hasAllLatentsActive);

    SOL_REGISTER("fold", CLuaBaseEntity::fold);
    SOL_REGISTER("doWildCard", CLuaBaseEntity::doWildCard);
    SOL_REGISTER("doRandomDeal", CLuaBaseEntity::doRandomDeal);
    SOL_REGISTER("addCorsairRoll", CLuaBaseEntity::addCorsairRoll);
    SOL_REGISTER("hasCorsairEffect", CLuaBaseEntity::hasCorsairEffect);
    SOL_REGISTER("hasBustEffect", CLuaBaseEntity::hasBustEffect);
    SOL_REGISTER("numBustEffects", CLuaBaseEntity::numBustEffects);
    SOL_REGISTER("healingWaltz", CLuaBaseEntity::healingWaltz);
    SOL_REGISTER("addBardSong", CLuaBaseEntity::addBardSong);

    // BST
    SOL_REGISTER("charm", CLuaBaseEntity::charm);
    SOL_REGISTER("uncharm", CLuaBaseEntity::uncharm);

    // PUP
    SOL_REGISTER("addBurden", CLuaBaseEntity::addBurden);
    SOL_REGISTER("getOverloadChance", CLuaBaseEntity::getOverloadChance);
    SOL_REGISTER("setStatDebilitation", CLuaBaseEntity::setStatDebilitation);
    SOL_REGISTER("isExceedingElementalCapacity", CLuaBaseEntity::isExceedingElementalCapacity);

    // Damage Calculation
    SOL_REGISTER("getStat", CLuaBaseEntity::getStat);
    SOL_REGISTER("getACC", CLuaBaseEntity::getACC);
    SOL_REGISTER("getEVA", CLuaBaseEntity::getEVA);
    SOL_REGISTER("getRACC", CLuaBaseEntity::getRACC);
    SOL_REGISTER("getRATT", CLuaBaseEntity::getRATT);
    SOL_REGISTER("getILvlMacc", CLuaBaseEntity::getILvlMacc);
    SOL_REGISTER("getILvlSkill", CLuaBaseEntity::getILvlSkill);
    SOL_REGISTER("getILvlParry", CLuaBaseEntity::getILvlParry);

    SOL_REGISTER("isSpellAoE", CLuaBaseEntity::isSpellAoE);

    SOL_REGISTER("physicalDmgTaken", CLuaBaseEntity::physicalDmgTaken);
    SOL_REGISTER("magicDmgTaken", CLuaBaseEntity::magicDmgTaken);
    SOL_REGISTER("rangedDmgTaken", CLuaBaseEntity::rangedDmgTaken);
    SOL_REGISTER("breathDmgTaken", CLuaBaseEntity::breathDmgTaken);
    SOL_REGISTER("handleAfflatusMiseryDamage", CLuaBaseEntity::handleAfflatusMiseryDamage);

    SOL_REGISTER("isWeaponTwoHanded", CLuaBaseEntity::isWeaponTwoHanded);
    SOL_REGISTER("getWeaponDmg", CLuaBaseEntity::getWeaponDmg);
    SOL_REGISTER("getWeaponDmgRank", CLuaBaseEntity::getWeaponDmgRank);
    SOL_REGISTER("getOffhandDmg", CLuaBaseEntity::getOffhandDmg);
    SOL_REGISTER("getOffhandDmgRank", CLuaBaseEntity::getOffhandDmgRank);
    SOL_REGISTER("getRangedDmg", CLuaBaseEntity::getRangedDmg);
    SOL_REGISTER("getRangedDmgRank", CLuaBaseEntity::getRangedDmgRank);
    SOL_REGISTER("getAmmoDmg", CLuaBaseEntity::getAmmoDmg);
    SOL_REGISTER("getWeaponHitCount", CLuaBaseEntity::getWeaponHitCount);

    SOL_REGISTER("removeAmmo", CLuaBaseEntity::removeAmmo);

    SOL_REGISTER("getWeaponSkillLevel", CLuaBaseEntity::getWeaponSkillLevel);
    SOL_REGISTER("getWeaponDamageType", CLuaBaseEntity::getWeaponDamageType);
    SOL_REGISTER("getWeaponSkillType", CLuaBaseEntity::getWeaponSkillType);
    SOL_REGISTER("getWeaponSubSkillType", CLuaBaseEntity::getWeaponSubSkillType);
    SOL_REGISTER("getWSSkillchainProp", CLuaBaseEntity::getWSSkillchainProp);

    SOL_REGISTER("takeWeaponskillDamage", CLuaBaseEntity::takeWeaponskillDamage);
    SOL_REGISTER("takeSpellDamage", CLuaBaseEntity::takeSpellDamage);
    SOL_REGISTER("takeSwipeLungeDamage", CLuaBaseEntity::takeSwipeLungeDamage);
    SOL_REGISTER("checkDamageCap", CLuaBaseEntity::checkDamageCap);

    // Pets and Automations
    SOL_REGISTER("spawnPet", CLuaBaseEntity::spawnPet);
    SOL_REGISTER("despawnPet", CLuaBaseEntity::despawnPet);

    SOL_REGISTER("hasValidJugPetItem", CLuaBaseEntity::hasValidJugPetItem);

    SOL_REGISTER("hasPet", CLuaBaseEntity::hasPet);
    SOL_REGISTER("hasJugPet", CLuaBaseEntity::hasJugPet);
    SOL_REGISTER("getPet", CLuaBaseEntity::getPet);
    SOL_REGISTER("getPetID", CLuaBaseEntity::getPetID);
    SOL_REGISTER("isAutomaton", CLuaBaseEntity::isAutomaton);
    SOL_REGISTER("isAvatar", CLuaBaseEntity::isAvatar);
    SOL_REGISTER("getPetElement", CLuaBaseEntity::getPetElement);
    SOL_REGISTER("setPet", CLuaBaseEntity::setPet);
    SOL_REGISTER("getMinimumPetLevel", CLuaBaseEntity::getMinimumPetLevel);
    SOL_REGISTER("getMaster", CLuaBaseEntity::getMaster);

    SOL_REGISTER("getPetName", CLuaBaseEntity::getPetName);
    SOL_REGISTER("setPetName", CLuaBaseEntity::setPetName);
    SOL_REGISTER("registerChocobo", CLuaBaseEntity::registerChocobo);

    SOL_REGISTER("petAttack", CLuaBaseEntity::petAttack);
    SOL_REGISTER("petAbility", CLuaBaseEntity::petAbility);
    SOL_REGISTER("petRetreat", CLuaBaseEntity::petRetreat);
    SOL_REGISTER("familiar", CLuaBaseEntity::familiar);

    SOL_REGISTER("addPetMod", CLuaBaseEntity::addPetMod);
    SOL_REGISTER("setPetMod", CLuaBaseEntity::setPetMod);
    SOL_REGISTER("delPetMod", CLuaBaseEntity::delPetMod);

    SOL_REGISTER("hasAttachment", CLuaBaseEntity::hasAttachment);
    SOL_REGISTER("getAutomatonName", CLuaBaseEntity::getAutomatonName);
    SOL_REGISTER("getAutomatonFrame", CLuaBaseEntity::getAutomatonFrame);
    SOL_REGISTER("setAutomatonFrame", CLuaBaseEntity::setAutomatonFrame);
    SOL_REGISTER("getAutomatonHead", CLuaBaseEntity::getAutomatonHead);
    SOL_REGISTER("setAutomatonHead", CLuaBaseEntity::setAutomatonHead);
    SOL_REGISTER("unlockAttachment", CLuaBaseEntity::unlockAttachment);

    SOL_REGISTER("getActiveManeuverCount", CLuaBaseEntity::getActiveManeuverCount);
    SOL_REGISTER("removeOldestManeuver", CLuaBaseEntity::removeOldestManeuver);
    SOL_REGISTER("removeAllManeuvers", CLuaBaseEntity::removeAllManeuvers);
    SOL_REGISTER("getAttachment", CLuaBaseEntity::getAttachment);
    SOL_REGISTER("setAttachment", CLuaBaseEntity::setAttachment);
    SOL_REGISTER("getAttachments", CLuaBaseEntity::getAttachments);
    SOL_REGISTER("updateAttachments", CLuaBaseEntity::updateAttachments);
    SOL_REGISTER("reduceBurden", CLuaBaseEntity::reduceBurden);

    SOL_REGISTER("getAllRuneEffects", CLuaBaseEntity::getAllRuneEffects);
    SOL_REGISTER("getActiveRuneCount", CLuaBaseEntity::getActiveRuneCount);
    SOL_REGISTER("getHighestRuneEffect", CLuaBaseEntity::getHighestRuneEffect);
    SOL_REGISTER("getNewestRuneEffect", CLuaBaseEntity::getNewestRuneEffect);
    SOL_REGISTER("removeOldestRune", CLuaBaseEntity::removeOldestRune);
    SOL_REGISTER("removeNewestRune", CLuaBaseEntity::removeNewestRune);
    SOL_REGISTER("removeAllRunes", CLuaBaseEntity::removeAllRunes);

    // Trust related
    SOL_REGISTER("spawnTrust", CLuaBaseEntity::spawnTrust);
    SOL_REGISTER("clearTrusts", CLuaBaseEntity::clearTrusts);
    SOL_REGISTER("getTrustID", CLuaBaseEntity::getTrustID);
    SOL_REGISTER("trustPartyMessage", CLuaBaseEntity::trustPartyMessage);
    SOL_REGISTER("addGambit", CLuaBaseEntity::addGambit);
    SOL_REGISTER("removeGambit", CLuaBaseEntity::removeGambit);
    SOL_REGISTER("removeAllGambits", CLuaBaseEntity::removeAllGambits);
    SOL_REGISTER("setTrustTPSkillSettings", CLuaBaseEntity::setTrustTPSkillSettings);

    // Mob Entity-Specific
    SOL_REGISTER("setMobLevel", CLuaBaseEntity::setMobLevel);
    SOL_REGISTER("getEcosystem", CLuaBaseEntity::getEcosystem);
    SOL_REGISTER("getSuperFamily", CLuaBaseEntity::getSuperFamily);
    SOL_REGISTER("getFamily", CLuaBaseEntity::getFamily);
    SOL_REGISTER("isMobType", CLuaBaseEntity::isMobType);
    SOL_REGISTER("isUndead", CLuaBaseEntity::isUndead);
    SOL_REGISTER("isNM", CLuaBaseEntity::isNM);

    SOL_REGISTER("getModelSize", CLuaBaseEntity::getModelSize);
    SOL_REGISTER("getMeleeRange", CLuaBaseEntity::getMeleeRange);
    SOL_REGISTER("setMeleeRange", CLuaBaseEntity::setMeleeRange);
    SOL_REGISTER("setMobFlags", CLuaBaseEntity::setMobFlags);
    SOL_REGISTER("getMobFlags", CLuaBaseEntity::getMobFlags);
    SOL_REGISTER("setNpcFlags", CLuaBaseEntity::setNpcFlags);

    SOL_REGISTER("spawn", CLuaBaseEntity::spawn);
    SOL_REGISTER("isSpawned", CLuaBaseEntity::isSpawned);
    SOL_REGISTER("getSpawnPos", CLuaBaseEntity::getSpawnPos);
    SOL_REGISTER("setSpawn", CLuaBaseEntity::setSpawn);
    SOL_REGISTER("getRespawnTime", CLuaBaseEntity::getRespawnTime);
    SOL_REGISTER("setRespawnTime", CLuaBaseEntity::setRespawnTime);

    SOL_REGISTER("instantiateMob", CLuaBaseEntity::instantiateMob);

    SOL_REGISTER("hasTrait", CLuaBaseEntity::hasTrait);
    SOL_REGISTER("hasImmunity", CLuaBaseEntity::hasImmunity);
    SOL_REGISTER("addImmunity", CLuaBaseEntity::addImmunity);
    SOL_REGISTER("delImmunity", CLuaBaseEntity::delImmunity);

    SOL_REGISTER("setAggressive", CLuaBaseEntity::setAggressive);
    SOL_REGISTER("setTrueDetection", CLuaBaseEntity::setTrueDetection);
    SOL_REGISTER("setUnkillable", CLuaBaseEntity::setUnkillable);
    SOL_REGISTER("setUntargetable", CLuaBaseEntity::setUntargetable);
    SOL_REGISTER("getUntargetable", CLuaBaseEntity::getUntargetable);
    SOL_REGISTER("setIsAggroable", CLuaBaseEntity::setIsAggroable);
    SOL_REGISTER("isAggroable", CLuaBaseEntity::isAggroable);

    SOL_REGISTER("setDelay", CLuaBaseEntity::setDelay);
    SOL_REGISTER("setDamage", CLuaBaseEntity::setDamage);
    SOL_REGISTER("hasSpellList", CLuaBaseEntity::hasSpellList);
    SOL_REGISTER("setSpellList", CLuaBaseEntity::setSpellList);
    SOL_REGISTER("setAutoAttackEnabled", CLuaBaseEntity::setAutoAttackEnabled);
    SOL_REGISTER("setMagicCastingEnabled", CLuaBaseEntity::setMagicCastingEnabled);
    SOL_REGISTER("setMobAbilityEnabled", CLuaBaseEntity::setMobAbilityEnabled);
    SOL_REGISTER("setMobSkillAttack", CLuaBaseEntity::setMobSkillAttack);

    SOL_REGISTER("getMobMod", CLuaBaseEntity::getMobMod);
    SOL_REGISTER("setMobMod", CLuaBaseEntity::setMobMod);
    SOL_REGISTER("addMobMod", CLuaBaseEntity::addMobMod);
    SOL_REGISTER("delMobMod", CLuaBaseEntity::delMobMod);

    SOL_REGISTER("getBattleTime", CLuaBaseEntity::getBattleTime);

    SOL_REGISTER("getBehavior", CLuaBaseEntity::getBehavior);
    SOL_REGISTER("setBehavior", CLuaBaseEntity::setBehavior);
    SOL_REGISTER("getLink", CLuaBaseEntity::getLink);
    SOL_REGISTER("setLink", CLuaBaseEntity::setLink);
    SOL_REGISTER("getRoamFlags", CLuaBaseEntity::getRoamFlags);
    SOL_REGISTER("setRoamFlags", CLuaBaseEntity::setRoamFlags);

    SOL_REGISTER("getTarget", CLuaBaseEntity::getTarget);
    SOL_REGISTER("updateTarget", CLuaBaseEntity::updateTarget);
    SOL_REGISTER("getEnmityList", CLuaBaseEntity::getEnmityList);
    SOL_REGISTER("getTrickAttackChar", CLuaBaseEntity::getTrickAttackChar);

    SOL_REGISTER("actionQueueEmpty", CLuaBaseEntity::actionQueueEmpty);

    SOL_REGISTER("castSpell", CLuaBaseEntity::castSpell);
    SOL_REGISTER("useJobAbility", CLuaBaseEntity::useJobAbility);
    SOL_REGISTER("useMobAbility", CLuaBaseEntity::useMobAbility);
    SOL_REGISTER("getAbilityDistance", CLuaBaseEntity::getAbilityDistance);
    SOL_REGISTER("hasTPMoves", CLuaBaseEntity::hasTPMoves);
    SOL_REGISTER("drawIn", CLuaBaseEntity::drawIn);

    SOL_REGISTER("weaknessTrigger", CLuaBaseEntity::weaknessTrigger);
    SOL_REGISTER("restoreFromChest", CLuaBaseEntity::restoreFromChest);
    SOL_REGISTER("hasPreventActionEffect", CLuaBaseEntity::hasPreventActionEffect);
    SOL_REGISTER("stun", CLuaBaseEntity::stun);
    SOL_REGISTER("untargetableAndUnactionable", CLuaBaseEntity::untargetableAndUnactionable);
    SOL_REGISTER("tryHitInterrupt", CLuaBaseEntity::tryHitInterrupt);

    SOL_REGISTER("getPool", CLuaBaseEntity::getPool);
    SOL_REGISTER("getDropID", CLuaBaseEntity::getDropID);
    SOL_REGISTER("setDropID", CLuaBaseEntity::setDropID);
    SOL_REGISTER("addTreasure", CLuaBaseEntity::addTreasure);
    SOL_REGISTER("getStealItem", CLuaBaseEntity::getStealItem);
    SOL_REGISTER("getDespoilItem", CLuaBaseEntity::getDespoilItem);
    SOL_REGISTER("getDespoilDebuff", CLuaBaseEntity::getDespoilDebuff);
    SOL_REGISTER("itemStolen", CLuaBaseEntity::itemStolen);
    SOL_REGISTER("getTHlevel", CLuaBaseEntity::getTHlevel);
    SOL_REGISTER("setTHlevel", CLuaBaseEntity::setTHlevel);

    SOL_REGISTER("getPlayerTriggerAreaInZone", CLuaBaseEntity::getPlayerTriggerAreaInZone);
    SOL_REGISTER("updateToEntireZone", CLuaBaseEntity::updateToEntireZone);
    SOL_REGISTER("sendEntityUpdateToPlayer", CLuaBaseEntity::sendEntityUpdateToPlayer);
    SOL_REGISTER("sendEmptyEntityUpdateToPlayer", CLuaBaseEntity::sendEmptyEntityUpdateToPlayer);
    SOL_REGISTER("forceRezone", CLuaBaseEntity::forceRezone);
    SOL_REGISTER("forceLogout", CLuaBaseEntity::forceLogout);

    // Abyssea
    SOL_REGISTER("getAvailableTraverserStones", CLuaBaseEntity::getAvailableTraverserStones);
    SOL_REGISTER("getTraverserEpoch", CLuaBaseEntity::getTraverserEpoch);
    SOL_REGISTER("setTraverserEpoch", CLuaBaseEntity::setTraverserEpoch);
    SOL_REGISTER("getClaimedTraverserStones", CLuaBaseEntity::getClaimedTraverserStones);
    SOL_REGISTER("addClaimedTraverserStones", CLuaBaseEntity::addClaimedTraverserStones);
    SOL_REGISTER("setClaimedTraverserStones", CLuaBaseEntity::setClaimedTraverserStones);

    SOL_REGISTER("getHistory", CLuaBaseEntity::getHistory);

    SOL_REGISTER("clearActionQueue", CLuaBaseEntity::clearActionQueue);
    SOL_REGISTER("clearTimerQueue", CLuaBaseEntity::clearTimerQueue);

    SOL_REGISTER("getChocoboRaisingInfo", CLuaBaseEntity::getChocoboRaisingInfo);
    SOL_REGISTER("setChocoboRaisingInfo", CLuaBaseEntity::setChocoboRaisingInfo);
    SOL_REGISTER("deleteRaisedChocobo", CLuaBaseEntity::deleteRaisedChocobo);

    SOL_REGISTER("setMannequinPose", CLuaBaseEntity::setMannequinPose);
    SOL_REGISTER("getMannequinPose", CLuaBaseEntity::getMannequinPose);

    // Fish Ranking Contest
    SOL_REGISTER("submitContestFish", CLuaBaseEntity::submitContestFish);
    SOL_REGISTER("withdrawContestFish", CLuaBaseEntity::withdrawContestFish);
    SOL_REGISTER("getContestScore", CLuaBaseEntity::getContestScore);
    SOL_REGISTER("getContestRank", CLuaBaseEntity::getContestRank);
    SOL_REGISTER("getContestRewardStatus", CLuaBaseEntity::getContestRewardStatus);
    SOL_REGISTER("getContestRankHistory", CLuaBaseEntity::getContestRankHistory);
    SOL_REGISTER("claimContestReward", CLuaBaseEntity::claimContestReward);

    SOL_REGISTER("addPacketMod", CLuaBaseEntity::addPacketMod);
    SOL_REGISTER("clearPacketMods", CLuaBaseEntity::clearPacketMods);
}

std::ostream& operator<<(std::ostream& os, const CLuaBaseEntity& entity)
{
    if (entity.m_PBaseEntity != nullptr)
    {
        std::string id         = std::to_string(entity.m_PBaseEntity->id);
        std::string name       = entity.m_PBaseEntity->name;
        std::string packetName = entity.m_PBaseEntity->packetName;
        std::string type       = "";
        switch (entity.m_PBaseEntity->objtype)
        {
            case TYPE_NONE:
            {
                type = "TYPE_NONE";
                break;
            }
            case TYPE_PC:
            {
                type = "TYPE_PC";
                break;
            }
            case TYPE_NPC:
            {
                type = "TYPE_NPC";
                break;
            }
            case TYPE_MOB:
            {
                type = "TYPE_MOB";
                break;
            }
            case TYPE_PET:
            {
                type = "TYPE_PET";
                break;
            }
            case TYPE_SHIP:
            {
                type = "TYPE_SHIP";
                break;
            }
            case TYPE_TRUST:
            {
                type = "TYPE_TRUST";
                break;
            }
            case TYPE_FELLOW:
            {
                type = "TYPE_FELLOW";
                break;
            }
            default:
            {
                type = "UNKNOWN";
                break;
            }
        }

        std::string ending = (packetName.empty()) ? ")" : " | " + packetName + ")";
        return os << "CLuaBaseEntity(" << type << " | " << id << " | " << name << ending;
    }

    return os << "CLuaBaseEntity(nullptr)";
}

//==========================================================//
