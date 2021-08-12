#include "testutils.h"

#include "../entities/charentity.h"
#include "../entities/dummyentity.h"

#include "../utils/charutils.h"

#include "../ai/ai_container.h"
#include "../ai/helpers/pathfind.h"

#include "../ext/spdlog/include/spdlog/fmt/bundled/core.h"

namespace testutils
{
    void createDummy(CCharEntity* PChar)
    {
        auto* PZone = PChar->loc.zone;

        auto* PDummy = new CDummyEntity(PChar);

        uint32 charsInZone = 0;
        PZone->ForEachChar([&](CCharEntity*) { ++charsInZone; });
        PDummy->id = charsInZone + 1;

        PDummy->look.face = 30; // Mannequin
        PDummy->look.race = xirand::GetRandomNumber(0, 8);
        PDummy->look.size = xirand::GetRandomNumber(0, 3);

        PDummy->SetName((int8*)fmt::format("Dummy-{}", PDummy->id).data());

        PZone->IncreaseZoneCounter(PDummy);
        PDummy->Spawn();

        PDummy->status = STATUS_TYPE::NORMAL;

        auto pos = PZone->m_navMesh->findRandomPosition(PChar->loc.p, 15.0f);

        PDummy->loc.p.x = pos.second.x;
        PDummy->loc.p.y = pos.second.y;
        PDummy->loc.p.z = pos.second.z;

        PDummy->loc.p.moving = PChar->loc.p.moving;
        PDummy->loc.p.rotation = PChar->loc.p.rotation + xirand::GetRandomNumber(0, 255);

        PDummy->m_TargID = 0;

        PDummy->updatemask |= UPDATE_ALL_CHAR;

        PDummy->loc.zone->SpawnPCs(PDummy);
        PDummy->loc.zone->SpawnNPCs(PDummy);
        PDummy->loc.zone->SpawnMOBs(PDummy);
        PDummy->loc.zone->SpawnPETs(PDummy);
        PDummy->loc.zone->SpawnTRUSTs(PDummy);

        PDummy->nameflags.flags = PChar->nameflags.flags;
        PDummy->animation       = ANIMATION_NONE;

        PDummy->SetMJob(PChar->GetMJob());
        PDummy->SetSJob(PChar->GetSJob());
        PDummy->SetMLevel(PChar->GetMLevel());
        PDummy->SetSLevel(PChar->GetSLevel());

        PDummy->health.maxhp = 1000;
        PDummy->health.maxmp = 1000;
        PDummy->health.hp    = PDummy->GetMaxHP();
        PDummy->health.mp    = PDummy->GetMaxMP();
        PDummy->UpdateHealth();
    }
}; // namespace testutils
