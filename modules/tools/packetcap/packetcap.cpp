/************************************************************************
 * PacketCap
 *
 * Captures packets for opted-in characters to assist with debugging.
 * Set charvar 'PacketCap' to 1 to enable capture for a character.
 *
 * File format: DD TT TT TT TT TT TT TT TT SS SS [PP PP PP PP ..]
 *
 * DD = direction
 * TT = timestamp
 * SS = packet size
 * PP = packet payload
 ************************************************************************/

#include "common/settings.h"
#include "map/entities/charentity.h"
#include "map/packets/basic.h"
#include "map/utils/moduleutils.h"

#include <chrono>
#include <filesystem>
#include <fstream>
#include <unordered_map>

namespace
{
constexpr uint8 DIRECTION_C2S       = 0x00; // Client to Server (incoming)
constexpr uint8 DIRECTION_S2C       = 0x01; // Server to Client (outgoing)
constexpr auto  DEFAULT_CAPTURE_DIR = "./log/packets";
} // namespace

class PacketCapModule : public CPPModule
{
public:
    void OnInit() override
    {
        captureDir_ = settings::get<std::string>("logging.PACKET_CAPTURE_DIR");
        if (captureDir_.empty())
        {
            captureDir_ = DEFAULT_CAPTURE_DIR;
        }

        std::error_code ec;
        std::filesystem::create_directories(captureDir_, ec);
        if (ec)
        {
            ShowErrorFmt("PacketCap: Failed to create directory {}: {}", captureDir_, ec.message());
            return;
        }

        ShowInfoFmt("PacketCap module loaded (dir: {})", captureDir_);
    }

    void OnCharZoneIn(CCharEntity* PChar) override
    {
        if (!PChar)
        {
            return;
        }

        if (PChar->getCharVar("PacketCap") == 1)
        {
            auto now      = std::chrono::floor<std::chrono::seconds>(std::chrono::system_clock::now());
            auto filename = fmt::format("{}/{}_{:%Y%m%d_%H%M%S}.cap", captureDir_, PChar->id, now);
            auto file     = std::make_unique<std::ofstream>(filename, std::ios::binary);

            if (!file->is_open())
            {
                ShowWarningFmt("PacketCap: Failed to open {} for {} ({})", filename, PChar->getName(), PChar->id);
                return;
            }

            captureFiles_[PChar->id] = { filename, std::move(file) };
            ShowInfoFmt("PacketCap: Enabled capture for {} ({}) -> {}", PChar->getName(), PChar->id, filename);
        }
    }

    void OnCharZoneOut(CCharEntity* PChar) override
    {
        if (!PChar)
        {
            return;
        }

        if (const auto it = captureFiles_.find(PChar->id); it != captureFiles_.end())
        {
            it->second.file->close();
            ShowInfoFmt("PacketCap: Disabled capture for {} ({}) -> {}", PChar->getName(), PChar->id, it->second.filename);
            captureFiles_.erase(it);
        }
    }

    void OnPushPacket(CCharEntity* PChar, const std::unique_ptr<CBasicPacket>& packet) override
    {
        if (!PChar)
        {
            return;
        }

        if (const auto it = captureFiles_.find(PChar->id); it != captureFiles_.end())
        {
            writePacket(*it->second.file, DIRECTION_S2C, *packet, packet->getSize());
        }
    }

    auto OnIncomingPacket(MapSession* session, CCharEntity* PChar, CBasicPacket& packet) -> bool override
    {
        if (!PChar)
        {
            return false;
        }

        if (const auto it = captureFiles_.find(PChar->id); it != captureFiles_.end())
        {
            writePacket(*it->second.file, DIRECTION_C2S, packet, packet.getSize());
        }

        return false;
    }

private:
    struct CaptureFile
    {
        std::string                    filename;
        std::unique_ptr<std::ofstream> file;
    };

    std::string                             captureDir_;
    std::unordered_map<uint32, CaptureFile> captureFiles_;

    static void writePacket(std::ofstream& file, const uint8 direction, const uint8* data, const std::size_t size)
    {
        const auto   now        = std::chrono::system_clock::now();
        const uint64 timestamp  = std::chrono::duration_cast<std::chrono::milliseconds>(now.time_since_epoch()).count();
        const uint16 packetSize = static_cast<uint16>(size);

        file.write(reinterpret_cast<const char*>(&direction), 1);
        file.write(reinterpret_cast<const char*>(&timestamp), 8);
        file.write(reinterpret_cast<const char*>(&packetSize), 2);
        file.write(reinterpret_cast<const char*>(data), size);
    }
};

REGISTER_CPP_MODULE(PacketCapModule);
