#include "daily_system.h"
#include "items/item.h"
#include "utils/charutils.h"
#include "utils/itemutils.h"

namespace daily
{
    std::vector<uint16> materialsDialItems;
    std::vector<uint16> foodDialItems;
    std::vector<uint16> medicineDialItems;
    std::vector<uint16> sundries1DialItems;
    std::vector<uint16> sundries2DialItems;
    std::vector<uint16> specialDialItems;

    uint16 SelectItem(CCharEntity* player, uint8 dial)
    {
        int selection;
        std::vector<uint16> dialItems;
        switch (dial)
        {
            case 1:
            {
                dialItems = materialsDialItems;
                break;
            }
            case 2:
            {
                dialItems = foodDialItems;
                break;
            }
            case 3:
            {
                dialItems = medicineDialItems;
                break;
            }
            case 4:
            {
                dialItems = sundries1DialItems;
                break;
            }
            case 5:
            {
                dialItems = sundries2DialItems;
                break;
            }
            case 6:
            {
                dialItems = specialDialItems;
                break;
            }
        }
        do
        {
            selection = std::rand() % dialItems.size();
        } while ((itemutils::GetItem(dialItems[selection])->getFlag() & ITEM_FLAG_RARE) > 0 && charutils::HasItem(player, dialItems[selection]));
        return dialItems[selection];
    }

    void LoadDailyItems()
    {
        int32 ret = Sql_Query(SqlHandle, "SELECT itemid, aH, flags FROM item_basic WHERE flags & 4 > 0");
        uint16 itemid, aH, flags;

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                itemid = Sql_GetUIntData(SqlHandle,0);
                aH = Sql_GetUIntData(SqlHandle,1);
                flags = Sql_GetUIntData(SqlHandle,2);
                specialDialItems.push_back(itemid);
                switch (aH)
                {
                    /* Dial 1 (Materials) */
                    case 38: // Smithing
                    case 39: // Goldsmithing
                    case 40: // Clothcrafting
                    case 41: // Leathercrafting
                    case 42: // Bonecrafting
                    case 43: // Woodworking
                    case 44: // Alchemy
                    case 50: // Beast-Made
                    {
                        materialsDialItems.push_back(itemid);
                        break;
                    }
                    /* Dial 2 (Food) */
                    case 52: // Meat & Eggs
                    case 53: // Seafood
                    case 54: // Vegetables
                    case 55: // Soups
                    case 56: // Breads & Rice
                    case 57: // Sweets
                    case 58: // Drinks
                    {
                        foodDialItems.push_back(itemid);
                        break;
                    }
                    /* Dial 3 (Medicine) */
                    case 33: // Medicine
                    {
                        medicineDialItems.push_back(itemid);
                        break;
                    }
                    /* Dial 4 (Sundries 1) */
                    case 15: // Ammunition
                    case 36: // Cards
                    case 49: // Ninja Tools
                    {
                        if ((flags & ITEM_FLAG_CANUSE) > 0) // only usable (pouch, case, quiver, etc)
                        {
                            sundries1DialItems.push_back(itemid);
                        }
                        break;
                    }
                    /* Dial 5 (Sundries 2) */
                    case 47: // Fishing Gear
                    case 51: // Fish
                    {
                        if (itemid == 489 || itemid == 17386) // Lu Shang is probably only special dial
                        {
                            break;
                        }
                        sundries2DialItems.push_back(itemid);
                        break;
                    }
                    default:
                    {
                        switch (itemid)
                        {
                            case 605: // pickaxe
                            case 1020: // sickle
                            case 1021: // hatchet
                            case 1022: // thief's tools
                            case 1023: // living key
                            case 15453: // lugworm belt
                            case 15454: // little worm belt
                            {
                                sundries2DialItems.push_back(itemid);
                                break;
                            }
                        }
                    }
                }
            }
        }
        else
        {
            ShowError("Failed to load daily tally items\n");
        }
    }

    void UpdateDailyTallyPoints()
    {
        uint16 dailyTallyLimit  = map_config.daily_tally_limit;
        uint16 dailyTallyAmount = map_config.daily_tally_amount;

        const char* fmtQuery = "UPDATE char_points \
                SET char_points.daily_tally = LEAST(%u, char_points.daily_tally + %u) \
                WHERE char_points.daily_tally > -1;";

        int32 ret = Sql_Query(SqlHandle, fmtQuery, dailyTallyLimit, dailyTallyAmount);

        if (ret == SQL_ERROR)
        {
            ShowError("Failed to update daily tally points\n");
        }
        else
        {
            ShowDebug("Distributed daily tally points\n");
        }

        fmtQuery = "DELETE FROM char_vars WHERE varname = 'gobbieBoxUsed';";

        if (Sql_Query(SqlHandle, fmtQuery, dailyTallyAmount) == SQL_ERROR)
        {
            ShowError("Failed to delete daily tally char_vars entries");
        }
    }
}