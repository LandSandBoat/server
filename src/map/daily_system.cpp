/*
===========================================================================

Copyright (c) 2022 LandSandBoat Dev Teams

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

    // clang-format off
    std::vector<uint16> gobbieJunk =
    {
        2542, // Goblin Mess Tin
        2543, // Goblin Weel
        4324, // Hobgoblin Chocolate
        4325, // Hobgoblin Pie
        4328, // Hobgoblin Bread
        4458, // Goblin Bread
        4495, // Goblin Chocolate
        4539  // Goblin Pie
    };
    // clang-format on

    uint16 SelectItem(CCharEntity* player, uint8 dial)
    {
        std::vector<uint16>* dialItems = &gobbieJunk;
        switch (dial)
        {
            case 1:
            {
                dialItems = &materialsDialItems;
                break;
            }
            case 2:
            {
                dialItems = &foodDialItems;
                break;
            }
            case 3:
            {
                dialItems = &medicineDialItems;
                break;
            }
            case 4:
            {
                dialItems = &sundries1DialItems;
                break;
            }
            case 5:
            {
                dialItems = &sundries2DialItems;
                break;
            }
            case 6:
            {
                dialItems = &specialDialItems;
                break;
            }
        }
        uint16 selection = xirand::GetRandomElement(dialItems);

        // Check if Rare item is already owned and substitute with Goblin trash item.
        if ((itemutils::GetItem(selection)->getFlag() & ITEM_FLAG_RARE) > 0 && charutils::HasItem(player, selection))
        {
            dialItems = &gobbieJunk;
            selection = xirand::GetRandomElement(dialItems);
        }

        return selection;
    }

    void LoadDailyItems()
    {
        int32  ret    = _sql->Query("SELECT itemid, aH, flags FROM item_basic WHERE flags & 4 > 0");
        uint16 itemid = 0;
        uint16 aH     = 0;
        uint16 flags  = 0;

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                itemid = _sql->GetUIntData(0);
                aH     = _sql->GetUIntData(1);
                flags  = _sql->GetUIntData(2);
                specialDialItems.emplace_back(itemid);
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
                        materialsDialItems.emplace_back(itemid);
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
                        foodDialItems.emplace_back(itemid);
                        break;
                    }
                    /* Dial 3 (Medicine) */
                    case 33: // Medicine
                    {
                        medicineDialItems.emplace_back(itemid);
                        break;
                    }
                    /* Dial 4 (Sundries 1) */
                    case 15: // Ammunition
                    case 36: // Cards
                    case 49: // Ninja Tools
                    {
                        if ((flags & ITEM_FLAG_CANUSE) > 0) // only usable (pouch, case, quiver, etc)
                        {
                            sundries1DialItems.emplace_back(itemid);
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
                        sundries2DialItems.emplace_back(itemid);
                        break;
                    }
                    default:
                    {
                        switch (itemid)
                        {
                            case 605:   // pickaxe
                            case 1020:  // sickle
                            case 1021:  // hatchet
                            case 1022:  // thief's tools
                            case 1023:  // living key
                            case 15453: // lugworm belt
                            case 15454: // little worm belt
                            {
                                sundries2DialItems.emplace_back(itemid);
                                break;
                            }
                        }
                    }
                }
            }
        }
        else
        {
            ShowError("Failed to load daily tally items");
        }
    }
} // namespace daily
