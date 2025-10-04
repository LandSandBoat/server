//
// ExampleModule
//
//   An example C++ module to demonstrate how to build and register a C++ module.
//

#include "map/utils/moduleutils.h"

class ExampleModule : public CPPModule
{
public:
    //
    // Required
    //

    void OnInit() override;

    //
    // Optional
    //

    void OnZoneTick(CZone* PZone) override;
    void OnTimeServerTick() override;
    void OnCharZoneIn(CCharEntity* PChar) override;
    void OnCharZoneOut(CCharEntity* PChar) override;
    void OnPushPacket(CCharEntity* PChar, const std::unique_ptr<CBasicPacket>& packet) override;
    auto OnIncomingPacket(MapSession* session, CCharEntity* PChar, CBasicPacket& packet) override -> bool;

private:
    //
    // Add any private members or methods here
    //
};

void ExampleModule::OnInit()
{
}

void ExampleModule::OnZoneTick(CZone* PZone)
{
}

void ExampleModule::OnTimeServerTick()
{
}

void ExampleModule::OnCharZoneIn(CCharEntity* PChar)
{
}

void ExampleModule::OnCharZoneOut(CCharEntity* PChar)
{
}

void ExampleModule::OnPushPacket(CCharEntity* PChar, const std::unique_ptr<CBasicPacket>& packet)
{
}

auto ExampleModule::OnIncomingPacket(MapSession* session, CCharEntity* PChar, CBasicPacket& packet) -> bool
{
    return false;
}

REGISTER_CPP_MODULE(ExampleModule);
