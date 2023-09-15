#ifndef SERVER_BESIEGED_DATA_H
#define SERVER_BESIEGED_DATA_H

#include "common/cbasetypes.h"
#include "common/sql.h"

enum BESIEGED_STRONGHOLD
{
    ALZAHBI  = 0,
    MAMOOK   = 1,
    HALVUNG  = 2,
    ARRAPAGO = 3,
};

enum ALZHABI_BESIEGED_ORDERS
{
    DEFENSE    = 0x00,
    INTERCEPT  = 0x01,
    INFILTRATE = 0x02,
};

enum BEASTMEN_BESIEGED_ORDERS
{
    TRAIN   = 0x00,
    ADVANCE = 0x01,
    ATTACK  = 0x02,
    RETREAT = 0x03,
    DEFEND  = 0x04,
    PREPARE = 0x05,
};

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

struct stronghold_info_t
{
    BEASTMEN_BESIEGED_ORDERS orders;
    STRONGHOLD_LEVEL         stronghold_level;
    uint8                    forces;
    uint8                    mirrors;
    uint8                    prisoners;
    bool                     ownsAstralCandescence;
};

/**
 * Besieged Data that is cached by the map server. This data is used to avoid redundant DB reads.
 * Besieged data should be updated periodically by the world server. This data is also updated
 * with specific events (i.e: Stronghold leader defeated)
 */
class BesiegedData
{
public:
    BesiegedData(std::unique_ptr<SqlConnection>& sql);

    /**
     * Returns the current owner of the Astral Candescence.
     */
    BESIEGED_STRONGHOLD getAstralCandescenceOwner();

    /**
     * Returns the current orders for Al Zahbi.
     */
    ALZHABI_BESIEGED_ORDERS getAlZhabiOrders();

    /**
     * Returns the stronghold info for a given stronghold.
     */
    stronghold_info_t getStrongholdInfo(BESIEGED_STRONGHOLD stronghold);

    /**
     * Updates the stonghold cache with the given stronghold data.
     * Should only be called by besieged system, as a result of a world server update.
     */
    void updateStrongholdInfos(std::vector<stronghold_info_t> const& updatedStrongholdInfos);

private:
    std::vector<stronghold_info_t> strongholdInfos;

    /**
     * Loads the latest besieged data from DB.
     * Should only ever be done on construction.
     * World server should be updating besieged data periodically.
     */
    void load(std::unique_ptr<SqlConnection>& sql);
};

#endif // SERVER_BESIEGED_DATA_H
