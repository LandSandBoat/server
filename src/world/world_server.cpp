/*
===========================================================================

Copyright (c) 2022 LandSandBoat Dev Teams

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

#include "world_server.h"

#include "common/application.h"
#include "common/logging.h"
#include "time_server.h"

int32 forward_queued_messages_to_handlers(time_point tick, CTaskMgr::CTask* PTask)
{
    TracyZoneScoped;
    WorldServer* worldServer = std::any_cast<WorldServer*>(PTask->m_data);

    while (std::optional<HandleableMessage> maybeMessage = pop_external_processing_message())
    {
        HandleableMessage message = *maybeMessage;
        auto              subType = static_cast<REGIONALMSGTYPE>(ref<uint8>(message.payload.data(), 0));
        IMessageHandler*  handler = nullptr;
        switch (subType)
        {
            case REGIONAL_EVT_MSG_CONQUEST:
            {
                handler = worldServer->conquestSystem.get();
            }
            break;
            case REGIONAL_EVT_MSG_BESIEGED:
            {
                handler = worldServer->besiegedSystem.get();
            }
            break;
            case REGIONAL_EVT_MSG_CAMPAIGN:
            {
                handler = worldServer->campaignSystem.get();
            }
            break;
            case REGIONAL_EVT_MSG_COLONIZATION:
            {
                handler = worldServer->colonizationSystem.get();
            }
            break;
            default:
            {
                ShowError(fmt::format("Unknown IMessageHandler type requested: {}", subType));
            }
            break;
        }

        if (handler)
        {
            handler->handleMessage(std::move(message));
        }
    }

    return 0;
}

WorldServer::WorldServer(int argc, char** argv)
: Application("world", argc, argv)
, httpServer(std::make_unique<HTTPServer>())
, messageServer(std::make_unique<message_server_wrapper_t>(std::ref(m_RequestExit)))
, conquestSystem(std::make_unique<ConquestSystem>())
, besiegedSystem(std::make_unique<BesiegedSystem>())
, campaignSystem(std::make_unique<CampaignSystem>())
, colonizationSystem(std::make_unique<ColonizationSystem>())
{
    // Tasks
    CTaskMgr::getInstance()->AddTask("time_server", server_clock::now(), this, CTaskMgr::TASK_INTERVAL, time_server, 2400ms);

    // TODO: Make this more reactive than a polling job
    CTaskMgr::getInstance()->AddTask("forward_queued_messages_to_handlers", server_clock::now(), this, CTaskMgr::TASK_INTERVAL, forward_queued_messages_to_handlers, 250ms);
}

WorldServer::~WorldServer() = default;

void WorldServer::Tick()
{
    Application::Tick();
}
