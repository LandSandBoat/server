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
}

CItemFlowerpot::CItemFlowerpot(const CItemFlowerpot& other)
: CItemFurnishing(other)
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
    return this->exdata<Exdata::FlowerPot>().Step > 0;
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
    this->exdata<Exdata::FlowerPot>().Dried = dried ? 1 : 0;
}

bool CItemFlowerpot::isDried()
{
    return this->exdata<Exdata::FlowerPot>().Dried;
}

bool CItemFlowerpot::canGrow()
{
    uint8 stage = this->exdata<Exdata::FlowerPot>().Step;
    return stage >= FLOWERPOT_STAGE_INITIAL && stage <= FLOWERPOT_STAGE_THIRD_SPROUTS && !isDried();
}

void CItemFlowerpot::setPlant(FLOWERPOT_PLANT_TYPE plant)
{
    this->exdata<Exdata::FlowerPot>().Kind = plant;
}

FLOWERPOT_PLANT_TYPE CItemFlowerpot::getPlant()
{
    return static_cast<FLOWERPOT_PLANT_TYPE>(this->exdata<Exdata::FlowerPot>().Kind);
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
    this->exdata<Exdata::FlowerPot>().Step = stage;
}

FLOWERPOT_STAGE_TYPE CItemFlowerpot::getStage()
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

FLOWERPOT_ELEMENT_TYPE CItemFlowerpot::getExtraCrystalFeed()
{
    return static_cast<FLOWERPOT_ELEMENT_TYPE>(this->exdata<Exdata::FlowerPot>().Crystal1);
}

FLOWERPOT_ELEMENT_TYPE CItemFlowerpot::getCommonCrystalFeed()
{
    return static_cast<FLOWERPOT_ELEMENT_TYPE>(this->exdata<Exdata::FlowerPot>().Crystal2);
}

int16 CItemFlowerpot::getItemFromElement(FLOWERPOT_ELEMENT_TYPE element)
{
    // Element and crystal item id ordering is the same with an offset
    return element + 4095;
}

FLOWERPOT_ELEMENT_TYPE CItemFlowerpot::getElementFromItem(int16 itemID)
{
    // Element and crystal item id ordering is the same with an offset
    return static_cast<FLOWERPOT_ELEMENT_TYPE>(itemID - 4095);
}

void CItemFlowerpot::setPlantTimestamp(uint32 vanatime)
{
    this->exdata<Exdata::FlowerPot>().TimePlanted = vanatime;
}

uint32 CItemFlowerpot::getPlantTimestamp()
{
    return this->exdata<Exdata::FlowerPot>().TimePlanted;
}

void CItemFlowerpot::setStageTimestamp(uint32 vanatime)
{
    this->exdata<Exdata::FlowerPot>().TimeNextStep = vanatime;
}

uint32 CItemFlowerpot::getStageTimestamp()
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

bool CItemFlowerpot::wasExamined()
{
    return this->exdata<Exdata::FlowerPot>().Examined;
}

void CItemFlowerpot::setStrength(uint8 strength)
{
    this->exdata<Exdata::FlowerPot>().Strength = strength;
}

uint8 CItemFlowerpot::getStrength()
{
    return this->exdata<Exdata::FlowerPot>().Strength;
}
