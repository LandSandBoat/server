#include "../src/map/utils/moduleutils.h"
#include "../src/map/zone.h"

/*
-- Example client addon for renaming entities with custom packets

local registry = {}

local function split(str, ch)
    local outTable = {}
    for word in string.gmatch(str, '([^' .. ch .. ']+)') do
        table.insert(outTable, word)
    end
    return outTable
end

local function getZoneId()
    if windower then return windower.ffxi.get_info().zone end
    if ashita then return AshitaCore:GetDataManager():GetParty():GetMemberZone(0) end
end

local function setMobName(id, name)
    local targid = bit.band(id, 0x0FFF)
    if windower then windower.set_mob_name(id, name) end
    if ashita then AshitaCore:GetDataManager():GetEntity():SetName(targid, name) end
end

local function askForList()
    local zoneId = getZoneId()

    registry = registry or {}
    registry[zoneId] = registry[zoneId] or {}

    if #registry[zoneId] == 0 then
        print("Asking for zone's renamer list")
        if windower then windower.packets.inject_outgoing(0x01, "CCCC":pack(0x01, 0x04, 0x00, 0x00)) end
        if ashita then AddOutgoingPacket(0x01, { 0x01, 0x04, 0x00, 0x00 }) end
    end
end

local function handleList(id, data)
    if id == 0x1FF then
        local zoneId = getZoneId()
        if registry[zoneId] == nil then
            registry[zoneId] = {}
        end

        local outString = ""
        for i = 5, #data do
            local c = data[i]
            outString = outString .. c
        end

        local entries = split(outString, '.')
        for _, entry in pairs(entries) do
            local parts = split(entry, ',')

            -- Transform back into full ID
            local targid = tonumber(parts[1])
            local name = parts[2]
            if targid and name then
                local fullid = 0x1000000 + bit.lshift(zoneId, 12) + targid
                registry[zoneId][fullid] = name
            end
        end
    end
end

local function render()
    local zoneId = getZoneId()
    if registry[zoneId] then
        for k, v in pairs(registry[zoneId]) do
            if k and v then
                setMobName(k, v)
            end
        end
    end
end

if windower then
    windower.register_event('load', function() askForList() end)
    windower.register_event('zone change', function() askForList() end)
    windower.register_event('incoming chunk', function(id, data) if id == 0x1FF then handleList(id, data) end end)
    windower.register_event("prerender", function() render() end)
end -- windower

if ashita then
    ashita.register_event('load', function() askForList() end)
    ashita.register_event('outgoing_packet', function(id, _, packet) if id == 0x011 then askForList() end end)
    ashita.register_event('incoming_packet', function(id, _, packet) if id == 0x1FF then handleList(id, packet) end end)
    ashita.register_event("prerender", function() render() end)
end --ashita

*/

extern uint8 PacketSize[512];
extern std::function<void(map_session_data_t* const, CCharEntity* const, CBasicPacket)> PacketParser[512];

class RenamerModule : public CPPModule
{
    static void SendListPacket(CCharEntity* PChar, std::string const& data)
    {
        if (data.empty())
        {
            // Nothing to do, bail out
            return;
        }

        auto* customPacket = new CBasicPacket();
        customPacket->setType(0x1FF);
        customPacket->setSize(0x100);
        for (std::size_t i = 0; i < data.size(); ++i)
        {
            customPacket->ref<uint8>(0x04 + i) = data[i];
        }
        PChar->pushPacket(customPacket);
    }

    static void Handle0x01Packet(map_session_data_t* const, CCharEntity* const PChar, CBasicPacket)
    {
        ShowInfo(fmt::format("{} requested renamer list for {}", PChar->GetName(), PChar->loc.zone->GetName()));

        auto zoneId = PChar->getZone();
        auto zoneTable = luautils::lua["xi"]["renamerTable"].get<sol::table>()[zoneId].get<sol::table>();

        std::string dataString;
        for (auto [key, value] : zoneTable)
        {
            auto entryTable = value.as<sol::table>();

            // convert entityId to targid
            auto entityId = entryTable[1].get<uint32>();
            auto targid = entityId - 0x1000000 - (zoneId << 12);
            auto entityName = entryTable[2].get<std::string>();
            auto packedString = fmt::format("{},{}.", targid, entityName);

            // If the dataString gets too large, send a packet with what we've
            // already prepared so we don't exceed the target size of 0x100.
            if (0x04 + dataString.size() + packedString.size() > 0x100)
            {
                SendListPacket(PChar, dataString);
                dataString.clear();
            }
            else
            {
                dataString += packedString;
            }
        }

        SendListPacket(PChar, dataString);
    }

    void OnInit() override
    {
        TracyZoneScoped;

        ShowInfo("Renamer: Loading ./modules/renamer/lua/list.lua");

        auto result = lua.safe_script_file("./modules/renamer/lua/list.lua");
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("Load error: %s", err.what());
            return;
        }

        if (!result.return_count())
        {
            ShowError("No returned renamer list object");
            return;
        }

        // NOTE: If we don't attach the result to something global, it will not be
        //     : correclty captured by the packet handling lambda.
        lua[sol::create_if_nil]["xi"]["renamerTable"] = result;

        // Add a custom packet handler to the PacketParser array for id 0x01
        PacketParser[0x01] = Handle0x01Packet;
    }
};

REGISTER_CPP_MODULE(RenamerModule);
