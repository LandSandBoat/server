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

#include "0x028_battle2.h"

#include "action/action.h"
#include "common/lua.h"

// Packs the action into the format expected by the FFXI client
// Use 'actionparse' by atom0s as reference when making changes.
void GP_SERV_COMMAND_BATTLE2::pack(action_t& action)
{
    // Set various default fields that never vary.
    action.normalize();

    const auto packet = buffer_.data();

    // Skip header and the WorkSize
    uint32_t      bitOffset = 8 * 5;
    const uint8_t trg_sum   = std::min<uint8_t>(static_cast<uint8_t>(action.targets.size()), 64);

    // Pack header fields in exact order from XiPackets
    bitOffset = packBitsBE(packet, action.actorId, bitOffset, 32);                          // Caster ID
    bitOffset = packBitsBE(packet, trg_sum, bitOffset, 6);                                  // Target count
    bitOffset = packBitsBE(packet, 0, bitOffset, 4);                                        // res_sum is always 0!
    bitOffset = packBitsBE(packet, static_cast<uint32_t>(action.actiontype), bitOffset, 4); // Command type
    bitOffset = packBitsBE(packet, action.actionid, bitOffset, 32);                         // Command argument
    bitOffset = packBitsBE(packet, timer::count_seconds(action.recast), bitOffset, 32);     // Action info

    // Pack targets
    action.ForEachTarget([&](const action_target_t& target)
                         {
                             // Pack target header
                             bitOffset                 = packBitsBE(packet, target.actorId, bitOffset, 32);
                             const uint8_t resultCount = std::min<uint8_t>(static_cast<uint8_t>(target.results.size()), 8);
                             bitOffset                 = packBitsBE(packet, resultCount, bitOffset, 4);

                             // Pack results for this target
                             for (const auto& result : target.results)
                             {
                                 // Core result fields (85 bits)
                                 bitOffset = packBitsBE(packet, static_cast<uint8_t>(result.resolution), bitOffset, 3);
                                 bitOffset = packBitsBE(packet, result.kind, bitOffset, 2);
                                 bitOffset = packBitsBE(packet, static_cast<uint64>(result.animation), bitOffset, 12);
                                 bitOffset = packBitsBE(packet, static_cast<uint64>(result.info), bitOffset, 5);
                                 bitOffset = packBitsBE(packet, static_cast<uint64>(result.hitDistortion), bitOffset, 2);
                                 bitOffset = packBitsBE(packet, static_cast<uint64>(result.knockback), bitOffset, 3);
                                 bitOffset = packBitsBE(packet, result.param, bitOffset, 17);
                                 bitOffset = packBitsBE(packet, result.messageID, bitOffset, 10);
                                 bitOffset = packBitsBE(packet, static_cast<uint32_t>(result.modifier), bitOffset, 31);

                                 // Conditional proc block
                                 bitOffset = packBitsBE(packet, result.hasAdditionalEffect() ? 1 : 0, bitOffset, 1);
                                 if (result.hasAdditionalEffect())
                                 {
                                     const auto effectValue = std::visit([](auto&& value) -> uint8_t
                                                                         {
                                                                             return static_cast<uint8_t>(value);
                                                                         },
                                                                         result.additionalEffect);

                                     bitOffset = packBitsBE(packet, effectValue, bitOffset, 6);
                                     bitOffset = packBitsBE(packet, result.addEffectInfo, bitOffset, 4);
                                     bitOffset = packBitsBE(packet, result.addEffectParam, bitOffset, 17);
                                     bitOffset = packBitsBE(packet, result.addEffectMessage, bitOffset, 10);
                                 }

                                 // Conditional reaction block
                                 bitOffset = packBitsBE(packet, result.spikesEffect != ActionReactKind::None ? 1 : 0, bitOffset, 1);
                                 if (result.spikesEffect != ActionReactKind::None)
                                 {
                                     bitOffset = packBitsBE(packet, static_cast<uint64>(result.spikesEffect), bitOffset, 6);
                                     bitOffset = packBitsBE(packet, result.spikesInfo, bitOffset, 4);
                                     bitOffset = packBitsBE(packet, result.spikesParam, bitOffset, 14);
                                     bitOffset = packBitsBE(packet, result.spikesMessage, bitOffset, 10);
                                 }
                             }
                         });

    // Client ignores it but we'll set it anyway.
    const uint8_t workSize = (bitOffset >> 3) + (bitOffset % 8 != 0);
    ref<uint8>(0x04)       = workSize;

    setSize(workSize + 1);
}

// This is the reverse of pack - unpacks a BATTLE2 packet into a Lua table
auto GP_SERV_COMMAND_BATTLE2::unpack() -> sol::table
{
    const auto data      = buffer_.data();
    uint32_t   bitOffset = 8 * 5; // Skip header and workSize

    // Helper to read bits and auto-increment offset
    auto readBits = [&](const uint8 bits) -> uint64
    {
        const auto value = unpackBitsBE(data, bitOffset, bits);
        bitOffset += bits;
        return value;
    };

    // Read action header
    auto action           = lua.create_table();
    action["m_uID"]       = readBits(32);
    const uint8_t trg_sum = static_cast<uint8_t>(readBits(6));
    action["trg_sum"]     = trg_sum;
    action["res_sum"]     = readBits(4);
    action["cmd_no"]      = readBits(4);
    action["cmd_arg"]     = readBits(32);
    action["info"]        = readBits(32);
    auto targets          = lua.create_table();
    action["target"]      = targets;

    // Read targets
    for (int t = 0; t < trg_sum; ++t)
    {
        auto target              = lua.create_table();
        target["m_uID"]          = readBits(32);
        const uint8_t result_sum = static_cast<uint8_t>(readBits(4));
        target["result_sum"]     = result_sum;

        auto results     = lua.create_table();
        target["result"] = results;

        // Read results
        for (int r = 0; r < result_sum; ++r)
        {
            auto result        = lua.create_table();
            result["miss"]     = readBits(3);
            result["kind"]     = readBits(2);
            result["sub_kind"] = readBits(12);
            result["info"]     = readBits(5);
            result["scale"]    = readBits(5);
            result["value"]    = readBits(17);
            result["message"]  = readBits(10);
            result["bit"]      = readBits(31);

            // Conditional proc block
            if (const uint8_t has_proc = static_cast<uint8_t>(readBits(1)); has_proc > 0)
            {
                result["has_proc"]     = true;
                result["proc_kind"]    = readBits(6);
                result["proc_info"]    = readBits(4);
                result["proc_value"]   = readBits(17);
                result["proc_message"] = readBits(10);
            }
            else
            {
                result["has_proc"]     = false;
                result["proc_kind"]    = 0;
                result["proc_info"]    = 0;
                result["proc_value"]   = 0;
                result["proc_message"] = 0;
            }

            // Conditional reaction block
            if (const uint8_t has_react = static_cast<uint8_t>(readBits(1)); has_react > 0)
            {
                result["has_react"]     = true;
                result["react_kind"]    = readBits(6);
                result["react_info"]    = readBits(4);
                result["react_value"]   = readBits(14);
                result["react_message"] = readBits(10);
            }
            else
            {
                result["has_react"]     = false;
                result["react_kind"]    = 0;
                result["react_info"]    = 0;
                result["react_value"]   = 0;
                result["react_message"] = 0;
            }

            results[r + 1] = result; // Lua tables are 1-indexed
        }

        targets[t + 1] = target; // Lua tables are 1-indexed
    }

    return action;
}

GP_SERV_COMMAND_BATTLE2::GP_SERV_COMMAND_BATTLE2(action_t& action)
{
    pack(action);
}
