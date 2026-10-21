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

#include "exdata/flower_pot.h"

CItemFlowerpot::CItemFlowerpot(uint16 id)
: CItemFurnishing(id)
{
    setType(ITEM_FLOWERPOT);
}

CItemFlowerpot::CItemFlowerpot(const CItemFlowerpot& other) = default;

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

auto CItemFlowerpot::isPlanted() -> bool
{
    return this->exdata<Exdata::FlowerPot>().Step > 0;
}

auto CItemFlowerpot::isTree() -> bool
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
    this->exdata<Exdata::FlowerPot>().Dried = dried ? 1 : 0;
}

auto CItemFlowerpot::isDried() -> bool
{
    return this->exdata<Exdata::FlowerPot>().Dried;
}

auto CItemFlowerpot::canGrow() -> bool
{
    uint8 stage = this->exdata<Exdata::FlowerPot>().Step;
    return stage >= FLOWERPOT_STAGE_INITIAL && stage <= FLOWERPOT_STAGE_THIRD_SPROUTS && !isDried();
}

void CItemFlowerpot::setPlant(FLOWERPOT_PLANT_TYPE plant)
{
    this->exdata<Exdata::FlowerPot>().Kind = plant;
}

auto CItemFlowerpot::getPlant() -> FLOWERPOT_PLANT_TYPE
{
    return static_cast<FLOWERPOT_PLANT_TYPE>(this->exdata<Exdata::FlowerPot>().Kind);
}

auto CItemFlowerpot::getSeedID(FLOWERPOT_PLANT_TYPE plantType) -> uint16
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

auto CItemFlowerpot::getPlantFromSeed(uint16 seedID) -> FLOWERPOT_PLANT_TYPE
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
    this->exdata<Exdata::FlowerPot>().Step = stage;
}

auto CItemFlowerpot::getStage() -> FLOWERPOT_STAGE_TYPE
{
    return static_cast<FLOWERPOT_STAGE_TYPE>(this->exdata<Exdata::FlowerPot>().Step);
}

void CItemFlowerpot::setFirstCrystalFeed(FLOWERPOT_ELEMENT_TYPE element)
{
    this->exdata<Exdata::FlowerPot>().Crystal1 = element;
}

void CItemFlowerpot::setSecondCrystalFeed(FLOWERPOT_ELEMENT_TYPE element)
{
    this->exdata<Exdata::FlowerPot>().Crystal2 = element;
}

auto CItemFlowerpot::getExtraCrystalFeed() -> FLOWERPOT_ELEMENT_TYPE
{
    return static_cast<FLOWERPOT_ELEMENT_TYPE>(this->exdata<Exdata::FlowerPot>().Crystal1);
}

auto CItemFlowerpot::getCommonCrystalFeed() -> FLOWERPOT_ELEMENT_TYPE
{
    return static_cast<FLOWERPOT_ELEMENT_TYPE>(this->exdata<Exdata::FlowerPot>().Crystal2);
}

auto CItemFlowerpot::getItemFromElement(FLOWERPOT_ELEMENT_TYPE element) -> int16
{
    // Element and crystal item id ordering is the same with an offset
    return element + 4095;
}

auto CItemFlowerpot::getElementFromItem(int16 itemID) -> FLOWERPOT_ELEMENT_TYPE
{
    // Element and crystal item id ordering is the same with an offset
    return static_cast<FLOWERPOT_ELEMENT_TYPE>(itemID - 4095);
}

void CItemFlowerpot::setPlantTimestamp(uint32 vanatime)
{
    this->exdata<Exdata::FlowerPot>().TimePlanted = vanatime;
}

auto CItemFlowerpot::getPlantTimestamp() -> uint32
{
    return this->exdata<Exdata::FlowerPot>().TimePlanted;
}

void CItemFlowerpot::setStageTimestamp(uint32 vanatime)
{
    this->exdata<Exdata::FlowerPot>().TimeNextStep = vanatime;
}

auto CItemFlowerpot::getStageTimestamp() -> uint32
{
    return this->exdata<Exdata::FlowerPot>().TimeNextStep;
}

void CItemFlowerpot::clearExamined()
{
    this->exdata<Exdata::FlowerPot>().Examined = 0;
}

void CItemFlowerpot::markExamined()
{
    this->exdata<Exdata::FlowerPot>().Examined = 1;
}

auto CItemFlowerpot::wasExamined() -> bool
{
    return this->exdata<Exdata::FlowerPot>().Examined;
}

void CItemFlowerpot::setStrength(uint8 strength)
{
    this->exdata<Exdata::FlowerPot>().Strength = strength;
}

auto CItemFlowerpot::getStrength() -> uint8
{
    return this->exdata<Exdata::FlowerPot>().Strength;
}
