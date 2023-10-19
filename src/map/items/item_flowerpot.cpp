/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "item_flowerpot.h"
#include "map.h"

// Flowerpot Extra data explained:
//          00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F 10 11 12 13 14 15 16 17
// Example: 08 40 03 07 01 37 0A 00 17 00 00 00 E5 C8 9A 1F 88 1A 9F 1F 08 3C 04 08
// 00 - Flowerpot stage ID (FLOWERPOT_STAGE_TYPE). Plants do not necessarily follow this sequentially and will skip some stages based on seed type.
// 01 - Tracks if displayed as well as if the plant has been dried
// 02 - Crystal feed element ID (FLOWERPOT_ELEMENT_TYPE). 4095 + element ID is the crystal item ID. This one is only used by trees that take two feedings.
// 03 - Same as 0x02 but is the common one used by all plants.
// 04 - Seed type (FLOWERPOT_PLANT_TYPE) of the plant
// 05 - Bit 1 tracks if the plant was examined since the last wilting check. Bits 2-N store the RNG "strength" of the plant.
// 06-0B - MH Display info used in CItemFurnishing
// 0C-0F - Vanatime of when the seed was planted in the flowerpot
// 10-13 - Vanatime of when the next plant stage will occur

CItemFlowerpot::CItemFlowerpot(uint16 id)
: CItemFurnishing(id)
{
}

CItemFlowerpot::~CItemFlowerpot() = default;

void CItemFlowerpot::cleanPot()
{
    setDried(false);
    setPlant(FLOWERPOT_PLANT_NONE);
    setStage(FLOWERPOT_STAGE_EMPTY);
    setFirstCrystalFeed(FLOWERPOT_ELEMENT_NONE);
    setSecondCrystalFeed(FLOWERPOT_ELEMENT_NONE);
    setPlantTimestamp(0);
    setStageTimestamp(0);
}

bool CItemFlowerpot::isPlanted()
{
    return ref<uint8>(m_extra, 0x00) > 0;
}

bool CItemFlowerpot::isTree()
{
    switch (getPlant())
    {
        case FLOWERPOT_PLANT_FRUIT_SEEDS:
        case FLOWERPOT_PLANT_CACTUS_STEMS:
        case FLOWERPOT_PLANT_TREE_CUTTINGS:
        case FLOWERPOT_PLANT_TREE_SAPLINGS:
            return true;
        case FLOWERPOT_PLANT_HERB_SEEDS:
        case FLOWERPOT_PLANT_GRAIN_SEEDS:
        case FLOWERPOT_PLANT_VEGETABLE_SEEDS:
        case FLOWERPOT_PLANT_WILDGRASS_SEEDS:
        default:
            return false;
    }
}

void CItemFlowerpot::setDried(bool dried)
{
    if (dried)
    {
        ref<uint8>(m_extra, 0x01) |= 0x80;
    }
    else
    {
        ref<uint8>(m_extra, 0x01) &= ~0x80;
    }
}

bool CItemFlowerpot::isDried()
{
    return ref<uint8>(m_extra, 0x01) & 0x80;
}

bool CItemFlowerpot::canGrow()
{
    uint8 stage = ref<uint8>(m_extra, 0x00);
    return stage >= FLOWERPOT_STAGE_INITIAL && stage <= FLOWERPOT_STAGE_THIRD_SPROUTS && !isDried();
}

void CItemFlowerpot::setPlant(FLOWERPOT_PLANT_TYPE plant)
{
    ref<uint8>(m_extra, 0x04) = plant;
}

FLOWERPOT_PLANT_TYPE CItemFlowerpot::getPlant()
{
    return (FLOWERPOT_PLANT_TYPE)ref<uint8>(m_extra, 0x04);
}

uint16 CItemFlowerpot::getSeedID(FLOWERPOT_PLANT_TYPE plantType)
{
    switch (plantType)
    {
        case FLOWERPOT_PLANT_HERB_SEEDS:
            return 572;
        case FLOWERPOT_PLANT_GRAIN_SEEDS:
            return 575;
        case FLOWERPOT_PLANT_VEGETABLE_SEEDS:
            return 573;
        case FLOWERPOT_PLANT_FRUIT_SEEDS:
            return 574;
        case FLOWERPOT_PLANT_CACTUS_STEMS:
            return 1236;
        case FLOWERPOT_PLANT_TREE_CUTTINGS:
            return 1237;
        case FLOWERPOT_PLANT_TREE_SAPLINGS:
            return 1238;
        case FLOWERPOT_PLANT_WILDGRASS_SEEDS:
            return 2235;
        case FLOWERPOT_PLANT_NONE:
        default:
            return 0;
    }
}

FLOWERPOT_PLANT_TYPE CItemFlowerpot::getPlantFromSeed(uint16 seedID)
{
    switch (seedID)
    {
        case 572:
            return FLOWERPOT_PLANT_HERB_SEEDS;
        case 575:
            return FLOWERPOT_PLANT_GRAIN_SEEDS;
        case 573:
            return FLOWERPOT_PLANT_VEGETABLE_SEEDS;
        case 574:
            return FLOWERPOT_PLANT_FRUIT_SEEDS;
        case 1236:
            return FLOWERPOT_PLANT_CACTUS_STEMS;
        case 1237:
            return FLOWERPOT_PLANT_TREE_CUTTINGS;
        case 1238:
            return FLOWERPOT_PLANT_TREE_SAPLINGS;
        case 2235:
            return FLOWERPOT_PLANT_WILDGRASS_SEEDS;
        default:
            return FLOWERPOT_PLANT_NONE;
    }
}

void CItemFlowerpot::setStage(FLOWERPOT_STAGE_TYPE stage)
{
    ref<uint8>(m_extra, 0x00) = stage;
}

FLOWERPOT_STAGE_TYPE CItemFlowerpot::getStage()
{
    return (FLOWERPOT_STAGE_TYPE)ref<uint8>(m_extra, 0x00);
}

void CItemFlowerpot::setFirstCrystalFeed(FLOWERPOT_ELEMENT_TYPE element)
{
    ref<uint8>(m_extra, 0x02) = element;
}

void CItemFlowerpot::setSecondCrystalFeed(FLOWERPOT_ELEMENT_TYPE element)
{
    ref<uint8>(m_extra, 0x03) = element;
}

FLOWERPOT_ELEMENT_TYPE CItemFlowerpot::getExtraCrystalFeed()
{
    return (FLOWERPOT_ELEMENT_TYPE)ref<uint8>(m_extra, 0x02);
}

FLOWERPOT_ELEMENT_TYPE CItemFlowerpot::getCommonCrystalFeed()
{
    return (FLOWERPOT_ELEMENT_TYPE)ref<uint8>(m_extra, 0x03);
}

int16 CItemFlowerpot::getItemFromElement(FLOWERPOT_ELEMENT_TYPE element)
{
    // Element and crystal item id ordering is the same with an offset
    return element + 4095;
}

FLOWERPOT_ELEMENT_TYPE CItemFlowerpot::getElementFromItem(int16 itemID)
{
    // Element and crystal item id ordering is the same with an offset
    return (FLOWERPOT_ELEMENT_TYPE)(itemID - 4095);
}

void CItemFlowerpot::setPlantTimestamp(uint32 vanatime)
{
    ref<uint32>(m_extra, 0x0C) = vanatime;
}

uint32 CItemFlowerpot::getPlantTimestamp()
{
    return ref<uint32>(m_extra, 0x0C);
}

void CItemFlowerpot::setStageTimestamp(uint32 vanatime)
{
    ref<uint32>(m_extra, 0x10) = vanatime;
}

uint32 CItemFlowerpot::getStageTimestamp()
{
    return ref<uint32>(m_extra, 0x10);
}

void CItemFlowerpot::clearExamined()
{
    ref<uint8>(m_extra, 0x05) &= ~1;
}

void CItemFlowerpot::markExamined()
{
    ref<uint8>(m_extra, 0x05) |= 1;
}

bool CItemFlowerpot::wasExamined()
{
    return ref<uint8>(m_extra, 0x05) & 1;
}

void CItemFlowerpot::setStrength(uint8 strength)
{
    ref<uint8>(m_extra, 0x05) = strength << 1;
}

uint8 CItemFlowerpot::getStrength()
{
    return ref<uint8>(m_extra, 0x05) >> 1;
}
