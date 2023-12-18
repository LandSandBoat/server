/*
===========================================================================

  Copyright (c) 2010-2018 Darkstar Dev Teams

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

  This file is part of DarkStar-server source code.

===========================================================================
*/

#include "gardenutils.h"

#include "common/vana_time.h"

#include <cmath>

#include "entities/charentity.h"
#include "item_container.h"
#include "items/item_flowerpot.h"
#include "map.h"
#include "packets/inventory_item.h"

#define MAX_RESULTID 2500

constexpr uint32 VANADAY_SECONDS            = 3456;
constexpr uint32 VANADAYS_TO_WILT           = 36;
constexpr uint32 VANADAYS_TO_GUARANTEE_WILT = 144;
constexpr uint32 VANATIME_FOR_WILT_STAGE    = 65535 * VANADAY_SECONDS;

std::map<uint32, GardenResultList_t> g_pGardenResultMap; // global map of gardening results

GardenResult_t::GardenResult_t() = default;
GardenResult_t::GardenResult_t(uint16 ItemID, uint8 MinQuantity, uint8 MaxQuantity, uint8 Weight)
: ItemID(ItemID)
, MinQuantity(MinQuantity)
, MaxQuantity(MaxQuantity)
, Weight(Weight)
{
}

namespace gardenutils
{
    void LoadResultList()
    {
        int32 ret = _sql->Query("SELECT resultId, seed, element1, element2, result, min_quantity, max_quantity, weight FROM gardening_results");

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                uint8 SeedID   = (uint8)_sql->GetUIntData(1);
                uint8 Element1 = (uint8)_sql->GetUIntData(2);
                uint8 Element2 = (uint8)_sql->GetUIntData(3);

                uint32 uid = (SeedID << 8) + (Element1 << 4) + Element2;

                GardenResultList_t& resultList = g_pGardenResultMap[uid];

                uint16 ItemID      = (uint16)_sql->GetIntData(4);
                uint8  MinQuantity = (uint8)_sql->GetIntData(5);
                uint8  MaxQuantity = (uint8)_sql->GetIntData(6);
                uint8  Weight      = (uint8)_sql->GetIntData(7);
                resultList.emplace_back(ItemID, MinQuantity, MaxQuantity, Weight);
            }
        }
    }

    void Initialize()
    {
        LoadResultList();
    }

    void UpdateGardening(CCharEntity* PChar, bool sendPacket)
    {
        TracyZoneScoped;
        uint32 vanatime = CVanaTime::getInstance()->getVanaTime();
        for (auto containerID : { LOC_MOGSAFE, LOC_MOGSAFE2 })
        {
            CItemContainer* PContainer = PChar->getStorage(containerID);
            for (int slotID = 0; slotID < PContainer->GetSize(); ++slotID)
            {
                CItem* PItem = PContainer->GetItem(slotID);
                if (PItem != nullptr && PItem->isType(ITEM_FURNISHING))
                {
                    CItemFlowerpot* PPotItem = static_cast<CItemFlowerpot*>(PItem);
                    if (PPotItem != nullptr && PPotItem->canGrow() && vanatime >= PPotItem->getStageTimestamp())
                    {
                        uint8  stageDuration        = GetStageDuration(PPotItem);
                        uint32 daysSinceStageChange = (vanatime - PPotItem->getStageTimestamp()) / VANADAY_SECONDS;
                        uint8  wiltTime             = VANADAYS_TO_WILT + PChar->getMod(Mod::GARDENING_WILT_BONUS);
                        bool   wasExamined          = PPotItem->wasExamined();
                        if ((!wasExamined && (stageDuration > wiltTime || (stageDuration + daysSinceStageChange > wiltTime))) ||
                            daysSinceStageChange > VANADAYS_TO_GUARANTEE_WILT + wiltTime)
                        {
                            PPotItem->setStage(FLOWERPOT_STAGE_WILTED);
                            PPotItem->setStageTimestamp(vanatime + VANATIME_FOR_WILT_STAGE);
                        }
                        else
                        {
                            GrowToNextStage(PPotItem);
                        }

                        PPotItem->clearExamined();

                        char extra[sizeof(PItem->m_extra) * 2 + 1];
                        _sql->EscapeStringLen(extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));
                        const char* Query = "UPDATE char_inventory SET extra = '%s' WHERE charid = %u AND location = %u AND slot = %u";
                        _sql->Query(Query, extra, PChar->id, containerID, slotID);

                        if (sendPacket)
                        {
                            PChar->pushPacket(new CInventoryItemPacket(PPotItem, containerID, slotID));
                        }
                    }
                }
            }
        }
    }

    std::tuple<uint16, uint8> CalculateResults(CCharEntity* PChar, CItemFlowerpot* PItem)
    {
        std::array<uint8, 9> elements = { 0 };
        elements[PItem->getCommonCrystalFeed()] += 10;
        if (PItem->isTree())
        {
            elements[PItem->getExtraCrystalFeed()] += 10;
        }

        switch (PItem->getPlant())
        {
            case FLOWERPOT_PLANT_HERB_SEEDS:
                elements[FLOWERPOT_ELEMENT_WIND] += 10;
                break;
            case FLOWERPOT_PLANT_GRAIN_SEEDS:
                elements[FLOWERPOT_ELEMENT_FIRE] += 10;
                break;
            case FLOWERPOT_PLANT_VEGETABLE_SEEDS:
                elements[FLOWERPOT_ELEMENT_EARTH] += 10;
                break;
            case FLOWERPOT_PLANT_FRUIT_SEEDS:
                elements[FLOWERPOT_ELEMENT_WATER] += 10;
                break;
            case FLOWERPOT_PLANT_CACTUS_STEMS:
                elements[FLOWERPOT_ELEMENT_LIGHT] += 10;
                break;
            case FLOWERPOT_PLANT_TREE_CUTTINGS:
                elements[FLOWERPOT_ELEMENT_ICE] += 10;
                break;
            case FLOWERPOT_PLANT_TREE_SAPLINGS:
                elements[FLOWERPOT_ELEMENT_DARK] += 10;
                break;
            case FLOWERPOT_PLANT_WILDGRASS_SEEDS:
                elements[FLOWERPOT_ELEMENT_LIGHTNING] += 10;
                break;
            default:
                elements[FLOWERPOT_ELEMENT_NONE] += 10;
        }

        if (settings::get<bool>("map.GARDEN_DAY_MATTERS"))
        {
            uint32 vanaDate   = PItem->getPlantTimestamp();
            uint32 dayElement = ((vanaDate % VTIME_WEEK) / VTIME_DAY) + 1;
            elements[dayElement] += 10;
        }

        if (settings::get<bool>("map.GARDEN_POT_MATTERS"))
        {
            switch (PItem->getID())
            {
                case 216: // Porcelain Flowerpot
                    elements[FLOWERPOT_ELEMENT_WIND] += 10;
                    break;
                case 217: // Brass Flowerpot
                    elements[FLOWERPOT_ELEMENT_FIRE] += 10;
                    break;
                case 218: // Earthen Flowerpot
                    elements[FLOWERPOT_ELEMENT_EARTH] += 10;
                    break;
                case 219: // Ceramic Flowerpot
                    elements[FLOWERPOT_ELEMENT_WATER] += 10;
                    break;
                case 220: // Wooden Flowerpot
                    elements[FLOWERPOT_ELEMENT_LIGHT] += 10;
                    break;
                case 221: // Arcane Flowerpot
                    elements[FLOWERPOT_ELEMENT_DARK] += 10;
                    break;
                default:
                    break;
            }
        }

        int16 strength = 0;
        if (PItem->getCommonCrystalFeed() == FLOWERPOT_ELEMENT_NONE)
        {
            for (uint8 element : elements)
            {
                if (element > strength)
                {
                    strength = element;
                }
            }
        }
        else
        {
            strength = elements[PItem->getCommonCrystalFeed()];
        }
        if (PItem->isTree())
        {
            if (PItem->getExtraCrystalFeed() == FLOWERPOT_ELEMENT_NONE)
            {
                uint16 best = 0;
                for (uint8 element : elements)
                {
                    if (element > best)
                    {
                        best = element;
                    }
                }
                strength += best;
            }
            else
            {
                strength += elements[PItem->getExtraCrystalFeed()];
            }
        }

        if (settings::get<bool>("map.GARDEN_MOONPHASE_MATTERS"))
        {
            strength += (int16)std::ceil(CVanaTime::getInstance()->getMoonPhase() / 10.0f);
        }

        if (settings::get<bool>("map.GARDEN_MH_AURA_MATTERS"))
        {
            // Add up all of the installed furniture auras
            std::array<uint16, 8> auras = { 0 };
            for (auto containerID : { LOC_MOGSAFE, LOC_MOGSAFE2 })
            {
                CItemContainer* PContainer = PChar->getStorage(containerID);
                for (int slotID = 0; slotID < PContainer->GetSize(); ++slotID)
                {
                    CItem* PItemContained = PContainer->GetItem(slotID);
                    if (PItemContained != nullptr && PItemContained->isType(ITEM_FURNISHING))
                    {
                        auto PFurniture = dynamic_cast<CItemFurnishing*>(PItemContained);
                        if (PFurniture && PFurniture->isInstalled())
                        {
                            // -1 because element values range from 1-8
                            // Converts from lua 1 based index to c/c++ 0 based index
                            auras[PFurniture->getElement() - 1] += PFurniture->getAura();
                        }
                    }
                }
            }

            // Determine the dominant aura
            uint16 dominantAura = 0;
            for (uint8 elementID = 0; elementID < 8; ++elementID)
            {
                dominantAura = std::max(auras[elementID], dominantAura);
            }
            strength += dominantAura / 10;
        }

        strength += (int16)((100 - strength) * (PItem->getStrength() / 32.0f));

        uint32 resultUid = (PItem->getPlant() << 8) + (PItem->getCommonCrystalFeed() << 4) + PItem->getExtraCrystalFeed();

        GardenResult_t      item;
        int8                cumulativeWeight = 0;
        GardenResultList_t& resultList       = g_pGardenResultMap[resultUid];
        for (GardenResult_t& result : resultList)
        {
            cumulativeWeight += result.Weight;
            if (strength < cumulativeWeight)
            {
                item = result;
                break;
            }
        }
        if (item.ItemID == 0)
        {
            item = resultList.back();
        }

        // The percentage of strength between the item's minimum weight to maximum weight
        float percentage = (strength - (cumulativeWeight - item.Weight)) / float(item.Weight);
        // Split the quantity range n into n+1 evenly-distributed buckets across 0-100%. Yields of 20-35 is a range of 15 with 16 possible outcomes.
        // Ex. For a yield of 4-8 which has a range of 4 and a percentage p, it's split into 5 equal buckets:
        // 4 = p < 0.2
        // 5 = 0.2 <= p < 0.4
        // 6 = 0.4 <= p < 0.6
        // 7 = 0.6 <= p < 0.8
        // 8 = p >= 0.8
        // The final result is truncated instead of rounded, so only p>=1.0 will return a higher than maximum yield. It's special-cased to avoid this.
        const uint8 quantity = percentage >= 1.0f ? item.MaxQuantity : (item.MinQuantity + percentage * (1 + item.MaxQuantity - item.MinQuantity));

        return std::make_tuple(item.ItemID, quantity);
    }

    void GrowToNextStage(CItemFlowerpot* PItem, bool growFromFeed /*= false*/)
    {
        switch (PItem->getStage())
        {
            case FLOWERPOT_STAGE_EMPTY:
                PItem->setStage(FLOWERPOT_STAGE_INITIAL);
                break;
            case FLOWERPOT_STAGE_INITIAL:
                PItem->setStage(FLOWERPOT_STAGE_FIRST_SPROUTS);
                break;
            case FLOWERPOT_STAGE_FIRST_SPROUTS:
                if (PItem->isTree())
                {
                    PItem->setStage(FLOWERPOT_STAGE_FIRST_SPROUTS_2);
                }
                else
                {
                    PItem->setStage(FLOWERPOT_STAGE_SECOND_SPROUTS_2);
                }
                break;
            case FLOWERPOT_STAGE_FIRST_SPROUTS_2:
                PItem->setStage(FLOWERPOT_STAGE_FIRST_SPROUTS_CRYSTAL);
                break;
            case FLOWERPOT_STAGE_FIRST_SPROUTS_CRYSTAL:
                PItem->setStage(FLOWERPOT_STAGE_SECOND_SPROUTS);
                break;
            case FLOWERPOT_STAGE_SECOND_SPROUTS:
                PItem->setStage(FLOWERPOT_STAGE_SECOND_SPROUTS_2);
                break;
            case FLOWERPOT_STAGE_SECOND_SPROUTS_2:
                PItem->setStage(FLOWERPOT_STAGE_SECOND_SPROUTS_CRYSTAL);
                break;
            case FLOWERPOT_STAGE_SECOND_SPROUTS_CRYSTAL:
                PItem->setStage(FLOWERPOT_STAGE_SECOND_SPROUTS_3);
                break;
            case FLOWERPOT_STAGE_SECOND_SPROUTS_3:
                PItem->setStage(FLOWERPOT_STAGE_THIRD_SPROUTS);
                break;
            case FLOWERPOT_STAGE_THIRD_SPROUTS:
                PItem->setStage(FLOWERPOT_STAGE_MATURE_PLANT);
                break;
            case FLOWERPOT_STAGE_MATURE_PLANT:
            case FLOWERPOT_STAGE_WILTED:
            default:
                break;
        }

        PItem->setStageTimestamp(CVanaTime::getInstance()->getVanaTime() + GetStageDuration(PItem, growFromFeed) * VANADAY_SECONDS);
    }

    uint8 GetStageDuration(CItemFlowerpot* PItem, bool growFromFeed /*= false*/)
    {
        switch (PItem->getPlant())
        {
            case FLOWERPOT_PLANT_FRUIT_SEEDS:
                switch (PItem->getStage())
                {
                    case FLOWERPOT_STAGE_EMPTY:
                        return 1;
                    case FLOWERPOT_STAGE_INITIAL:
                        return 8;
                    case FLOWERPOT_STAGE_FIRST_SPROUTS:
                        return 10;
                    case FLOWERPOT_STAGE_FIRST_SPROUTS_2:
                        return 12;
                    case FLOWERPOT_STAGE_FIRST_SPROUTS_CRYSTAL:
                        return 50;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS:
                        return growFromFeed ? 18 : 4;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS_2:
                        return 14;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS_CRYSTAL:
                        return 52;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS_3:
                        return growFromFeed ? 16 : 4;
                    case FLOWERPOT_STAGE_THIRD_SPROUTS:
                        return 20;
                    case FLOWERPOT_STAGE_MATURE_PLANT:
                        return 187;
                    default:
                        break;
                }
                break;
            case FLOWERPOT_PLANT_HERB_SEEDS:
                switch (PItem->getStage())
                {
                    case FLOWERPOT_STAGE_INITIAL:
                        return 9;
                    case FLOWERPOT_STAGE_FIRST_SPROUTS:
                        return 4;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS_2:
                        return 12;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS_CRYSTAL:
                        return 50;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS_3:
                        return growFromFeed ? 24 : 4;
                    case FLOWERPOT_STAGE_THIRD_SPROUTS:
                        return 30;
                    case FLOWERPOT_STAGE_MATURE_PLANT:
                        return 187;
                    default:
                        break;
                }
                break;
            case FLOWERPOT_PLANT_GRAIN_SEEDS:
                switch (PItem->getStage())
                {
                    case FLOWERPOT_STAGE_INITIAL:
                        return 1;
                    case FLOWERPOT_STAGE_FIRST_SPROUTS:
                        return 2;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS_2:
                        return 6;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS_CRYSTAL:
                        return 62;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS_3:
                        return growFromFeed ? 24 : 4;
                    case FLOWERPOT_STAGE_THIRD_SPROUTS:
                        return 36;
                    case FLOWERPOT_STAGE_MATURE_PLANT:
                        return 187;
                    default:
                        break;
                }
                break;
            case FLOWERPOT_PLANT_VEGETABLE_SEEDS:
                switch (PItem->getStage())
                {
                    case FLOWERPOT_STAGE_INITIAL:
                        return 18;
                    case FLOWERPOT_STAGE_FIRST_SPROUTS:
                        return 4;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS_2:
                        return 2;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS_CRYSTAL:
                        return 56;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS_3:
                        return growFromFeed ? 16 : 1;
                    case FLOWERPOT_STAGE_THIRD_SPROUTS:
                        return 30;
                    case FLOWERPOT_STAGE_MATURE_PLANT:
                        return 187;
                    default:
                        break;
                }
                break;
            case FLOWERPOT_PLANT_CACTUS_STEMS:
                switch (PItem->getStage())
                {
                    case FLOWERPOT_STAGE_EMPTY:
                        return 18;
                    case FLOWERPOT_STAGE_INITIAL:
                        return 26;
                    case FLOWERPOT_STAGE_FIRST_SPROUTS:
                        return 42;
                    case FLOWERPOT_STAGE_FIRST_SPROUTS_2:
                        return 74;
                    case FLOWERPOT_STAGE_FIRST_SPROUTS_CRYSTAL:
                        return 72;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS:
                        return growFromFeed ? 40 : 4;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS_2:
                        return 48;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS_CRYSTAL:
                        return 72;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS_3:
                        return growFromFeed ? 52 : 4;
                    case FLOWERPOT_STAGE_THIRD_SPROUTS:
                        return 72;
                    case FLOWERPOT_STAGE_MATURE_PLANT:
                        return 187;
                    default:
                        break;
                }
                break;
            case FLOWERPOT_PLANT_TREE_CUTTINGS:
                switch (PItem->getStage())
                {
                    case FLOWERPOT_STAGE_EMPTY:
                        return 24;
                    case FLOWERPOT_STAGE_INITIAL:
                        return 30;
                    case FLOWERPOT_STAGE_FIRST_SPROUTS:
                        return 40;
                    case FLOWERPOT_STAGE_FIRST_SPROUTS_2:
                        return 74;
                    case FLOWERPOT_STAGE_FIRST_SPROUTS_CRYSTAL:
                        return 72;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS:
                        return growFromFeed ? 48 : 8;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS_2:
                        return 52;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS_CRYSTAL:
                        return 72;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS_3:
                        return growFromFeed ? 54 : 8;
                    case FLOWERPOT_STAGE_THIRD_SPROUTS:
                        return 60;
                    case FLOWERPOT_STAGE_MATURE_PLANT:
                        return 187;
                    default:
                        break;
                }
                break;
            case FLOWERPOT_PLANT_TREE_SAPLINGS:
                switch (PItem->getStage())
                {
                    case FLOWERPOT_STAGE_EMPTY:
                        return 40;
                    case FLOWERPOT_STAGE_INITIAL:
                        return 48;
                    case FLOWERPOT_STAGE_FIRST_SPROUTS:
                        return 62;
                    case FLOWERPOT_STAGE_FIRST_SPROUTS_2:
                        return 74;
                    case FLOWERPOT_STAGE_FIRST_SPROUTS_CRYSTAL:
                        return 80;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS:
                        return growFromFeed ? 60 : 22;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS_2:
                        return 80;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS_CRYSTAL:
                        return 86;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS_3:
                        return growFromFeed ? 64 : 26;
                    case FLOWERPOT_STAGE_THIRD_SPROUTS:
                        return 108;
                    case FLOWERPOT_STAGE_MATURE_PLANT:
                        return 187;
                    default:
                        break;
                }
                break;
            case FLOWERPOT_PLANT_WILDGRASS_SEEDS:
                switch (PItem->getStage())
                {
                    case FLOWERPOT_STAGE_INITIAL:
                        return 12;
                    case FLOWERPOT_STAGE_FIRST_SPROUTS:
                        return 18;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS_2:
                        return 28;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS_CRYSTAL:
                        return 62;
                    case FLOWERPOT_STAGE_SECOND_SPROUTS_3:
                        return growFromFeed ? 36 : 4;
                    case FLOWERPOT_STAGE_THIRD_SPROUTS:
                        return 46;
                    case FLOWERPOT_STAGE_MATURE_PLANT:
                        return 187;
                    default:
                        break;
                }
                break;
            default:
                break;
        }
        return 0;
    }
} // namespace gardenutils
