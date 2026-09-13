/************************************************************************
 * I hate this event - treants
 *
 * Drops any action a player aims at a Twinkling Treant unless the player holds the event's level cap.
 * The treant then needs no Confrontation flag, so capped players stay fair game for the rest of the zone.
 ************************************************************************/

#include "map/entities/char_entity.h"
#include "map/entities/mob_entity.h"
#include "map/enums/msg_basic.h"
#include "map/lua/lua_base_entity.h"
#include "map/packets/basic.h"
#include "map/packets/c2s/0x01a_action.h"
#include "map/packets/s2c/0x029_battle_message.h"
#include "map/status_effect_container.h"
#include "map/utils/moduleutils.h"

class TreantGate : public CPPModule
{
    void OnInit() override
    {
        // Lets the module test know the gate is compiled in, since xi_test links core without modules
        // Probably remove this later
        ::lua["TreantGateLoaded"] = true;
    }

    auto OnIncomingPacket(MapSession* PSession, CCharEntity* PChar, CBasicPacket& data) -> bool override
    {
        // Is this an action packet?
        if (data.getType() != 0x01A)
        {
            return false;
        }

        // Is this an action that needs to be checked? See list below
        const auto* packet = data.as<GP_CLI_COMMAND_ACTION>();
        if (!actsOnTarget(packet->ActionID))
        {
            return false;
        }

        // Get the target from the action packet that is already validated
        const auto* PTarget = dynamic_cast<CMobEntity*>(PChar->GetEntity(packet->ActIndex, TYPE_MOB));
        if (PTarget == nullptr)
        {
            return false;
        }

        // Check tree subtype
        const auto capSubType = PTarget->GetLocalVar("[TreantEvent]CapSubType");
        if (capSubType == 0 || PChar->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::LevelRestriction, static_cast<uint16>(capSubType)))
        {
            return false;
        }

        PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, 0, 0, MsgBasic::CannotAttackTarget);

        const auto treantEvent = ::lua["xi"]["treantEvent"].get<sol::optional<sol::table>>();
        if (treantEvent)
        {
            const auto onGateRejected = (*treantEvent)["onGateRejected"].get<sol::optional<sol::protected_function>>();
            if (onGateRejected)
            {
                (*onGateRejected)(CLuaBaseEntity(PChar));
            }
        }

        return true;
    }

    static auto actsOnTarget(const GP_CLI_COMMAND_ACTION_ACTIONID action) -> bool
    {
        switch (action)
        {
            case GP_CLI_COMMAND_ACTION_ACTIONID::Attack:
            case GP_CLI_COMMAND_ACTION_ACTIONID::CastMagic:
            case GP_CLI_COMMAND_ACTION_ACTIONID::Weaponskill:
            case GP_CLI_COMMAND_ACTION_ACTIONID::JobAbility:
            case GP_CLI_COMMAND_ACTION_ACTIONID::ChangeTarget:
            case GP_CLI_COMMAND_ACTION_ACTIONID::Shoot:
            case GP_CLI_COMMAND_ACTION_ACTIONID::MonsterSkill:
                return true;
            default:
                return false;
        }
    }
};

REGISTER_CPP_MODULE(TreantGate);
