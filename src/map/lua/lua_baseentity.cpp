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

#include "../../common/kernel.h"
#include "../../common/showmsg.h"
#include "../../common/timer.h"
#include "../../common/utils.h"

#include "../ability.h"
#include "../alliance.h"
#include "../battlefield.h"
#include "../daily_system.h"
#include "../enmity_container.h"
#include "../guild.h"
#include "../instance.h"
#include "../item_container.h"
#include "../latent_effect_container.h"
#include "../linkshell.h"
#include "../map.h"
#include "../message.h"
#include "../mob_modifier.h"
#include "../mob_spell_container.h"
#include "../mobskill.h"
#include "../notoriety_container.h"
#include "../recast_container.h"
#include "../roe.h"
#include "../spell.h"
#include "../status_effect_container.h"
#include "../timetriggers.h"
#include "../trade_container.h"
#include "../transport.h"
#include "../treasure_pool.h"
#include "../weapon_skill.h"

#include "../ai/ai_container.h"

#include "../ai/states/ability_state.h"
#include "../ai/states/attack_state.h"
#include "../ai/states/death_state.h"
#include "../ai/states/inactive_state.h"
#include "../ai/states/item_state.h"
#include "../ai/states/magic_state.h"
#include "../ai/states/mobskill_state.h"
#include "../ai/states/raise_state.h"
#include "../ai/states/range_state.h"
#include "../ai/states/respawn_state.h"
#include "../ai/states/weaponskill_state.h"

#include "../ai/controllers/mob_controller.h"
#include "../ai/controllers/trust_controller.h"

#include "../ai/helpers/gambits_container.h"

#include "../entities/automatonentity.h"
#include "../entities/charentity.h"
#include "../entities/mobentity.h"
#include "../entities/npcentity.h"
#include "../entities/petentity.h"
#include "../entities/trustentity.h"

#include "../packets/action.h"
#include "../packets/auction_house.h"
#include "../packets/change_music.h"
#include "../packets/char.h"
#include "../packets/char_abilities.h"
#include "../packets/char_appearance.h"
#include "../packets/char_emotion.h"
#include "../packets/char_equip.h"
#include "../packets/char_health.h"
#include "../packets/char_job_extra.h"
#include "../packets/char_jobs.h"
#include "../packets/char_mounts.h"
#include "../packets/char_recast.h"
#include "../packets/char_skills.h"
#include "../packets/char_spells.h"
#include "../packets/char_stats.h"
#include "../packets/char_sync.h"
#include "../packets/char_update.h"
#include "../packets/chat_message.h"
#include "../packets/conquest_map.h"
#include "../packets/entity_animation.h"
#include "../packets/entity_enable_list.h"
#include "../packets/entity_update.h"
#include "../packets/entity_visual.h"
#include "../packets/event.h"
#include "../packets/event_string.h"
#include "../packets/event_update.h"
#include "../packets/event_update_string.h"
#include "../packets/guild_menu.h"
#include "../packets/guild_menu_buy.h"
#include "../packets/independent_animation.h"
#include "../packets/instance_entry.h"
#include "../packets/inventory_assign.h"
#include "../packets/inventory_finish.h"
#include "../packets/inventory_item.h"
#include "../packets/inventory_modify.h"
#include "../packets/inventory_size.h"
#include "../packets/key_items.h"
#include "../packets/linkshell_equip.h"
#include "../packets/menu_jobpoints.h"
#include "../packets/menu_merit.h"
#include "../packets/menu_mog.h"
#include "../packets/menu_raisetractor.h"
#include "../packets/message_basic.h"
#include "../packets/message_combat.h"
#include "../packets/message_name.h"
#include "../packets/message_special.h"
#include "../packets/message_standard.h"
#include "../packets/message_system.h"
#include "../packets/message_text.h"
#include "../packets/position.h"
#include "../packets/quest_mission_log.h"
#include "../packets/release.h"
#include "../packets/roe_questlog.h"
#include "../packets/server_ip.h"
#include "../packets/shop_items.h"
#include "../packets/shop_menu.h"
#include "../packets/timer_bar_util.h"
#include "../packets/weather.h"

#include "../utils/battleutils.h"
#include "../utils/blueutils.h"
#include "../utils/charutils.h"
#include "../utils/guildutils.h"
#include "../utils/instanceutils.h"
#include "../utils/itemutils.h"
#include "../utils/jailutils.h"
#include "../utils/mobutils.h"
#include "../utils/petutils.h"
#include "../utils/puppetutils.h"
#include "../utils/trustutils.h"
#include "../utils/zoneutils.h"

//======================================================//

CLuaBaseEntity::CLuaBaseEntity(CBaseEntity* PEntity)
: m_PBaseEntity(PEntity)
{
    if (PEntity == nullptr)
    {
        ShowError("CLuaBaseEntity created with nullptr instead of valid CBaseEntity*!\n");
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

        PBaseEntity->loc.zone->PushPacket(PBaseEntity, CHAR_INRANGE, new CEntityUpdatePacket(PBaseEntity, ENTITY_UPDATE, UPDATE_POS));
    }

    uint32 param0 = (p0 != sol::nil) ? p0.as<uint32>() : 0;
    uint32 param1 = (p1 != sol::nil) ? p1.as<uint32>() : 0;
    uint32 param2 = (p2 != sol::nil) ? p2.as<uint32>() : 0;
    uint32 param3 = (p3 != sol::nil) ? p3.as<uint32>() : 0;

    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        static_cast<CCharEntity*>(m_PBaseEntity)->pushPacket(new CMessageSpecialPacket(PBaseEntity, messageID, param0, param1, param2, param3));
    }
    else
    {
        m_PBaseEntity->loc.zone->PushPacket(m_PBaseEntity, CHAR_INRANGE, new CMessageSpecialPacket(PBaseEntity, messageID, param0, param1, param3));
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
    CBaseEntity* PTarget  = PLuaBaseEntity->m_PBaseEntity;
    bool         showName = true;
    uint8        mode     = 0;

    bool  faceGiven = false;
    uint8 face = 0;

    // TODO: Clean this up.  We could potentially accept two int vals for optional args, which could cause unexpected showName behavior.
    if (arg2 != sol::nil)
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
            auto table = arg2.as<sol::table>();
            auto faceArg = table.get<sol::object>("face");
            faceGiven = true;

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

    if (arg3 != sol::nil)
    {
        mode = arg3.as<uint8>();
    }

    if (faceGiven)
    {
        PTarget->m_TargID = m_PBaseEntity->targid;
        PTarget->loc.p.rotation = face;
        PTarget->updatemask |= UPDATE_POS;
    }

    if (auto player = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        player->gotMessage = true;
        player->pushPacket(new CMessageTextPacket(PTarget, messageID, showName, mode));
    }
    else
    { // broadcast in range
        m_PBaseEntity->loc.zone->PushPacket(m_PBaseEntity, CHAR_INRANGE, new CMessageTextPacket(PTarget, messageID, showName, mode));
    }
}

/************************************************************************
 *  Function: PrintToPlayer()
 *  Purpose : Displays either standad messages to a PC or custom text
 *  Example : player:PrintToPlayer("Hello!", xi.msg.channel.NS_SAY)
 *          : player:PrintToPlayer(string.format("Hello, %s!", player:getName()), xi.msg.channel.SYSTEM_1)
 *  Notes   : see scripts/globals/msg.lua for message channels
 *          : Can modify the name shown through explicit declaration
 ************************************************************************/

void CLuaBaseEntity::PrintToPlayer(std::string const& message, sol::object messageType, sol::object name)
{
    CHAT_MESSAGE_TYPE int_messageType = (messageType == sol::lua_nil) ? MESSAGE_SYSTEM_1 : messageType.as<CHAT_MESSAGE_TYPE>();
    const char*       cstr_name       = (name == sol::lua_nil) ? "" : name.as<const char*>();

    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        PChar->pushPacket(new CChatMessagePacket(PChar, int_messageType, message, cstr_name));
    }
}

/************************************************************************
 *  Function: PrintToArea()
 *  Purpose : version of PrintToPlayer that passes to messageserver
 *  Example : player:PrintToArea("Im a real boy!", xi.msg.channel.SHOUT, xi.msg.area.SYSTEM, "Pinocchio");
 *          : would print a shout type message from Pinocchio to the entire server
 ************************************************************************/

void CLuaBaseEntity::PrintToArea(std::string const& message, sol::object const& arg1, sol::object const& arg2, sol::object const& arg3)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    // see scripts\globals\msg.lua or src\map\packets\chat_message.h for values
    CHAT_MESSAGE_TYPE messageLook  = (arg1 == sol::nil) ? MESSAGE_SYSTEM_1 : arg1.as<CHAT_MESSAGE_TYPE>();
    uint8             messageRange = (arg2 == sol::nil) ? 0 : arg2.as<CHAT_MESSAGE_TYPE>();
    std::string       name         = (arg3 == sol::nil) ? std::string() : arg3.as<std::string>();

    if (messageRange == 0) // All zones world wide
    {
        message::send(MSG_CHAT_SERVMES, nullptr, 0, new CChatMessagePacket(PChar, messageLook, message, name));
    }
    else if (messageRange == 1) // Say range
    {
        PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, new CChatMessagePacket(PChar, messageLook, message, name));
    }
    else if (messageRange == 2) // Shout
    {
        PChar->loc.zone->PushPacket(PChar, CHAR_INSHOUT, new CChatMessagePacket(PChar, messageLook, message, name));
    }
    else if (messageRange == 3) // Party and Alliance
    {
        message::send(MSG_CHAT_PARTY, nullptr, 0, new CChatMessagePacket(PChar, messageLook, message, name));
    }
    else if (messageRange == 4) // Yell zones only
    {
        message::send(MSG_CHAT_YELL, nullptr, 0, new CChatMessagePacket(PChar, messageLook, message, name));
    }
    /*
    Todo: Unity, LS 1 and LS 2 for the lols?
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
    uint32 param0  = (p0 != sol::nil) ? p0.as<uint32>() : 0;
    uint32 param1  = (p1 != sol::nil) ? p1.as<uint32>() : 0;
    auto*  PTarget = (target != sol::nil) ? target.as<CLuaBaseEntity*>()->m_PBaseEntity : m_PBaseEntity;

    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        static_cast<CCharEntity*>(m_PBaseEntity)->pushPacket(new CMessageBasicPacket(m_PBaseEntity, PTarget, param0, param1, messageID));
    }
    else
    {
        // Broadcast in range
        m_PBaseEntity->loc.zone->PushPacket(m_PBaseEntity, CHAR_INRANGE, new CMessageBasicPacket(m_PBaseEntity, PTarget, param0, param1, messageID));
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
    CLuaBaseEntity* PLuaEntity  = (entity != sol::nil) ? entity.as<CLuaBaseEntity*>() : nullptr;
    CBaseEntity*    PNameEntity = PLuaEntity ? PLuaEntity->m_PBaseEntity : nullptr;

    int32 param0 = (p0 != sol::nil) ? p0.as<int32>() : 0;
    int32 param1 = (p1 != sol::nil) ? p1.as<int32>() : 0;
    int32 param2 = (p2 != sol::nil) ? p2.as<int32>() : 0;
    int32 param3 = (p3 != sol::nil) ? p3.as<int32>() : 0;

    int32 chatType = (chat != sol::nil) ? chat.as<int32>() : 4;

    if (CCharEntity* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        PChar->pushPacket(new CMessageNamePacket(PChar, messageID, PNameEntity, param0, param1, param2, param3, chatType));
    }
    else
    {
        m_PBaseEntity->loc.zone->PushPacket(m_PBaseEntity, CHAR_INRANGE,
                                            new CMessageNamePacket(m_PBaseEntity, messageID, PNameEntity, param0, param1, param2, param3, chatType));
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
    uint32 param0 = (arg2 != sol::nil) ? arg2.as<uint32>() : 0;
    uint32 param1 = (arg3 != sol::nil) ? arg3.as<uint32>() : 0;

    if (PEntity != nullptr)
    {
        m_PBaseEntity->loc.zone->PushPacket(m_PBaseEntity, CHAR_INRANGE_SELF,
                                            new CMessageBasicPacket(m_PBaseEntity, PEntity->GetBaseEntity(), param0, param1, messageID));
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    uint32 param0   = va.get_type(0) == sol::type::number ? va.get<uint32>(0) : 0;
    uint32 param1   = va.get_type(1) == sol::type::number ? va.get<uint32>(1) : 0;
    uint32 param2   = va.get_type(2) == sol::type::number ? va.get<uint32>(2) : 0;
    uint32 param3   = va.get_type(3) == sol::type::number ? va.get<uint32>(3) : 0;
    bool   showName = va.get_type(4) == sol::type::boolean ? va.get<bool>(4) : false;

    static_cast<CCharEntity*>(m_PBaseEntity)->pushPacket(new CMessageSpecialPacket(m_PBaseEntity, messageID, param0, param1, param2, param3, showName));
}

/************************************************************************
 *  Function: messageSystem()
 *  Purpose : Sends a standard system message
 *  Example : player:messageSystem("Text")
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::messageSystem(uint16 messageID, sol::object const& p0, sol::object const& p1)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    uint32 param0 = (p0 != sol::nil) ? p0.as<uint32>() : 0;
    uint32 param1 = (p1 != sol::nil) ? p1.as<uint32>() : 0;

    static_cast<CCharEntity*>(m_PBaseEntity)->pushPacket(new CMessageSystemPacket(param0, param1, messageID));
}

/************************************************************************
 *  Function: messageCombat(...)
 *  Purpose : Various combat related messages are ended with this packet
 *  Example : master:messageCombat(mob, offset + id, 0, 711)
 *  Notes   :
 ************************************************************************/
void CLuaBaseEntity::messageCombat(sol::object const& speaker, int32 p0, int32 p1, int16 message)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    CBaseEntity* PSpeaker;
    if (speaker != sol::nil)
    {
        CLuaBaseEntity* PLuaBaseEntity = speaker.as<CLuaBaseEntity*>();
        PSpeaker                       = PLuaBaseEntity->m_PBaseEntity;
    }
    else
    {
        PSpeaker = m_PBaseEntity;
    }

    PChar->pushPacket(new CMessageCombatPacket(PSpeaker, PChar, p0, p1, message));
}

/************************************************************************
 *  Function: getCharVar()
 *  Purpose : Returns a var value assigned to a PC (in char_vars.sql)
 *  Example : local status = player:getCharVar("[ZM]Status")
 *  Notes   :
 ************************************************************************/

int32 CLuaBaseEntity::getCharVar(std::string const& varName)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);
    auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity);
    return charutils::GetCharVar(PChar, varName.c_str());
}

/************************************************************************
 *  Function: setCharVar()
 *  Purpose : Updates PC's variable to an explicit value
 *  Example : player:setCharVar("[ZM]Status", 4)
 *  Notes   : Passing a '0' value will delete the variable
 ************************************************************************/

void CLuaBaseEntity::setCharVar(std::string const& varName, int32 value)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);
    auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity);
    return charutils::SetCharVar(PChar, varName.c_str(), value);
}

/************************************************************************
 *  Function: addCharVar()
 *  Purpose : Increments PC's variable by an explicit amount
 *  Example : player:addCharVar("[ZM]Status", 1) -- if 4, becomes 5
 *  Notes   : Can use values greater than 1 to increment more
 ************************************************************************/

void CLuaBaseEntity::addCharVar(std::string const& varName, int32 value)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    const char* Query = "INSERT INTO char_vars SET charid = %u, varname = '%s', value = %i ON DUPLICATE KEY UPDATE value = value + %i;";

    Sql_Query(SqlHandle, Query, m_PBaseEntity->id, varName, value, value);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);
    auto player = dynamic_cast<CCharEntity*>(m_PBaseEntity);

    if (!player)
    {
        return;
    }

    charutils::ClearCharVarsWithPrefix(player, prefix);
}

/************************************************************************
 *  Function: getLastOnline()
 *  Purpose : Returns the unix timestamp of the last time the char logged off or zoned
 *  Example : player:getLastOnline()
 *  Notes   :
 ************************************************************************/

uint32 CLuaBaseEntity::getLastOnline()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    uint8 size = 0;
    FILE* File = fopen(filename.c_str(), "rb");

    if (File)
    {
        CBasicPacket* PPacket = new CBasicPacket();

        fseek(File, 1, SEEK_SET);
        if (fread(&size, 1, 1, File) != 1)
        {
            ShowError(CL_RED "CLuaBaseEntity::injectPacket : Did not read size\n" CL_RESET);
            return;
        }

        fseek(File, 0, SEEK_SET);
        if (fread(*PPacket, 1, size * 2, File) != size * 2)
        {
            ShowError(CL_RED "CLuaBaseEntity::injectPacket : Did not read entire packet\n" CL_RESET);
            return;
        }

        ((CCharEntity*)m_PBaseEntity)->pushPacket(PPacket);

        fclose(File);
    }
    else
    {
        ShowError(CL_RED "CLuaBaseEntity::injectPacket : Cannot open file\n" CL_RESET);
    }
}

/************************************************************************
 *  Function: injectActionPacket()
 *  Purpose : Used for testing and finding animations, not production use
 *  Example : player:injectActionPacket(actID, animID, spEffect, react, msg);
 *  Notes   : Used only for testing through injectaction.lua command
 *            ONLY FOR DEBUGGING. Injects an action packet with the specified params.
 ************************************************************************/

void CLuaBaseEntity::injectActionPacket(uint16 action, uint16 anim, uint16 spec, uint16 react, uint16 message)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    CCharEntity* PChar = (CCharEntity*)m_PBaseEntity;

    SPECEFFECT speceffect = static_cast<SPECEFFECT>(spec);
    REACTION   reaction   = static_cast<REACTION>(react);

    ACTIONTYPE actiontype = ACTION_MAGIC_FINISH;
    switch (action)
    {
        case 3:
            actiontype = ACTION_WEAPONSKILL_FINISH;
            break;
        case 4:
            actiontype = ACTION_MAGIC_FINISH;
            break;
        case 5:
            actiontype = ACTION_ITEM_FINISH;
            break;
        case 6:
            actiontype = ACTION_JOBABILITY_FINISH;
            break;
        case 8:
            actiontype = ACTION_MAGIC_START;
            break;
        case 11:
            actiontype = ACTION_MOBABILITY_FINISH;
            break;
        case 13:
            actiontype = ACTION_PET_MOBABILITY_FINISH;
            break;
        case 14:
            actiontype = ACTION_DANCE;
            break;
    }

    action_t Action;

    Action.id       = PChar->id;
    Action.actionid = 1;

    // If you use ACTION_MOBABILITY_FINISH, the first param = anim, the second param = skill id.
    if (actiontype == ACTION_MOBABILITY_FINISH || actiontype == ACTION_PET_MOBABILITY_FINISH)
    {
        CBattleEntity* PTarget = (CBattleEntity*)PChar->GetEntity(PChar->m_TargID);
        if (PTarget == nullptr)
        {
            ShowError("Cannot use MOBABILITY_FINISH on a nullptr battle target! Target a mob! \n");
            return;
        }
        Action.id              = PTarget->id;
        Action.actiontype      = actiontype;
        actionList_t& list     = Action.getNewActionList();
        list.ActionTargetID    = PChar->id;
        actionTarget_t& target = list.getNewActionTarget();
        target.animation       = anim;
        target.param           = 10;
        target.messageID       = message;
        PTarget->loc.zone->PushPacket(PTarget, CHAR_INRANGE, new CActionPacket(Action));
        return;
    }

    Action.actiontype      = actiontype;
    actionList_t& list     = Action.getNewActionList();
    list.ActionTargetID    = PChar->id;
    actionTarget_t& target = list.getNewActionTarget();
    target.animation       = anim;
    target.param           = 10;
    target.messageID       = message;
    target.speceffect      = speceffect;
    target.reaction        = reaction;

    if (actiontype == ACTION_MAGIC_START)
    {
        SPELLGROUP castType = static_cast<SPELLGROUP>(anim);
        uint16     castAnim = spec;

        Action.spellgroup = castType;
        Action.actiontype = actiontype;
        target.reaction   = REACTION::NONE;
        target.speceffect = SPECEFFECT::NONE;
        if (!castAnim)
        {
            target.animation = 0;
        }
        else
        {
            target.animation = castAnim;
        }
        target.param     = message;
        target.messageID = 327; // starts casting
        return;
    }

    PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE_SELF, new CActionPacket(Action));
}

/************************************************************************
 *  Function: entityVisualPacket()
 *  Purpose : Sends a visual packet to the PC
 *  Example : player:entityVisualPacket("byc7")
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::entityVisualPacket(std::string const& command, sol::object const& entity)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    CBaseEntity* PNpc = nullptr;
    if (entity != sol::nil)
    {
        CLuaBaseEntity* PLuaBaseEntity = entity.as<CLuaBaseEntity*>(); // nullptr;
        PNpc                           = PLuaBaseEntity->m_PBaseEntity;
    }

    static_cast<CCharEntity*>(m_PBaseEntity)->pushPacket(new CEntityVisualPacket(PNpc, command.c_str()));
}

/************************************************************************
 *  Function: entityAnimationPacket()
 *  Purpose : Sends an animation packet to the entity
 *  Example : mob:entityAnimationPacket("sp00")
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::entityAnimationPacket(const char* command)
{
    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        static_cast<CCharEntity*>(m_PBaseEntity)->pushPacket(new CEntityAnimationPacket(m_PBaseEntity, command));
    }
    else
    {
        m_PBaseEntity->loc.zone->PushPacket(m_PBaseEntity, CHAR_INRANGE, new CEntityAnimationPacket(m_PBaseEntity, command));
    }
}

/************************************************************************
 *  Function: startEvent()
 *  Purpose : Starts an event (cutscene)
 *  Example : player:startEvent(4)
 *          : player:startEvent(csid, op1, op2, op3, op4, op5, op6, op7, op8, texttable)
 *  Notes   : Cutscene ID must be associated with the zone
 *            https://sol2.readthedocs.io/en/latest/api/variadic_args.html
 *            Arguments listed after sol::variadic_args are INCLUDED in it at position 0!
 ************************************************************************/

void CLuaBaseEntity::startEvent(uint32 EventID, sol::variadic_args va)
{
    auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity);
    auto* PNpc  = PChar->m_event.Target;

    if (!PChar)
    {
        ShowError("CLuaBaseEntity::startEvent: Could not start event, Base Entity is not a Character Entity.\n");
        return;
    }

    if (PChar->animation == ANIMATION_HEALING)
    {
        PChar->StatusEffectContainer->DelStatusEffect(EFFECT_HEALING);
    }

    if (PChar->PPet)
    {
        PChar->PPet->PAI->Disengage();
    }

    if (PNpc && PNpc->objtype == TYPE_NPC)
    {
        PNpc->SetLocalVar("pauseNPCPathing", 1);

        if (PNpc->PAI->PathFind != nullptr)
        {
            PNpc->PAI->PathFind->Clear();
        }
    }

    uint32 param0 = va.get_type(0) == sol::type::number ? va.get<uint32>(0) : 0;
    uint32 param1 = va.get_type(1) == sol::type::number ? va.get<uint32>(1) : 0;
    uint32 param2 = va.get_type(2) == sol::type::number ? va.get<uint32>(2) : 0;
    uint32 param3 = va.get_type(3) == sol::type::number ? va.get<uint32>(3) : 0;
    uint32 param4 = va.get_type(4) == sol::type::number ? va.get<uint32>(4) : 0;
    uint32 param5 = va.get_type(5) == sol::type::number ? va.get<uint32>(5) : 0;
    uint32 param6 = va.get_type(6) == sol::type::number ? va.get<uint32>(6) : 0;
    uint32 param7 = va.get_type(7) == sol::type::number ? va.get<uint32>(7) : 0;

    int16 textTable = va.get_type(8) == sol::type::number ? va.get<int16>(8) : -1;

    PChar->pushPacket(new CEventPacket(PChar, EventID, va.size(),
                                       param0, param1, param2, param3, param4, param5, param6, param7,
                                       textTable));

    // if you want to return a dummy result, then do it
    if (textTable != -1)
    {
        PChar->m_event.Option = textTable;
    }

    PChar->m_Substate = CHAR_SUBSTATE::SUBSTATE_IN_CS;
}

/************************************************************************
 *  Function: startEventString()
 *  Purpose : Starts an event (cutscene) with string parameters (0x33 packet)
 *  Example : Too long to show
 *  Notes   : See scripts/zones/Aht_Urhgan_Whitegate/npcs/Ghatsad.lua
 ************************************************************************/

void CLuaBaseEntity::startEventString(uint16 EventID, sol::variadic_args va)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity);
    if (!PChar)
    {
        ShowError("CLuaBaseEntity::startEventString: Could not start event, Base Entity is not a Character Entity.\n");
        return;
    }

    if (PChar->animation == ANIMATION_HEALING)
    {
        PChar->StatusEffectContainer->DelStatusEffect(EFFECT_HEALING);
    }

    if (PChar->PPet)
    {
        PChar->PPet->PAI->Disengage();
    }

    string_t string0 = va.get_type(0) == sol::type::string ? va.get<std::string>(0) : "";
    string_t string1 = va.get_type(1) == sol::type::string ? va.get<std::string>(1) : "";
    string_t string2 = va.get_type(2) == sol::type::string ? va.get<std::string>(2) : "";
    string_t string3 = va.get_type(3) == sol::type::string ? va.get<std::string>(3) : "";

    uint32 param0 = va.get_type(4) == sol::type::number ? va.get<uint32>(4) : 0;
    uint32 param1 = va.get_type(5) == sol::type::number ? va.get<uint32>(5) : 0;
    uint32 param2 = va.get_type(6) == sol::type::number ? va.get<uint32>(6) : 0;
    uint32 param3 = va.get_type(7) == sol::type::number ? va.get<uint32>(7) : 0;
    uint32 param4 = va.get_type(8) == sol::type::number ? va.get<uint32>(8) : 0;
    uint32 param5 = va.get_type(9) == sol::type::number ? va.get<uint32>(9) : 0;
    uint32 param6 = va.get_type(10) == sol::type::number ? va.get<uint32>(10) : 0;
    uint32 param7 = va.get_type(11) == sol::type::number ? va.get<uint32>(11) : 0;

    PChar->pushPacket(
        new CEventStringPacket(PChar, EventID, string0, string1, string2, string3, param0, param1, param2, param3, param4, param5, param6, param7));
}

/************************************************************************
 *  Function: updateEvent()
 *  Purpose : Sends new arguments to an event
 *  Example : player:updateEvent(ring[1],ring[2],ring[3])
 *  Notes   : Ex: CoP ring selection uses this to redisplay correct order of rings
 ************************************************************************/

void CLuaBaseEntity::updateEvent(sol::variadic_args va)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    uint32 param0 = va.get_type(0) == sol::type::number ? va.get<uint32>(0) : 0;
    uint32 param1 = va.get_type(1) == sol::type::number ? va.get<uint32>(1) : 0;
    uint32 param2 = va.get_type(2) == sol::type::number ? va.get<uint32>(2) : 0;
    uint32 param3 = va.get_type(3) == sol::type::number ? va.get<uint32>(3) : 0;
    uint32 param4 = va.get_type(4) == sol::type::number ? va.get<uint32>(4) : 0;
    uint32 param5 = va.get_type(5) == sol::type::number ? va.get<uint32>(5) : 0;
    uint32 param6 = va.get_type(6) == sol::type::number ? va.get<uint32>(6) : 0;
    uint32 param7 = va.get_type(7) == sol::type::number ? va.get<uint32>(7) : 0;

    static_cast<CCharEntity*>(m_PBaseEntity)->pushPacket(new CEventUpdatePacket(param0, param1, param2, param3, param4, param5, param6, param7));
}

/************************************************************************
 *  Function: updateEventString()
 *  Purpose : Sends a string to an event in progress
 *  Example : player:updateEventString(name)
 *  Notes   : Used by BCNM to display record holder's name
 ************************************************************************/

void CLuaBaseEntity::updateEventString(sol::variadic_args va)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
        ->pushPacket(new CEventUpdateStringPacket(string0, string1, string2, string3, param0, param1, param2, param3, param4, param5, param6, param7, param8));
}

/************************************************************************
 *  Function: getEventTarget()
 *  Purpose : Returns object data of the NPC in the event
 *  Example : local npc = player:getEventTarget()
 *  Notes   : Used to relocate Siren's Tear, as an example
 ************************************************************************/

std::optional<CLuaBaseEntity> CLuaBaseEntity::getEventTarget()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = (CCharEntity*)m_PBaseEntity;
    if (PChar->m_event.Target == nullptr)
    {
        ShowWarning(CL_YELLOW "EventTarget is empty: %s\n" CL_RESET, m_PBaseEntity->GetName());
        return std::nullopt;
    }

    return std::optional<CLuaBaseEntity>(PChar->m_event.Target);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    RELEASE_TYPE releaseType = RELEASE_TYPE::STANDARD;

    if (PChar->m_event.EventID != -1)
    {
        // Message: Event skipped
        releaseType = RELEASE_TYPE::SKIPPING;
        PChar->pushPacket(new CMessageSystemPacket(0, 0, 117));
    }

    PChar->inSequence = false;
    PChar->pushPacket(new CReleasePacket(PChar, releaseType));
    PChar->pushPacket(new CReleasePacket(PChar, RELEASE_TYPE::EVENT));
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
 *  Function: setFlag()
 *  Purpose : Sets a flag for a PC
 *  Example : player:setFlag(FLAG_GM)
 *  Notes   : Also used for Regain and Spike spell effects
 ************************************************************************/

void CLuaBaseEntity::setFlag(uint32 flags)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    static_cast<CCharEntity*>(m_PBaseEntity)->nameflags.flags ^= flags;
    m_PBaseEntity->updatemask |= UPDATE_HP;
}

/************************************************************************
 *  Function: setMoghouseFlag()
 *  Purpose : Creates or returns exit flag for Mog House
 *  Example : player:moghouseFlag(2)
 *  Notes   :  Used in Mog House exit quests (ex. A Lady's Heart)
 ************************************************************************/

void CLuaBaseEntity::setMoghouseFlag(uint8 flag)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->profile.mhflag |= flag;
    charutils::SaveCharStats(PChar);
}

/************************************************************************
 *  Function: getMoghouseFlag()
 *  Purpose : Returns exit flag for Mog House
 *  Example :
 *  Notes   :  Used in Mog House exit quests (ex. A Lady's Heart)
 ************************************************************************/

uint8 CLuaBaseEntity::getMoghouseFlag()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    return PChar->profile.mhflag;
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
    if (arg0 != sol::nil)
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
 *  Function: getShortID()
 *  Purpose : Gets the ID of a Target
 *  Example : mob:getShortID(); pet:getShortID()
 *  Notes   : To Do: Should be renamed to getTargID
 ************************************************************************/

uint16 CLuaBaseEntity::getShortID()
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

uint8 CLuaBaseEntity::getObjType()
{
    return m_PBaseEntity->objtype;
}

/************************************************************************
 *  Function: isPC()
 *  Purpose : Returns true if entity is of the PC object type
 *  Example : if target:isPC() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isPC()
{
    return m_PBaseEntity->objtype == TYPE_PC;
}

/************************************************************************
 *  Function: isNPC()
 *  Purpose : Returns true if entity is of the NPC object type
 *  Example : if target:isNPC() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isNPC()
{
    return m_PBaseEntity->objtype == TYPE_NPC;
}

/************************************************************************
 *  Function: isMob()
 *  Purpose : Returns true if entity is of the Mob object type
 *  Example : if target:isMob() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isMob()
{
    return m_PBaseEntity->objtype == TYPE_MOB;
}

/************************************************************************
 *  Function: isPet()
 *  Purpose : Returns true if entity is of the Pet object type
 *  Example : if caster:isPet() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isPet()
{
    return m_PBaseEntity->objtype == TYPE_PET;
}

/************************************************************************
 *  Function: isAlly()
 *  Purpose : Returns true if entity is an ally
 *  Example : if mob:isAlly() then table.insert(allies, mob) end
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isAlly()
{
    return m_PBaseEntity->objtype == TYPE_MOB && m_PBaseEntity->allegiance == ALLEGIANCE_TYPE::PLAYER;
}

/************************************************************************
 *  Function: initNpcAi()
 *  Purpose : Initiate pre-defined NPC AI
 *  Example : npc:initNpcAi(); -- Red Ghost in Port Jeuno (walks a path)
 *  Notes   : To Do: Change name, this is ugly
 ************************************************************************/

void CLuaBaseEntity::initNpcAi()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_NPC);

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
 *          : See globals/status.lua for action definitions
 ************************************************************************/

uint8 CLuaBaseEntity::getCurrentAction()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    uint8 action = 0;

    if (m_PBaseEntity->PAI->IsStateStackEmpty())
    {
        action = 16;
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
    else if (m_PBaseEntity->PAI->IsCurrentState<CRaiseState>())
    {
        action = 37;
    }
    else if (m_PBaseEntity->PAI->IsCurrentState<CMobSkillState>())
    {
        action = 34;
    }
    else
    {
        ShowWarning("getCurrentAction: Unhandled State for %s, defaulting to NONE (0).\n", m_PBaseEntity->GetName());
    }

    return action;
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

    if ((arg0 != sol::nil) && (arg0.is<double>()))
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

    m_PBaseEntity->loc.p.rotation = worldAngle(m_PBaseEntity->loc.p, point);
    m_PBaseEntity->updatemask |= UPDATE_POS;
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
    m_PBaseEntity->loc.zone->PushPacket(m_PBaseEntity, CHAR_INRANGE, new CEntityUpdatePacket(m_PBaseEntity, ENTITY_UPDATE, UPDATE_POS));
}

/************************************************************************
 *  Function: atPoint()
 *  Purpose : Used to check whether an entity is at a specified point in the specified path
 *  Example : if npc:atPoint(pathfind.get(path, 45)) then
 *  Notes   : Used to trigger delays, messages, etc (Ex: Patroller in West Ronfaure)
 ************************************************************************/

bool CLuaBaseEntity::atPoint(sol::variadic_args va)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity == nullptr);

    float posX = 0;
    float posY = 0;
    float posZ = 0;

    if (va.get_type(0) == sol::type::number)
    {
        posX = va.get<float>(0);
        posY = va.get<float>(1);
        posZ = va.get<float>(2);
    }
    else if (va.get_type(0) == sol::type::table)
    {
        auto table = va.get<sol::table>(0);
        auto vec   = table.as<std::vector<float>>();

        posX = vec[0];
        posY = vec[1];
        posZ = vec[2];
    }

    return m_PBaseEntity->loc.p.x == posX && m_PBaseEntity->loc.p.y == posY && m_PBaseEntity->loc.p.z == posZ;
}

/************************************************************************
 *  Function: pathTo()
 *  Purpose : Makes a non-PC move toward a target without changing action
 *  Example : mob:pathTo(Pos.x + math.cos(radians) * 16, Pos.y, Pos.z + math.sin(radians) * 16);
 *  Notes   : Currently only used by Selh'Teus during final CoP fight
 ************************************************************************/

void CLuaBaseEntity::pathTo(float x, float y, float z, sol::object const& flags)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_PC);

    position_t point;
    point.x = x;
    point.y = y;
    point.z = z;

    if (m_PBaseEntity->PAI->PathFind)
    {
        uint8 pathFlags = (flags != sol::nil) ? flags.as<uint8>() : (PATHFLAG_RUN | PATHFLAG_WALLHACK | PATHFLAG_SCRIPT);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity == nullptr);

    std::vector<position_t> points;

    // Grab points from array and store in points array
    for (uint8 i = 1; i < pointsTable.size(); i += 3)
    {
        points.push_back({ (float)pointsTable[i], (float)pointsTable[i + 1], (float)pointsTable[i + 2], 0, 0 });
    }

    uint8 flags = 0;

    if (flagsObj.is<uint8>())
    {
        flags = flagsObj.as<uint8>();
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
    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);

    return PBattle->PAI->PathFind != nullptr && PBattle->PAI->PathFind->IsFollowingPath();
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

    if (PBattle->PAI->PathFind != nullptr)
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_PC);

    auto* PBattle  = static_cast<CBattleEntity*>(m_PBaseEntity);
    int32 waitTime = (milliseconds != sol::nil) ? milliseconds.as<uint32>() : 4000;

    PBattle->PAI->Inactive(std::chrono::milliseconds(waitTime), true);
}

/************************************************************************
 *  Function: openDoor()
 *  Purpose : Opens a door for 7 seconds; different time can be specified
 *  Example : npc:openDoor(30) -- Open for 30 sec; npc:openDoor() -- 7 sec
 ************************************************************************/

void CLuaBaseEntity::openDoor(sol::object const& seconds)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_NPC);

    if (m_PBaseEntity->animation == ANIMATION_CLOSE_DOOR)
    {
        uint32 OpenTime = (seconds != sol::nil) ? seconds.as<uint32>() * 1000 : 7000;

        m_PBaseEntity->animation = ANIMATION_OPEN_DOOR;
        m_PBaseEntity->loc.zone->PushPacket(m_PBaseEntity, CHAR_INRANGE, new CEntityUpdatePacket(m_PBaseEntity, ENTITY_UPDATE, UPDATE_COMBAT));

        m_PBaseEntity->PAI->QueueAction(queueAction_t(std::chrono::milliseconds(OpenTime), false, [](CBaseEntity* PNpc) {
            PNpc->animation = ANIMATION_CLOSE_DOOR;
            PNpc->loc.zone->PushPacket(PNpc, CHAR_INRANGE, new CEntityUpdatePacket(PNpc, ENTITY_UPDATE, UPDATE_COMBAT));
        }));
    }
}

/************************************************************************
 *  Function: closeDoor()
 *  Purpose : Closes a door for 7 seconds; different delay can be specified
 *  Example : npc:closeDoor(); GetNPCByID(ID.npc.LANTERN):closeDoor(1)
 ************************************************************************/

void CLuaBaseEntity::closeDoor(sol::object const& seconds)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity == nullptr);
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_NPC);

    if (m_PBaseEntity->animation == ANIMATION_OPEN_DOOR)
    {
        uint32 CloseTime         = (seconds != sol::nil) ? seconds.as<uint32>() * 1000 : 7000;
        m_PBaseEntity->animation = ANIMATION_CLOSE_DOOR;
        m_PBaseEntity->loc.zone->PushPacket(m_PBaseEntity, CHAR_INRANGE, new CEntityUpdatePacket(m_PBaseEntity, ENTITY_UPDATE, UPDATE_COMBAT));

        m_PBaseEntity->PAI->QueueAction(queueAction_t(std::chrono::milliseconds(CloseTime), false, [](CBaseEntity* PNpc) {
            PNpc->animation = ANIMATION_OPEN_DOOR;
            PNpc->loc.zone->PushPacket(PNpc, CHAR_INRANGE, new CEntityUpdatePacket(PNpc, ENTITY_UPDATE, UPDATE_COMBAT));
        }));
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_NPC);

    Elevator_t elevator;

    elevator.id                 = id;
    elevator.LowerDoor          = static_cast<CNpcEntity*>(zoneutils::GetEntity(lowerDoor, TYPE_NPC));
    elevator.UpperDoor          = static_cast<CNpcEntity*>(zoneutils::GetEntity(upperDoor, TYPE_NPC));
    elevator.Elevator           = static_cast<CNpcEntity*>(zoneutils::GetEntity(elevatorId, TYPE_NPC));
    elevator.animationsReversed = reversed;

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

    elevator.Elevator->name.resize(10);
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

    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_NPC);

    Trigger_t trigger;

    trigger.id           = id;
    trigger.period       = period;
    trigger.minuteOffset = minOffset;
    trigger.npc          = dynamic_cast<CNpcEntity*>(zoneutils::GetEntity(m_PBaseEntity->id, TYPE_NPC));

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_NPC);

    uint32 showTime = (seconds != sol::nil) ? seconds.as<uint32>() * 1000 : 15000;

    m_PBaseEntity->status = STATUS_TYPE::NORMAL;
    m_PBaseEntity->loc.zone->PushPacket(m_PBaseEntity, CHAR_INRANGE, new CEntityUpdatePacket(m_PBaseEntity, ENTITY_UPDATE, UPDATE_COMBAT));

    m_PBaseEntity->PAI->QueueAction(queueAction_t(std::chrono::milliseconds(showTime), false, [](CBaseEntity* PNpc) {
        PNpc->status = STATUS_TYPE::DISAPPEAR;
        PNpc->loc.zone->PushPacket(PNpc, CHAR_INRANGE, new CEntityUpdatePacket(PNpc, ENTITY_DESPAWN, UPDATE_NONE));
    }));
}

/************************************************************************
 *  Function: hideNPC()
 *  Purpose : Hides an NPC for a set amount of time
 *  Example : npc:hideNPC(30) -- Will hide for 30 seconds
 *  Notes   : Default is 15 seconds
 ************************************************************************/

void CLuaBaseEntity::hideNPC(sol::object const& seconds)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_NPC);

    if (m_PBaseEntity->status == STATUS_TYPE::NORMAL)
    {
        uint32 hideTime = (seconds != sol::nil) ? seconds.as<uint32>() * 1000 : 15000;

        m_PBaseEntity->status = STATUS_TYPE::DISAPPEAR;
        m_PBaseEntity->loc.zone->PushPacket(m_PBaseEntity, CHAR_INRANGE, new CEntityUpdatePacket(m_PBaseEntity, ENTITY_DESPAWN, UPDATE_NONE));

        m_PBaseEntity->PAI->QueueAction(queueAction_t(std::chrono::milliseconds(hideTime), false, [](CBaseEntity* PNpc) {
            PNpc->status = STATUS_TYPE::NORMAL;
            PNpc->loc.zone->PushPacket(PNpc, CHAR_INRANGE, new CEntityUpdatePacket(PNpc, ENTITY_UPDATE, UPDATE_COMBAT));
        }));
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_NPC);

    if (m_PBaseEntity->status == STATUS_TYPE::DISAPPEAR)
    {
        uint32 hideTime = (seconds != sol::nil) ? seconds.as<uint32>() * 1000 : 15000;

        m_PBaseEntity->PAI->QueueAction(queueAction_t(std::chrono::milliseconds(hideTime), false, [](CBaseEntity* PNpc) {
            PNpc->status = STATUS_TYPE::NORMAL;
            PNpc->loc.zone->PushPacket(PNpc, CHAR_INRANGE, new CEntityUpdatePacket(PNpc, ENTITY_UPDATE, UPDATE_COMBAT));
        }));
    }
}

/************************************************************************
 *  Function: getWeather()
 *  Purpose : Returns the current weather status
 *  Example : if player:getWeather() == xi.weather.WIND then
 ************************************************************************/

uint8 CLuaBaseEntity::getWeather()
{
    WEATHER weather = WEATHER_NONE;

    if (m_PBaseEntity->objtype & TYPE_PC || m_PBaseEntity->objtype & TYPE_MOB)
    {
        weather = battleutils::GetWeather(static_cast<CBattleEntity*>(m_PBaseEntity), false);
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
 *  Function: ChangeMusic()
 *  Purpose : Select a new .bgw file to play on the client
 *  Example : player:ChangeMusic(5,84)
 *  Notes   : Used for mounting Chocobo and changing Jeuno music in Winter
 ************************************************************************/

void CLuaBaseEntity::ChangeMusic(uint8 blockID, uint8 musicTrackID)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    PChar->pushPacket(new CChangeMusicPacket(blockID, musicTrackID));
}

/************************************************************************
 *  Function: sendMenu()
 *  Purpose : Sends a menu to the PC (Ex: Auction, Mog House, Shop)
 *  Example : player:sendMenu(3)
 ************************************************************************/

void CLuaBaseEntity::sendMenu(uint32 menu)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    switch (menu)
    {
        case 1:
            PChar->pushPacket(new CMenuMogPacket());
            break;
        case 2:
            PChar->pushPacket(new CShopMenuPacket(PChar));
            PChar->pushPacket(new CShopItemsPacket(PChar));
            break;
        case 3:
            PChar->pushPacket(new CAuctionHousePacket(2));
            break;
        default:
            ShowDebug("Menu %i not implemented, yet.\n", menu);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);
    XI_DEBUG_BREAK_IF(open > close);

    uint8 VanadielHour = (uint8)CVanaTime::getInstance()->getHour();
    // uint8 VanadielDay = (uint8)CVanaTime::getInstance()->getWeekday();

    GUILDSTATUS status = GUILD_OPEN;

    /*
     * No more guild holidays since 2014
    if (VanadielDay == holiday)
    {
        status = GUILD_HOLYDAY;
    }
    */
    if ((VanadielHour < open) || (VanadielHour >= close))
    {
        status = GUILD_CLOSE;
    }

    CItemContainer* PGuildShop = guildutils::GetGuildShop(guildID);
    auto*           PChar      = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->PGuildShop = PGuildShop;
    PChar->pushPacket(new CGuildMenuPacket(status, open, close, holiday));

    if (status == GUILD_OPEN)
    {
        PChar->pushPacket(new CGuildMenuBuyPacket(PChar, PGuildShop));
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    charutils::OpenSendBox(static_cast<CCharEntity*>(m_PBaseEntity));
}

/************************************************************************
 *  Function: leaveGame()
 *  Purpose : Forces a client shutdown
 *  Example : player:leaveGame()
 *  Notes   : Used for logoff commands
 ************************************************************************/

void CLuaBaseEntity::leaveGame()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->status = STATUS_TYPE::SHUTDOWN;
    charutils::SendToZone(PChar, 1, 0);
}

/************************************************************************
 *  Function: sendEmote()
 *  Purpose : Makes a player entity emit an emote.
 *  Example : player:sendEmote(npc, xi.emote.EXCAVATION, xi.emoteMode.MOTION)
 *  Notes   : Currently only used for HELM animations.
 ************************************************************************/

void CLuaBaseEntity::sendEmote(CLuaBaseEntity* target, uint8 emID, uint8 emMode)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC)

    auto* const PChar   = dynamic_cast<CCharEntity*>(m_PBaseEntity);
    auto* const PTarget = dynamic_cast<CCharEntity*>(target->GetBaseEntity());

    if (PChar && PTarget)
    {
        const auto emoteID   = static_cast<Emote>(emID);
        const auto emoteMode = static_cast<EmoteMode>(emMode);

        PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE,
                                    new CCharEmotionPacket(PChar, PTarget->id, PTarget->targid, emoteID, emoteMode, 0));
    }
}

/************************************************************************
 *  Function: getWorldAngle()
 *  Purpose : Returns angle between two entities, relative to cardinal direction
 *  Example : player:worldAngle(target)
 *  Notes   : Target is... 0: east; 64: south; 128: west, 192: north
 *            Default angle is 255-based mob rotation value - NOT a 360 angle
 ************************************************************************/

int16 CLuaBaseEntity::getWorldAngle(CLuaBaseEntity const* target, sol::object const& deg)
{
    int16 angle   = worldAngle(m_PBaseEntity->loc.p, target->GetBaseEntity()->loc.p);
    int16 degrees = (deg != sol::nil) ? deg.as<int16>() : 256;

    if (degrees != 256)
    {
        if (degrees % 4 == 0)
        {
            angle = static_cast<int16>(round((angle * M_PI / 128) * (degrees / (2 * M_PI))));
            angle = angle % degrees; // If we rounded up to the "final" angle, we want the starting angle
        }
        else
        {
            ShowError(CL_RED "getWorldAngle: Called with degrees %d which isn't multiple of 4 \n" CL_RESET, degrees);
        }
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
    uint8 angle = (angleArg != sol::nil) ? angleArg.as<uint8>() : 64;

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
    uint8 angle = (angleArg != sol::nil) ? angleArg.as<uint8>() : 64;

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
    uint8 angle = (angleArg != sol::nil) ? angleArg.as<uint8>() : 64;

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
    uint8 angle = (angleArg != sol::nil) ? angleArg.as<uint8>() : 64;

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
    else if (m_PBaseEntity->loc.destination && (arg0 != sol::nil) && arg0.is<bool>() && arg0.as<bool>() != false)
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

auto CLuaBaseEntity::getZoneName() -> const char*
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->loc.zone == nullptr);

    // TODO: Fix c-style cast
    return (const char*)m_PBaseEntity->loc.zone->GetName();
}

/************************************************************************
 *  Function: isZoneVisited()
 *  Purpose : Returns true if a player has ever visited the zone
 *  Example : if not target:isZoneVisited(xi.zone.BIBIKI_BAY) then
 *  Notes   : Mainly used for teleport items (like to Bibiki Bay)
 ************************************************************************/

bool CLuaBaseEntity::isZoneVisited(uint16 zone)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    return static_cast<CCharEntity*>(m_PBaseEntity)->m_moghouseID;
}
/************************************************************************
*  Function: getPlayerRegionInZone
*  Purpose : Returns the player's current region inside the zone
*  Example : local regionID = player:getPlayerRegionInZone()
*  Notes   : This refers to regions added via the registerRegion function
             Currently only used for port bastok drawbridge
************************************************************************/
uint32 CLuaBaseEntity::getPlayerRegionInZone()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    return PChar->m_InsideRegionID;
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_NPC);

    auto* PNpc          = static_cast<CNpcEntity*>(m_PBaseEntity);
    bool  updateForTime = (matchTime != sol::nil) ? matchTime.as<bool>() : false;

    PNpc->status    = static_cast<STATUS_TYPE>(statusID);
    PNpc->animation = animation;

    // If this flag is high, update the NPC's name to match the current time
    if (updateForTime == true)
    {
        PNpc->name.resize(10);
        ref<uint32>(&PNpc->name[0], 4) = CVanaTime::getInstance()->getVanaTime();
        PNpc->name[8]                  = 8;
    }

    PNpc->loc.zone->PushPacket(nullptr, CHAR_INZONE, new CEntityUpdatePacket(PNpc, ENTITY_UPDATE, UPDATE_COMBAT));
}
/************************************************************************
 *  Function: getPos()
 *  Purpose : Returns a table of signed coordinates (x,y,z,rot)
 *  Example : local pos = battletarget:getPos() -- pos becomes a Lua table
 *  Notes   : Access values with key identifiers (pos.x or pos.y)
 ************************************************************************/

auto CLuaBaseEntity::getPos() -> sol::table
{
    auto pos = luautils::lua.create_table();

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    // TODO: Fix c-style cast
    static_cast<CCharEntity*>(m_PBaseEntity)
        ->pushPacket(new CMessageStandardPacket((int32)m_PBaseEntity->loc.p.x, (int32)m_PBaseEntity->loc.p.y, (int32)m_PBaseEntity->loc.p.z,
                                                m_PBaseEntity->loc.p.rotation, MsgStd::Compass));
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
    float x = 0;
    float y = 0;
    float z = 0;
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
        ShowError("CLuaBaseEntity::setPos() - Received non-table or float value for first parameter!\n");
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
        if (va[4].is<double>())
        {
            auto zoneid = va[4].as<uint16>();
            if (zoneid >= MAX_ZONEID)
            {
                return;
            }

            ((CCharEntity*)m_PBaseEntity)->loc.destination = zoneid;
            ((CCharEntity*)m_PBaseEntity)->status          = STATUS_TYPE::DISAPPEAR;
            ((CCharEntity*)m_PBaseEntity)->loc.boundary    = 0;
            ((CCharEntity*)m_PBaseEntity)->m_moghouseID    = 0;
            ((CCharEntity*)m_PBaseEntity)->clearPacketList();
            charutils::SendToZone((CCharEntity*)m_PBaseEntity, 2, zoneutils::GetZoneIPP(m_PBaseEntity->loc.destination));
            //((CCharEntity*)m_PBaseEntity)->loc.zone->DecreaseZoneCounter(((CCharEntity*)m_PBaseEntity));
        }
        else if (((CCharEntity*)m_PBaseEntity)->status != STATUS_TYPE::DISAPPEAR)
        {
            ((CCharEntity*)m_PBaseEntity)->pushPacket(new CPositionPacket((CCharEntity*)m_PBaseEntity));
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->loc.boundary    = 0;
    PChar->m_moghouseID    = 0;
    PChar->loc.p           = PChar->profile.home_point.p;
    PChar->loc.destination = PChar->profile.home_point.destination;

    PChar->status    = STATUS_TYPE::DISAPPEAR;
    PChar->animation = ANIMATION_NONE;

    PChar->clearPacketList();
    charutils::SendToZone(PChar, 2, zoneutils::GetZoneIPP(m_PBaseEntity->loc.destination));
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

    m_PBaseEntity->loc.zone->PushPacket(m_PBaseEntity, CHAR_INRANGE, new CPositionPacket(m_PBaseEntity));
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    CCharEntity* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    TELEPORT_TYPE type = static_cast<TELEPORT_TYPE>(teleType);
    uint32        bit  = 1 << bitval;
    uint8         set  = (setval != sol::nil) ? setval.as<uint8>() : 0;

    if ((type == TELEPORT_TYPE::HOMEPOINT || type == TELEPORT_TYPE::SURVIVAL) && ((setval == sol::nil) || set > 3))
    {
        ShowError("Lua::addteleport : Attempt to index array out-of-bounds or parameter is nil.");
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
        default:
            ShowError("LuaBaseEntity::addTeleport : Parameter 1 out of bounds.\n");
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

uint32 CLuaBaseEntity::getTeleport(uint8 type)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    TELEPORT_TYPE tele_type = static_cast<TELEPORT_TYPE>(type);
    CCharEntity*  PChar     = (CCharEntity*)m_PBaseEntity;

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
        default:
            ShowError("LuaBaseEntity::getteleport : Parameter 1 out of bounds.\n");
    }

    return 0;
}

sol::table CLuaBaseEntity::getTeleportTable(uint8 type)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    sol::state_view lua       = luautils::lua;
    sol::table      teleTable = lua.create_table();

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
        default:
            ShowError("LuaBaseEntity::getteleport : Parameter 1 out of bounds.\n");
    }

    return sol::nil;
}

/************************************************************************
 *  Function: hasTeleport(uint8 type, uint8 bit, uint8 set (optional))
 *  Purpose : Returns true if player has HP, false otherwise
 *  Example : player:hasTeleport(xi.teleport.type.HOMEPOINT, bit, set)
 *  Notes   : Refactor this to reduce the amount of returns
 ************************************************************************/

bool CLuaBaseEntity::hasTeleport(uint8 tType, uint8 bit, sol::object const& arg2)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    TELEPORT_TYPE type = static_cast<TELEPORT_TYPE>(tType);
    uint8         set  = (arg2 == sol::nil) ? 0 : arg2.as<uint8>();

    if (type == TELEPORT_TYPE::HOMEPOINT || type == TELEPORT_TYPE::SURVIVAL)
    {
        if ((arg2 == sol::nil) || set > 3)
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
            return PChar->teleport.outpostSandy & (1 << bit);
            break;
        case TELEPORT_TYPE::OUTPOST_BASTOK:
            return PChar->teleport.outpostBastok & (1 << bit);
            break;
        case TELEPORT_TYPE::OUTPOST_WINDY:
            return PChar->teleport.outpostWindy & (1 << bit);
            break;
        case TELEPORT_TYPE::RUNIC_PORTAL:
            return PChar->teleport.runicPortal & (1 << bit);
            break;
        case TELEPORT_TYPE::PAST_MAW:
            return PChar->teleport.pastMaw & (1 << bit);
            break;
        case TELEPORT_TYPE::CAMPAIGN_SANDY:
            return PChar->teleport.campaignSandy & (1 << bit);
            break;
        case TELEPORT_TYPE::CAMPAIGN_BASTOK:
            return PChar->teleport.campaignBastok & (1 << bit);
            break;
        case TELEPORT_TYPE::CAMPAIGN_WINDY:
            return PChar->teleport.campaignWindy & (1 << bit);
            break;
        default:
            ShowError("LuaBaseEntity::hasTeleport : Parameter 1 out of bounds.\n");
            return false;
    }

    XI_DEBUG_BREAK_IF(true); // We should never get here
    return false;
}

/************************************************************************
 *  Function: setTeleportMenu(uint8 type)
 *  Purpose : Store favorite homepoints or menu layout
 *  Example : player:setTeleportMenu(xi.teleport.type.HOMEPOINT)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setTeleportMenu(uint16 type, sol::table const& favs)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    CCharEntity* PChar = (CCharEntity*)m_PBaseEntity;

    TELEPORT_TYPE tele_type = static_cast<TELEPORT_TYPE>(type);

    if (tele_type != TELEPORT_TYPE::HOMEPOINT && tele_type != TELEPORT_TYPE::SURVIVAL)
    {
        ShowError("LuaBaseEntity::setteleportMenu : Incorrect value for Parameter 1.\n");
        return;
    }

    uint8 x = 0;
    for (auto& entry : favs)
    {
        if (tele_type == TELEPORT_TYPE::HOMEPOINT)
        {
            PChar->teleport.homepoint.menu[x++] = entry.second.as<int32>();
        }
        else
        {
            PChar->teleport.survival.menu[x++] = entry.second.as<int32>();
        }
    }

    charutils::SaveTeleport(PChar, tele_type);
}

/************************************************************************
 *  Function: getTeleportMenu(uint8)
 *  Purpose : Return lua table containing integer values for favs + layout
 *  Example : player:getTeleportMenu(xi.teleport.teleport.HOMEPOINT)
 *  Notes   :
 ************************************************************************/

sol::table CLuaBaseEntity::getTeleportMenu(uint8 type)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    CCharEntity*  PChar     = (CCharEntity*)m_PBaseEntity;
    TELEPORT_TYPE tele_type = static_cast<TELEPORT_TYPE>(type);

    if (tele_type != TELEPORT_TYPE::HOMEPOINT && tele_type != TELEPORT_TYPE::SURVIVAL)
    {
        ShowError("LuaBaseEntity::getTeleportMenu : Incorrect value or parameter 1.\n");
        return sol::nil;
    }

    auto table = luautils::lua.create_table();
    for (uint8 x = 0; x < 10; x++)
    {
        if (tele_type == TELEPORT_TYPE::HOMEPOINT)
        {
            table.add(PChar->teleport.homepoint.menu[x]);
        }
        else
        {
            table.add(PChar->teleport.survival.menu[x]);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->profile.home_point.p           = PChar->loc.p;
    PChar->profile.home_point.destination = PChar->getZone();

    const char* fmtQuery = "UPDATE chars \
                            SET home_zone = %u, home_rot = %u, home_x = %.3f, home_y = %.3f, home_z = %.3f \
                            WHERE charid = %u;";

    Sql_Query(SqlHandle, fmtQuery, PChar->profile.home_point.destination, PChar->profile.home_point.p.rotation, PChar->profile.home_point.p.x,
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
    const char* Query = "SELECT charid FROM chars WHERE charname = '%s';";
    int32       ret   = Sql_Query(SqlHandle, Query, charName);

    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        id = (int32)Sql_GetIntData(SqlHandle, 0);
    }

    // could not get player from database
    if (id == 0)
    {
        ShowDebug("Could not get the character from database.\n");
        return;
    }

    // delete the account session
    Query = "DELETE FROM accounts_sessions WHERE charid = %u;";
    Sql_Query(SqlHandle, Query, id);

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
            "WHERE charid = %u;";

    Sql_Query(SqlHandle, Query,
              245,     // lower jeuno
              122,     // prev zone
              86,      // rotation
              33.464f, // x
              -5.000f, // y
              69.162f, // z
              0,       // boundary,
              0,       // moghouse,
              id);

    ShowDebug("Player reset was successful.\n");
}

/************************************************************************
 *  Function: goToEntity()
 *  Purpose : Transports PC to a Mob or NPC; works across multiple servers
 *  Example : player:goToEntity(ID, Option)
 *  Notes   : Option 0: Spawned/Unspawned | Option 1: Spawned only
 ************************************************************************/

void CLuaBaseEntity::goToEntity(uint32 targetID, sol::object const& option)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    bool spawnedOnly = (option != sol::nil) ? option.as<bool>() : false;

    uint16 targetZone = (targetID >> 12) & 0x0FFF;
    uint16 playerID   = m_PBaseEntity->id;
    uint16 playerZone = PChar->loc.zone->GetID();

    char buf[12];
    memset(&buf[0], 0, sizeof(buf));

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    bool        found    = false;
    const char* fmtQuery = "SELECT charid FROM chars WHERE charname = '%s';";
    int32       ret      = Sql_Query(SqlHandle, fmtQuery, playerName.c_str());

    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        char buf[30];
        memset(&buf[0], 0, sizeof(buf));

        ref<uint16>(&buf, 0) = Sql_GetUIntData(SqlHandle, 0); // target char
        ref<uint16>(&buf, 4) = m_PBaseEntity->id;             // warping to target char, their server will send us a zoning message with their pos

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

    const char* fmtQuery = "SELECT charid FROM chars WHERE charname = '%s';";
    int32       ret      = Sql_Query(SqlHandle, fmtQuery, playerName.c_str());

    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        char buf[30];
        memset(&buf[0], 0, sizeof(buf));

        ref<uint16>(&buf, 0)  = Sql_GetUIntData(SqlHandle, 0); // target char
        ref<uint16>(&buf, 4)  = 0;                             // wanting to bring target char here so wont give our id
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
        XI_DEBUG_BREAK_IF(slot > 15);

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
        XI_DEBUG_BREAK_IF(slot > 15);

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

    if (location != sol::nil)
    {
        uint8 locationID = LOC_INVENTORY;

        locationID = location.as<uint8>();
        locationID = (locationID < MAX_CONTAINER_ID ? locationID : LOC_INVENTORY);

        return PChar->getStorage(locationID)->SearchItem(itemID) != ERROR_SLOTID;
    }

    return charutils::HasItem(PChar, itemID);
}

/************************************************************************
 *  Function: addItem()
 *  Purpose : Adds an item to a player's inventory
 *  Example : player:addItem(4102, 12) -- a stack of Light Crystals
 *  Notes   : See format and variable options below
 ************************************************************************/

bool CLuaBaseEntity::addItem(sol::variadic_args va)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    uint8 SlotID = ERROR_SLOTID;

    CCharEntity* PChar = (CCharEntity*)m_PBaseEntity;

    /* FORMAT 1:
    player:addItem({id=itemID, quantity=quantity}) -- add quantity of itemID

    player:addItem({id=itemID, silent=true}) -- silently add 1 of itemID

    player:addItem({id=itemID, signature="Char"}) -- add 1 signed of itemID
    player:addItem({id=itemID, augments={[4]=5,[10]=10}}) -- add 1 of itemID with augment id 4 and 10,
        with values of 5 and 10, respectively
    */

    if (va.get_type(0) == sol::type::table)
    {
        auto table = va.get<sol::table>(0);

        if (!table["id"].valid())
        {
            ShowError("AddItem: id is nil");
            return false;
        }

        uint16 id       = table.get<uint16>("id");
        int32  quantity = table.get<int32>("quantity");
        if (quantity == 0)
        {
            quantity = 1;
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
                    int8 encoded[12];
                    PItem->setSignature(EncodeStringSignature((int8*)signature.c_str(), encoded));
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
                        for (auto& entryPair : augmentsTable)
                        {
                            auto   pair   = entryPair.second.as<sol::table>();
                            uint16 augid  = pair[0];
                            uint8  augval = pair[1];
                            ((CItemEquipment*)PItem)->PushAugment(augid, augval);
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
                ShowWarning(CL_YELLOW "charplugin::AddItem: Item <%i> is not found in a database\n" CL_RESET, id);
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
                ShowWarning(CL_YELLOW "charplugin::AddItem: Item <%i> is not found in a database\n" CL_RESET, itemID);
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
 *  Notes   : Can specify contianer using third variable
 ************************************************************************/

bool CLuaBaseEntity::delItem(uint16 itemID, uint32 quantity, sol::object const& containerID)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    uint32 location = containerID.is<double>() ? containerID.as<uint32>() : 0;

    if (containerID.as<uint32>() >= MAX_CONTAINER_ID)
    {
        ShowWarning(CL_YELLOW "Lua::delItem: Attempting to delete an item from an invalid slot. Defaulting to main inventory.\n" CL_RESET);
    }

    auto* PChar  = static_cast<CCharEntity*>(m_PBaseEntity);
    auto  SlotID = PChar->getStorage(location)->SearchItem(itemID);

    if (SlotID != ERROR_SLOTID)
    {
        charutils::UpdateItem(PChar, location, SlotID, -quantity);
        PChar->pushPacket(new CInventoryFinishPacket());

        return true;
    }

    return false;
}

/************************************************************************
 *  Function: addUsedItem()
 *  Purpose : Add charged item with use timer already on full cooldown
 *  Example : player:addUsedItem(17040) -- Warp Cudgel
 *  Notes   : Currently unused, but should be
 ************************************************************************/

bool CLuaBaseEntity::addUsedItem(uint16 itemID)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
                ShowWarning(CL_YELLOW "addUsedItem: tried to setLastUseTime but itemID <%i> is not type ITEM_CHARGED\n" CL_RESET, itemID);
            }
        }
        else
        {
            ShowWarning(CL_YELLOW "charplugin::AddItem: Item <%i> is not found in a database\n" CL_RESET, itemID);
        }
    }

    return SlotID != ERROR_SLOTID;
}

/************************************************************************
 *  Function: hasWornItem()
 *  Purpose : Returns true if a player has a worn (unusable) item
 *  Example : if player:hasWornItem(trade:getItemId()) then
 *  Notes   : Used mainly for Testimonies and BCNM orbs
 ************************************************************************/

bool CLuaBaseEntity::hasWornItem(uint16 itemID)
{
    auto* PChar  = static_cast<CCharEntity*>(m_PBaseEntity);
    uint8 slotID = PChar->getStorage(LOC_INVENTORY)->SearchItem(itemID);

    if (slotID != ERROR_SLOTID)
    {
        CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(slotID);

        return PItem->m_extra[0] == 1;
    }

    return false;
}

/************************************************************************
 *  Function: createWornItem()
 *  Purpose : Flags an item as being used up (worn)
 *  Example : player:createWornItem(itemID)
 *  Notes   : Prevent Orbs and Testimonies from being used again
 ************************************************************************/

void CLuaBaseEntity::createWornItem(uint16 itemID)
{
    auto* PChar  = static_cast<CCharEntity*>(m_PBaseEntity);
    uint8 slotID = PChar->getStorage(LOC_INVENTORY)->SearchItem(itemID);

    if (slotID != ERROR_SLOTID)
    {
        CItem* PItem      = PChar->getStorage(LOC_INVENTORY)->GetItem(slotID);
        PItem->m_extra[0] = 1;

        char extra[sizeof(PItem->m_extra) * 2 + 1];
        Sql_EscapeStringLen(SqlHandle, extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));

        const char* Query = "UPDATE char_inventory "
                            "SET extra = '%s' "
                            "WHERE charid = %u AND location = %u AND slot = %u;";

        Sql_Query(SqlHandle, Query, extra, PChar->id, PItem->getLocationID(), PItem->getSlotID());
    }
}

/************************************************************************
 *  Function: addTempItem()
 *  Purpose : Add a temporary item to the player
 *  Example : player:addTempItem(5399) -- Azouph Fireflies
 *  Notes   : Used almost exclusively for instances
 ************************************************************************/

bool CLuaBaseEntity::addTempItem(uint16 itemID, sol::object const& arg1)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    uint32 quantity = (arg1 != sol::nil) ? arg1.as<uint32>() : 1;
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
            ShowWarning(CL_YELLOW "charplugin::AddItem: Item <%i> is not found in a database\n" CL_RESET, itemID);
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
    if (location != sol::nil)
    {
        uint8 locationID = LOC_INVENTORY;

        locationID = location.as<uint8>();
        locationID = (locationID < MAX_CONTAINER_ID ? locationID : LOC_INVENTORY);

        if (auto slot = PChar->getStorage(locationID)->SearchItem(itemID); slot != ERROR_SLOTID)
        {
            auto* item = PChar->getStorage(locationID)->GetItem(slot);
            return item ? std::optional<CLuaItem>(item) : std::nullopt;
        }
    }
    else // Look in all containers
    {
        for (uint8 i = 0; i < MAX_CONTAINER_ID; ++i)
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->Container->Clean();
    PChar->Container->setSize(size + 1);

    if (arg1 != sol::nil && arg1.is<double>())
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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

    int32 ret = Sql_Query(SqlHandle, "SELECT broken, linkshellid FROM linkshells WHERE name = '%s'", lsname.c_str());
    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        uint8 broken = Sql_GetUIntData(SqlHandle, 0);

        if (broken)
        {
            return true;
        }

        uint32      lsid       = Sql_GetUIntData(SqlHandle, 1);
        CLinkshell* PLinkshell = linkshell::GetLinkshell(lsid);

        if (!PLinkshell)
        {
            PLinkshell = linkshell::LoadLinkshell(lsid);
        }

        int8 EncodedName[16];
        EncodeStringLinkshell((int8*)lsname.c_str(), EncodedName);
        PLinkshell->BreakLinkshell(EncodedName, true);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);
    CCharEntity*    PChar          = (CCharEntity*)m_PBaseEntity;
    CItemLinkshell* PItemLinkPearl = PChar->m_GMlevel > 0 ? (CItemLinkshell*)itemutils::GetItem(514) : (CItemLinkshell*)itemutils::GetItem(515);
    LSTYPE          lstype         = PChar->m_GMlevel > 0 ? LSTYPE_PEARLSACK : LSTYPE_LINKPEARL;
    if (PItemLinkPearl != NULL)
    {
        const char* Query = "SELECT linkshellid, color FROM linkshells WHERE name = '%s' AND broken = 0";
        int32       ret   = Sql_Query(SqlHandle, Query, lsname);
        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            // build linkpearl
            int8 EncodedString[16];
            EncodeStringLinkshell((int8*)lsname.c_str(), EncodedString);
            ((CItem*)PItemLinkPearl)->setSignature(EncodedString);
            PItemLinkPearl->SetLSID(Sql_GetUIntData(SqlHandle, 0));
            PItemLinkPearl->SetLSColor(Sql_GetIntData(SqlHandle, 1));
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
                    PChar->pushPacket(new CInventoryAssignPacket(PItemLinkPearl, INV_LINKSHELL));
                    charutils::SaveCharEquip(PChar);
                    PChar->pushPacket(new CLinkshellEquipPacket(PChar, PItemLinkPearl->GetLSID()));
                    PChar->pushPacket(new CInventoryItemPacket(PItemLinkPearl, LOC_INVENTORY, PItemLinkPearl->getSlotID()));
                    PChar->pushPacket(new CInventoryFinishPacket());
                    charutils::LoadInventory(PChar);
                }
                return true;
            }
        }
    }
    return false;
}

/************************************************************************
 *  Function: getContainerSize()
 *  Purpose : Returns the size of an item container
 *  Example : player:getContainerSize(xi.inv.INVENTORY)
 ************************************************************************/

uint8 CLuaBaseEntity::getContainerSize(uint8 locationID)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    if (locationID < MAX_CONTAINER_ID)
    {
        auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

        PChar->getStorage(locationID)->AddBuff(newSize);
        PChar->pushPacket(new CInventorySizePacket(PChar));
        charutils::SaveCharInventoryCapacity(PChar);
    }
    else
    {
        ShowError(CL_RED "CLuaBaseEntity::changeContainerSize: bad container id (%u)\n", locationID);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    uint8 locationID = (locID != sol::nil) ? locID.as<CONTAINER_ID>() : LOC_INVENTORY;
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    for (uint8 slotID = 0; slotID < TRADE_CONTAINER_SIZE; ++slotID)
    {
        if (PChar->TradeContainer->getInvSlotID(slotID) != 0xFF)
        {
            CItem* PItem = PChar->TradeContainer->getItem(slotID);
            if (PItem)
            {
                uint8 confirmedItems = PChar->TradeContainer->getConfirmedStatus(slotID);
                auto  quantity       = (int32)std::min<uint32>(PChar->TradeContainer->getQuantity(slotID), confirmedItems);

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
    PChar->pushPacket(new CInventoryFinishPacket());
}

/************************************************************************
 *  Function: tradeComplete()
 *  Purpose : Completes trade and removes all items in trade container
 *  Example : player:tradeComplete()
 ************************************************************************/

void CLuaBaseEntity::tradeComplete()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    PChar->pushPacket(new CInventoryFinishPacket());
}

/************************************************************************
 *  Function: canEquipItem()
 *  Purpose : Returns true if a player can equip the item
 *  Example : if player:canEquipItem(17652) then
 *  Notes   : CItemEquipment* is a pointer to weapons or armor
 ************************************************************************/

bool CLuaBaseEntity::canEquipItem(uint16 itemID, sol::object const& chkLevel)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);
    XI_DEBUG_BREAK_IF(itemID > MAX_ITEMID);

    bool checkLevel = (chkLevel != sol::nil) ? chkLevel.as<bool>() : false;

    auto* PItem = static_cast<CItemEquipment*>(itemutils::GetItem(itemID));
    auto* PChar = static_cast<CBattleEntity*>(m_PBaseEntity);

    if (!(PItem->getJobs() & (1 << (PChar->GetMJob() - 1))))
    {
        return false;
    }
    if (checkLevel && (PItem->getReqLvl() > PChar->GetMLevel()))
    {
        return false;
    }
    // ShowDebug("Item ID: %u Item Jobs: %u Player Job: %u\n",itemID,PItem->getJobs(),PChar->GetMJob());
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    uint8           containerID = (container != sol::nil) ? container.as<uint8>() : LOC_INVENTORY;
    uint8           SLOT        = PChar->getStorage(containerID)->SearchItem(itemID);
    CItemEquipment* PItem;

    if (SLOT != ERROR_SLOTID)
    {
        PItem = static_cast<CItemEquipment*>(PChar->getStorage(containerID)->GetItem(SLOT));

        charutils::EquipItem(PChar, SLOT, PItem->getSlotType(), containerID);
        charutils::SaveCharEquip(PChar);
        charutils::SaveCharLook(PChar);
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
        PChar->pushPacket(new CCharJobsPacket(PChar));
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);
    XI_DEBUG_BREAK_IF(slot > 15);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    charutils::EquipItem(PChar, 0, slot, LOC_INVENTORY);

    PChar->m_EquipBlock |= 1 << slot;
    PChar->pushPacket(new CCharAppearancePacket(PChar));
    PChar->pushPacket(new CEquipPacket(0, slot, LOC_INVENTORY));
    PChar->pushPacket(new CCharJobsPacket(PChar));
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);
    XI_DEBUG_BREAK_IF(slot > 15);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->m_EquipBlock &= ~(1 << slot);
    PChar->pushPacket(new CCharJobsPacket(PChar));
}

/************************************************************************
 *  Function: getShieldSize()
 *  Purpose : Return the shield size of the equipped shield
 *  Example : player:getShieldSize()
 *  Notes   : Returns 0 if player does not have shield equipped
 ************************************************************************/

int8 CLuaBaseEntity::getShieldSize()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC && m_PBaseEntity->objtype != TYPE_PET);

    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        return static_cast<CCharEntity*>(m_PBaseEntity)->getShieldSize();
    }

    return 0;
}

/************************************************************************
 *  Function: hasGearSetMod()
 *  Purpose : Need to research functionality more to provide description
 *  Example :  if not player:hasGearSetMod(gearset.id) then
 *  Notes   : Used exclusively in scripts/globals/gear_sets.lua
 ************************************************************************/

bool CLuaBaseEntity::hasGearSetMod(uint8 modNameId)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        for (auto exsistingMod : PChar->m_GearSetMods)
        {
            if (modNameId == exsistingMod.modNameId)
            {
                return true;
            }
        }
    }

    return false;
}

/************************************************************************
 *  Function: addGearSetMod()
 *  Purpose : Need to research functionality more to provide description
 *  Example : player:addGearSetMod(gearset.id + i, modId, modValue + addSetBonus)
 *  Notes   : Used exclusively in scripts/globals/gear_sets.lua
 ************************************************************************/

void CLuaBaseEntity::addGearSetMod(uint8 modNameId, Mod modId, uint16 modValue)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    GearSetMod_t gearSetMod;
    gearSetMod.modNameId = modNameId;
    gearSetMod.modId     = modId;
    gearSetMod.modValue  = modValue;

    CCharEntity* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity);

    for (auto& exsistingMod : PChar->m_GearSetMods)
    {
        if (gearSetMod.modNameId == exsistingMod.modNameId)
        {
            return;
        }
    }

    PChar->m_GearSetMods.push_back(gearSetMod);
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
        for (uint8 i = 0; i < PChar->m_GearSetMods.size(); ++i)
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity == nullptr);
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar      = (CCharEntity*)m_PBaseEntity;
    auto  slipSlotId = PChar->getStorage(LOC_INVENTORY)->SearchItem(slipId);

    if (slipSlotId == 255)
    {
        return 0;
    }

    auto* slip = PChar->getStorage(LOC_INVENTORY)->GetItem(slipSlotId);

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

    for (auto itemId : storedItemIds)
    {
        if (itemId != 0)
        {
            auto slotId = PChar->getStorage(LOC_INVENTORY)->SearchItem(itemId);
            if (slotId != 255)
            {
                // TODO: Items need to be checked for an in-progress magian trial before storing.
                // auto item = PChar->getStorage(LOC_INVENTORY)->GetItem(slotId);
                // if (item->isType(ITEM_EQUIPMENT) && ((CItemEquipment*)item)->getTrialNumber() != 0)
                CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(slotId);
                if (PItem)
                {
                    PItem->setReserve(0);
                    charutils::UpdateItem(PChar, LOC_INVENTORY, slotId, -1);
                }
                // else
                //{
                // lua_pushinteger(L, 2);
                // return 1;
                //}
            }
        }
    }

    char extra[sizeof(slip->m_extra) * 2 + 1];
    Sql_EscapeStringLen(SqlHandle, extra, (const char*)slip->m_extra, sizeof(slip->m_extra));

    const char* Query = "UPDATE char_inventory "
                        "SET extra = '%s' "
                        "WHERE charid = %u AND location = %u AND slot = %u;";

    Sql_Query(SqlHandle, Query, extra, PChar->id, slip->getLocationID(), slip->getSlotID());

    return 0;
}

/************************************************************************
 *  Function: getRetrievableItemsForSlip()
 *  Purpose : Returns listing of 'stored' items as Lua table
 *  Example : local extra = player:getRetrievableItemsForSlip(slipId)
 *  Notes   : See scripts/globals/porter_moogle_util.lua
 ************************************************************************/

sol::table CLuaBaseEntity::getRetrievableItemsForSlip(uint16 slipId)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    CCharEntity* PChar      = (CCharEntity*)m_PBaseEntity;
    auto         slipSlotId = PChar->getStorage(LOC_INVENTORY)->SearchItem(slipId);

    if (slipSlotId == 255)
    {
        return {};
    }

    auto* slip = PChar->getStorage(LOC_INVENTORY)->GetItem(slipSlotId);

    sol::table table = luautils::lua.create_table();
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar      = static_cast<CCharEntity*>(m_PBaseEntity);
    auto  slipSlotId = PChar->getStorage(LOC_INVENTORY)->SearchItem(slipId);

    if (slipSlotId == 255)
    {
        return;
    }

    auto* slip = PChar->getStorage(LOC_INVENTORY)->GetItem(slipSlotId);

    slip->m_extra[extraId] &= extraData;

    char extra[sizeof(slip->m_extra) * 2 + 1];
    Sql_EscapeStringLen(SqlHandle, extra, (const char*)slip->m_extra, sizeof(slip->m_extra));

    const char* Query = "UPDATE char_inventory "
                        "SET extra = '%s' "
                        "WHERE charid = %u AND location = %u AND slot = %u;";

    Sql_Query(SqlHandle, Query, extra, PChar->id, slip->getLocationID(), slip->getSlotID());

    auto* item = itemutils::GetItem(itemId);
    item->setQuantity(1);
    charutils::AddItem(PChar, LOC_INVENTORY, item);
}

/************************************************************************
 *  Function: getRace()
 *  Purpose : Returns the integer value of the race of the character
 *  Example : player:getRace()
 ************************************************************************/

uint8 CLuaBaseEntity::getRace()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    return static_cast<CCharEntity*>(m_PBaseEntity)->look.race;
}

/************************************************************************
 *  Function: getGender()
 *  Purpose : Returns the integer value of the gender of the character
 *  Example : player:getGender()
 ************************************************************************/

uint8 CLuaBaseEntity::getGender()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    return PChar->GetGender();
}

/************************************************************************
 *  Function: getName()
 *  Purpose : Returns the string name of the character
 *  Example : player:getName()
 ************************************************************************/

const char* CLuaBaseEntity::getName()
{
    // TODO: Fix C-style cast
    return (const char*)m_PBaseEntity->GetName();
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
 *  Function: checkNameFlags()
 *  Purpose : Returns true if a player has name flags
 ************************************************************************/

bool CLuaBaseEntity::checkNameFlags(uint32 flags)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (PChar->nameflags.flags & flags)
    {
        return true;
    }

    return false;
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
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setModelId(uint16 modelId, sol::object const& slotObj)
{
    if (m_PBaseEntity->objtype == TYPE_PC)
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

        auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
        PChar->pushPacket(new CCharAppearancePacket(PChar));
    }
    else
    {
        m_PBaseEntity->SetModelId(modelId);
    }
    m_PBaseEntity->updatemask |= UPDATE_LOOK;
}

/************************************************************************
 *  Function: setCostume()
 *  Purpose : Updates the PC's appearance
 *  Example : player:setCostume( costumeId )
 ************************************************************************/

void CLuaBaseEntity::setCostume(uint16 costume)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (PChar->m_Costume != costume && PChar->status != STATUS_TYPE::SHUTDOWN && PChar->status != STATUS_TYPE::DISAPPEAR)
    {
        PChar->m_Costume = costume;
        PChar->updatemask |= UPDATE_LOOK;
        PChar->pushPacket(new CCharUpdatePacket(PChar));
    }
}

/************************************************************************
 *  Function: getCostume()
 *  Purpose : Returns the PC's appearance
 *  Example : player:getCostume()
 ************************************************************************/

uint16 CLuaBaseEntity::getCostume()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    return PChar->m_Costume;
}

/************************************************************************
 *  Function: getCostume2()
 *  Purpose : Sets or returns a monstrosity costume
 *  Example : player:costume2( costumeId )
 *  Notes   : Not currently implemented
 ************************************************************************/

uint16 CLuaBaseEntity::getCostume2()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    return PChar->m_Monstrosity;
}

/************************************************************************
 *  Function: setCostume2()
 *  Purpose : Sets or returns a monstrosity costume
 *  Example : player:costume2( costumeId )
 *  Notes   : Not currently implemented
 ************************************************************************/

void CLuaBaseEntity::setCostume2(uint16 costume)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (PChar->m_Monstrosity != costume && PChar->status != STATUS_TYPE::SHUTDOWN && PChar->status != STATUS_TYPE::DISAPPEAR)
    {
        PChar->m_Monstrosity = costume;
        PChar->updatemask |= UPDATE_LOOK;
        PChar->pushPacket(new CCharAppearancePacket(PChar));
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
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setAnimationSub(uint8 animationsub)
{
    if (m_PBaseEntity->animationsub != animationsub)
    {
        m_PBaseEntity->animationsub = animationsub;

        if (m_PBaseEntity->objtype == TYPE_PC)
        {
            auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
            PChar->pushPacket(new CCharUpdatePacket(PChar));
        }
        else
        {
            m_PBaseEntity->loc.zone->PushPacket(m_PBaseEntity, CHAR_INRANGE, new CEntityUpdatePacket(m_PBaseEntity, ENTITY_UPDATE, UPDATE_COMBAT));
        }
    }
}

/************************************************************************
 *  Function: getNation()
 *  Purpose : Returns the integer value of the player's nation
 *  Example : player:getNation()
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getNation()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    m_PBaseEntity->updatemask |= UPDATE_HP;
}

/************************************************************************
 *  Function: getCampaignAllegiance()
 *  Purpose : Returns the integer value of a player's Campaign allegiance
 *  Example : if player:getCampaignAllegiance() > 0 then
 *  Notes   : A return of 0 means the player doesn't have any allegiances
 ************************************************************************/

uint8 CLuaBaseEntity::getCampaignAllegiance()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    return static_cast<CCharEntity*>(m_PBaseEntity)->profile.campaign_allegiance;
}

/************************************************************************
 *  Function: setCampaignAllegiance()
 *  Purpose : Affiliates the player with a particular nation in the past
 *  Example : targ:setCampaignAllegiance(nation)
 ************************************************************************/

void CLuaBaseEntity::setCampaignAllegiance(uint8 allegiance)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    return (static_cast<CCharEntity*>(m_PBaseEntity)->nameflags.flags & FLAG_INVITE);
}

/************************************************************************
 *  Function: getNewPlayer()
 *  Purpose : Returns true if a player is new
 *  Example : if not player:getNewPlayer() then
 ************************************************************************/

bool CLuaBaseEntity::getNewPlayer()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    return (static_cast<CCharEntity*>(m_PBaseEntity)->menuConfigFlags.flags & NFLAG_NEWPLAYER) == 0;
}

/************************************************************************
 *  Function: setNewPlayer()
 *  Purpose : Marks a player as being new and calls charutils to update DB
 *  Example : player:setNewPlayer(1)
 ************************************************************************/

void CLuaBaseEntity::setNewPlayer(bool newplayer)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity);

    if (newplayer == true)
    {
        PChar->menuConfigFlags.flags |= NFLAG_NEWPLAYER;
    }
    else
    {
        PChar->menuConfigFlags.flags &= ~NFLAG_NEWPLAYER;
    }

    PChar->updatemask |= UPDATE_HP;

    charutils::SaveMenuConfigFlags(PChar);
}

/************************************************************************
 *  Function: getMentor()
 *  Purpose : Returns true if a player is flagged as a mentor
 *  Notes   : Test me!  Changing retval to bool
 ************************************************************************/

bool CLuaBaseEntity::getMentor()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->m_GMlevel = level;
    charutils::SaveCharGMLevel(PChar);
}

/************************************************************************
 *  Function: getGMHidden()
 *  Purpose : Returns true if a GM is currently hidden
 *  Example : if player:getGMHidden() then
 ************************************************************************/

bool CLuaBaseEntity::getGMHidden()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar         = static_cast<CCharEntity*>(m_PBaseEntity);
    PChar->m_isGMHidden = isHidden;

    if (PChar->loc.zone)
    {
        if (PChar->m_isGMHidden)
        {
            PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, new CCharPacket(PChar, ENTITY_DESPAWN, 0));
        }
        else
        {
            PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, new CCharPacket(PChar, ENTITY_SPAWN, 0));
        }
    }
}

/************************************************************************
 *  Function: isJailed()
 *  Purpose : Returns true if a player is a violent felon
 *  Example : if player:isJailed() then
 ************************************************************************/

bool CLuaBaseEntity::isJailed()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    return jailutils::InPrison(static_cast<CCharEntity*>(m_PBaseEntity));
}

/************************************************************************
 *  Function: jail()
 *  Purpose : Locks up a misbehaving Elvaan
 *  Example : player:jail()
 ************************************************************************/

void CLuaBaseEntity::jail()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->loc.zone == nullptr);

    return m_PBaseEntity->loc.zone->CanUseMisc(misc);
}

/************************************************************************
 *  Function: getSpeed()
 *  Purpose : Sets a player's speed or returns their current speed
 *  Example : player:getSpeed()
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getSpeed()
{
    return m_PBaseEntity->speed;
}

/************************************************************************
 *  Function: setSpeed()
 *  Purpose : Sets a player's speed or returns their current speed
 *  Example : player:setSpeed(40)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setSpeed(uint8 speedVal)
{
    auto speed = std::min<uint8>(speedVal, 255);

    if (m_PBaseEntity->speed != speed)
    {
        m_PBaseEntity->speed = speed;

        if (m_PBaseEntity->objtype == TYPE_PC)
        {
            auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
            PChar->pushPacket(new CCharUpdatePacket(PChar));
        }
        else
        {
            m_PBaseEntity->loc.zone->PushPacket(m_PBaseEntity, CHAR_INRANGE, new CEntityUpdatePacket(m_PBaseEntity, ENTITY_UPDATE, UPDATE_POS));
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    bool  update = (shouldUpdate != sol::nil) ? shouldUpdate.as<bool>() : true;
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto*   PChar   = dynamic_cast<CCharEntity*>(m_PBaseEntity);
    JOBTYPE prevjob = PChar->GetMJob();

    PChar->resetPetZoningInfo();

    PChar->jobs.unlocked |= (1 << newJob);
    PChar->SetMJob(newJob);

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

    PChar->ForParty([](CBattleEntity* PMember) { ((CCharEntity*)PMember)->PLatentEffectContainer->CheckLatentsPartyJobs(); });

    PChar->UpdateHealth();
    PChar->health.hp = PChar->GetMaxHP();
    PChar->health.mp = PChar->GetMaxMP();

    charutils::SaveCharStats(PChar);
    charutils::SaveCharJob(PChar, PChar->GetMJob());
    charutils::SaveCharExp(PChar, PChar->GetMJob());
    PChar->updatemask |= UPDATE_HP;

    PChar->pushPacket(new CCharJobsPacket(PChar));
    PChar->pushPacket(new CCharStatsPacket(PChar));
    PChar->pushPacket(new CCharSkillsPacket(PChar));
    PChar->pushPacket(new CCharRecastPacket(PChar));
    PChar->pushPacket(new CCharAbilitiesPacket(PChar));
    PChar->pushPacket(new CCharUpdatePacket(PChar));
    PChar->pushPacket(new CMenuMeritPacket(PChar));
    PChar->pushPacket(new CCharSyncPacket(PChar));
}

/************************************************************************
 *  Function: changesJob()
 *  Purpose : Changes an entities sub job
 *  Example : mob:changesJob(xi.job.RDM); player:changesJob(xi.job.MNK)
 *  Notes   : To Do: Change name to changeSubJob for visual clarity?
 ************************************************************************/

void CLuaBaseEntity::changesJob(uint8 subJob)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
        PChar->pushPacket(new CCharJobsPacket(PChar));
    }
}

/************************************************************************
 *  Function: hasJob()
 *  Purpose : Check to see if JOBTYPE is unlocked
 *  Example : player:hasJob(xi.job.BRD)
 ************************************************************************/

bool CLuaBaseEntity::hasJob(uint8 job)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    JOBTYPE JobID = static_cast<JOBTYPE>(job);

    XI_DEBUG_BREAK_IF(JobID > MAX_JOBTYPE || JobID < 0);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    return (PChar->jobs.unlocked >> JobID) & 1;
}

/************************************************************************
 *  Function: getMainLvl()
 *  Purpose : Returns the main level of entity's current job
 *  Example : player:getMainLvl()
 ************************************************************************/

uint8 CLuaBaseEntity::getMainLvl()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    return static_cast<CBattleEntity*>(m_PBaseEntity)->GetMLevel();
}

/************************************************************************
 *  Function: getSubLvl()
 *  Purpose : Returns the level of entity's current sub job
 *  Example : player:getSubLvl()
 ************************************************************************/

uint8 CLuaBaseEntity::getSubLvl()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    return static_cast<CBattleEntity*>(m_PBaseEntity)->GetSLevel();
}

/************************************************************************
 *  Function: getJobLevel()
 *  Purpose : Return the levle of job specified by JOBTYPE
 *  Example : player:getJobLevel(xi.job.BRD)
 ************************************************************************/

uint8 CLuaBaseEntity::getJobLevel(uint8 JobID)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    XI_DEBUG_BREAK_IF(JobID > MAX_JOBTYPE || JobID < 0);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    XI_DEBUG_BREAK_IF(level > 99);

    if (auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity))
    {
        PChar->SetMLevel(level);
        PChar->jobs.job[PChar->GetMJob()] = level;
        PChar->SetSLevel(PChar->jobs.job[PChar->GetSJob()]);
        PChar->jobs.exp[PChar->GetMJob()] = charutils::GetExpNEXTLevel(PChar->jobs.job[PChar->GetMJob()]) - 1;

        charutils::SetStyleLock(PChar, false);
        blueutils::ValidateBlueSpells(PChar);
        charutils::CalculateStats(PChar);
        charutils::CheckValidEquipment(PChar);
        jobpointutils::RefreshGiftMods(PChar);
        charutils::BuildingCharSkillsTable(PChar);
        charutils::BuildingCharAbilityTable(PChar);
        charutils::BuildingCharTraitsTable(PChar);

        PChar->UpdateHealth();
        PChar->health.hp = PChar->GetMaxHP();
        PChar->health.mp = PChar->GetMaxMP();

        charutils::SaveCharStats(PChar);
        charutils::SaveCharJob(PChar, PChar->GetMJob());
        charutils::SaveCharExp(PChar, PChar->GetMJob());
        PChar->updatemask |= UPDATE_HP;

        PChar->pushPacket(new CCharJobsPacket(PChar));
        PChar->pushPacket(new CCharStatsPacket(PChar));
        PChar->pushPacket(new CCharSkillsPacket(PChar));
        PChar->pushPacket(new CCharRecastPacket(PChar));
        PChar->pushPacket(new CCharAbilitiesPacket(PChar));
        PChar->pushPacket(new CCharUpdatePacket(PChar));
        PChar->pushPacket(new CMenuMeritPacket(PChar));
        PChar->pushPacket(new CCharSyncPacket(PChar));
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);
    XI_DEBUG_BREAK_IF(slevel > 99);

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

    PChar->pushPacket(new CCharJobsPacket(PChar));
    PChar->pushPacket(new CCharStatsPacket(PChar));
    PChar->pushPacket(new CCharSkillsPacket(PChar));
    PChar->pushPacket(new CCharRecastPacket(PChar));
    PChar->pushPacket(new CCharAbilitiesPacket(PChar));
    PChar->pushPacket(new CCharUpdatePacket(PChar));
    PChar->pushPacket(new CMenuMeritPacket(PChar));
    PChar->pushPacket(new CCharSyncPacket(PChar));
}

/************************************************************************
 *  Function: getLevelCap()
 *  Purpose : Returns the player's level cap (genkai)
 *  Example : player:getLevelCap()
 ************************************************************************/

uint8 CLuaBaseEntity::getLevelCap()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (PChar->jobs.genkai != cap)
    {
        PChar->jobs.genkai = cap;
        Sql_Query(SqlHandle, "UPDATE char_jobs SET genkai = %u WHERE charid = %u LIMIT 1", PChar->jobs.genkai, PChar->id);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity == nullptr);
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if ((level != sol::nil) && level.is<int>())
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
            charutils::RemoveAllEquipMods(PChar);
            PChar->SetMLevel(NewMLevel);
            PChar->SetSLevel(PChar->jobs.job[PChar->GetSJob()]);
            charutils::ApplyAllEquipMods(PChar);

            if (PChar->status != STATUS_TYPE::DISAPPEAR)
            {
                blueutils::ValidateBlueSpells(PChar);
                jobpointutils::RefreshGiftMods(PChar);
                charutils::BuildingCharSkillsTable(PChar);
                charutils::CalculateStats(PChar);
                charutils::BuildingCharTraitsTable(PChar);
                charutils::BuildingCharAbilityTable(PChar);
                charutils::CheckValidEquipment(PChar);
                PChar->pushPacket(new CCharJobsPacket(PChar));
                PChar->pushPacket(new CCharStatsPacket(PChar));
                PChar->pushPacket(new CCharSkillsPacket(PChar));
                PChar->pushPacket(new CCharRecastPacket(PChar));
                PChar->pushPacket(new CCharAbilitiesPacket(PChar));
                PChar->pushPacket(new CCharSpellsPacket(PChar));
                PChar->pushPacket(new CCharUpdatePacket(PChar));
                PChar->pushPacket(new CCharSyncPacket(PChar));
                PChar->updatemask |= UPDATE_HP;
            }

            if (PChar->PPet)
            {
                CPetEntity* PPet = static_cast<CPetEntity*>(PChar->PPet);
                if (PPet->getPetType() == PET_TYPE::WYVERN)
                {
                    petutils::LoadWyvernStatistics(PChar, PPet, true);
                }
                else
                {
                    petutils::DespawnPet(PChar);
                }
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

/************************************************************************
 *  Function: getTitle()
 *  Purpose : Returns the integer value of the player's current title
 *  Example : if player:getTitle()) == xi.title.FAKEMOUSTACHED_INVESTIGATOR then
 ************************************************************************/

uint16 CLuaBaseEntity::getTitle()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    return static_cast<CCharEntity*>(m_PBaseEntity)->profile.title;
}

/************************************************************************
 *  Function: hasTitle()
 *  Purpose : Returns true if a player's current title matches a value
 *  Example : if player:hasTitle(xi.title.AWESOME_SAUCE) then
 ************************************************************************/

bool CLuaBaseEntity::hasTitle(uint16 titleID)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->profile.title = titleID;
    PChar->pushPacket(new CCharStatsPacket(PChar));

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (charutils::delTitle(PChar, titleID))
    {
        if (PChar->profile.title == titleID)
        {
            PChar->profile.title = 0;
        }

        PChar->pushPacket(new CCharStatsPacket(PChar));
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    uint8  fameArea = areaObj.is<sol::table>() ? areaObj.as<sol::table>()["fame_area"] : areaObj.as<uint8>();
    uint16 fame     = 0;

    if (fameArea <= 15)
    {
        float fameMultiplier = map_config.fame_multiplier;
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
        ShowError(CL_RED "Lua::getFame: fameArea %i is invalid\n" CL_RESET, fameArea);
    }

    return fame;
}

/************************************************************************
 *  Function: addFame()
 *  Purpose : Adds a specified amount of fame to the player's balance
 *  Example : player:addFame(WINDURST, 30)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::addFame(sol::object const& areaObj, uint16 fame)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
        ShowError(CL_RED "Lua::addFame: fameArea %i is invalid\n" CL_RESET, fameArea);
    }
}

/************************************************************************
 *  Function: setFame()
 *  Purpose : Sets the fame level for a player to a specified amount
 *  Example : player:setFame(BASTOK, 1500)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setFame(sol::object const& areaObj, uint16 fame)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
        ShowError(CL_RED "Lua::setFame: fameArea %i is invalid\n" CL_RESET, fameArea);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
        ShowError(CL_RED "Lua::getFameLevel: fameArea %i is invalid\n" CL_RESET, fameArea);
    }

    return fameLevel;
}

/************************************************************************
 *  Function: getRank()
 *  Purpose : Returns the rank of a player's current nation
 *  Example : player:getRank()
 ************************************************************************/

uint8 CLuaBaseEntity::getRank()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    return PChar->profile.rank[PChar->profile.nation];
}

/************************************************************************
 *  Function: getOtherRank()
 *  Purpose : Returns the rank of <nation> for the player
 *  Example : player:getOtherRank(xi.nation.WINDURST)
 ************************************************************************/

uint8 CLuaBaseEntity::getOtherRank(uint8 nation)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->profile.rank[PChar->profile.nation] = rank;

    charutils::SaveMissionsList(PChar);
}

/************************************************************************
 *  Function: getRankPoints()
 *  Purpose : Returns the current rank points (rank bar) of a player
 *  Example : player:getRankPoints()
 ************************************************************************/

uint32 CLuaBaseEntity::getRankPoints()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    return static_cast<CCharEntity*>(m_PBaseEntity)->profile.rankpoints;
}

/************************************************************************
 *  Function: addRankPoints()
 *  Purpose : Adds a set amount of rank points to the player's balance
 *  Example : player:addRankPoints(10)
 *  Notes   : Like, when you trade crystals
 ************************************************************************/

void CLuaBaseEntity::addRankPoints(uint32 rankpoints)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->profile.rankpoints += rankpoints;

    charutils::SaveMissionsList(PChar);
}

/************************************************************************
 *  Function: setRankPoints()
 *  Purpose : Sets the current rank points of a player to a specified value
 *  Example : player:setRankPoints(100)
 *  Notes   : player:setRankPoints(0) is called after switching nations
 ************************************************************************/

void CLuaBaseEntity::setRankPoints(uint32 rankpoints)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->profile.rankpoints = rankpoints;
    charutils::SaveMissionsList(PChar);
}

/************************************************************************
 *  Function: addQuest()
 *  Purpose : Adds a new quest to the character's in-progress quest log
 *  Example : player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.LURE_OF_THE_WILDCAT)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::addQuest(uint8 questLogID, uint16 questID)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (questLogID < MAX_QUESTAREA && questID < MAX_QUESTID)
    {
        uint8 current  = PChar->m_questLog[questLogID].current[questID / 8] & (1 << (questID % 8));
        uint8 complete = PChar->m_questLog[questLogID].complete[questID / 8] & (1 << (questID % 8));

        if ((current == 0) && (complete == 0))
        {
            PChar->m_questLog[questLogID].current[questID / 8] |= (1 << (questID % 8));
            PChar->pushPacket(new CQuestMissionLogPacket(PChar, questLogID, LOG_QUEST_CURRENT));

            charutils::SaveQuestsList(PChar);
        }
    }
    else
    {
        ShowError(CL_RED "Lua::addQuest: questLogID %i or QuestID %i is invalid\n" CL_RESET, questLogID, questID);
    }
}

/************************************************************************
 *  Function: delQuest()
 *  Purpose : Deletes a quest from a character's quest log
 *  Example : player:delQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT)
 *  Notes   : Doesn't delete any player variables associated with quest
 ************************************************************************/

void CLuaBaseEntity::delQuest(uint8 questLogID, uint16 questID)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (questLogID < MAX_QUESTAREA && questID < MAX_QUESTID)
    {
        uint8 current  = PChar->m_questLog[questLogID].current[questID / 8] & (1 << (questID % 8));
        uint8 complete = PChar->m_questLog[questLogID].complete[questID / 8] & (1 << (questID % 8));

        if ((current != 0) || (complete != 0))
        {
            PChar->m_questLog[questLogID].current[questID / 8] &= ~(1 << (questID % 8));
            PChar->m_questLog[questLogID].complete[questID / 8] &= ~(1 << (questID % 8));

            PChar->pushPacket(new CQuestMissionLogPacket(PChar, questLogID, LOG_QUEST_CURRENT));
            PChar->pushPacket(new CQuestMissionLogPacket(PChar, questLogID, LOG_QUEST_COMPLETE));

            charutils::SaveQuestsList(PChar);
        }
    }
    else
    {
        ShowError(CL_RED "Lua::delQuest: questLogID %i or QuestID %i is invalid\n" CL_RESET, questLogID, questID);
    }
}

/************************************************************************
 *  Function: getQuestStatus()
 *  Purpose : Gets the current quest status of the player
 *  Example : player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MAKING_THE_GRADE)
 ************************************************************************/

uint8 CLuaBaseEntity::getQuestStatus(uint8 questLogID, uint16 questID)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    if (questLogID < MAX_QUESTAREA && questID < MAX_QUESTID)
    {
        auto* PChar    = static_cast<CCharEntity*>(m_PBaseEntity);
        uint8 current  = PChar->m_questLog[questLogID].current[questID / 8] & (1 << (questID % 8));
        uint8 complete = PChar->m_questLog[questLogID].complete[questID / 8] & (1 << (questID % 8));

        return (complete != 0 ? 2 : (current != 0 ? 1 : 0));
    }
    else
    {
        ShowError(CL_RED "Lua::getQuestStatus: questLogID %i or QuestID %i is invalid\n" CL_RESET, questLogID, questID);
    }

    XI_DEBUG_BREAK_IF(true); // We shouldn't get here.  If you did, fix the lua call.
    return 0;
}

/************************************************************************
 *  Function: hasCompletedQuest()
 *  Purpose : Returns true if a player has completed a quest
 *  Example : if (player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_INFINITY)) then
 ************************************************************************/

bool CLuaBaseEntity::hasCompletedQuest(uint8 questLogID, uint16 questID)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    if (questLogID < MAX_QUESTAREA && questID < MAX_QUESTID)
    {
        uint8 complete = static_cast<CCharEntity*>(m_PBaseEntity)->m_questLog[questLogID].complete[questID / 8] & (1 << (questID % 8));

        return complete != 0;
    }

    ShowError(CL_RED "Lua::hasCompletedQuest: questLogID %i or QuestID %i is invalid\n" CL_RESET, questLogID, questID);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (questLogID < MAX_QUESTAREA && questID < MAX_QUESTID)
    {
        uint8 complete = PChar->m_questLog[questLogID].complete[questID / 8] & (1 << (questID % 8));

        if (!complete)
        {
            PChar->m_questLog[questLogID].current[questID / 8] &= ~(1 << (questID % 8));
            PChar->m_questLog[questLogID].complete[questID / 8] |= (1 << (questID % 8));

            PChar->pushPacket(new CQuestMissionLogPacket(PChar, questLogID, LOG_QUEST_CURRENT));
            PChar->pushPacket(new CQuestMissionLogPacket(PChar, questLogID, LOG_QUEST_COMPLETE));
            charutils::SaveQuestsList(PChar);
            roeutils::event(ROE_QUEST_COMPLETE, PChar, RoeDatagramList{});
        }
    }
    else
    {
        ShowError(CL_RED "Lua::completeQuest: questLogID %i or QuestID %i is invalid\n" CL_RESET, questLogID, questID);
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

        if (PChar->m_missionLog[missionLogID].current != (missionLogID > 2 ? 0 : -1))
        {
            ShowWarning(CL_YELLOW "Lua::addMission: player has a current mission\n" CL_RESET, missionLogID);
        }

        PChar->m_missionLog[missionLogID].current = missionID;
        PChar->pushPacket(new CQuestMissionLogPacket(PChar, missionLogID, LOG_MISSION_CURRENT));

        charutils::SaveMissionsList(PChar);
    }
    else
    {
        ShowError(CL_RED "Lua::delMission: missionLogID %i or Mission %i is invalid\n" CL_RESET, missionLogID, missionID);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    if (missionLogID < MAX_MISSIONAREA && missionID < MAX_MISSIONID)
    {
        auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

        uint16 current  = PChar->m_missionLog[missionLogID].current;
        bool   complete = (missionLogID == MISSION_COP || missionID >= 64) ? false : PChar->m_missionLog[missionLogID].complete[missionID];

        if (current == missionID)
        {
            PChar->m_missionLog[missionLogID].current = missionLogID > 2 ? 0 : -1;
            PChar->pushPacket(new CQuestMissionLogPacket(PChar, missionLogID, LOG_MISSION_CURRENT));
        }
        if (complete)
        {
            PChar->m_missionLog[missionLogID].complete[missionID] = false;
            PChar->pushPacket(new CQuestMissionLogPacket(PChar, missionLogID, LOG_MISSION_COMPLETE));
        }
        charutils::SaveMissionsList(PChar);
    }
    else
    {
        ShowError(CL_RED "Lua::delMission: missionLogID %i or Mission %i is invalid\n" CL_RESET, missionLogID, missionID);
    }
}

/************************************************************************
 *  Function: getCurrentMission()
 *  Purpose : Returns the integer associated with the player's current mission
 *  Example : player:getCurrentMission(TOAU)
 *  Notes   : Specify the area to pass a Lua table object
 ************************************************************************/

uint16 CLuaBaseEntity::getCurrentMission(sol::object const& missionLogObj)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
        ShowError(CL_RED "Lua::getCurrentMission: missionLogID %i is invalid\n" CL_RESET, missionLogID);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    bool complete = false;

    if (missionLogID < MAX_MISSIONAREA && missionID < MAX_MISSIONID)
    {
        auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
        complete    = (missionLogID == MISSION_COP || missionID >= 64) ? missionID < PChar->m_missionLog[missionLogID].current
                                                                       : PChar->m_missionLog[missionLogID].complete[missionID];
    }
    else
    {
        ShowError(CL_RED "Lua::hasCompletedMission: missionLogID %i or Mission %i is invalid\n" CL_RESET, missionLogID, missionID);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    if (missionLogID < MAX_MISSIONAREA && missionID < MAX_MISSIONID)
    {
        auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

        if (PChar->m_missionLog[missionLogID].current != missionID)
        {
            ShowWarning(CL_YELLOW "Lua::completeMission: can't complete non current mission\n" CL_RESET, missionLogID);
        }
        else
        {
            PChar->m_missionLog[missionLogID].current = missionLogID > 2 ? 0 : -1;
            if ((missionLogID != MISSION_COP) && (missionID < 64))
            {
                PChar->m_missionLog[missionLogID].complete[missionID] = true;
                PChar->pushPacket(new CQuestMissionLogPacket(PChar, missionLogID, LOG_MISSION_COMPLETE));
            }
            PChar->pushPacket(new CQuestMissionLogPacket(PChar, missionLogID, LOG_MISSION_CURRENT));

            charutils::SaveMissionsList(PChar);
            roeutils::event(ROE_MISSION_COMPLETE, PChar, RoeDatagramList{});
        }
    }
    else
    {
        ShowError(CL_RED "Lua::completeMission: missionLogID %i or Mission %i is invalid\n" CL_RESET, missionLogID, missionID);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    CCharEntity* PChar = (CCharEntity*)m_PBaseEntity;

    if (missionLogID >= MAX_MISSIONAREA)
    {
        ShowError(CL_RED "Lua::setMissionStatus: missionLogID %i is invalid\n" CL_RESET, missionLogID);
        return;
    }

    if (arg3Obj.is<uint8>())
    {
        uint8 missionStatusPos = arg3Obj.as<uint8>();
        if (missionStatusPos > 7)
        {
            ShowError(CL_RED "Lua::setMissionStatus: position %i is invalid\n" CL_RESET, missionStatusPos);
            return;
        }
        uint8 missionStatusValue = arg2Obj.as<uint8>();
        if (missionStatusValue > 0xF)
        {
            ShowError(CL_RED "Lua::setMissionStatus: value %i is invalid\n" CL_RESET, missionStatusValue);
            return;
        }
        uint32 missionStatus = (PChar->m_missionLog[missionLogID].statusUpper << 16) | PChar->m_missionLog[missionLogID].statusLower;
        uint32 mask  = ~(0xF << (4 * missionStatusPos));

        missionStatus &= mask;
        missionStatus |= missionStatusValue << (4 * missionStatusPos);
        PChar->m_missionLog[missionLogID].statusLower = missionStatus;
        PChar->m_missionLog[missionLogID].statusUpper = missionStatus >> 16;
        PChar->pushPacket(new CQuestMissionLogPacket(PChar, missionLogID, LOG_MISSION_CURRENT));
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    CCharEntity* PChar = (CCharEntity*)m_PBaseEntity;
    if (missionLogID < MAX_MISSIONAREA)
    {
        uint32 missionStatus = (PChar->m_missionLog[missionLogID].statusUpper << 16) | PChar->m_missionLog[missionLogID].statusLower;
        if (missionStatusPosObj.is<uint8>())
        {
            uint8 missionStatusPos = missionStatusPosObj.as<uint8>();
            if (missionStatusPos > 7)
            {
                ShowError(CL_RED "Lua::getMissionStatus: position %i is invalid\n" CL_RESET, missionStatusPos);
                return 0;
            }
            return ((missionStatus >> (4 * missionStatusPos)) & 0xF);
        }
        else
        {
            return missionStatus;
        }
    }

    ShowError(CL_RED "Lua::getMissionStatus: missionLogID %i is invalid\n" CL_RESET, missionLogID);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    bool repeat = (arg1 != sol::nil) ? arg1.as<bool>() : false;
    bool status = (arg2 != sol::nil) ? arg2.as<bool>() : true;

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    return roeutils::GetEminenceRecordCompletion(PChar, recordID);
}

uint16 CLuaBaseEntity::getNumEminenceCompleted()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto*  PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    uint32 total = arg2.get_type() == sol::type::number ? arg2.as<uint32>() : 0;

    // Determine threshold for sending progress messages
    bool progressNotify{ true };
    if (uint32 threshold = roeutils::RoeSystem.NotifyThresholds[recordID]; threshold > 1)
    {
        uint32 prevStep = static_cast<uint32>(roeutils::GetEminenceRecordProgress(PChar, recordID) / threshold);
        uint32 nextStep = static_cast<uint32>(progress / threshold);
        progressNotify  = nextStep > prevStep;
    }

    bool result = roeutils::SetEminenceRecordProgress(PChar, recordID, progress);

    if (total && progressNotify)
    {
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, recordID, 0, MSGBASIC_ROE_RECORD));
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, progress, total, MSGBASIC_ROE_PROGRESS));
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    if (m_PBaseEntity->objtype != TYPE_PC)
    {
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);
    RoeDatagramList roeEventData({});
    ROE_EVENT       eventID = static_cast<ROE_EVENT>(eventNum);

    if (reqTable.get_type() == sol::type::table)
    {
        for (const auto& kv : reqTable.as<sol::table>())
        {
            if (kv.first.get_type() == sol::type::string)
            {
                if (kv.second.get_type() == sol::type::number)
                {
                    roeEventData.emplace_back(RoeDatagram(kv.first.as<std::string>(), kv.second.as<uint32>()));
                }
                else if (kv.second.get_type() == sol::type::string)
                {
                    roeEventData.emplace_back(RoeDatagram(kv.first.as<std::string>(), kv.second.as<std::string>()));
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    uint8 unity = (unityObj != sol::nil) ? unityObj.as<uint8>() : PChar->profile.unity_leader;

    if (unity >= 1 && unity <= 11)
    {
        return roeutils::RoeSystem.unityLeaderRank[unity - 1];
    }

    return std::nullopt;
}

/************************************************************************
 *  Function: addAssault()
 *  Purpose : Adds an assault mission to the player's log
 *  Example : player:addAssault(bit.rshift(option,4))
 *  Notes   : See scripts/zones/Aht_Urhgan_Whitegate/npcs/Famad.lua
 ************************************************************************/

void CLuaBaseEntity::addAssault(uint8 missionID)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (PChar->m_assaultLog.current != 0)
    {
        ShowWarning(CL_YELLOW "Lua::addAssault: player has a current assault\n" CL_RESET);
    }

    PChar->m_assaultLog.current = missionID;
    PChar->pushPacket(new CQuestMissionLogPacket(PChar, MISSION_ASSAULT, LOG_MISSION_CURRENT));

    charutils::SaveMissionsList(PChar);
}

/************************************************************************
 *  Function: delAssault()
 *  Purpose : Deletes an assault mission from a player's log
 *  Example : player:delAssault(currentAssault)
 ************************************************************************/

void CLuaBaseEntity::delAssault(uint8 missionID)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar   = static_cast<CCharEntity*>(m_PBaseEntity);
    auto  current = static_cast<uint8>(PChar->m_assaultLog.current);

    if (current == missionID)
    {
        PChar->m_assaultLog.current = 0;
        PChar->pushPacket(new CQuestMissionLogPacket(PChar, MISSION_ASSAULT, LOG_MISSION_CURRENT));
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (PChar->m_assaultLog.current != missionID)
    {
        ShowWarning(CL_YELLOW "Lua::completeAssault: completion of not current assault\n" CL_RESET);
    }

    PChar->m_assaultLog.current             = 0;
    PChar->m_assaultLog.complete[missionID] = true;
    PChar->pushPacket(new CQuestMissionLogPacket(PChar, MISSION_ASSAULT, LOG_MISSION_CURRENT));
    PChar->pushPacket(new CQuestMissionLogPacket(PChar, MISSION_ASSAULT, LOG_MISSION_COMPLETE));

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    uint8 table = keyItemID >> 9;

    charutils::addKeyItem(PChar, keyItemID);
    PChar->pushPacket(new CKeyItemsPacket(PChar, static_cast<KEYS_TABLE>(table)));

    if (table == 6)
    {
        PChar->pushPacket(new CCharMountsPacket(PChar));
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    charutils::delKeyItem(PChar, keyItemID);
    PChar->pushPacket(new CKeyItemsPacket(PChar, static_cast<KEYS_TABLE>(keyItemID >> 9)));

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    charutils::unseenKeyItem(PChar, keyItemID);
    PChar->pushPacket(new CKeyItemsPacket(PChar, static_cast<KEYS_TABLE>(keyItemID >> 9)));

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->PMeritPoints->SetMeritPoints(numPoints);
    PChar->pushPacket(new CMenuMeritPacket(PChar));

    charutils::SaveCharExp(PChar, PChar->GetMJob());
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
        ShowDebug("Warning: Attempt to set Capacity Points for non-PC type!\n");
        return;
    }

    CCharEntity* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->PJobPoints->SetCapacityPoints(amount);
    PChar->pushPacket(new CMenuJobPointsPacket(PChar));
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
        ShowDebug("Warning: Attempt to set Job Points for non-PC type!\n");
        return;
    }

    CCharEntity* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->PJobPoints->SetJobPoints(amount);
    PChar->pushPacket(new CMenuJobPointsPacket(PChar));
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
            ShowFatalError(CL_RED "lua::getGil : Item in currency slot is not gil!\n" CL_RESET);
            return 0;
        }

        return item->getQuantity();
    }

    if (m_PBaseEntity->objtype == TYPE_MOB)
    {
        auto* PMob = dynamic_cast<CMobEntity*>(m_PBaseEntity);
        if (PMob->CanStealGil())
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    CItem* item = static_cast<CCharEntity*>(m_PBaseEntity)->getStorage(LOC_INVENTORY)->GetItem(0);

    if (item == nullptr || !item->isType(ITEM_CURRENCY))
    {
        ShowFatalError(CL_RED "lua::addGil : No Gil in currency slot\n" CL_RESET);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    CItem* item = static_cast<CCharEntity*>(m_PBaseEntity)->getStorage(LOC_INVENTORY)->GetItem(0);

    if (item == nullptr || !item->isType(ITEM_CURRENCY))
    {
        ShowFatalError(CL_RED "lua::setGil : No Gil in currency slot\n" CL_RESET);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    bool result = false;

    CItem* PItem = static_cast<CCharEntity*>(m_PBaseEntity)->getStorage(LOC_INVENTORY)->GetItem(0);

    if (PItem != nullptr && PItem->isType(ITEM_CURRENCY))
    {
        auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
        result      = charutils::UpdateItem(PChar, LOC_INVENTORY, 0, -gil) == 0xFFFF;
    }
    else
    {
        ShowFatalError(CL_RED "lua::delGil : No Gil in currency slot\n" CL_RESET);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    charutils::AddPoints(PChar, charutils::GetConquestPointsName(PChar).c_str(), cp);
    PChar->pushPacket(new CConquestPacket(PChar));
}

/************************************************************************
 *  Function: delCP()
 *  Purpose : Takes conquest points from a player
 *  Example : player:delCP(2500)
 *  Notes   : Current nation only
 ************************************************************************/

void CLuaBaseEntity::delCP(int32 cp)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    charutils::AddPoints(PChar, charutils::GetConquestPointsName(PChar).c_str(), -cp);
    PChar->pushPacket(new CConquestPacket(PChar));
}

/************************************************************************
 *  Function: getSeals()
 *  Purpose : Returns the current seal balance for a player
 *  Example : player:getSeals(type)
 *  Notes   : 0 = Beast; 1 = Kindred; 2 = KCrest; 3 = HKCrest; 4 = SKCrest
 ************************************************************************/

int32 CLuaBaseEntity::getSeals(uint8 sealType)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    CGuild* PGuild = guildutils::GetGuild(guildID);
    auto*   PChar  = static_cast<CCharEntity*>(m_PBaseEntity);

    int16 points = 0;
    uint8 items  = PGuild->addGuildPoints(PChar, PChar->TradeContainer->getItem(slotID), points);

    return { items, points };
}

/************************************************************************
 *  Function: getHP()
 *  Purpose : Returns current Hit Points of an Entity
 *  Example : player:getHP()
 *  Notes   :
 ************************************************************************/

int32 CLuaBaseEntity::getHP()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);

    int32 result = PBattle->addHP(hpAdd);

    // will always remove sleep effect
    PBattle->StatusEffectContainer->DelStatusEffect(EFFECT_SLEEP);
    PBattle->StatusEffectContainer->DelStatusEffect(EFFECT_SLEEP_II);
    PBattle->StatusEffectContainer->DelStatusEffect(EFFECT_LULLABY);

    return result;
}

/************************************************************************
 *  Function: setHP()
 *  Purpose : Sets the Hit Points of an Entity
 *  Example : player:setHP(player:getMaxHP())
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setHP(int32 value)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
 *  Function: restoreHP()
 *  Purpose : Restores the Hit Points of an Entity by a specified amount
 *  Example : player:restoreHP(1000)
 *  Notes   : Returns amount restored if not dead
 ************************************************************************/

int32 CLuaBaseEntity::restoreHP(int32 restoreAmt)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    static_cast<CBattleEntity*>(m_PBaseEntity)->takeDamage(delAmt);
}

/************************************************************************
 *  Function: takeDamage()
 *  Purpose : Takes damage from the provided attacker. If no attacker is provided then it clears the last attacker.
 *  Example : target:takeDamage(500, attacker=nil, attackType=ATTACK_NONE, damageType=DAMAGE_NONE, flags={wakeUp=true})
 ************************************************************************/

void CLuaBaseEntity::takeDamage(int32 damage, sol::object const& attacker, sol::object const& atkType, sol::object const& dmgType, sol::object const& flags)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    // Attempt to retrieve the attacker
    CBattleEntity* PAttacker = nullptr;
    if (attacker != sol::nil)
    {
        CLuaBaseEntity* PLuaAttacker = attacker.as<CLuaBaseEntity*>();

        XI_DEBUG_BREAK_IF(PLuaAttacker == nullptr);
        XI_DEBUG_BREAK_IF(PLuaAttacker->m_PBaseEntity->objtype == TYPE_NPC);

        PAttacker = dynamic_cast<CBattleEntity*>(PLuaAttacker->m_PBaseEntity);
    }

    CBattleEntity* PDefender = dynamic_cast<CBattleEntity*>(m_PBaseEntity);

    // Check for special flags which may prevent damage from waking up the target
    bool wakeUp        = true;
    bool breakBind     = true;
    bool removePetrify = true;

    // TODO: Unused in current code, needs testing; change type to sol::table?
    //       Find a way to make this better! (Optional keys as well?)
    if (flags != sol::nil)
    {
        auto flag_map = flags.as<std::map<std::string, bool>>();

        wakeUp        = flag_map["wakeUp"];
        removePetrify = flag_map["removePetrify"];
        breakBind     = flag_map["breakBind"];
    }

    // Deal damage and liberate target when applicable
    if (damage > 0)
    {
        ATTACK_TYPE attackType = (atkType != sol::nil) ? static_cast<ATTACK_TYPE>(atkType.as<uint8>()) : ATTACK_TYPE::NONE;
        DAMAGE_TYPE damageType = (dmgType != sol::nil) ? static_cast<DAMAGE_TYPE>(dmgType.as<uint8>()) : DAMAGE_TYPE::NONE;

        PDefender->takeDamage(damage, PAttacker, attackType, damageType);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB && m_PBaseEntity->objtype != TYPE_NPC);

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

/************************************************************************
 *  Function: getMP()
 *  Purpose : Returns the current Mana Points of an entity
 *  Example : player:getMP()
 ************************************************************************/

int32 CLuaBaseEntity::getMP()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    return static_cast<CBattleEntity*>(m_PBaseEntity)->GetMPP();
}

/************************************************************************
 *  Function: getMaxMP()
 *  Purpose : Returns the Max Mana Points of an entity
 *  Example : player:getMaxMP()
 ************************************************************************/

int32 CLuaBaseEntity::getMaxMP()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    return static_cast<CBattleEntity*>(m_PBaseEntity)->GetMaxMP();
}

/************************************************************************
 *  Function: getBaseMP()
 *  Purpose : Returns the Base Mana Points of an entity
 *  Example : player:getBaseMP()
 ************************************************************************/

int32 CLuaBaseEntity::getBaseMP()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    return static_cast<CBattleEntity*>(m_PBaseEntity)->addMP(amount);
}

/************************************************************************
 *  Function: setMP()
 *  Purpose : Sets the Mana Points of an entity to a specified amount
 *  Example : player:setMP(player:getMaxMP())
 ************************************************************************/

void CLuaBaseEntity::setMP(int32 value)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);

    PBattle->health.mp = 0;
    PBattle->addMP(value);
}

/************************************************************************
 *  Function: restoreMP()
 *  Purpose : Restores Mana Points to a player
 *  Example : player:restoreMP(player:getMaxHP() - player:getHP())
 *  Notes   : Returns the restored amount if not dead
 ************************************************************************/

int32 CLuaBaseEntity::restoreMP(int32 amount)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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

void CLuaBaseEntity::delMP(int32 amount)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    static_cast<CBattleEntity*>(m_PBaseEntity)->addMP(-amount);
}

/************************************************************************
 *  Function: getTP()
 *  Purpose : Returns the current Tactical Points of an Entity
 *  Example : if player:getTP() > 1000 then
 ************************************************************************/

float CLuaBaseEntity::getTP()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);
    return static_cast<float>(PBattle->health.tp);
}

/************************************************************************
 *  Function: addTP()
 *  Purpose : Adds Tactical Points to an Entity
 *  Example : player:addTP(1000) - Icarus Wing
 ************************************************************************/

void CLuaBaseEntity::addTP(int16 amount)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    static_cast<CBattleEntity*>(m_PBaseEntity)->addTP(amount);
}

/************************************************************************
 *  Function: setTP()
 *  Purpose : Sets the Tactical Points of an entity
 *  Example : player:setTP(1000)
 ************************************************************************/

void CLuaBaseEntity::setTP(int16 value)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);

    PBattle->health.tp    = 0;
    int16 available_value = value - (PBattle->health.tp);
    PBattle->addTP(available_value);
}

/************************************************************************
 *  Function: delTP()
 *  Purpose : Subtracts Tactical Points from an Entity
 *  Example : player:delTP(50)
 ************************************************************************/

void CLuaBaseEntity::delTP(int16 amount)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    static_cast<CBattleEntity*>(m_PBaseEntity)->addTP(-amount);
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
    static_cast<CBattleEntity*>(m_PBaseEntity)->UpdateHealth();
}

/************************************************************************
 *  Function: capSkill()
 *  Purpose : Caps a particular skill for a PC
 *  Example : player:capSkill(xi.skill.DAGGER)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::capSkill(uint8 skill)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    if (skill < MAX_SKILLTYPE)
    {
        auto* PChar = dynamic_cast<CCharEntity*>(m_PBaseEntity);
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
        PChar->pushPacket(new CCharSkillsPacket(PChar));
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    for (uint8 i = 1; i < 45; ++i)
    {
        const char* Query = "INSERT INTO char_skills "
                            "SET "
                            "charid = %u,"
                            "skillid = %u,"
                            "value = %u,"
                            "rank = %u "
                            "ON DUPLICATE KEY UPDATE value = %u, rank = %u;";

        Sql_Query(SqlHandle, Query, PChar->id, i, 5000, PChar->RealSkills.rank[i], 5000, PChar->RealSkills.rank[i]);

        uint16 maxSkill               = 10 * battleutils::GetMaxSkill(static_cast<SKILLTYPE>(i), PChar->GetMJob(), PChar->GetMLevel());
        PChar->RealSkills.skill[i]    = maxSkill; // set to capped
        PChar->WorkingSkills.skill[i] = maxSkill / 10;
        PChar->WorkingSkills.skill[i] |= 0x8000; // set blue capped flag
    }
    charutils::CheckWeaponSkill(PChar, SKILL_NONE);
    PChar->pushPacket(new CCharSkillsPacket(PChar));
}

/************************************************************************
 *  Function: getSkillLevel()
 *  Purpose : Returns the level for a specified skill of a PC
 *  Example : player:getSkillLevel(xi.skill.ENHANCING_MAGIC)
 *  Notes   :
 ************************************************************************/

uint16 CLuaBaseEntity::getSkillLevel(uint16 skillId)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype & TYPE_NPC);

    XI_DEBUG_BREAK_IF(skillId >= MAX_SKILLTYPE);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    XI_DEBUG_BREAK_IF(SkillID >= MAX_SKILLTYPE);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->RealSkills.skill[SkillID]    = SkillAmount;
    PChar->WorkingSkills.skill[SkillID] = (SkillAmount / 10) * 0x20 + PChar->WorkingSkills.rank[SkillID];

    jobpointutils::RefreshGiftMods(PChar);
    charutils::BuildingCharSkillsTable(PChar);
    charutils::CheckWeaponSkill(PChar, SkillID);
    charutils::SaveCharSkills(PChar, SkillID);

    PChar->pushPacket(new CCharSkillsPacket(PChar));
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
 *  Notes   : XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);?
 ************************************************************************/

uint8 CLuaBaseEntity::getSkillRank(uint8 rankID)
{
    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    return PChar->RealSkills.rank[rankID];
}

/************************************************************************
 *  Function: setSkillRank()
 *  Purpose : Sets a Skill Rank for a particular skill
 *  Example : player:setSkillRank(xi.skill.DIG, 20)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::setSkillRank(uint8 skillID, uint8 newrank)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    PChar->WorkingSkills.rank[skillID]  = newrank;
    PChar->WorkingSkills.skill[skillID] = (PChar->RealSkills.skill[skillID] / 10) * 0x20 + newrank;
    PChar->RealSkills.rank[skillID]     = newrank;
    // PChar->RealSkills.skill[skillID] += 1;

    jobpointutils::RefreshGiftMods(PChar);
    charutils::BuildingCharSkillsTable(PChar);
    charutils::SaveCharSkills(PChar, skillID);
    PChar->pushPacket(new CCharSkillsPacket(PChar));
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
 *  Example : player:addLearnedWeaponskill(xi.weaponskill.DECIMATION)
 *  Notes   : Do not see implemented in any script
 ************************************************************************/

void CLuaBaseEntity::addLearnedWeaponskill(uint8 wsID)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    charutils::addLearnedWeaponskill(PChar, wsID);
    charutils::BuildingCharWeaponSkills(PChar);
    charutils::SaveLearnedAbilities(PChar);
    PChar->pushPacket(new CCharAbilitiesPacket(PChar));
}

/************************************************************************
 *  Function: hasLearnedWeaponskill()
 *  Purpose : Returns true if a player has learned a particular weaponskill
 *  Example : if player:hasLearnedWeaponskill(xi.weaponskill.DECIMATION) then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::hasLearnedWeaponskill(uint8 wsID)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    return (charutils::hasLearnedWeaponskill(static_cast<CCharEntity*>(m_PBaseEntity), wsID) != 0);
}

/************************************************************************
 *  Function: delLearnedWeaponskill()
 *  Purpose : Removes a learned weaponskill from the player
 *  Example : player:delLearnedWeaponskill(xi.weaponskill.ASURAN_FISTS)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::delLearnedWeaponskill(uint8 wsID)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    charutils::delLearnedWeaponskill(PChar, wsID);
    charutils::BuildingCharWeaponSkills(PChar);
    charutils::SaveLearnedAbilities(PChar);
    PChar->pushPacket(new CCharAbilitiesPacket(PChar));
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

    bool forceSkillUp = (forceSkillUpObj != sol::nil) ? forceSkillUpObj.as<bool>() : false;
    bool useSubSkill  = (useSubSkillObj != sol::nil) ? forceSkillUpObj.as<bool>() : false;

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (charutils::addLearnedAbility(PChar, abilityID))
    {
        charutils::addAbility(PChar, abilityID);
        charutils::SaveLearnedAbilities(PChar);
        PChar->pushPacket(new CCharAbilitiesPacket(PChar));
        PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 442));
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (charutils::delLearnedAbility(PChar, abilityID))
    {
        charutils::SaveLearnedAbilities(PChar);
        PChar->pushPacket(new CCharAbilitiesPacket(PChar));
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    bool silentLog  = va[0].is<bool>() ? va[0].as<bool>() : false;
    bool save       = va[1].is<bool>() ? va[1].as<bool>() : true;
    bool sendUpdate = va[2].is<bool>() ? va[2].as<bool>() : true;

    if (charutils::addSpell(PChar, spellID))
    {
        if (sendUpdate)
        {
            PChar->pushPacket(new CCharSpellsPacket(PChar));
        }

        if (!silentLog)
        {
            PChar->pushPacket(new CMessageBasicPacket(PChar, PChar, 0, 0, 23));
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (charutils::delSpell(PChar, spellID))
    {
        charutils::DeleteSpell(PChar, spellID);
        PChar->pushPacket(new CCharSpellsPacket(PChar));
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC)

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    charutils::BuildingCharSkillsTable(PChar);
    charutils::BuildingCharWeaponSkills(PChar);

    PChar->pushPacket(new CCharSkillsPacket(PChar));
    PChar->pushPacket(new CCharRecastPacket(PChar));
    PChar->pushPacket(new CCharAbilitiesPacket(PChar));
}

/************************************************************************
 *  Function: recalculateAbilitiesTable()
 *  Purpose : Recalculates ability tables to get new values and calculations
 *  Example : target:recalculateAbilitiesTable()
 *  Notes   : Used exlusively for Scholar abilities and Astral Flow
 ************************************************************************/

void CLuaBaseEntity::recalculateAbilitiesTable()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC)

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    charutils::BuildingCharAbilityTable(PChar);
    charutils::BuildingCharTraitsTable(PChar);
    charutils::BuildingCharWeaponSkills(PChar);

    if (PChar->PPet != nullptr && PChar->PPet->objtype == TYPE_PET)
    {
        auto* PPetEntity = static_cast<CPetEntity*>(PChar->PPet);

        charutils::BuildingCharPetAbilityTable(PChar, PPetEntity, PPetEntity->m_PetID);
    }

    PChar->pushPacket(new CCharAbilitiesPacket(PChar));
}

/************************************************************************
 *  Function: getParty()
 *  Purpose : Returns a Lua table of party member Entity objects
 *  Example : local party = player:getParty()
 *  Notes   :
 ************************************************************************/

sol::table CLuaBaseEntity::getParty()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    CParty* party = static_cast<CBattleEntity*>(m_PBaseEntity)->PParty;

    auto table = luautils::lua.create_table();
    ((CBattleEntity*)m_PBaseEntity)->ForParty([&table](CBattleEntity* member) {
        table.add(CLuaBaseEntity(member));
    });

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    CParty* party = static_cast<CCharEntity*>(m_PBaseEntity)->PParty;

    auto table = luautils::lua.create_table();
    ((CCharEntity*)m_PBaseEntity)->ForPartyWithTrusts([&table](CBattleEntity* member) {
        table.add(CLuaBaseEntity(member));
    });

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    uint8 allianceparty = (arg0 == sol::nil) ? 0 : arg0.as<uint8>();
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
        for (auto& member : static_cast<CCharEntity*>(m_PBaseEntity)->PParty->members)
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    CBattleEntity* PBattle     = static_cast<CBattleEntity*>(m_PBaseEntity);
    CBattleEntity* PTargetChar = nullptr;

    if (allianceparty == 0 && member == 0)
    {
        PTargetChar = PBattle;
    }
    else if (PBattle->PParty != nullptr)
    {
        if (allianceparty == 0 && member <= PBattle->PParty->members.size())
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

    ShowError(CL_RED "Lua::getPartyMember :: Member or Alliance Number is not valid.\n" CL_RESET);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity == nullptr);
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    target->ForParty([&target, &range, &function](CBattleEntity* member) {
        if (target->loc.zone == member->loc.zone && distanceSquared(target->loc.p, member->loc.p) < (range * range))
        {
            function(CLuaBaseEntity(member));
        }
    });
}

/************************************************************************
 *  Function: addPartyEffect()
 *  Purpose : Adds effect to members of the entire party
 *  Example : player:addPartyEffect(effect, 1, 2, 3, ...)?
 *  Notes   : Must have at least three members, scales to six max
 ************************************************************************/

void CLuaBaseEntity::addPartyEffect(sol::variadic_args va)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    std::vector<uint16> args(7, 0);

    uint8 idx = 0;
    for (auto v : va)
    {
        args[idx++] = v.get<uint16>();
    }

    CStatusEffect* PEffect =
        new CStatusEffect(static_cast<EFFECT>(args[0]), args[1], args[2], args[3], args[4], args[5], args[6]);

    CBattleEntity* PEntity = ((CBattleEntity*)m_PBaseEntity);

    PEntity->ForParty([PEffect](CBattleEntity* PMember) { PMember->StatusEffectContainer->AddStatusEffect(PEffect); });
}

/************************************************************************
 *  Function: hasPartyEffect()
 *  Purpose : Returns true if all members of party have a specified effect
 *  Example : if player:hasPartyEffect(effect) then
 *  Notes   : Currently not used in any script
 ************************************************************************/

bool CLuaBaseEntity::hasPartyEffect(uint16 effectid)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    auto table = luautils::lua.create_table();
    PChar->ForAlliance([&table](CBattleEntity* PMember) {
        table.add(CLuaBaseEntity(PMember));
    });

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
    auto* PBattle      = static_cast<CBattleEntity*>(m_PBaseEntity);
    uint8 alliancesize = 1;

    if (PBattle->PParty != nullptr)
    {
        if (PBattle->PParty->m_PAlliance != nullptr)
        {
            alliancesize = static_cast<uint8>(PBattle->PParty->m_PAlliance->partyList.size());
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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

    XI_DEBUG_BREAK_IF(true); // Only a failed cast should get us here, examine why
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    static_cast<CCharEntity*>(m_PBaseEntity)->ReloadPartyInc();
}

/************************************************************************
 *  Function: disableLevelSync()
 *  Purpose : Disables...wait for it...Level Sync
 *  Example : target:disableLevelSync()
 *  Notes   : Only used in scripts/globals/effects/level_sync.lua
 ************************************************************************/

void CLuaBaseEntity::disableLevelSync()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (PChar->PParty)
    {
        if (PChar->PParty->GetSyncTarget() == PChar)
        {
            PChar->PParty->SetSyncTarget(nullptr, 553);
        }
        else
        {
            PChar->PParty->DisableSync();
        }
    }

    PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, new CCharSyncPacket(PChar));
}

/************************************************************************
 *  Function: isLevelSync()
 *  Purpose :
 *  Example : player:isLevelSync()
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isLevelSync()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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

bool CLuaBaseEntity::checkKillCredit(CLuaBaseEntity* PLuaBaseEntity, sol::object const& arg1, sol::object const& arg2)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    XI_DEBUG_BREAK_IF(PLuaBaseEntity == nullptr);
    XI_DEBUG_BREAK_IF(PLuaBaseEntity->GetBaseEntity()->objtype != TYPE_MOB);

    CCharEntity* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    CMobEntity*  PMob  = static_cast<CMobEntity*>(PLuaBaseEntity->GetBaseEntity());

    bool  credit  = false;
    int   lvlDiff = (int)(PMob->GetMLevel()) - (int)(PChar->GetMLevel());
    int   maxDiff = (arg1 != sol::nil) ? arg1.as<int>() : 15;
    float range   = (arg2 != sol::nil) ? arg2.as<float>() : 100;

    if (charutils::CheckMob(PMob->m_HiPCLvl, PMob->GetMLevel()) > EMobDifficulty::TooWeak && distance(PMob->loc.p, PChar->loc.p) < range && lvlDiff < maxDiff)
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    CInstance* PInstance     = PLuaInstance->GetInstance();
    m_PBaseEntity->PInstance = PInstance;

    if (PInstance)
    {
        PInstance->RegisterChar(dynamic_cast<CCharEntity*>(m_PBaseEntity));
    }
}

/************************************************************************
 *  Function: createInstance()
 *  Purpose : Creates a new instance for a PC
 *  Example : player:createInstance(player:getCurrentAssault(), 63)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::createInstance(uint8 instanceID, uint16 zoneID)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    instanceutils::LoadInstance(instanceID, zoneID, static_cast<CCharEntity*>(m_PBaseEntity));
}

/************************************************************************
 *  Function: instanceEntry()
 *  Purpose : Creates an instance entry packet for the player
 *  Example : player:instanceEntry(target,1)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::instanceEntry(CLuaBaseEntity* PLuaBaseEntity, uint32 response)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    CBaseEntity* PTarget = PLuaBaseEntity->m_PBaseEntity;

    static_cast<CCharEntity*>(m_PBaseEntity)->pushPacket(new CInstanceEntryPacket(PTarget, response));
}

/************************************************************************
 *  Function: getConfrontationEffect()
 *  Purpose : None yet
 *  Example :
 *  Notes   : Not moved to scripts
 ************************************************************************/

uint16 CLuaBaseEntity::getConfrontationEffect()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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

uint8 CLuaBaseEntity::registerBattlefield(sol::object const& arg0, sol::object const& arg1, sol::object const& arg2)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->loc.zone->m_BattlefieldHandler == nullptr);
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    auto* PZone = PChar->loc.zone == nullptr ? zoneutils::GetZone(PChar->loc.destination) : PChar->loc.zone;

    int    battlefield = (arg0 != sol::nil) ? arg0.as<int>() : -1;
    uint8  area        = (arg1 != sol::nil) ? arg1.as<uint8>() : 1;
    uint32 initiator   = (arg2 != sol::nil) ? arg2.as<uint32>() : 0;

    // TODO: Verify what happens if -1 makes it to the cast below
    XI_DEBUG_BREAK_IF(battlefield < 0);

    return PZone->m_BattlefieldHandler->RegisterBattlefield(PChar, static_cast<uint16>(battlefield), area, initiator);
}

bool CLuaBaseEntity::battlefieldAtCapacity(int battlefieldID)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->loc.zone->m_BattlefieldHandler == nullptr);
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    auto* PZone = PChar->loc.zone == nullptr ? zoneutils::GetZone(PChar->loc.destination) : PChar->loc.zone;

    XI_DEBUG_BREAK_IF(PZone->m_BattlefieldHandler == nullptr);

    bool full = false;

    if (PZone != nullptr && PZone->m_BattlefieldHandler != nullptr && PZone->m_BattlefieldHandler->ReachedMaxCapacity(battlefieldID))
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->loc.zone->m_BattlefieldHandler == nullptr);
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    CBattlefield* PBattlefield = nullptr;
    if (area == sol::nil)
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity == nullptr || m_PBaseEntity->loc.zone->m_BattlefieldHandler == nullptr);
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    return static_cast<CBattleEntity*>(m_PBaseEntity)->isInDynamis();
}

/************************************************************************
 *  Function: isAlive()
 *  Purpose : Returns true if an Entity is alive
 *  Example : if mob:isAlive() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isAlive()
{
    return static_cast<CBattleEntity*>(m_PBaseEntity)->isAlive();
}

/************************************************************************
 *  Function: isDead()
 *  Purpose : Returns true if an Entity is dead
 *  Example : if pet:isDead() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isDead()
{
    return static_cast<CBattleEntity*>(m_PBaseEntity)->isDead();
}

/************************************************************************
 *  Function: sendRaise()
 *  Purpose : Updates the m_hasRaise private member with the Raise Level
 *  Example : target:sendRaise(1) -- 2, or 3 for R2, R3
 *  Notes   : Sending the Raise menu is handled by CDeathState::Update
 ************************************************************************/

void CLuaBaseEntity::sendRaise(uint8 raiseLevel)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (raiseLevel == 0 || raiseLevel > 3)
    {
        ShowDebug(CL_CYAN "lua::sendRaise raise value is not valid!\n" CL_RESET);
    }
    else if (PChar->m_hasTractor == 0 && PChar->m_hasRaise == 0)
    {
        PChar->m_hasRaise = raiseLevel;
        PChar->pushPacket(new CRaiseTractorMenuPacket(PChar, TYPE_RAISE));
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (raiseLevel == 0 || raiseLevel > 4)
    {
        ShowDebug(CL_CYAN "lua::sendRaise raise value is not valide!\n" CL_RESET);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (PChar->m_hasTractor == 0 && PChar->m_hasRaise == 0)
    {
        PChar->m_hasTractor = 1;

        PChar->m_StartActionPos.x        = xPos;
        PChar->m_StartActionPos.y        = yPos;
        PChar->m_StartActionPos.z        = zPos;
        PChar->m_StartActionPos.rotation = rotation;

        PChar->pushPacket(new CRaiseTractorMenuPacket(PChar, TYPE_TRACTOR));
    }
}

/************************************************************************
 *  Function: countdown()
 *  Purpose : Starts or clears a visible countdown bar for player
 *  Example : player:countdown(60)
 *  Notes   : Using 0 or no argument removes the countdown bar from the player
 ************************************************************************/
void CLuaBaseEntity::countdown(sol::object const& secondsObj,
                               sol::object const& bar1NameObj, sol::object const& bar1ValObj,
                               sol::object const& bar2NameObj, sol::object const& bar2ValObj)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    CCharEntity* PChar  = (CCharEntity*)m_PBaseEntity;
    auto*        packet = new CTimerBarUtilPacket();

    if (secondsObj.is<uint32>())
    {
        packet->addCountdown(secondsObj.as<uint32>());
    }

    if (bar1NameObj.is<std::string>() && bar1ValObj.is<uint8>())
    {
        packet->addBar1(bar1NameObj.as<std::string>(), bar1ValObj.as<uint8>());
    }

    if (bar2NameObj.is<std::string>() && bar2ValObj.is<uint8>())
    {
        packet->addBar2(bar2NameObj.as<std::string>(), bar2ValObj.as<uint8>());
    }

    PChar->pushPacket(packet);
}

/************************************************************************
 *  Function: enableEntities()
 *  Purpose : Enables/disables the list of given special hidden entities for just the target char
 *  Example : player:enableEntities({ 17207972, 17207973})
 *  Notes   : Default is all off, so sending the ID enables the special entity
 ************************************************************************/
void CLuaBaseEntity::enableEntities(std::vector<uint32> data)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar = static_cast<CCharEntity*>(m_PBaseEntity);
    PChar->pushPacket(new CEntityEnableList(data));
}

/************************************************************************
 *  Function: independentAnimation()
 *  Purpose : Play an animation independent of action messages
 *  Example : player:independentAnimation(player, 251, 4) -- Plays little hearts
 *  Notes   :
 ************************************************************************/
void CLuaBaseEntity::independentAnimation(CLuaBaseEntity* PTarget, uint16 animId, uint8 mode)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity == nullptr);

    CBaseEntity* PActor = (CCharEntity*)m_PBaseEntity;
    PActor->loc.zone->PushPacket(PActor, CHAR_INRANGE_SELF, new CIndependentAnimationPacket(PActor, PTarget->GetBaseEntity(), animId, mode));
}

/************************************************************************
 *  Function: engage()
 *  Purpose : Instructs a Battle Entity to engage in combat
 *  Example : pet:engage(target)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::engage(uint16 requestedTarget)
{
    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);

    if (requestedTarget > 0)
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
    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);
    PBattle->PAI->Disengage();
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
    m_PBaseEntity->PAI->QueueAction(queueAction_t(ms, false, func));
}

/************************************************************************
 *  Function: queue()
 *  Purpose : Queues a Lua function
 *  Example :
 *  Notes   : For instance, Sic can be used before a Pet reaches 100% TP.
 *          : Once the Pet reaches 100%, it will use it's Special Ability.
 *          : See scripts/globals/abilities/sic.lua for how the Special
 *          : Ability is delayed until 100% (essentially loops into Action Queue)
 ************************************************************************/

void CLuaBaseEntity::queue(int ms, sol::function func)
{
    m_PBaseEntity->PAI->QueueAction(queueAction_t(ms, true, func));
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
            PChar->pushPacket(new CCharSkillsPacket(PChar));
            PChar->pushPacket(new CCharRecastPacket(PChar));
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
        uint32     recast          = (arg2 != sol::nil) ? arg2.as<uint32>() : 0;

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

        PChar->pushPacket(new CCharSkillsPacket(PChar));
        PChar->pushPacket(new CCharRecastPacket(PChar));
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
        PChar->pushPacket(new CCharSkillsPacket(PChar));
        PChar->pushPacket(new CCharRecastPacket(PChar));
    }
}

/************************************************************************
 *  Function: addListener()
 *  Purpose : Instructs the Event Handler to monitor for an Event, then
 *            execute a prepared Lua function once the Event has occurred
 *  Example : See: scripts/mixins/families/chigoe.lua
 *  Notes   : Function along with statements must be passed in L3
 ************************************************************************/

void CLuaBaseEntity::addListener(std::string eventName, std::string identifier, sol::function func)
{
    m_PBaseEntity->PAI->EventHandler.addListener(eventName, func, identifier);
}

/************************************************************************
 *  Function: removeListener()
 *  Purpose : Instructs the Event Handler to stop monitoring for an Event
 *  Example : pet:removeListener("AUTO_PATTERN_READER_TICK")
 *  Notes   : Used heavily in Pup Ability scripts
 ************************************************************************/

void CLuaBaseEntity::removeListener(std::string identifier)
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

void CLuaBaseEntity::triggerListener(std::string eventName, sol::variadic_args args)
{
    m_PBaseEntity->PAI->EventHandler.triggerListener(eventName, sol::as_args(args));
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    auto* PEntity = static_cast<CBattleEntity*>(m_PBaseEntity);

    // is asleep is not working!
    // if(PEntity->isAsleep())
    // {
    // wake them up!
    PEntity->StatusEffectContainer->DelStatusEffect(EFFECT_SLEEP);
    PEntity->StatusEffectContainer->DelStatusEffect(EFFECT_SLEEP_II);
    PEntity->StatusEffectContainer->DelStatusEffect(EFFECT_LULLABY);
    // }
}

/************************************************************************
 *  Function: recalculateStats()
 *  Purpose : Recalculate the total Stats for a PC (force update)
 *  Example : target:recalculateStats()
 *  Notes   : See scripts/globals/effects/obliviscence.lua
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

        PChar->pushPacket(new CCharJobsPacket(PChar));
        PChar->pushPacket(new CCharStatsPacket(PChar));
        PChar->pushPacket(new CCharSkillsPacket(PChar));
        PChar->pushPacket(new CCharRecastPacket(PChar));
        PChar->pushPacket(new CCharAbilitiesPacket(PChar));
        PChar->pushPacket(new CCharUpdatePacket(PChar));
        PChar->pushPacket(new CMenuMeritPacket(PChar));
        PChar->pushPacket(new CCharSyncPacket(PChar));
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    auto* PChar{ static_cast<CCharEntity*>(m_PBaseEntity) };

    for (uint8 LocID = 0; LocID < MAX_CONTAINER_ID; ++LocID)
    {
        bool found = false;
        PChar->getStorage(LocID)->ForEachItem([&found](CItem* PItem) {
            if (PItem->getID() >= 5365 && PItem->getID() <= 5384)
            {
                found = true;
            }
        });

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
        ShowError("lua::isDualWielding :: NPCs don't wield weapons!\n");
    }

    return false;
}

/************************************************************************
 *  Function: getCE()
 *  Purpose : Returns the current Cumulative Enmity a Mob has against an Entity
 *  Example : local playerCE = target:getCE(player)
 *  Notes   : See Ventriloquy and Atonement
 ************************************************************************/

int32 CLuaBaseEntity::getCE(CLuaBaseEntity const* target)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

    return static_cast<CMobEntity*>(m_PBaseEntity)->PEnmityContainer->GetVE(static_cast<CBattleEntity*>(target->GetBaseEntity()));
}

/************************************************************************
 *  Function: setCE()
 *  Purpose : Sets a specified amount of Cumulative Enmity against an Entity
 *  Example : target:setCE(player, petCE * petEnmityBonus)
 *  Notes   : Currently only used in scripts/globals/abilities/ventriloquy.lua
 ************************************************************************/

void CLuaBaseEntity::setCE(CLuaBaseEntity* target, uint16 amount)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

    static_cast<CMobEntity*>(m_PBaseEntity)->PEnmityContainer->SetCE(static_cast<CBattleEntity*>(target->GetBaseEntity()), amount);
}

/************************************************************************
 *  Function: setVE()
 *  Purpose : Sets a specified amount of Volatile Enmity against an Entity
 *  Example : target:setVE(player, petVE * petEnmityBonus)
 *  Notes   : Currently only used in scripts/globals/abilities/ventriloquy.lua
 ************************************************************************/

void CLuaBaseEntity::setVE(CLuaBaseEntity* target, uint16 amount)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

    if (PEntity != nullptr && PEntity->GetBaseEntity()->objtype != TYPE_NPC)
    {
        static_cast<CMobEntity*>(m_PBaseEntity)->PEnmityContainer->LowerEnmityByPercent(static_cast<CBattleEntity*>(PEntity->GetBaseEntity()), percent, nullptr);
    }
}

/************************************************************************
 *  Function: updateEnmity()
 *  Purpose : Unlike updateClaim(), this function only generates Enmity toward an Entity
 *  Example : mob:updateEnmity(target)
 *  Notes   : Mob will aggro an Entity, but be unclaimed until engaged
 ************************************************************************/

void CLuaBaseEntity::updateEnmity(CLuaBaseEntity* PEntity)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

    if (PEntity != nullptr && PEntity->GetBaseEntity()->objtype != TYPE_NPC)
    {
        static_cast<CMobEntity*>(m_PBaseEntity)->PEnmityContainer->AddBaseEnmity(static_cast<CBattleEntity*>(PEntity->GetBaseEntity()));
    }
}

/************************************************************************
 *  Function: transferEnmity()
 *  Purpose : Used to transfer an amount of Enmity from one Entity to another
 *  Example : target:transferEnmity(player, 50, 20.6)
 *  Notes   : See scripts/globals/abilities/accomplice.lua
 ************************************************************************/

void CLuaBaseEntity::transferEnmity(CLuaBaseEntity* entity, uint8 percent, float range)
{
    CBaseEntity* PEntity = entity->GetBaseEntity();

    auto* PIterEntity = [&]() -> CCharEntity* {
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
        for (auto&& mob_pair : PIterEntity->SpawnMOBList)
        {
            if (distanceSquared(mob_pair.second->loc.p, PEntity->loc.p) < (range * range))
            {
                battleutils::TransferEnmity(static_cast<CBattleEntity*>(PEntity), static_cast<CBattleEntity*>(m_PBaseEntity),
                                            static_cast<CMobEntity*>(mob_pair.second), percent);
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

void CLuaBaseEntity::updateEnmityFromCure(CLuaBaseEntity* PEntity, int32 amount)
{
    XI_DEBUG_BREAK_IF(amount < 0);

    auto* PCurer = [&]() -> CBattleEntity* {
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

    if (PEntity != nullptr && PCurer)
    {
        battleutils::GenerateCureEnmity(PCurer, static_cast<CBattleEntity*>(PEntity->GetBaseEntity()), amount);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

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

    if ((entity == sol::nil) || !entity.is<CLuaBaseEntity*>())
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
 *  Purpose : Check if a an entity is on any mob's enmity list
 *  Example : if player:hasEnmity() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::hasEnmity()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    return static_cast<CBattleEntity*>(m_PBaseEntity)->PNotorietyContainer->hasEnmity();
}

/************************************************************************
 *  Function: getNotorietyList()
 *  Purpose : Return a list of mobs that hold enmity towards the player
 *  Example : local list = player:getNotorietyList()
 *  Notes   : Key removed from table, this might break things
 ************************************************************************/

sol::table CLuaBaseEntity::getNotorietyList()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    auto& notorietyContainer = static_cast<CBattleEntity*>(m_PBaseEntity)->PNotorietyContainer;

    auto table = luautils::lua.create_table();
    for (auto* entry : *notorietyContainer)
    {
        table.add(CLuaBaseEntity(entry));
    }

    return table;
}

/************************************************************************
 *  Function: addStatusEffect(effect, power, tick, duration)
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
        auto subID    = va[4].is<uint32>() ? va[4].as<uint32>() : 0;
        auto subPower = va[5].is<uint16>() ? va[5].as<uint16>() : 0;
        auto tier     = va[6].is<uint16>() ? va[6].as<uint16>() : 0;

        CStatusEffect* PEffect = new CStatusEffect(effectID,
                                                   effectIcon,
                                                   power,
                                                   tick,
                                                   duration,
                                                   subID,
                                                   subPower,
                                                   tier);

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
    auto subID      = va[5].is<uint32>() ? va[5].as<uint32>() : 0;
    auto subPower   = va[6].is<uint16>() ? va[6].as<uint16>() : 0;
    auto tier       = va[7].is<uint16>() ? va[7].as<uint16>() : 0;
    auto effectFlag = va[8].is<uint32>() ? va[8].as<uint32>() : 0;

    CStatusEffect* PEffect =
        new CStatusEffect(effectID,
                          effectIcon,
                          power,
                          tick,
                          duration,
                          subID,
                          subPower,
                          tier,
                          effectFlag); // Effect Flag (i.e in lua xi.effectFlag.AURA will make this an aura effect)

    return ((CBattleEntity*)m_PBaseEntity)->StatusEffectContainer->AddStatusEffect(PEffect, silent);
}

/************************************************************************
 *  Function: getStatusEffect()
 *  Purpose : Returns the Object of a specified Status ID
 *  Example : local debilitation = target:getStatusEffect(xi.effect.DEBILITATION)
 *  Notes   :
 ************************************************************************/

std::optional<CLuaStatusEffect> CLuaBaseEntity::getStatusEffect(uint16 StatusID, sol::object const& SubID)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleEntity)
    {
        return nullptr;
    }

    CStatusEffect* PStatusEffect   = nullptr;
    auto           effect_StatusID = static_cast<EFFECT>(StatusID);

    if (SubID != sol::nil)
    {
        auto uint16_SubID = SubID.as<uint16>();
        PStatusEffect     = PBattleEntity->StatusEffectContainer->GetStatusEffect(effect_StatusID, uint16_SubID);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleEntity)
    {
        return {};
    }

    auto table = luautils::lua.create_table();
    static_cast<CBattleEntity*>(m_PBaseEntity)->StatusEffectContainer->ForEachEffect([&table](CStatusEffect* PEffect) {
        table.add(CLuaStatusEffect(PEffect));
    });

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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

bool CLuaBaseEntity::hasStatusEffect(uint16 StatusID, sol::object const& SubID)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleEntity)
    {
        return false;
    }

    bool hasEffect       = false;
    auto effect_StatusID = static_cast<EFFECT>(StatusID);

    if (SubID != sol::nil)
    {
        auto uint16_SubID = SubID.as<uint16>();
        hasEffect         = PBattleEntity->StatusEffectContainer->HasStatusEffect(effect_StatusID, uint16_SubID);
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

uint16 CLuaBaseEntity::hasStatusEffectByFlag(uint16 StatusID)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleEntity)
    {
        return 0;
    }

    auto effect_StatusID = static_cast<EFFECT>(StatusID);
    return PBattleEntity->StatusEffectContainer->GetEffectsCount(effect_StatusID);
}

/************************************************************************
 *  Function: delStatusEffect()
 *  Purpose : Deletes a specified Effect from the Entity's Status Effect Container
 *  Example : target:delStatusEffect(xi.effect.RERAISE)
 *  Notes   : Can specify Power of the Effect as an option
 ************************************************************************/

bool CLuaBaseEntity::delStatusEffect(uint16 StatusID, sol::object const& SubID)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleEntity)
    {
        return false;
    }

    bool result = false;

    bool hasEffect       = false;
    auto effect_StatusID = static_cast<EFFECT>(StatusID);

    if (SubID != sol::nil)
    {
        auto uint16_SubID = SubID.as<uint16>();
        result            = PBattleEntity->StatusEffectContainer->DelStatusEffect(effect_StatusID, uint16_SubID);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleEntity)
    {
        return false;
    }

    auto effect_StatusID = static_cast<EFFECT>(StatusID);
    return PBattleEntity->StatusEffectContainer->DelStatusEffect(effect_StatusID);
}

/************************************************************************
 *  Function: eraseStatusEffect()
 *  Purpose : Removes an Erasable Status Effect from the Entity's Status Effect Container
 *  Example : target:eraseStatusEffect()
 *  Notes   : Can specify which type to remove, if Erasable
 ************************************************************************/

uint16 CLuaBaseEntity::eraseStatusEffect()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleEntity)
    {
        return 0;
    }

    uint32 flag = flagObj.is<uint32>() ? flagObj.as<uint32>() : EFFECTFLAG_DISPELABLE;

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    auto* PBattleEntity = dynamic_cast<CBattleEntity*>(m_PBaseEntity);
    if (!PBattleEntity)
    {
        return 0;
    }

    uint32 flag = flagObj.is<uint32>() ? flagObj.as<uint32>() : EFFECTFLAG_DISPELABLE;

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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

    uint32 flag = flagObj.is<uint32>() ? flagObj.as<uint32>() : EFFECTFLAG_DISPELABLE;

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    static_cast<CBattleEntity*>(m_PBaseEntity)->delModifier(static_cast<Mod>(modID), value);
}

/************************************************************************
 *  Function: addLatent()
 *  Purpose : Adds the specified latent to the player
 *  Example : player:addLatent(xi.latent.LATENT_HP_UNDER_PERCENT, 95, xi.mod.REGEN, 1)
 ************************************************************************/

void CLuaBaseEntity::addLatent(uint16 condID, uint16 conditionValue, uint16 mID, int16 modValue)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    LATENT conditionID = static_cast<LATENT>(condID);
    Mod    modID       = static_cast<Mod>(mID);

    return static_cast<CCharEntity*>(m_PBaseEntity)->PLatentEffectContainer->DelLatentEffect(conditionID, conditionValue, modID, modValue);
}

/************************************************************************
 *  Function: fold()
 *  Purpose : Removes the most recent Phantom Roll or Bust effect
 *  Example : target:fold()
 *  Notes   : Calls the Fold member of CStatusEffectContainer for calculation
 ************************************************************************/

void CLuaBaseEntity::fold()
{
    auto* PEntity = static_cast<CBattleEntity*>(m_PBaseEntity);
    PEntity->StatusEffectContainer->Fold(PEntity->id);
}

/************************************************************************
 *  Function: doWildCard()
 *  Purpose : Executes the Wild Card two hour for a COR
 *  Example : caster:doWildCard(target,total)
 *  Notes   : Calls the DoWildCardToEntity member of battleutils
 ************************************************************************/

void CLuaBaseEntity::doWildCard(CLuaBaseEntity* PEntity, uint8 total)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    battleutils::DoWildCardToEntity(static_cast<CCharEntity*>(m_PBaseEntity), static_cast<CCharEntity*>(PEntity->m_PBaseEntity), total);
}

/************************************************************************
 *  Function: addCorsairRoll()
 *  Purpose : Adds the Corsair Roll to the Target's Status Effect Container
 *  Example : target:addCorsairRoll(caster:getMainJob(), caster:getMerit(xi.merit.BUST_DURATION), xi.effect.CHAOS_ROLL, effectpower, 0, duration, caster:getID(),
 *total, MOD_ATTP) Notes   : Returns true if success (Is range a factor?)
 ************************************************************************/

bool CLuaBaseEntity::addCorsairRoll(uint8 casterJob, uint8 bustDuration, uint16 effectID, uint16 power, uint32 tick, uint32 duration, sol::object const& arg6, sol::object const& arg7, sol::object const& arg8)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    CStatusEffect* PEffect = new CStatusEffect(static_cast<EFFECT>(effectID),              // Effect ID
                                               effectID,                                   // Effect Icon (Associated with ID)
                                               power,                                      // Power
                                               tick,                                       // Tick
                                               duration,                                   // Duration
                                               (arg6 != sol::nil) ? arg6.as<uint32>() : 0, // SubID or 0
                                               (arg7 != sol::nil) ? arg7.as<uint16>() : 0, // SubPower or 0
                                               (arg8 != sol::nil) ? arg8.as<uint16>() : 0  // Tier or 0
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
    auto* PEntity = static_cast<CBattleEntity*>(m_PBaseEntity);

    return PEntity->StatusEffectContainer->HasCorsairEffect(PEntity->id);
}

/************************************************************************
 *  Function: hasBustEffect()
 *  Purpose : Returns true if an Entity has a Bust Effect of a specified type
 *  Example : if target:hasBustEffect(effect) then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::hasBustEffect(uint16 id)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    auto* PBattleEntity = static_cast<CBattleEntity*>(m_PBaseEntity);
    return static_cast<uint16>(PBattleEntity->StatusEffectContainer->HealingWaltz());
}

/************************************************************************
 *  Function: addBardSong()
 *  Purpose : Adds a song effect to Player(s') Status Effect Container(s); returns true if sucess
 *  Example : target:addBardSong(caster, xi.effect.BALLAD, power, 0, duration, caster:getID(), 0, 1)
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::addBardSong(CLuaBaseEntity* PEntity, uint16 effectID, uint16 power, uint16 tick, uint16 duration, uint16 subID, uint16 subPower, uint16 tier)
{
    CStatusEffect* PEffect = new CStatusEffect(static_cast<EFFECT>(effectID), // Effect ID
                                               effectID,                      // Effect Icon (Associated with ID)
                                               power,                         // Power
                                               tick,                          // Tick
                                               duration,                      // Duration
                                               subID,                         // SubID
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

    return static_cast<CBattleEntity*>(m_PBaseEntity)->StatusEffectContainer->ApplyBardEffect(PEffect, maxSongs);
}

/************************************************************************
 *  Function: charm()
 *  Purpose : Charms an entity target
 *  Example : mob:charm(target)
 ************************************************************************/

void CLuaBaseEntity::charm(CLuaBaseEntity const* target)
{
    battleutils::applyCharm(static_cast<CBattleEntity*>(m_PBaseEntity), static_cast<CBattleEntity*>(target->GetBaseEntity()));
}

/************************************************************************
 *  Function: uncharm()
 *  Purpose : Removes charm from an entity
 *  Example : target:uncharm()
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::uncharm()
{
    battleutils::unCharm(static_cast<CBattleEntity*>(m_PBaseEntity));
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    if (((CBattleEntity*)m_PBaseEntity)->PPet && ((CPetEntity*)((CBattleEntity*)m_PBaseEntity)->PPet)->getPetType() == PET_TYPE::AUTOMATON)
    {
        return ((CAutomatonEntity*)((CBattleEntity*)m_PBaseEntity)->PPet)->addBurden(element, burden);
    }

    return 0;
}

/************************************************************************
 *  Function: setStatDebilitation()
 *  Purpose : Updates the private member m_StatsDebilitation in CCharEntity
 *  Example : target:setStatDebilitation(power)
 *  Notes   : Used only through scripts/globals/effects/debilitation.lua
 ************************************************************************/

void CLuaBaseEntity::setStatDebilitation(uint16 statDebil)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity == nullptr);

    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        auto* PChar{ static_cast<CCharEntity*>(m_PBaseEntity) };
        PChar->m_StatsDebilitation = statDebil;
        PChar->pushPacket(new CCharJobsPacket(PChar));
    }
}

/************************************************************************
 *  Function: getStat()
 *  Purpose : Returns a particular stat for an Entity
 *  Example : caster:getStat(xi.mod.INT)
 *  Notes   :
 ************************************************************************/

uint16 CLuaBaseEntity::getStat(uint16 statId)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
            value = PEntity->ATT();
            break;
        case Mod::DEF:
            value = PEntity->DEF();
            break;
        case Mod::EVA:
            value = PEntity->EVA();
            break;
        // TODO: support getStat for ACC/RACC/RATT
        // case Mod::ACC:  lua_pushinteger(L, PEntity->ACC()); break;
        // case Mod::RACC: lua_pushinteger(L, PEntity->RACC()); break;
        // case Mod::RATT: lua_pushinteger(L, PEntity->RATT()); break;
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    auto* PEntity = static_cast<CBattleEntity*>(m_PBaseEntity);
    return PEntity->EVA();
}

/************************************************************************
 *  Function: getRACC()
 *  Purpose : Calculates and returns the Ranged Accuracy of a Weapon euipped in the Ranged slot
 *  Example : player:getRACC()
 *  Notes   : To Do: The calculation is already a public member of battleentity, shouldn't have two calculations, just call (CBattleEntity*)m_PBaseEntity)->RACC
 *and return result
 ************************************************************************/

int CLuaBaseEntity::getRACC()
{
    auto* weapon = dynamic_cast<CItemWeapon*>(static_cast<CBattleEntity*>(m_PBaseEntity)->m_Weapons[SLOT_RANGED]);

    if (weapon == nullptr)
    {
        ShowDebug(CL_CYAN "lua::getRACC weapon in ranged slot is NULL!\n" CL_RESET);
        return 0;
    }

    CBattleEntity* PEntity = static_cast<CBattleEntity*>(m_PBaseEntity);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    auto* weapon = dynamic_cast<CItemWeapon*>(static_cast<CBattleEntity*>(m_PBaseEntity)->m_Weapons[SLOT_RANGED]);

    if (weapon == nullptr)
    {
        ShowDebug(CL_CYAN "lua::getRATT weapon in ranged slot is NULL!\n" CL_RESET);
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
    if (auto* weapon = dynamic_cast<CItemWeapon*>(static_cast<CBattleEntity*>(m_PBaseEntity)->m_Weapons[SLOT_MAIN]))
    {
        return weapon->getILvlMacc();
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
    CBattleEntity* PEntity = static_cast<CBattleEntity*>(m_PBaseEntity);
    CSpell*        PSpell  = spell::GetSpell(static_cast<SpellID>(spellId));

    if (PSpell != nullptr)
    {
        return battleutils::GetSpellAoEType(PEntity, PSpell) > 0;
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    auto* weapon = dynamic_cast<CItemWeapon*>(static_cast<CBattleEntity*>(m_PBaseEntity)->m_Weapons[SLOT_MAIN]);

    if (weapon == nullptr)
    {
        ShowDebug(CL_CYAN "lua::getWeaponDmg weapon in main slot is NULL!\n" CL_RESET);
        return 0;
    }

    return weapon->isTwoHanded();
}

/************************************************************************
 *  Function: getMeleeHitDamage()
 *  Purpose : Calculates and returns total damage for a single hit
 *  Example : getMeleeHitDamage(Attacker,Local Hit Rate)
 *  Notes   : Battleutils calculates hit rate already, so inserting hit rate
 *          : here only increases chance of missing (assuming < 100)?
 *          : Not currently used in any scripts (handled by battleutils) - Is this even needed?
 ************************************************************************/

int CLuaBaseEntity::getMeleeHitDamage(CLuaBaseEntity* PLuaBaseEntity, sol::object const& arg1)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    CBattleEntity* PAttacker = static_cast<CBattleEntity*>(m_PBaseEntity);
    CBattleEntity* PDefender = static_cast<CBattleEntity*>(PLuaBaseEntity->GetBaseEntity());

    uint8 hitrate = (arg1 == sol::nil) ? battleutils::GetHitRate(PAttacker, PDefender) : arg1.as<uint8>();

    if (xirand::GetRandomNumber(100) < hitrate)
    {
        float DamageRatio = battleutils::GetDamageRatio(PAttacker, PDefender, false, 0.f);
        int   damage      = (uint16)((PAttacker->GetMainWeaponDmg() + battleutils::GetFSTR(PAttacker, PDefender, SLOT_MAIN)) * DamageRatio);

        return damage;
    }

    return -1;
}

/************************************************************************
 *  Function: getWeaponDmg()
 *  Purpose : Returns the real damage value of a Weapon in the Main slot
 *  Example : local weaponDamage = attacker:getWeaponDmg()
 *  Notes   : Also used in Mob damage calculations
 ************************************************************************/

uint16 CLuaBaseEntity::getWeaponDmg()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    return static_cast<CBattleEntity*>(m_PBaseEntity)->GetMainWeaponDmg();
}

/************************************************************************
 *  Function: getWeaponDmgRank()
 *  Purpose : Returns the damage rating for the Weapon in the Main slot
 *  Example : attacker:getWeaponDmgRank()
 *  Notes   : Primarily used in fSTR calculation in scripts/globals/weaponskills.lua
 ************************************************************************/

uint16 CLuaBaseEntity::getWeaponDmgRank()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);
    auto* weapon  = dynamic_cast<CItemWeapon*>(PBattle->m_Weapons[SLOT_AMMO]);

    if (weapon == nullptr)
    {
        ShowDebug(CL_CYAN "lua::getAmmoDmg weapon in ammo slot is NULL!\n" CL_RESET);
        return 0;
    }

    return weapon->getDamage();
}

/************************************************************************
 *  Function: removeAmmo()
 *  Purpose : Expends one item in the ammo slot (arrow,bullet, etc)
 *  Example : player:removeAmmo()
 *  Notes   : Ammo consumed is calculated in charentity.cpp and passed to battleutils
 ************************************************************************/

void CLuaBaseEntity::removeAmmo()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    battleutils::RemoveAmmo(static_cast<CCharEntity*>(m_PBaseEntity));
}

/************************************************************************
 *  Function: getWeaponSkillLevel()
 *  Purpose : Returns the player's skill level for the weapon in a slot
 *  Example : caster:getWeaponSkillLevel(xi.slot.RANGED)
 *  Notes   : Mainly used to determine String/Wind level, but can be used for others
 ************************************************************************/

uint8 CLuaBaseEntity::getWeaponSkillLevel(uint8 slotID)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        XI_DEBUG_BREAK_IF(slotID > 3);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    if (slotID <= 3)
    {
        auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);
        auto* PWeapon = dynamic_cast<CItemWeapon*>(PBattle->m_Weapons[slotID]);

        if (PWeapon)
        {
            return static_cast<uint16>(PWeapon->getDmgType());
        }
    }

    ShowError(CL_RED "lua::getWeaponDamageType :: Invalid slot specified!" CL_RESET);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    if (slotID <= 3)
    {
        auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);
        auto* PWeapon = dynamic_cast<CItemWeapon*>(PBattle->m_Weapons[slotID]);

        if (PWeapon)
        {
            return PWeapon->getSkillType();
        }
    }

    ShowError(CL_RED "lua::getWeaponSkillType :: Invalid slot specified!" CL_RESET);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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

    ShowError(CL_RED "lua::getWeaponSubskillType :: Invalid slot specified!" CL_RESET);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    auto*       PChar      = static_cast<CCharEntity*>(attacker->m_PBaseEntity);
    ATTACK_TYPE attackType = static_cast<ATTACK_TYPE>(atkType);
    DAMAGE_TYPE damageType = static_cast<DAMAGE_TYPE>(dmgType);

    return battleutils::TakeWeaponskillDamage(PChar, static_cast<CBattleEntity*>(m_PBaseEntity), damage, attackType, damageType, slot,
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
    auto*       PChar      = static_cast<CCharEntity*>(caster->m_PBaseEntity);
    auto*       PSpell     = spell->GetSpell();
    ATTACK_TYPE attackType = static_cast<ATTACK_TYPE>(atkType);
    DAMAGE_TYPE damageType = static_cast<DAMAGE_TYPE>(dmgType);

    return battleutils::TakeSpellDamage(static_cast<CBattleEntity*>(m_PBaseEntity), PChar, PSpell, damage, attackType, damageType);
}

/************************************************************************
 *  Function: spawnPet()
 *  Purpose : Spawns a pet if a few correct conditions are met
 *  Example : caster:spawnPet(xi.pet.id.CARBUNCLE)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::spawnPet(sol::object const& arg0)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity == nullptr);
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    if (m_PBaseEntity->objtype == TYPE_PC)
    {
        if ((arg0 != sol::nil) && arg0.is<int>())
        {
            uint32 petId = arg0.as<uint32>();
            if (petId == PETID_HARLEQUINFRAME)
            {
                if (((CCharEntity*)m_PBaseEntity)->PAutomaton)
                {
                    petId = PETID_HARLEQUINFRAME + static_cast<CCharEntity*>(m_PBaseEntity)->PAutomaton->getFrame() - 0x20;
                }
                else
                {
                    ShowError(CL_RED "CLuaBaseEntity::spawnPet : PetID is NULL\n" CL_RESET);
                }
            }

            // Note: arg1 of SpawnPet below was arg0 and not petId
            petutils::SpawnPet(static_cast<CBattleEntity*>(m_PBaseEntity), petId, false);
        }
        else
        {
            ShowError(CL_RED "CLuaBaseEntity::spawnPet : PetID is NULL\n" CL_RESET);
        }
    }
    else if (m_PBaseEntity->objtype == TYPE_MOB)
    {
        auto* PMob = static_cast<CMobEntity*>(m_PBaseEntity);

        if (PMob->PPet == nullptr)
        {
            ShowError("lua_baseentity::spawnPet PMob (%d) trying to spawn pet but its nullptr\n", PMob->id);
            return;
        }

        CMobEntity* PPet = static_cast<CMobEntity*>(PMob->PPet);

        // if a number is given its an avatar or elemental spawn
        if ((arg0 != sol::nil) && arg0.is<int>())
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

void CLuaBaseEntity::spawnTrust(uint16 trustId)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC); // only PCs can spawn trusts

    trustutils::SpawnTrust(static_cast<CCharEntity*>(m_PBaseEntity), trustId);
}

/************************************************************************
 *  Function: clearTrusts()
 *  Purpose :
 *  Example : caster:clearTrusts()
 ************************************************************************/

void CLuaBaseEntity::clearTrusts()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC); // only PCs can spawn trusts

    static_cast<CCharEntity*>(m_PBaseEntity)->ClearTrusts();
}

/************************************************************************
 *  Function: getTrustID()
 *  Purpose :
 *  Example : trust:getTrustID()
 ************************************************************************/

uint32 CLuaBaseEntity::getTrustID()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_TRUST);

    return static_cast<CTrustEntity*>(m_PBaseEntity)->m_TrustID;
}

/************************************************************************
 *  Function: trustPartyMessage()
 *  Purpose :
 *  Example : mob:trustPartyMessage(message_id)
 ************************************************************************/

void CLuaBaseEntity::trustPartyMessage(uint32 message_id)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_TRUST);

    auto* PTrust  = static_cast<CTrustEntity*>(m_PBaseEntity);
    auto* PMaster = dynamic_cast<CCharEntity*>(PTrust->PMaster);

    if (PMaster)
    {
        PMaster->ForParty([&](CBattleEntity* PMember) {
            auto* PCharMember = static_cast<CCharEntity*>(PMember);
            PCharMember->pushPacket(new CMessageCombatPacket(PTrust, PMember, message_id, 0, 711));
        });
    }
}

/************************************************************************
 *  Function: addSimpleGambit()
 *  Purpose :
 *  Example : trust:addSimpleGambit(target, condition, condition_arg, reaction, selector, selector_arg)
 *  Notes   : Adds a behaviour to the gambit system
 ************************************************************************/

void CLuaBaseEntity::addSimpleGambit(uint16 targ, uint16 cond, uint32 condition_arg, uint16 react, uint16 select, uint32 selector_arg, sol::object const& retry)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_TRUST);

    using namespace gambits;

    auto target    = static_cast<G_TARGET>(targ);
    auto condition = static_cast<G_CONDITION>(cond);

    auto reaction = static_cast<G_REACTION>(react);
    auto selector = static_cast<G_SELECT>(select);

    // Optional
    uint16 retry_delay = (retry != sol::nil) ? retry.as<uint16>() : 0;

    Gambit_t g;
    g.predicates.emplace_back(Predicate_t{ target, condition, condition_arg });
    g.actions.emplace_back(Action_t{ reaction, selector, selector_arg });
    g.retry_delay = retry_delay;

    auto* trust      = static_cast<CTrustEntity*>(m_PBaseEntity);
    auto* controller = static_cast<CTrustController*>(trust->PAI->GetController());

    controller->m_GambitsContainer->AddGambit(g);
}

/************************************************************************
 *  Function: setTrustTPSkillSettings(trigger, select)
 *  Purpose :
 *  Example : mob:setTrustTPSkillSettings(ai.tp.ASAP, ai.s.RANDOM)
 ************************************************************************/

void CLuaBaseEntity::setTrustTPSkillSettings(uint16 trigger, uint16 select)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_TRUST);

    using namespace gambits;

    auto* trust      = static_cast<CTrustEntity*>(m_PBaseEntity);
    auto* controller = static_cast<CTrustController*>(trust->PAI->GetController());

    controller->m_GambitsContainer->tp_trigger = static_cast<G_TP_TRIGGER>(trigger);
    controller->m_GambitsContainer->tp_select  = static_cast<G_SELECT>(select);
}

/************************************************************************
 *  Function: despawnPet()
 *  Purpose : Despawns a Pet Entity
 *  Example : target:despawnPet()
 *  Notes   : Upon death or dismissal or similar
 ************************************************************************/

void CLuaBaseEntity::despawnPet()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);

    if (PBattle->PPet != nullptr)
    {
        petutils::DespawnPet(PBattle);
    }
}

/************************************************************************
 *  Function: isJugPet()
 *  Purpose : Returns true if the entity crawled out of a jug after birth
 *  Example : if pet:isJugPet() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isJugPet()
{
    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);

    if (PBattle->PPet)
    {
        return static_cast<CPetEntity*>(PBattle->PPet)->getPetType() == PET_TYPE::JUG_PET;
    }

    return false;
}

/************************************************************************
 *  Function: hasValidJugPetItem()
 *  Purpose : Returns true if subSkill Type is of sufficient value
 *  Example : if player:hasValidJugPetItem() then
 *  Notes   : Solely used for determining Call Beast activation
 ************************************************************************/

bool CLuaBaseEntity::hasValidJugPetItem()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    auto* PTarget = static_cast<CBattleEntity*>(m_PBaseEntity);

    return PTarget->PPet != nullptr && PTarget->PPet->status != STATUS_TYPE::DISAPPEAR;
}

/************************************************************************
 *  Function: getPet()
 *  Purpose : Returns the Entity Object of a Pet-type entity
 *  Example : local pet = getPet()
 *  Notes   :
 ************************************************************************/

std::optional<CLuaBaseEntity> CLuaBaseEntity::getPet()
{
    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);

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
    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);

    if (PBattle->PPet)
    {
        return static_cast<CPetEntity*>(PBattle->PPet)->m_PetID;
    }

    return 0;
}

/************************************************************************
 *  Function: getPetElement()
 *  Purpose : Returns the elemental affinity of a pet entity
 *  Example : pet:getPetElement()
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getPetElement()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);

    if (PBattle->PPet)
    {
        return static_cast<CPetEntity*>(PBattle->PPet)->m_Element;
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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

auto CLuaBaseEntity::getPetName() -> const char*
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);

    if (PBattle->PPet)
    {
        return PBattle->PPet->name.c_str();
    }

    return 0; // Check this!
}

/************************************************************************
 *  Function: setPetName()
 *  Purpose : Passes a string to name a new pet
 *  Example : player:setPetName(xi.pet.type.WYVERN, xi.pet.name.ROVER)
 *  Notes   : Updates char_pet.sql
 ************************************************************************/

void CLuaBaseEntity::setPetName(uint8 pType, uint16 value, sol::object const& arg2)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    PET_TYPE petType = static_cast<PET_TYPE>(pType);

    if (arg2 == sol::nil)
    {
        if (petType == PET_TYPE::WYVERN)
        {
            Sql_Query(SqlHandle, "INSERT INTO char_pet SET charid = %u, wyvernid = %u ON DUPLICATE KEY UPDATE wyvernid = %u;", m_PBaseEntity->id, value, value);
        }
        else if (petType == PET_TYPE::AUTOMATON)
        {
            Sql_Query(SqlHandle, "INSERT INTO char_pet SET charid = %u, automatonid = %u ON DUPLICATE KEY UPDATE automatonid = %u;", m_PBaseEntity->id, value,
                      value);
            if (static_cast<CCharEntity*>(m_PBaseEntity)->PAutomaton != nullptr)
            {
                puppetutils::LoadAutomaton(static_cast<CCharEntity*>(m_PBaseEntity));
            }
        }
        /*
        else if (petType == PETTYPE_ADVENTURING_FELLOW)
        {
            Sql_Query(SqlHandle, "INSERT INTO char_pet SET charid = %u, adventuringfellowid = %u ON DUPLICATE KEY UPDATE adventuringfellowid = %u;",
        m_PBaseEntity->id, value, value);
        }
        */
    }
    else if (arg2.is<int>())
    {
        if (petType == PET_TYPE::CHOCOBO)
        {
            uint32 chocoboname1 = value & 0x0000FFFF;
            uint32 chocoboname2 = static_cast<uint32>(arg2.as<uint32>() << 16);

            uint32 value = chocoboname1 + chocoboname2;

            Sql_Query(SqlHandle, "INSERT INTO char_pet SET charid = %u, chocoboid = %u ON DUPLICATE KEY UPDATE chocoboid = %u;", m_PBaseEntity->id, value,
                      value);
        }
    }
}

/************************************************************************
 *  Function: getCharmChance()
 *  Purpose : Returns decimal value of the chances of charming an Entity
 *  Example : player:getCharmChance(target, false)
 *  Notes   : Used for Guage and Maiden's Virelai
 ************************************************************************/

float CLuaBaseEntity::getCharmChance(CLuaBaseEntity const* target, sol::object const& mods)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    auto* PCharmer = static_cast<CBattleEntity*>(m_PBaseEntity);
    auto* PTarget  = static_cast<CBattleEntity*>(target->GetBaseEntity());

    bool  includeCharmAffinityAndChanceMods = (mods != sol::nil) ? mods.as<bool>() : true;
    float charmChance                       = battleutils::GetCharmChance(PCharmer, PTarget, includeCharmAffinityAndChanceMods);

    return charmChance;
}

/************************************************************************
 *  Function: charmPet()
 *  Purpose : Attempts to charm a pet
 *  Example : player:charmPet(target)
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::charmPet(CLuaBaseEntity const* target)
{
    if (m_PBaseEntity->objtype != TYPE_MOB)
    {
        battleutils::tryToCharm(static_cast<CBattleEntity*>(m_PBaseEntity), static_cast<CBattleEntity*>(target->GetBaseEntity()));
    }
}

/************************************************************************
 *  Function: petAttack()
 *  Purpose : Engages a pet with a target
 *  Example : pet:petAttack(target)
 *  Notes   : Sic
 ************************************************************************/

void CLuaBaseEntity::petAttack(CLuaBaseEntity* PEntity)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    ShowWarning(CL_YELLOW "CLuaBaseEntity::petAbility: Non-implemented function called with parameter %d\n" CL_RESET, abilityID);
}

/************************************************************************
 *  Function: petRetreat()
 *  Purpose : Disengages a pet from battle, returns to master
 *  Example : player:petRetreat()
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::petRetreat()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    CItem* PItem = itemutils::GetItem(itemID);
    return puppetutils::HasAttachment(static_cast<CCharEntity*>(m_PBaseEntity), PItem);
}

/************************************************************************
 *  Function: getAutomatonName()
 *  Purpose : Returns the string name of the automation pet
 *  Example : local name = pet:getAutomatonName()
 *  Notes   :
 ************************************************************************/

auto CLuaBaseEntity::getAutomatonName() -> const char*
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);
    const char* Query = "SELECT name FROM "
                        "char_pet LEFT JOIN pet_name ON automatonid = id "
                        "WHERE charid = %u;";

    int32 ret = Sql_Query(SqlHandle, Query, m_PBaseEntity->id);

    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        return (const char*)Sql_GetData(SqlHandle, 0); // TODO: Fix c-style cast
    }

    return 0; // TODO: Verify this case
}

/************************************************************************
 *  Function: getAutomatonFrame()
 *  Purpose : Returns the integer value of frame being used for automation
 *  Example : local frame = pet:getAutomatonFrame()
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getAutomatonFrame()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PET || static_cast<CPetEntity*>(m_PBaseEntity)->getPetType() != PET_TYPE::AUTOMATON);

    auto* PAutomaton = static_cast<CAutomatonEntity*>(m_PBaseEntity);
    return static_cast<uint8>(PAutomaton->getFrame());
}

/************************************************************************
 *  Function: getAutomatonHead()
 *  Purpose : Returns the integer value of the (active?) automation head
 *  Example : local head = pet:getAutomatonHead()
 *  Notes   : Currently unscripted
 ************************************************************************/

uint8 CLuaBaseEntity::getAutomatonHead()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PET || static_cast<CPetEntity*>(m_PBaseEntity)->getPetType() != PET_TYPE::AUTOMATON);

    auto* PAutomaton = static_cast<CAutomatonEntity*>(m_PBaseEntity);
    return static_cast<uint8>(PAutomaton->getHead());
}

/************************************************************************
 *  Function: unlockAttachment()
 *  Purpose : Makes new attachment frames available to the Puppetmaster
 *  Example : player:unlockAttachment(8224) -- Harlequin Frame
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::unlockAttachment(uint16 itemID)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    CItem* PItem = itemutils::GetItem(itemID);
    return puppetutils::UnlockAttachment(static_cast<CCharEntity*>(m_PBaseEntity), PItem);
}

/************************************************************************
 *  Function: getActiveManeuvers()
 *  Purpose : Get the amount of active maneuvers for an automation
 *  Example : if target:getActiveManeuvers() == 3 then
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getActiveManeuvers()
{
    auto* PEntity = static_cast<CBattleEntity*>(m_PBaseEntity);

    return PEntity->StatusEffectContainer->GetActiveManeuvers();
}

/************************************************************************
 *  Function: removeOldestManeuver()
 *  Purpose : Removes the oldest maneuver in an automation set (FIFO)
 *  Example : target:removeOldestManeuver()
 *  Notes   : Often used if (target:getActiveManeuvers() == 3)
 ************************************************************************/

void CLuaBaseEntity::removeOldestManeuver()
{
    auto* PEntity = static_cast<CBattleEntity*>(m_PBaseEntity);

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
    auto* PEntity = static_cast<CBattleEntity*>(m_PBaseEntity);

    PEntity->StatusEffectContainer->RemoveAllManeuvers();
}

/************************************************************************
 *  Function: updateAttachments()
 *  Purpose : Updates all of the attachments
 *  Example : master:updateAttachments()
 *  Notes   : Called when Optic Fiber has changed.
 ************************************************************************/

void CLuaBaseEntity::updateAttachments()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    auto* PEntity = static_cast<CCharEntity*>(m_PBaseEntity);
    auto* PAutomaton = dynamic_cast<CAutomatonEntity*>(PEntity->PPet);

    if (!PAutomaton)
    {
        return;
    }

    std::array<uint8, 8> burden = PAutomaton->getBurden();
    for (int i = 0; i < 8; i++)
    {
        uint8 intReduction = (intReductionObj != sol::nil) ? intReductionObj.as<uint8>() : 0;

        burden[i] = (uint8)std::max(0.f, burden[i] * (1 - ((percentReduction / 100) - PEntity->PJobPoints->GetJobPointValue(JP_COOLDOWN_EFFECT))) - intReduction);
    }

    PAutomaton->setBurdenArray(burden);
}

/************************************************************************
 *  Function: setMobLevel()
 *  Purpose : Updates the monsters level and recalculates stats
 *  Example : mob:setMobLevel(125)
 *  Notes   : CalculateStats will refill mobs hp/mp as well
 ************************************************************************/

void CLuaBaseEntity::setMobLevel(uint8 level)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

    if (auto* PMob = dynamic_cast<CMobEntity*>(m_PBaseEntity))
    {
        PMob->SetMLevel(level);
        mobutils::CalculateStats(PMob);
        mobutils::GetAvailableSpells(PMob);
    }
}

/************************************************************************
 *  Function: getSystem()
 *  Purpose : Returns integer value of system associated with an Entity
 *  Example : if pet:getSystem() ~= xi.ecosystem.AVATAR then -- Not an avatar
 *  Notes   :
 ************************************************************************/

uint8 CLuaBaseEntity::getSystem()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    auto* PBattle = static_cast<CBattleEntity*>(m_PBaseEntity);
    return static_cast<uint8>(PBattle->m_EcoSystem);
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
    XI_DEBUG_BREAK_IF(!entity);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    auto* PEntity = static_cast<CBattleEntity*>(m_PBaseEntity);

    return PEntity->m_ModelSize;
}

/************************************************************************
 *  Function: setMobFlags()
 *  Purpose : Manually set Mob flags
 *  Example : player:setMobFlags(flags, targ:getID())
 *  Notes   : Currently only used through !setmobflags command
 ************************************************************************/

void CLuaBaseEntity::setMobFlags(uint32 flags, uint32 mobid)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    CMobEntity* PMob = (CMobEntity*)zoneutils::GetEntity(mobid, TYPE_MOB);

    if (PMob != nullptr)
    {
        PMob->setEntityFlags(flags);
        PMob->updatemask |= UPDATE_HP;
    }
    else
    {
        CCharEntity*   PChar   = (CCharEntity*)m_PBaseEntity;
        CBattleEntity* PTarget = (CBattleEntity*)PChar->GetEntity(PChar->m_TargID);

        if (PTarget == nullptr)
        {
            ShowError("Must target a monster to use for setMobFlags \n");
            return;
        }
        else if (PTarget->objtype != TYPE_MOB)
        {
            ShowError("Battle target must be a monster to use setMobFlags \n");
            return;
        }

        ((CMobEntity*)PTarget)->setEntityFlags(flags);
        PTarget->updatemask |= UPDATE_HP;
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

    if (auto* PMob = dynamic_cast<CMobEntity*>(m_PBaseEntity))
    {
        return PMob->getEntityFlags();
    }

    return 0;
}

/************************************************************************
 *  Function: spawn()
 *  Purpose : Forces a mob to spawn with optional Despawn/Respawn values
 *  Example : mob:spawn(60,3600); mob:spawn()
 *  Notes   :
 ************************************************************************/

void CLuaBaseEntity::spawn(sol::object const& despawnSec, sol::object const& respawnSec)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

    auto* PMob = static_cast<CMobEntity*>(m_PBaseEntity);

    if (despawnSec != sol::nil)
    {
        PMob->SetDespawnTime(std::chrono::seconds(despawnSec.as<uint32>()));
    }

    if (respawnSec != sol::nil)
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
            ShowDebug(CL_CYAN "SpawnMob: %u <%s> is already spawned\n" CL_RESET, PMob->id, PMob->GetName());
        }
    }
}

/************************************************************************
 *  Function: isSpawned()
 *  Purpose : Returns true if a Mob is already spawned
 *  Example : if mob:isSpawned() then
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::isSpawned()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

    return static_cast<CMobEntity*>(m_PBaseEntity)->PAI->IsSpawned();
}

/************************************************************************
 *  Function: getSpawnPos()
 *  Purpose : Returns the spawn position for a Mob in a Lua table
 *  Example : local spawn = mob:getSpawnPos()
 *  Notes   : x = spawn.x; y = spawn.y, etc
 ************************************************************************/

auto CLuaBaseEntity::getSpawnPos() -> std::map<std::string, float>
{
    XI_DEBUG_BREAK_IF(!(m_PBaseEntity->objtype & TYPE_MOB));

    auto*                        PMob = static_cast<CMobEntity*>(m_PBaseEntity);
    std::map<std::string, float> pos;

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

    auto* PMob = static_cast<CMobEntity*>(m_PBaseEntity);

    PMob->m_SpawnPoint.x        = x;
    PMob->m_SpawnPoint.y        = y;
    PMob->m_SpawnPoint.z        = z;
    PMob->m_SpawnPoint.rotation = (rot != sol::nil) ? rot.as<uint8>() : 0;
}

/************************************************************************
 *  Function: getRespawnTime()
 *  Purpose : Returns the remaining respawn time for a Mob
 *  Example : if nm:getRespawnTime() == 0 then
 *  Notes   : Used in mobs.lua...and directly in Charybdis
 ************************************************************************/

uint32 CLuaBaseEntity::getRespawnTime()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    CMobEntity* newMob = mobutils::InstantiateAlly(groupID, m_PBaseEntity->getZone());

    newMob->loc.p        = m_PBaseEntity->loc.p;
    newMob->m_SpawnPoint = newMob->loc.p;
    newMob->Spawn();
}

/************************************************************************
 *  Function: hasTrait()
 *  Purpose : Returns true if a Mob has an active trait
 *  Example : if target:hasTrait(15) then -- Double Attack
 *  Notes   :
 ************************************************************************/

bool CLuaBaseEntity::hasTrait(uint8 traitID)
{
    if (m_PBaseEntity->objtype != TYPE_PC)
    {
        return false;
    }

    return charutils::hasTrait(static_cast<CCharEntity*>(m_PBaseEntity), traitID);
}

/************************************************************************
 *  Function: hasImmunity()
 *  Purpose : Returns true if a Mob is immune to a specified type of spell
 *  Example : if target:hasImmunity(64) then
 *  Notes   : Arguments are dec to bin, so powers of 2 (max 256) -- Listed in mobentity.h
 ************************************************************************/

bool CLuaBaseEntity::hasImmunity(uint32 immunityID)
{
    return static_cast<CBattleEntity*>(m_PBaseEntity)->hasImmunity(immunityID);
}

/************************************************************************
 *  Function: setAggressive()
 *  Purpose : Toggle a Mob to an aggressive or passive state
 *  Example : mob:setAggressive(true)
 ************************************************************************/

void CLuaBaseEntity::setAggressive(bool aggressive)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

    static_cast<CMobEntity*>(m_PBaseEntity)->m_Aggro = aggressive;
}

/************************************************************************
 *  Function: setTrueDetection()
 *  Purpose : Toggle True Detection on or off for a Mob
 *  Example : mob:setTrueDetection(true)
 ************************************************************************/

void CLuaBaseEntity::setTrueDetection(bool truedetection)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    dynamic_cast<CBattleEntity*>(m_PBaseEntity)->m_unkillable = unkillable;
}

/************************************************************************
 *  Function: untargetable()
 *  Purpose : Returns true if a Mob or NPC is untargetable (Not True)
 *  Example : if target:untargetable() then
 *  Notes   : This does not return a value, but instead sets state!
 ************************************************************************/

void CLuaBaseEntity::untargetable(bool untargetable)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB && m_PBaseEntity->objtype != TYPE_NPC);

    if (m_PBaseEntity->objtype == TYPE_MOB)
    {
        static_cast<CMobEntity*>(m_PBaseEntity)->Untargetable(untargetable);
    }
    else if (m_PBaseEntity->objtype == TYPE_NPC)
    {
        static_cast<CMobEntity*>(m_PBaseEntity)->Untargetable(untargetable);
    }

    m_PBaseEntity->updatemask |= UPDATE_HP;
}

/************************************************************************
 *  Function: setDelay()
 *  Purpose : Override default delay settings for a Mob
 *  Example : mob:setDelay(2400)
 ************************************************************************/

void CLuaBaseEntity::setDelay(uint16 delay)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

    auto* PMobEntity = static_cast<CMobEntity*>(m_PBaseEntity);
    static_cast<CItemWeapon*>(PMobEntity->m_Weapons[SLOT_MAIN])->setDelay(delay);
}

/************************************************************************
 *  Function: setDamage()
 *  Purpose : Override default damage settings for a Mob
 *  Example : mob:setDamage(40)
 ************************************************************************/

void CLuaBaseEntity::setDamage(uint16 damage)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

    auto* PMobEntity = static_cast<CMobEntity*>(m_PBaseEntity);
    static_cast<CItemWeapon*>(PMobEntity->m_Weapons[SLOT_MAIN])->setDamage(damage);
}

/************************************************************************
 *  Function: hasSpellList()
 *  Purpose : Returns true if a Mob has spells to cast
 *  Example : if mob:hasSpellList() then
 ************************************************************************/

bool CLuaBaseEntity::hasSpellList()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB && m_PBaseEntity->objtype != TYPE_PET);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB && m_PBaseEntity->objtype != TYPE_PET);

    mobutils::SetSpellList(static_cast<CMobEntity*>(m_PBaseEntity), spellList);
}

/************************************************************************
 *  Function: SetAutoAttackEnabled()
 *  Purpose : Enables/disabled auto-attack for a Mob
 *  Example : mob:SetAutoAttackEnabled(false)
 *  Notes   : See scripts/zones/Throne_Room/mobs/Shadow_Lord.lua
 ************************************************************************/

void CLuaBaseEntity::SetAutoAttackEnabled(bool state)
{
    m_PBaseEntity->PAI->GetController()->SetAutoAttackEnabled(state);
}

/************************************************************************
 *  Function: SetMagicCastingEnabled()
 *  Purpose : Used to enable/disable the casting of spells for a Mob
 *  Example : mob:SetMagicCastingEnabled(false)
 *  Notes   : Used primarily for Mob behavior and battle control
 ************************************************************************/

void CLuaBaseEntity::SetMagicCastingEnabled(bool state)
{
    m_PBaseEntity->PAI->GetController()->SetMagicCastingEnabled(state);
}

/************************************************************************
 *  Function: SetMobAbilityEnabled()
 *  Purpose : Used primarily to clear queue for special ability to be used
 *  Example : mob:SetMobAbilityEnabled(false)
 *  Notes   : See Bahamut.lua
 ************************************************************************/

void CLuaBaseEntity::SetMobAbilityEnabled(bool state)
{
    m_PBaseEntity->PAI->GetController()->SetWeaponSkillEnabled(state);
}

/************************************************************************
 *  Function: SetMobSkillAttack()
 *  Purpose : Used mainly so Mobs don't respawn in flight?
 *  Example : mob:SetMobSkillAttack(0)
 *  Notes   : Used in Ouryu, Jormungand, Tiamat, etc
 ************************************************************************/

void CLuaBaseEntity::SetMobSkillAttack(int16 value)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

    static_cast<CMobEntity*>(m_PBaseEntity)->setMobMod(MOBMOD_ATTACK_SKILL_LIST, value);
}

/************************************************************************
 *  Function: getMobMod()
 *  Purpose : Returns the power value of a Mob Mod in effect
 *  Example : mob:getMobMod(xi.mobMod.MUG_GIL)
 *  Notes   :
 ************************************************************************/

int16 CLuaBaseEntity::getMobMod(uint16 mobModID)
{
    XI_DEBUG_BREAK_IF(!(m_PBaseEntity->objtype & TYPE_MOB));

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
    // putting this in here to find elusive bug
    if (!(m_PBaseEntity->objtype & TYPE_MOB))
    {
        // this once broke on an entity (17532673) but it could not be found
        ShowError("CLuaBaseEntity::addMobMod Expected type mob (%d) but its a (%d)\n", m_PBaseEntity->id, m_PBaseEntity->objtype);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity == nullptr);

    // putting this in here to find elusive bug
    if (!(m_PBaseEntity->objtype & TYPE_MOB))
    {
        // this once broke on an entity (17532673) but it could not be found
        ShowError("CLuaBaseEntity::setMobMod Expected type mob (%d) but its a (%d)\n", m_PBaseEntity->id, m_PBaseEntity->objtype);
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
    // putting this in here to find elusive bug
    if (!(m_PBaseEntity->objtype & TYPE_MOB))
    {
        // this once broke on an entity (17532673) but it could not be found
        ShowError("CLuaBaseEntity::addMobMod Expected type mob (%d) but its a (%d)\n", m_PBaseEntity->id, m_PBaseEntity->objtype);
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    return static_cast<uint32>(std::chrono::duration_cast<std::chrono::seconds>(((CBattleEntity*)m_PBaseEntity)->GetBattleTime()).count());
}

/************************************************************************
 *  Function: getBehaviour()
 *  Purpose : Returns the current Mob behavior
 *  Example : mob:getBehaviour()
 *  Notes   : Currently used in bitwise calculations for high-tier NM's
 ************************************************************************/

uint16 CLuaBaseEntity::getBehaviour()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

    return static_cast<CMobEntity*>(m_PBaseEntity)->m_Behaviour;
}

/************************************************************************
 *  Function: setBehaviour()
 *  Purpose : Sets a particular behavior for a Mob
 *  Example : mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
 *  Notes   : Currently used in bitwise calculations for high-tier NM's
 ************************************************************************/

void CLuaBaseEntity::setBehaviour(uint16 behavior)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

    static_cast<CMobEntity*>(m_PBaseEntity)->m_Behaviour = behavior;
}

/************************************************************************
 *  Function: getTarget()
 *  Purpose : Return available targets as a Lua table to the Mob
 *  Example : mob:getTarget(); pet:getTarget(); if not v:getTarget() then
 *  Notes   :
 ************************************************************************/

std::optional<CLuaBaseEntity> CLuaBaseEntity::getTarget()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

    EnmityList_t* enmityList = ((CMobEntity*)m_PBaseEntity)->PEnmityContainer->GetEnmityList();

    if (enmityList)
    {
        auto table = luautils::lua.create_table();
        for (auto member : *enmityList)
        {
            if (member.second.PEnmityOwner)
            {
                auto subTable = luautils::lua.create_table();

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    CBattleEntity* PMob = static_cast<CBattleEntity*>(PLuaBaseEntity->GetBaseEntity());

    if (PMob != nullptr)
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

void CLuaBaseEntity::castSpell(sol::object const& spell, sol::object entity)
{
    if (spell != sol::nil)
    {
        SpellID spellid = spell.as<SpellID>();
        uint16  targid  = 0;

        if (entity != sol::nil)
        {
            CLuaBaseEntity* PLuaBaseEntity = entity.as<CLuaBaseEntity*>();
            if (PLuaBaseEntity->m_PBaseEntity)
            {
                targid = PLuaBaseEntity->m_PBaseEntity->targid;
            }
        }

        m_PBaseEntity->PAI->QueueAction(queueAction_t(0ms, true, [targid, spellid](auto PEntity) {
            if (targid)
            {
                PEntity->PAI->Cast(targid, spellid);
            }
            else if (dynamic_cast<CMobEntity*>(PEntity))
            {
                PEntity->PAI->Cast(static_cast<CMobEntity*>(PEntity)->GetBattleTargetID(), spellid);
            }
        }));
    }
    else
    {
        m_PBaseEntity->PAI->QueueAction(queueAction_t(0ms, true, [](auto PEntity) {
            if (dynamic_cast<CMobEntity*>(PEntity))
            {
                static_cast<CMobController*>(PEntity->PAI->GetController())->TryCastSpell();
            }
        }));
    }
}

/************************************************************************
 *  Function: useJobAbility()
 *  Purpose : Instruct a Mob to use a specified Job Ability
 *  Example : wyvern:useJobAbility(636, wyvern) -- Specifying pet to use
 *  Notes   : Inserts directly into queue stack with 0ms delay
 ************************************************************************/

void CLuaBaseEntity::useJobAbility(uint16 skillID, sol::object const& pet)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity == nullptr);

    CBattleEntity* PTarget{ nullptr };

    if ((pet != sol::nil) && pet.is<CLuaBaseEntity*>())
    {
        CLuaBaseEntity* PLuaBaseEntity = pet.as<CLuaBaseEntity*>();
        PTarget                        = static_cast<CBattleEntity*>(PLuaBaseEntity->m_PBaseEntity);
    }

    m_PBaseEntity->PAI->QueueAction(queueAction_t(0ms, true, [PTarget, skillID](auto PEntity) {
        if (PTarget)
        {
            PEntity->PAI->Ability(PTarget->targid, skillID);
        }
        else if (dynamic_cast<CMobEntity*>(PEntity))
        {
            PEntity->PAI->Ability(static_cast<CMobEntity*>(PEntity)->GetBattleTargetID(), skillID);
        }
    }));
}

/************************************************************************
 *  Function: useMobAbility()
 *  Purpose : Uses a specified Mob Ability or the next one ready in the que
 *  Example : automation:useMobAbility(2132, automation) --Specifying pet
 *  Notes   : Use single variable (Ability ID only) for base entity only
 ************************************************************************/

void CLuaBaseEntity::useMobAbility(sol::variadic_args va)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_TRUST && m_PBaseEntity->objtype != TYPE_MOB && m_PBaseEntity->objtype != TYPE_PET);

    if (va.size() == 0)
    {
        m_PBaseEntity->PAI->QueueAction(queueAction_t(0ms, true, [](auto PEntity) {
            if (dynamic_cast<CMobEntity*>(PEntity))
            {
                static_cast<CMobController*>(PEntity->PAI->GetController())->MobSkill();
            }
        }));
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

    m_PBaseEntity->PAI->QueueAction(queueAction_t(0ms, true, [PTarget, skillid, PMobSkill](auto PEntity) {
        if (PTarget)
        {
            PEntity->PAI->MobSkill(PTarget->targid, skillid);
        }
        else if (dynamic_cast<CMobEntity*>(PEntity))
        {
            if (PMobSkill->getValidTargets() & TARGET_ENEMY)
            {
                PEntity->PAI->MobSkill(static_cast<CMobEntity*>(PEntity)->GetBattleTargetID(), skillid);
            }
            else if (PMobSkill->getValidTargets() & TARGET_SELF)
            {
                PEntity->PAI->MobSkill(PEntity->targid, skillid);
            }
        }
    }));
}

/************************************************************************
 *  Function: hasTPMoves()
 *  Purpose : Returns true if a Mob has TP moves in its skill list
 *  Example : if mob:hasTPMoves() then
 ************************************************************************/

bool CLuaBaseEntity::hasTPMoves()
{
    XI_DEBUG_BREAK_IF((m_PBaseEntity->objtype == TYPE_NPC) || (m_PBaseEntity->objtype == TYPE_PC));

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
 *  Function: weaknessTrigger()
 *  Purpose : Triggers the weakness of a mob to an active state
 *  Example : mob:weaknessTrigger(1)
 *  Notes   : Used in scripts/mixins/abyssea_nm.lua
 ************************************************************************/

void CLuaBaseEntity::weaknessTrigger(uint8 level)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

    mobutils::WeaknessTrigger(m_PBaseEntity, static_cast<WeaknessType>(level));
}

/************************************************************************
 *  Function: hasPreventActionEffect()
 *  Purpose : Returns true if a non-NPC entity has a preventative status effect
 *  Example : if not pet:hasPreventActionEffect() then
 *  Notes   : Used in scripts/globals/abilities/stay.lua
 ************************************************************************/

bool CLuaBaseEntity::hasPreventActionEffect()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype == TYPE_NPC);

    return static_cast<CBattleEntity*>(m_PBaseEntity)->StatusEffectContainer->HasPreventActionEffect();
}

/************************************************************************
 *  Function: stun()
 *  Purpose : Stuns a mob for a specified amount of time (in ms)
 *  Example : mob:stun(5000) -- Stun for 5 seconds
 *  Notes   : To Do: Change to seconds for standardization?
 ************************************************************************/

void CLuaBaseEntity::stun(uint32 milliseconds)
{
    m_PBaseEntity->PAI->Inactive(std::chrono::milliseconds(milliseconds), false);
}

/************************************************************************
 *  Function: getPool()
 *  Purpose : Returns a Mob's Pool ID integer
 *  Example : if mob:getPool() = 4006 then
 *  Notes   :
 ************************************************************************/

uint32 CLuaBaseEntity::getPool()
{
    if (m_PBaseEntity->objtype == TYPE_MOB)
    {
        CMobEntity* PMob = static_cast<CMobEntity*>(m_PBaseEntity);
        return PMob->m_Pool;
    }

    XI_DEBUG_BREAK_IF(true); // TODO: Examine impact of returning 0
    return 0;
}

/************************************************************************
 *  Function: getDropID()
 *  Purpose : Returns the integer Drop ID assigned to a Mob
 *  Example : local DropID = mob:getDropID()
 ************************************************************************/

uint32 CLuaBaseEntity::getDropID()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

    return static_cast<CMobEntity*>(m_PBaseEntity)->m_DropID;
}

/************************************************************************
 *  Function: setDropID()
 *  Purpose : Permanently changes the Drop ID assigned to a Mob
 *  Example : target:setDropID(2408)
 *  Notes   : Useful for situations where drops only occur from conditions
 ************************************************************************/

void CLuaBaseEntity::setDropID(uint32 dropID)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

    auto* PMob = static_cast<CMobEntity*>(m_PBaseEntity);

    PMob->m_DropID = dropID;
    PMob->m_DropListModifications.clear();
}

/************************************************************************
 *  Function: addTreasure()
 *  Purpose : Manually adds treasure to a party's treasure pool
 *  Example : targ:addTreasure(itemId, dropper)
 ************************************************************************/

void CLuaBaseEntity::addTreasure(uint16 itemID, sol::object const& arg1, sol::object const& arg2)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_PC);

    CCharEntity* PChar = static_cast<CCharEntity*>(m_PBaseEntity);

    if (PChar->PTreasurePool != nullptr)
    {
        if ((arg1 != sol::nil) && arg1.is<CLuaBaseEntity*>())
        {
            uint16 droprate = (arg2 != sol::nil) ? arg2.as<uint16>() : 1000;

            // The specified PEntity can be a Mob or NPC
            CLuaBaseEntity* PLuaBaseEntity = arg1.as<CLuaBaseEntity*>();
            CBaseEntity*    PEntity        = PLuaBaseEntity->GetBaseEntity();

            charutils::DistributeItem(PChar, PEntity, itemID, droprate);
        }
        else // Entity can be nullptr - this is intentional
        {
            uint16 droprate = (arg1 != sol::nil) ? arg1.as<uint16>() : 1000;

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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

    auto* PMob = dynamic_cast<CMobEntity*>(m_PBaseEntity);

    if (PMob)
    {
        DropList_t* PDropList = itemutils::GetDropList(PMob->m_DropID);

        if (PDropList && !PMob->m_ItemStolen)
        {
            for (const DropItem_t& drop : PDropList->Items)
            {
                if (drop.DropType == DROP_STEAL)
                {
                    return drop.ItemID;
                }
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
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

    auto* PMob = dynamic_cast<CMobEntity*>(m_PBaseEntity);

    if (PMob)
    {
        DropList_t* PDropList = itemutils::GetDropList(PMob->m_DropID);

        if (PDropList && !PMob->m_ItemStolen)
        {
            for (const DropItem_t& drop : PDropList->Items)
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
 *  Notes   : Used in scripts/globals/abilities/steal.lua
 ************************************************************************/

bool CLuaBaseEntity::itemStolen()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

    static_cast<CMobEntity*>(m_PBaseEntity)->m_ItemStolen = true;
    return true;
}

/************************************************************************
 *  Function: getTHlevel()
 *  Purpose : Return mob's current Treasure Hunter tier if alive, or its last if dead.
 *  Example : local TH = target:getTHlevel()
 ************************************************************************/

int16 CLuaBaseEntity::getTHlevel()
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

    auto* PMob = static_cast<CMobEntity*>(m_PBaseEntity);
    return PMob->isDead() ? PMob->m_THLvl : PMob->PEnmityContainer->GetHighestTH();
}

/************************************************************************
 *  Function: addDropListModification()
 *  Purpose : Adds a modification to the drop list of this mob, to be applied just before loot is rolled.
 *  Example : mob:addDropListModification(4112, 1000) -- Set drop rate of Potion to 100%
 *  Notes   : Erased on death, once the modifications are applied.
 *          : Modifications are cleared if the drop list is changed.
 ************************************************************************/

void CLuaBaseEntity::addDropListModification(uint16 id, uint16 newRate, sol::variadic_args va)
{
    XI_DEBUG_BREAK_IF(m_PBaseEntity->objtype != TYPE_MOB);

    auto* PMob = static_cast<CMobEntity*>(m_PBaseEntity);

    uint8 dropType = va[0].get_type() == sol::type::number ? va[0].as<uint8>() : 0;

    PMob->m_DropListModifications[id] = std::pair<uint16, uint8>(newRate, dropType);
}

//==========================================================//

void CLuaBaseEntity::Register()
{
    SOL_USERTYPE("CBaseEntity", CLuaBaseEntity);

    // Messaging System
    SOL_REGISTER("showText", CLuaBaseEntity::showText);
    SOL_REGISTER("messageText", CLuaBaseEntity::messageText);
    SOL_REGISTER("PrintToPlayer", CLuaBaseEntity::PrintToPlayer);
    SOL_REGISTER("PrintToArea", CLuaBaseEntity::PrintToArea);
    SOL_REGISTER("messageBasic", CLuaBaseEntity::messageBasic);
    SOL_REGISTER("messageName", CLuaBaseEntity::messageName);
    SOL_REGISTER("messagePublic", CLuaBaseEntity::messagePublic);
    SOL_REGISTER("messageSpecial", CLuaBaseEntity::messageSpecial);
    SOL_REGISTER("messageSystem", CLuaBaseEntity::messageSystem);
    SOL_REGISTER("messageCombat", CLuaBaseEntity::messageCombat);

    // Variables
    SOL_REGISTER("getCharVar", CLuaBaseEntity::getCharVar);
    SOL_REGISTER("setCharVar", CLuaBaseEntity::setCharVar);
    SOL_REGISTER("getVar", CLuaBaseEntity::getCharVar); // Compatibility binding
    SOL_REGISTER("setVar", CLuaBaseEntity::setCharVar); // Compatibility binding
    SOL_REGISTER("addCharVar", CLuaBaseEntity::addCharVar);
    SOL_REGISTER("getLocalVar", CLuaBaseEntity::getLocalVar);
    SOL_REGISTER("setLocalVar", CLuaBaseEntity::setLocalVar);
    SOL_REGISTER("resetLocalVars", CLuaBaseEntity::resetLocalVars);
    SOL_REGISTER("clearVarsWithPrefix", CLuaBaseEntity::clearVarsWithPrefix);
    SOL_REGISTER("getLastOnline", CLuaBaseEntity::getLastOnline);

    // Packets, Events, and Flags
    SOL_REGISTER("injectPacket", CLuaBaseEntity::injectPacket);
    SOL_REGISTER("injectActionPacket", CLuaBaseEntity::injectActionPacket);
    SOL_REGISTER("entityVisualPacket", CLuaBaseEntity::entityVisualPacket);
    SOL_REGISTER("entityAnimationPacket", CLuaBaseEntity::entityAnimationPacket);

    SOL_REGISTER("startEvent", CLuaBaseEntity::startEvent);
    SOL_REGISTER("startCutscene", CLuaBaseEntity::startEvent); // Compatibility binding
    SOL_REGISTER("startOptionalCutscene", CLuaBaseEntity::startEvent); // Compatibility binding
    SOL_REGISTER("startEventString", CLuaBaseEntity::startEventString);
    SOL_REGISTER("updateEvent", CLuaBaseEntity::updateEvent);
    SOL_REGISTER("updateEventString", CLuaBaseEntity::updateEventString);
    SOL_REGISTER("getEventTarget", CLuaBaseEntity::getEventTarget);
    SOL_REGISTER("isInEvent", CLuaBaseEntity::isInEvent);
    SOL_REGISTER("release", CLuaBaseEntity::release);
    SOL_REGISTER("startSequence", CLuaBaseEntity::startSequence);
    SOL_REGISTER("didGetMessage", CLuaBaseEntity::didGetMessage);
    SOL_REGISTER("resetGotMessage", CLuaBaseEntity::resetGotMessage);

    SOL_REGISTER("setFlag", CLuaBaseEntity::setFlag);
    SOL_REGISTER("getMoghouseFlag", CLuaBaseEntity::getMoghouseFlag);
    SOL_REGISTER("setMoghouseFlag", CLuaBaseEntity::setMoghouseFlag);
    SOL_REGISTER("needToZone", CLuaBaseEntity::needToZone);

    // Object Identification
    SOL_REGISTER("getID", CLuaBaseEntity::getID);
    SOL_REGISTER("getShortID", CLuaBaseEntity::getShortID);
    SOL_REGISTER("getCursorTarget", CLuaBaseEntity::getCursorTarget);

    SOL_REGISTER("getObjType", CLuaBaseEntity::getObjType);
    SOL_REGISTER("isPC", CLuaBaseEntity::isPC);
    SOL_REGISTER("isNPC", CLuaBaseEntity::isNPC);
    SOL_REGISTER("isMob", CLuaBaseEntity::isMob);
    SOL_REGISTER("isPet", CLuaBaseEntity::isPet);
    SOL_REGISTER("isAlly", CLuaBaseEntity::isAlly);

    // AI and Control
    SOL_REGISTER("initNpcAi", CLuaBaseEntity::initNpcAi);
    SOL_REGISTER("resetAI", CLuaBaseEntity::resetAI);
    SOL_REGISTER("getStatus", CLuaBaseEntity::getStatus);
    SOL_REGISTER("setStatus", CLuaBaseEntity::setStatus);
    SOL_REGISTER("getCurrentAction", CLuaBaseEntity::getCurrentAction);

    SOL_REGISTER("lookAt", CLuaBaseEntity::lookAt);
    SOL_REGISTER("clearTargID", CLuaBaseEntity::clearTargID);

    SOL_REGISTER("atPoint", CLuaBaseEntity::atPoint);
    SOL_REGISTER("pathTo", CLuaBaseEntity::pathTo);
    SOL_REGISTER("pathThrough", CLuaBaseEntity::pathThrough);
    SOL_REGISTER("isFollowingPath", CLuaBaseEntity::isFollowingPath);
    SOL_REGISTER("clearPath", CLuaBaseEntity::clearPath);
    SOL_REGISTER("continuePath", CLuaBaseEntity::continuePath);
    SOL_REGISTER("checkDistance", CLuaBaseEntity::checkDistance);
    SOL_REGISTER("wait", CLuaBaseEntity::wait);

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
    SOL_REGISTER("ChangeMusic", CLuaBaseEntity::ChangeMusic);
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
    SOL_REGISTER("isZoneVisited", CLuaBaseEntity::isZoneVisited);
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
    SOL_REGISTER("hasItem", CLuaBaseEntity::hasItem);
    SOL_REGISTER("addItem", CLuaBaseEntity::addItem);
    SOL_REGISTER("delItem", CLuaBaseEntity::delItem);
    SOL_REGISTER("addUsedItem", CLuaBaseEntity::addUsedItem);
    SOL_REGISTER("addTempItem", CLuaBaseEntity::addTempItem);
    SOL_REGISTER("hasWornItem", CLuaBaseEntity::hasWornItem);
    SOL_REGISTER("createWornItem", CLuaBaseEntity::createWornItem);
    SOL_REGISTER("findItem", CLuaBaseEntity::findItem);

    SOL_REGISTER("createShop", CLuaBaseEntity::createShop);
    SOL_REGISTER("addShopItem", CLuaBaseEntity::addShopItem);
    SOL_REGISTER("getCurrentGPItem", CLuaBaseEntity::getCurrentGPItem);
    SOL_REGISTER("breakLinkshell", CLuaBaseEntity::breakLinkshell);
    SOL_REGISTER("addLinkpearl", CLuaBaseEntity::addLinkpearl);

    // Trading
    SOL_REGISTER("getContainerSize", CLuaBaseEntity::getContainerSize);
    SOL_REGISTER("changeContainerSize", CLuaBaseEntity::changeContainerSize);
    SOL_REGISTER("getFreeSlotsCount", CLuaBaseEntity::getFreeSlotsCount);
    SOL_REGISTER("confirmTrade", CLuaBaseEntity::confirmTrade);
    SOL_REGISTER("tradeComplete", CLuaBaseEntity::tradeComplete);

    // Equipping
    SOL_REGISTER("canEquipItem", CLuaBaseEntity::canEquipItem);
    SOL_REGISTER("equipItem", CLuaBaseEntity::equipItem);
    SOL_REGISTER("unequipItem", CLuaBaseEntity::unequipItem);

    SOL_REGISTER("setEquipBlock", CLuaBaseEntity::setEquipBlock);
    SOL_REGISTER("lockEquipSlot", CLuaBaseEntity::lockEquipSlot);
    SOL_REGISTER("unlockEquipSlot", CLuaBaseEntity::unlockEquipSlot);

    SOL_REGISTER("getShieldSize", CLuaBaseEntity::getShieldSize);

    SOL_REGISTER("hasGearSetMod", CLuaBaseEntity::hasGearSetMod);
    SOL_REGISTER("addGearSetMod", CLuaBaseEntity::addGearSetMod);
    SOL_REGISTER("clearGearSetMods", CLuaBaseEntity::clearGearSetMods);

    // Storing
    SOL_REGISTER("getStorageItem", CLuaBaseEntity::getStorageItem);
    SOL_REGISTER("storeWithPorterMoogle", CLuaBaseEntity::storeWithPorterMoogle);
    SOL_REGISTER("getRetrievableItemsForSlip", CLuaBaseEntity::getRetrievableItemsForSlip);
    SOL_REGISTER("retrieveItemFromSlip", CLuaBaseEntity::retrieveItemFromSlip);

    // Player Appearance
    SOL_REGISTER("getRace", CLuaBaseEntity::getRace);
    SOL_REGISTER("getGender", CLuaBaseEntity::getGender);
    SOL_REGISTER("getName", CLuaBaseEntity::getName);
    SOL_REGISTER("hideName", CLuaBaseEntity::hideName);
    SOL_REGISTER("checkNameFlags", CLuaBaseEntity::checkNameFlags);
    SOL_REGISTER("getModelId", CLuaBaseEntity::getModelId);
    SOL_REGISTER("setModelId", CLuaBaseEntity::setModelId);
    SOL_REGISTER("setCostume", CLuaBaseEntity::setCostume);
    SOL_REGISTER("getCostume", CLuaBaseEntity::getCostume);
    SOL_REGISTER("getCostume2", CLuaBaseEntity::getCostume2);
    SOL_REGISTER("setCostume2", CLuaBaseEntity::setCostume2);

    SOL_REGISTER("getAnimation", CLuaBaseEntity::getAnimation);
    SOL_REGISTER("setAnimation", CLuaBaseEntity::setAnimation);
    SOL_REGISTER("getAnimationSub", CLuaBaseEntity::getAnimationSub);
    SOL_REGISTER("setAnimationSub", CLuaBaseEntity::setAnimationSub);

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
    SOL_REGISTER("getGMHidden", CLuaBaseEntity::getGMHidden);
    SOL_REGISTER("setGMHidden", CLuaBaseEntity::setGMHidden);

    SOL_REGISTER("isJailed", CLuaBaseEntity::isJailed);
    SOL_REGISTER("jail", CLuaBaseEntity::jail);

    SOL_REGISTER("canUseMisc", CLuaBaseEntity::canUseMisc);

    SOL_REGISTER("getSpeed", CLuaBaseEntity::getSpeed);
    SOL_REGISTER("setSpeed", CLuaBaseEntity::setSpeed);

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

    SOL_REGISTER("getJobPointLevel", CLuaBaseEntity::getJobPointLevel);
    SOL_REGISTER("addCapacityPoints", CLuaBaseEntity::addCapacityPoints);
    SOL_REGISTER("setCapacityPoints", CLuaBaseEntity::setCapacityPoints);
    SOL_REGISTER("setJobPoints", CLuaBaseEntity::setJobPoints);

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
    SOL_REGISTER("setHP", CLuaBaseEntity::setHP);
    SOL_REGISTER("restoreHP", CLuaBaseEntity::restoreHP);
    SOL_REGISTER("delHP", CLuaBaseEntity::delHP);
    SOL_REGISTER("takeDamage", CLuaBaseEntity::takeDamage);
    SOL_REGISTER("hideHP", CLuaBaseEntity::hideHP);

    SOL_REGISTER("getMP", CLuaBaseEntity::getMP);
    SOL_REGISTER("getMPP", CLuaBaseEntity::getMPP);
    SOL_REGISTER("getMaxMP", CLuaBaseEntity::getMaxMP);
    SOL_REGISTER("getBaseMP", CLuaBaseEntity::getBaseMP);
    SOL_REGISTER("addMP", CLuaBaseEntity::addMP);
    SOL_REGISTER("setMP", CLuaBaseEntity::setMP);
    SOL_REGISTER("restoreMP", CLuaBaseEntity::restoreMP);
    SOL_REGISTER("delMP", CLuaBaseEntity::delMP);

    SOL_REGISTER("getTP", CLuaBaseEntity::getTP);
    SOL_REGISTER("addTP", CLuaBaseEntity::addTP);
    SOL_REGISTER("setTP", CLuaBaseEntity::setTP);
    SOL_REGISTER("delTP", CLuaBaseEntity::delTP);

    SOL_REGISTER("updateHealth", CLuaBaseEntity::updateHealth);

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

    // Battle Utilities
    SOL_REGISTER("isAlive", CLuaBaseEntity::isAlive);
    SOL_REGISTER("isDead", CLuaBaseEntity::isDead);

    SOL_REGISTER("sendRaise", CLuaBaseEntity::sendRaise);
    SOL_REGISTER("sendReraise", CLuaBaseEntity::sendReraise);
    SOL_REGISTER("sendTractor", CLuaBaseEntity::sendTractor);

    SOL_REGISTER("countdown", CLuaBaseEntity::countdown);
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

    SOL_REGISTER("getEntity", CLuaBaseEntity::getEntity);
    SOL_REGISTER("canChangeState", CLuaBaseEntity::canChangeState);

    SOL_REGISTER("wakeUp", CLuaBaseEntity::wakeUp);

    SOL_REGISTER("recalculateStats", CLuaBaseEntity::recalculateStats);
    SOL_REGISTER("checkImbuedItems", CLuaBaseEntity::checkImbuedItems);

    SOL_REGISTER("isDualWielding", CLuaBaseEntity::isDualWielding);

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

    SOL_REGISTER("addLatent", CLuaBaseEntity::addLatent);
    SOL_REGISTER("delLatent", CLuaBaseEntity::delLatent);

    SOL_REGISTER("fold", CLuaBaseEntity::fold);
    SOL_REGISTER("doWildCard", CLuaBaseEntity::doWildCard);
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
    SOL_REGISTER("setStatDebilitation", CLuaBaseEntity::setStatDebilitation);

    // Damage Calculation
    SOL_REGISTER("getStat", CLuaBaseEntity::getStat);
    SOL_REGISTER("getACC", CLuaBaseEntity::getACC);
    SOL_REGISTER("getEVA", CLuaBaseEntity::getEVA);
    SOL_REGISTER("getRACC", CLuaBaseEntity::getRACC);
    SOL_REGISTER("getRATT", CLuaBaseEntity::getRATT);
    SOL_REGISTER("getILvlMacc", CLuaBaseEntity::getILvlMacc);

    SOL_REGISTER("isSpellAoE", CLuaBaseEntity::isSpellAoE);

    SOL_REGISTER("physicalDmgTaken", CLuaBaseEntity::physicalDmgTaken);
    SOL_REGISTER("magicDmgTaken", CLuaBaseEntity::magicDmgTaken);
    SOL_REGISTER("rangedDmgTaken", CLuaBaseEntity::rangedDmgTaken);
    SOL_REGISTER("breathDmgTaken", CLuaBaseEntity::breathDmgTaken);
    SOL_REGISTER("handleAfflatusMiseryDamage", CLuaBaseEntity::handleAfflatusMiseryDamage);

    SOL_REGISTER("isWeaponTwoHanded", CLuaBaseEntity::isWeaponTwoHanded);
    SOL_REGISTER("getMeleeHitDamage", CLuaBaseEntity::getMeleeHitDamage);
    SOL_REGISTER("getWeaponDmg", CLuaBaseEntity::getWeaponDmg);
    SOL_REGISTER("getWeaponDmgRank", CLuaBaseEntity::getWeaponDmgRank);
    SOL_REGISTER("getOffhandDmg", CLuaBaseEntity::getOffhandDmg);
    SOL_REGISTER("getOffhandDmgRank", CLuaBaseEntity::getOffhandDmgRank);
    SOL_REGISTER("getRangedDmg", CLuaBaseEntity::getRangedDmg);
    SOL_REGISTER("getRangedDmgRank", CLuaBaseEntity::getRangedDmgRank);
    SOL_REGISTER("getAmmoDmg", CLuaBaseEntity::getAmmoDmg);

    SOL_REGISTER("removeAmmo", CLuaBaseEntity::removeAmmo);

    SOL_REGISTER("getWeaponSkillLevel", CLuaBaseEntity::getWeaponSkillLevel);
    SOL_REGISTER("getWeaponDamageType", CLuaBaseEntity::getWeaponDamageType);
    SOL_REGISTER("getWeaponSkillType", CLuaBaseEntity::getWeaponSkillType);
    SOL_REGISTER("getWeaponSubSkillType", CLuaBaseEntity::getWeaponSubSkillType);
    SOL_REGISTER("getWSSkillchainProp", CLuaBaseEntity::getWSSkillchainProp);

    SOL_REGISTER("takeWeaponskillDamage", CLuaBaseEntity::takeWeaponskillDamage);
    SOL_REGISTER("takeSpellDamage", CLuaBaseEntity::takeSpellDamage);

    // Pets and Automations
    SOL_REGISTER("spawnPet", CLuaBaseEntity::spawnPet);
    SOL_REGISTER("despawnPet", CLuaBaseEntity::despawnPet);

    SOL_REGISTER("isJugPet", CLuaBaseEntity::isJugPet);
    SOL_REGISTER("hasValidJugPetItem", CLuaBaseEntity::hasValidJugPetItem);

    SOL_REGISTER("hasPet", CLuaBaseEntity::hasPet);
    SOL_REGISTER("getPet", CLuaBaseEntity::getPet);
    SOL_REGISTER("getPetID", CLuaBaseEntity::getPetID);
    SOL_REGISTER("getPetElement", CLuaBaseEntity::getPetElement);
    SOL_REGISTER("getMaster", CLuaBaseEntity::getMaster);

    SOL_REGISTER("getPetName", CLuaBaseEntity::getPetName);
    SOL_REGISTER("setPetName", CLuaBaseEntity::setPetName);

    SOL_REGISTER("getCharmChance", CLuaBaseEntity::getCharmChance);
    SOL_REGISTER("charmPet", CLuaBaseEntity::charmPet);

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
    SOL_REGISTER("getAutomatonHead", CLuaBaseEntity::getAutomatonHead);
    SOL_REGISTER("unlockAttachment", CLuaBaseEntity::unlockAttachment);

    SOL_REGISTER("getActiveManeuvers", CLuaBaseEntity::getActiveManeuvers);
    SOL_REGISTER("removeOldestManeuver", CLuaBaseEntity::removeOldestManeuver);
    SOL_REGISTER("removeAllManeuvers", CLuaBaseEntity::removeAllManeuvers);
    SOL_REGISTER("updateAttachments", CLuaBaseEntity::updateAttachments);
    SOL_REGISTER("reduceBurden", CLuaBaseEntity::reduceBurden);

    // Trust related
    SOL_REGISTER("spawnTrust", CLuaBaseEntity::spawnTrust);
    SOL_REGISTER("clearTrusts", CLuaBaseEntity::clearTrusts);
    SOL_REGISTER("getTrustID", CLuaBaseEntity::getTrustID);
    SOL_REGISTER("trustPartyMessage", CLuaBaseEntity::trustPartyMessage);
    SOL_REGISTER("addSimpleGambit", CLuaBaseEntity::addSimpleGambit);
    SOL_REGISTER("setTrustTPSkillSettings", CLuaBaseEntity::setTrustTPSkillSettings);

    // Mob Entity-Specific
    SOL_REGISTER("setMobLevel", CLuaBaseEntity::setMobLevel);
    SOL_REGISTER("getSystem", CLuaBaseEntity::getSystem);
    SOL_REGISTER("getFamily", CLuaBaseEntity::getFamily);
    SOL_REGISTER("isMobType", CLuaBaseEntity::isMobType);
    SOL_REGISTER("isUndead", CLuaBaseEntity::isUndead);
    SOL_REGISTER("isNM", CLuaBaseEntity::isNM);

    SOL_REGISTER("getModelSize", CLuaBaseEntity::getModelSize);
    SOL_REGISTER("setMobFlags", CLuaBaseEntity::setMobFlags);
    SOL_REGISTER("getMobFlags", CLuaBaseEntity::getMobFlags);

    SOL_REGISTER("spawn", CLuaBaseEntity::spawn);
    SOL_REGISTER("isSpawned", CLuaBaseEntity::isSpawned);
    SOL_REGISTER("getSpawnPos", CLuaBaseEntity::getSpawnPos);
    SOL_REGISTER("setSpawn", CLuaBaseEntity::setSpawn);
    SOL_REGISTER("getRespawnTime", CLuaBaseEntity::getRespawnTime);
    SOL_REGISTER("setRespawnTime", CLuaBaseEntity::setRespawnTime);

    SOL_REGISTER("instantiateMob", CLuaBaseEntity::instantiateMob);

    SOL_REGISTER("hasTrait", CLuaBaseEntity::hasTrait);
    SOL_REGISTER("hasImmunity", CLuaBaseEntity::hasImmunity);

    SOL_REGISTER("setAggressive", CLuaBaseEntity::setAggressive);
    SOL_REGISTER("setTrueDetection", CLuaBaseEntity::setTrueDetection);
    SOL_REGISTER("setUnkillable", CLuaBaseEntity::setUnkillable);
    SOL_REGISTER("untargetable", CLuaBaseEntity::untargetable);

    SOL_REGISTER("setDelay", CLuaBaseEntity::setDelay);
    SOL_REGISTER("setDamage", CLuaBaseEntity::setDamage);
    SOL_REGISTER("hasSpellList", CLuaBaseEntity::hasSpellList);
    SOL_REGISTER("setSpellList", CLuaBaseEntity::setSpellList);
    SOL_REGISTER("SetAutoAttackEnabled", CLuaBaseEntity::SetAutoAttackEnabled);
    SOL_REGISTER("SetMagicCastingEnabled", CLuaBaseEntity::SetMagicCastingEnabled);
    SOL_REGISTER("SetMobAbilityEnabled", CLuaBaseEntity::SetMobAbilityEnabled);
    SOL_REGISTER("SetMobSkillAttack", CLuaBaseEntity::SetMobSkillAttack);

    SOL_REGISTER("getMobMod", CLuaBaseEntity::getMobMod);
    SOL_REGISTER("setMobMod", CLuaBaseEntity::setMobMod);
    SOL_REGISTER("addMobMod", CLuaBaseEntity::addMobMod);
    SOL_REGISTER("delMobMod", CLuaBaseEntity::delMobMod);

    SOL_REGISTER("getBattleTime", CLuaBaseEntity::getBattleTime);

    SOL_REGISTER("getBehaviour", CLuaBaseEntity::getBehaviour);
    SOL_REGISTER("setBehaviour", CLuaBaseEntity::setBehaviour);

    SOL_REGISTER("getTarget", CLuaBaseEntity::getTarget);
    SOL_REGISTER("updateTarget", CLuaBaseEntity::updateTarget);
    SOL_REGISTER("getEnmityList", CLuaBaseEntity::getEnmityList);
    SOL_REGISTER("getTrickAttackChar", CLuaBaseEntity::getTrickAttackChar);

    SOL_REGISTER("actionQueueEmpty", CLuaBaseEntity::actionQueueEmpty);

    SOL_REGISTER("castSpell", CLuaBaseEntity::castSpell);
    SOL_REGISTER("useJobAbility", CLuaBaseEntity::useJobAbility);
    SOL_REGISTER("useMobAbility", CLuaBaseEntity::useMobAbility);
    SOL_REGISTER("hasTPMoves", CLuaBaseEntity::hasTPMoves);

    SOL_REGISTER("weaknessTrigger", CLuaBaseEntity::weaknessTrigger);
    SOL_REGISTER("hasPreventActionEffect", CLuaBaseEntity::hasPreventActionEffect);
    SOL_REGISTER("stun", CLuaBaseEntity::stun);

    SOL_REGISTER("getPool", CLuaBaseEntity::getPool);
    SOL_REGISTER("getDropID", CLuaBaseEntity::getDropID);
    SOL_REGISTER("setDropID", CLuaBaseEntity::setDropID);
    SOL_REGISTER("addTreasure", CLuaBaseEntity::addTreasure);
    SOL_REGISTER("getStealItem", CLuaBaseEntity::getStealItem);
    SOL_REGISTER("getDespoilItem", CLuaBaseEntity::getDespoilItem);
    SOL_REGISTER("getDespoilDebuff", CLuaBaseEntity::getDespoilDebuff);
    SOL_REGISTER("itemStolen", CLuaBaseEntity::itemStolen);
    SOL_REGISTER("getTHlevel", CLuaBaseEntity::getTHlevel);
    SOL_REGISTER("addDropListModification", CLuaBaseEntity::addDropListModification);

    SOL_REGISTER("getPlayerRegionInZone", CLuaBaseEntity::getPlayerRegionInZone);
    SOL_REGISTER("updateToEntireZone", CLuaBaseEntity::updateToEntireZone);
}

//==========================================================//
