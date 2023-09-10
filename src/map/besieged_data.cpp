#include "besieged_data.h"

#include "common/settings.h"

BesiegedData::BesiegedData(std::unique_ptr<SqlConnection>& sql)
: strongholdInfos(std::vector<stronghold_info_t>(4))
{
    load(sql);
}

void BesiegedData::load(std::unique_ptr<SqlConnection>& sql)
{
    const char* Query = "SELECT stronghold_id, orders, stronghold_level, forces, prisoners, owns_astral_candescence, \
                        (SELECT COUNT(*) FROM besieged_mirrors WHERE destroyed = 0 AND besieged_mirrors.stronghold_id = besieged_strongholds.stronghold_id) AS mirrors \
                        FROM besieged_strongholds;";
    int32       ret   = sql->Query(Query);

    if (ret != SQL_ERROR && sql->NumRows() != 0)
    {
        while (sql->NextRow() == SQL_SUCCESS)
        {
            uint8 strongholdId = sql->GetUIntData(0);
            if (strongholdId > 3)
            {
                ShowError("Invalid stronghold id %d", strongholdId);
                throw std::runtime_error("Besieged stronghold id out of range");
            }

            stronghold_info_t strongholdInfo;
            strongholdInfo.orders                = sql->GetUIntData<BEASTMEN_BESIEGED_ORDERS>(1);
            strongholdInfo.stronghold_level      = sql->GetUIntData<STRONGHOLD_LEVEL>(2);
            strongholdInfo.forces                = sql->GetUIntData(3);
            strongholdInfo.prisoners             = sql->GetUIntData(4);
            strongholdInfo.ownsAstralCandescence = sql->GetUIntData(5);
            strongholdInfo.mirrors               = sql->GetUIntData(6);

            strongholdInfos[sql->GetUIntData(0)] = strongholdInfo;
        }
    }

    if (settings::get<bool>("logging.DEBUG_BESIEGED"))
    {
        ShowInfo("Loading besieged Stronghold Data:");
        for (uint8 strongholdId = 0; strongholdId < strongholdInfos.size(); strongholdId++)
        {
            stronghold_info_t strongholdInfo = strongholdInfos[strongholdId];
            ShowInfo("Stronghold %d: Orders %d, Level %d, Forces %d, Mirrors %d, Prisoners %d, Owns Astral Candescence %d",
                     strongholdId, strongholdInfo.orders, strongholdInfo.stronghold_level, strongholdInfo.forces, strongholdInfo.mirrors, strongholdInfo.prisoners, strongholdInfo.ownsAstralCandescence);
        }
    }
}

BESIEGED_STRONGHOLD BesiegedData::getAstralCandescenceOwner()
{
    for (uint8 strongholdId = 0; strongholdId < strongholdInfos.size(); strongholdId++)
    {
        if (strongholdInfos[strongholdId].ownsAstralCandescence)
        {
            return static_cast<BESIEGED_STRONGHOLD>(strongholdId);
        }
    }

    ShowError("No stronghold owns the Astral Candescence");
    return BESIEGED_STRONGHOLD::ALZAHBI;
}

ALZHABI_BESIEGED_ORDERS BesiegedData::getAlZhabiOrders()
{
    return static_cast<ALZHABI_BESIEGED_ORDERS>(strongholdInfos[BESIEGED_STRONGHOLD::ALZAHBI].orders);
}

stronghold_info_t BesiegedData::getStrongholdInfo(BESIEGED_STRONGHOLD stronghold)
{
    if ((uint8)stronghold > strongholdInfos.size())
    {
        ShowError("Invalid stronghold id %d", stronghold);
        throw std::runtime_error("Besieged stronghold id out of range");
    }

    return strongholdInfos[stronghold];
}

void BesiegedData::updateStrongholdInfos(std::vector<stronghold_info_t> const& updatedStrongholdInfos)
{
    strongholdInfos.clear();
    for (const auto& info : updatedStrongholdInfos)
    {
        strongholdInfos.push_back(info);
    }
}
