/*
===========================================================================

Copyright (c) 2023 LandSandBoat Dev Teams

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

#include "besieged_system.h"
#include "common/mmo.h"
#include "common/settings.h"
#include "common/socket.h"
#include "map/besieged_data.h"
#include "world/message_server.h"

BesiegedSystem::BesiegedSystem()
: sql(std::make_unique<SqlConnection>())
, besiegedData(std::make_unique<BesiegedData>(sql))
{
}

bool BesiegedSystem::handleMessage(HandleableMessage&& message)
{
    // TODO: Handle incoming map messages
    DebugBesieged(fmt::format("Message: unknown conquest type received from {}:{}",
                              message.from_addr.s_addr,
                              message.from_port));

    return false;
}

void BesiegedSystem::updateVanaHourlyBesieged()
{
    if (!settings::get<bool>("main.BESIEGED_ENABLED"))
    {
        return;
    }

    updateBeastmenForces();
    sendStrongholdInfosMsg();
}

void BesiegedSystem::updateBeastmenForces()
{
    for (auto strongholdId : { BESIEGED_STRONGHOLD::MAMOOK, BESIEGED_STRONGHOLD::HALVUNG, BESIEGED_STRONGHOLD::ARRAPAGO })
    {
        // If not training or preparing, skip this
        auto strongholdInfo = this->besiegedData->getBeastmenStrongholdInfo(strongholdId);
        if (strongholdInfo.orders != BEASTMEN_BESIEGED_ORDERS::TRAIN &&
            strongholdInfo.orders != BEASTMEN_BESIEGED_ORDERS::PREPARE)
        {
            continue;
        }

        stronghold_info_t updatedInfo = strongholdInfo;

        // Increase forces and log this increase
        auto forceIncreaseRate = getForcesPerTick(strongholdInfo);
        updatedInfo.forces += forceIncreaseRate;
        DebugBesieged("Stronghold %d: Forces increased by %f to %f", strongholdInfo.strongholdId, forceIncreaseRate, updatedInfo.forces);

        if (strongholdInfo.orders == BEASTMEN_BESIEGED_ORDERS::TRAIN)
        {
            handleTrainingPhase(updatedInfo);
        }

        if (updatedInfo.orders == BEASTMEN_BESIEGED_ORDERS::PREPARE)
        {
            handlePreparingPhase(updatedInfo);
        }

        this->besiegedData->updateStrongholdInfo(updatedInfo);
        this->besiegedData->commit(sql);
    }
}

float BesiegedSystem::getForcesPerTick(stronghold_info_t strongholdInfo) const
{
    // These rates are currently linear
    // However, retail behavior has been observed, where force buildup
    // is slower as the forces get closer to 100
    // For now, we keep a linear growth rate, but we may want to change
    // this in the future
    auto minBeastmenTrainingRate  = settings::get<float>("main.BESIEGED_MIN_TRAINING_RATE");
    auto perMirrorTrainRate       = settings::get<float>("main.BESIEGED_PER_MIRROR_TRAINING_RATE");
    auto minBeastmenPreparingRate = settings::get<float>("main.BESIEGED_MIN_PREPARING_RATE");
    auto perMirrorPrepareRate     = settings::get<float>("main.BESIEGED_PER_MIRROR_PREPARING_RATE");

    if (strongholdInfo.orders == BEASTMEN_BESIEGED_ORDERS::TRAIN)
    {
        return std::max(minBeastmenTrainingRate, strongholdInfo.mirrors * perMirrorTrainRate);
    }
    else if (strongholdInfo.orders == BEASTMEN_BESIEGED_ORDERS::PREPARE)
    {
        return std::max(minBeastmenPreparingRate, strongholdInfo.mirrors * perMirrorPrepareRate);
    }

    return 0;
}

void BesiegedSystem::handleTrainingPhase(stronghold_info_t& strongholdInfo) const
{
    // If forces are less than 100, we are still in training
    DebugBesieged("Stronghold %d: Training. Current forces: %f", strongholdInfo.strongholdId, strongholdInfo.forces);
    if (strongholdInfo.forces < 100)
    {
        return;
    }

    // If forces are at 100, we need to change from training to preparing.
    // Preparing ends when the military force reaches
    // 100 + [10 * the number of times it was consecutively defeated] to a maximum of 200
    auto targetPrepareForces = std::min<uint8>(200, 100 + strongholdInfo.consecutiveDefeats * 10);

    // Copy the given info and update the orders + stronghold level
    // Set stronghold level based on forces during prepare stage
    // Level 1: 100 to 110
    // Level 2: 120
    // Level 3: 130
    // Level 4: 140
    // Level 5: 150
    // Level 6: 160
    // Level 7: 170
    // Level 8: 180, 190 or 200
    strongholdInfo.orders          = BEASTMEN_BESIEGED_ORDERS::PREPARE;
    strongholdInfo.strongholdLevel = targetPrepareForces <= 110 ? STRONGHOLD_LEVEL::LEVEL1 : (STRONGHOLD_LEVEL)std::min(8, 1 + (targetPrepareForces - 110) / 10);
    DebugBesieged("Stronghold %d: Orders changed to PREPARE. Stronghold Level: %d. Target forces: %d", strongholdInfo.strongholdId, strongholdInfo.strongholdLevel, targetPrepareForces);
}

void BesiegedSystem::handlePreparingPhase(stronghold_info_t& strongholdInfo) const
{
    // If we still haven't reached the target forces, we are still in preparing phase.
    auto targetPrepareForces = std::min<uint8>(200, 100 + strongholdInfo.consecutiveDefeats * 10);
    DebugBesieged("Stronghold %d: Preparing. Target forces: %d. Current forces: %f", strongholdInfo.strongholdId, targetPrepareForces, strongholdInfo.forces);
    if (strongholdInfo.forces < targetPrepareForces)
    {
        return;
    }

    strongholdInfo.orders = BEASTMEN_BESIEGED_ORDERS::ADVANCE;
    DebugBesieged("Stronghold %d: Orders changed to ADVANCE. Stronghold Level: %d", strongholdInfo.strongholdId, strongholdInfo.strongholdLevel);
}

void BesiegedSystem::sendStrongholdInfosMsg() const
{
    auto strongholdInfos = this->besiegedData->getStrongholdInfos();

    DebugBesieged("Sending besieged Stronghold Data:");
    for (auto line : this->besiegedData->getFormattedData())
    {
        DebugBesieged(line);
    }

    // Base length is the type + subtype + vector size
    const std::size_t headerLength = 2 * sizeof(uint8);
    const std::size_t dataLen      = headerLength + sizeof(size_t) + sizeof(stronghold_info_t) * strongholdInfos.size();
    const uint8*      data         = new uint8[dataLen];

    // Regional event type + besieged msg type
    ref<uint8>((uint8*)data, 0) = REGIONAL_EVT_MSG_BESIEGED;
    ref<uint8>((uint8*)data, 1) = BESIEGED_WORLD2MAP_STRONGHOLD_INFO;

    // Size info for deserialization
    ref<std::size_t>((uint8*)data, 2) = strongholdInfos.size();

    for (std::size_t i = 0; i < strongholdInfos.size(); i++)
    {
        // Everything is offset by i*size of region control struct + headerLength
        // Every field is one byte, so we can just add the offset to the start of the data
        const std::size_t start               = headerLength + sizeof(size_t) + i * sizeof(stronghold_info_t);
        ref<uint8>((uint8*)data, start)       = strongholdInfos[i].strongholdId;
        ref<uint8>((uint8*)data, start + 1)   = strongholdInfos[i].orders;
        ref<uint8>((uint8*)data, start + 2)   = strongholdInfos[i].strongholdLevel;
        ref<float>((uint8*)data, start + 3)   = strongholdInfos[i].forces;
        ref<uint8>((uint8*)data, start + 7)   = strongholdInfos[i].mirrors;
        ref<uint8>((uint8*)data, start + 8)   = strongholdInfos[i].prisoners;
        ref<uint8>((uint8*)data, start + 9)   = strongholdInfos[i].ownsAstralCandescence;
        ref<uint32>((uint8*)data, start + 10) = strongholdInfos[i].consecutiveDefeats;
    }

    // Send to map
    queue_data_broadcast(MSG_WORLD2MAP_REGIONAL_EVENT, data, dataLen);
}
