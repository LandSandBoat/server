/************************************************************************
 * Delivery Box Anywhere
 *
 * Allows players to use the delivery/post system in zones that normally
 * disallow it, when `map.POST_ENABLED_ANYWHERE` is enabled.
 ************************************************************************/

#include "map/utils/moduleutils.h"

#include "map/packets/c2s/0x04d_pbx.h"
#include "map/utils/zoneutils.h"
#include "map/zone.h"

class PostAnywhereModule : public CPPModule
{
    void OnInit() override
    {
        enabled_ = settings::get<bool>("map.POST_ENABLED_ANYWHERE");

        if (enabled_)
        {
            ShowInfo("[POST ANYWHERE] Enabled: delivery box can be used outside normal zones.");
        }
        else
        {
            ShowInfo("[POST ANYWHERE] Disabled.");
        }
    }

    auto OnIncomingPacket(MapSession* session, CCharEntity* PChar, CBasicPacket& packet) -> bool override
    {
        if (!enabled_ || packet.getType() != 0x04D)
        {
            return false;
        }

        // In allowed zones, keep original processing path unchanged.
        if (zoneutils::IsResidentialArea(PChar) || PChar->m_GMlevel > 0 || PChar->loc.zone->CanUseMisc(MISC_AH) || PChar->loc.zone->CanUseMisc(MISC_MOGMENU))
        {
            return false;
        }

        // Reuse stock packet logic by temporarily passing the GM zone gate.
        const auto originalGMLevel = PChar->m_GMlevel;
        PChar->m_GMlevel           = 1;
        packet.as<GP_CLI_COMMAND_PBX>()->process(session, PChar);
        PChar->m_GMlevel = originalGMLevel;

        return true;
    }

    bool enabled_{ false };
};

REGISTER_CPP_MODULE(PostAnywhereModule);
