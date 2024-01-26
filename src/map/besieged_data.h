#ifndef SERVER_BESIEGED_DATA_H
#define SERVER_BESIEGED_DATA_H

#include "common/cbasetypes.h"
#include "common/settings.h"
#include "common/sql.h"

/**
 * besieged_data.h contains full implementations to avoid having to move
 * the files to common.
 */

enum BESIEGED_STRONGHOLD
{
    ALZAHBI  = 0,
    MAMOOK   = 1,
    HALVUNG  = 2,
    ARRAPAGO = 3,
};
DECLARE_FORMAT_AS_UNDERLYING(BESIEGED_STRONGHOLD);

enum ALZHABI_BESIEGED_ORDERS
{
    DEFENSE    = 0x00,
    INTERCEPT  = 0x01,
    INFILTRATE = 0x02,
};
DECLARE_FORMAT_AS_UNDERLYING(ALZHABI_BESIEGED_ORDERS);

enum BEASTMEN_BESIEGED_ORDERS
{
    TRAIN   = 0x00,
    ADVANCE = 0x01,
    ATTACK  = 0x02,
    RETREAT = 0x03,
    DEFEND  = 0x04,
    PREPARE = 0x05,
};
DECLARE_FORMAT_AS_UNDERLYING(BEASTMEN_BESIEGED_ORDERS);

enum STRONGHOLD_LEVEL
{
    LEVEL0,
    LEVEL1,
    LEVEL2,
    LEVEL3,
    LEVEL4,
    LEVEL5,
    LEVEL6,
    LEVEL7,
    LEVEL8,
};
DECLARE_FORMAT_AS_UNDERLYING(STRONGHOLD_LEVEL);

/**
 * stronghold_info_t provides information about alzhabi and beastmen stronghold state.
 * Alzhabi state is a bit of an edge case, and is abstracted via the
 * BesiegedData class.
 */
struct stronghold_info_t
{
    BESIEGED_STRONGHOLD strongholdId;
    /**
     * The orders for this stronghold.
     * These orders define the current state of the stronghold.
     */
    BEASTMEN_BESIEGED_ORDERS orders;
    /**
     * The level of this stronghold. Strongholds can grow from 0 to a max of 8.
     */
    STRONGHOLD_LEVEL strongholdLevel;
    /**
     * The number of forces this stronghold has
     * Forces can grow from 0 to a max of 100 + [10 * the number of times it was consecutively defeated]
     * to a maximum of 200.
     */
    float forces;
    /**
     * The number of mirrors owned. 8 is the maximum amount of mirrors
     * a stronghold can have.
     */
    uint8 mirrors;
    /**
     * The number of prisoners captured. Though a stronghold can hold up to 24 prisoners,
     * the maximum number of prisoners that can be captured is 8.
     */
    uint8 prisoners;
    /**
     * The number of times this stronghold has been consecutively defeated.
     */
    uint32 consecutiveDefeats;
    /**
     * Whether or not this stronghold owns the Astral Candescence.
     */
    bool ownsAstralCandescence;
};

/** Serialization static methods */

/**
 * Besieged Data that is cached by the map server. This data is used to avoid redundant DB reads.
 * Besieged data should be updated periodically by the world server. This data is also updated
 * with specific events (i.e: Stronghold leader defeated)
 */
class BesiegedData
{
public:
    BesiegedData(std::unique_ptr<SqlConnection>& sql)
    : strongholdInfos(std::vector<stronghold_info_t>(4))
    {
        load(sql);
    }

    /**
     * Returns the current owner of the Astral Candescence.
     */
    BESIEGED_STRONGHOLD getAstralCandescenceOwner() const
    {
        for (auto strongholdInfo : strongholdInfos)
        {
            if (strongholdInfo.ownsAstralCandescence)
            {
                return strongholdInfo.strongholdId;
            }
        }

        ShowError("No stronghold owns the Astral Candescence");
        return BESIEGED_STRONGHOLD::ALZAHBI;
    }

    /**
     * Returns the current orders for Al Zahbi.
     */
    ALZHABI_BESIEGED_ORDERS getAlZhabiOrders() const
    {
        // Implementation detail: For alzhabi, we can cast the orders field to ALZHABI_BESIEGED_ORDERS
        // This is fine because alzhabi order values are a subset of beastmen order values, and
        // should never change
        return static_cast<ALZHABI_BESIEGED_ORDERS>(strongholdInfos[BESIEGED_STRONGHOLD::ALZAHBI].orders);
    }

    /*
     * Returns the current defense level for Al Zahbi.
     * The higher the defense level, the more gates appear between Bastion
     * and other Al Zahbi areas during the besieged battle.
     * Captured from 0 to 116, but potentially higher.
     */
    uint8 getImperialDefenseLevel() const
    {
        // Implementation detail: For alzhabi, we use the forces field to represent imperial defense level
        return strongholdInfos[BESIEGED_STRONGHOLD::ALZAHBI].forces;
    }

    /**
     * Returns the stronghold info for a given stronghold.
     * For Alzhabi stronghold info, use getAlZhabiOrders() and getImperialDefenseLevel().
     */
    stronghold_info_t getBeastmenStrongholdInfo(BESIEGED_STRONGHOLD stronghold) const
    {
        if (stronghold == BESIEGED_STRONGHOLD::ALZAHBI)
        {
            ShowError("getBeastmenStrongholdInfo called with Al Zahbi stronghold id");
            throw std::runtime_error("Al Zahbi is not a beastmen stronghold");
        }

        if ((uint8)stronghold >= strongholdInfos.size())
        {
            ShowError("Invalid stronghold id %d", stronghold);
            throw std::runtime_error("Besieged stronghold id out of range");
        }

        return strongholdInfos[stronghold];
    }

    /**
     * Returns a vector with all the stronghold infos.
     * This includes AlZhabi info.
     * Should only be called by world server to send the stronghold data to the map servers.
     */
    auto getStrongholdInfos() const -> std::vector<stronghold_info_t> const
    {
        return strongholdInfos;
    }

    /**
     * Updates the stonghold cache with the given stronghold data.
     * Should only be called by map besieged system, as a result of a world server update.
     */
    void updateStrongholdInfos(std::vector<stronghold_info_t> const& updatedStrongholdInfos)
    {
        strongholdInfos.clear();
        for (const auto& info : updatedStrongholdInfos)
        {
            strongholdInfos.push_back(info);
        }
    }

    /**
     * Updates the stonghold cache with the given stronghold data.
     * This is called for individual updates to stronghold data, from world server.
     */
    void updateStrongholdInfo(stronghold_info_t const& strongholdInfo)
    {
        if ((size_t)strongholdInfo.strongholdId >= strongholdInfos.size())
        {
            ShowError("updateStrongholdInfo() called with invalid stronghold id %d", strongholdInfo.strongholdId);
            throw std::runtime_error("Besieged stronghold id out of range");
        }

        strongholdInfos[strongholdInfo.strongholdId] = strongholdInfo;
    }

    /**
     * Commits the besieged data to the DB.
     * This should only ever be used by world server. Maps should not be updating DB.
     */
    void commit(std::unique_ptr<SqlConnection>& sql)
    {
        // For now, we always commit all stronghold data, without marking certain strongholds as dirty.
        // There are only 4 rows, and likely will never be more.
        const char* query = "UPDATE besieged_strongholds SET orders = %d, stronghold_level = %d, forces = %f, \
                             prisoners = %d, owns_astral_candescence = %d, consecutive_defeats = %d WHERE stronghold_id = %d;";

        for (auto strongholdInfo : strongholdInfos)
        {
            int32 ret = sql->Query(query, strongholdInfo.orders, strongholdInfo.strongholdLevel, strongholdInfo.forces,
                                   strongholdInfo.prisoners, strongholdInfo.ownsAstralCandescence, strongholdInfo.consecutiveDefeats,
                                   strongholdInfo.strongholdId);

            if (ret == SQL_ERROR)
            {
                ShowError("Failed to update stronghold info for stronghold %d", strongholdInfo.strongholdId);
            }
        }
    }

    /**
     * Returns a string representation of the besieged data, for logging purposes.
     */
    auto getFormattedData() const -> std::vector<std::string> const
    {
        std::vector<std::string> lines;
        for (auto strongholdInfo : strongholdInfos)
        {
            auto strongholdData = fmt::format("Stronghold {}: Orders {}, Level {}, Forces {}, Mirrors {}, Prisoners {}, Owns Astral Candescence {}, Consecutive Defeats {}",
                                              strongholdInfo.strongholdId, strongholdInfo.orders, strongholdInfo.strongholdLevel, strongholdInfo.forces,
                                              strongholdInfo.mirrors, strongholdInfo.prisoners, strongholdInfo.ownsAstralCandescence, strongholdInfo.consecutiveDefeats);

            lines.push_back(strongholdData);
        }

        return lines;
    }

private:
    std::vector<stronghold_info_t> strongholdInfos;

    /**
     * Loads the latest besieged data from DB.
     * Should only ever be done on construction.
     * World server should be updating besieged data periodically.
     */
    void load(std::unique_ptr<SqlConnection>& sql)
    {
        const char* Query = "SELECT stronghold_id, orders, stronghold_level, forces, prisoners, owns_astral_candescence, consecutive_defeats, \
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
                    throw std::runtime_error("Besieged stronghold id out of range when loading from DB");
                }

                stronghold_info_t strongholdInfo;
                strongholdInfo.strongholdId          = sql->GetUIntData<BESIEGED_STRONGHOLD>(0);
                strongholdInfo.orders                = sql->GetUIntData<BEASTMEN_BESIEGED_ORDERS>(1);
                strongholdInfo.strongholdLevel       = sql->GetUIntData<STRONGHOLD_LEVEL>(2);
                strongholdInfo.forces                = sql->GetFloatData(3);
                strongholdInfo.prisoners             = sql->GetUIntData(4);
                strongholdInfo.ownsAstralCandescence = sql->GetUIntData(5);
                strongholdInfo.consecutiveDefeats    = sql->GetUIntData(6);
                strongholdInfo.mirrors               = sql->GetUIntData(7);

                strongholdInfos[sql->GetUIntData(0)] = strongholdInfo;
            }
        }

        DebugBesieged("Loading besieged Stronghold Data:");
        for (auto line : getFormattedData())
        {
            DebugBesieged(line);
        }
    }
};

#endif // SERVER_BESIEGED_DATA_H
