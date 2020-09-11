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

#ifndef _CITEMFLOWERPOT_H
#define _CITEMFLOWERPOT_H

#include "../../common/cbasetypes.h"

#include "item_furnishing.h"

enum FLOWERPOT_POT_TYPE
{
    FLOWERPOT_POT_PORCELAIN,
    FLOWERPOT_POT_BRASS,
    FLOWERPOT_POT_EARTHEN,
    FLOWERPOT_POT_CERAMIC,
    FLOWERPOT_POT_WOODEN,
    FLOWERPOT_POT_ARCANE,
};

enum FLOWERPOT_PLANT_TYPE
{
    FLOWERPOT_PLANT_NONE,
    FLOWERPOT_PLANT_FRUIT_SEEDS,
    FLOWERPOT_PLANT_HERB_SEEDS,
    FLOWERPOT_PLANT_GRAIN_SEEDS,
    FLOWERPOT_PLANT_VEGETABLE_SEEDS,
    FLOWERPOT_PLANT_CACTUS_STEMS,
    FLOWERPOT_PLANT_TREE_CUTTINGS,
    FLOWERPOT_PLANT_TREE_SAPLINGS,
    FLOWERPOT_PLANT_WILDGRASS_SEEDS,
};

enum FLOWERPOT_STAGE_TYPE
{
    FLOWERPOT_STAGE_EMPTY,
    FLOWERPOT_STAGE_INITIAL,
    FLOWERPOT_STAGE_FIRST_SPROUTS,
    FLOWERPOT_STAGE_FIRST_SPROUTS_2,
    FLOWERPOT_STAGE_FIRST_SPROUTS_CRYSTAL,
    FLOWERPOT_STAGE_SECOND_SPROUTS,
    FLOWERPOT_STAGE_SECOND_SPROUTS_2,
    FLOWERPOT_STAGE_SECOND_SPROUTS_CRYSTAL,
    FLOWERPOT_STAGE_SECOND_SPROUTS_3,
    FLOWERPOT_STAGE_THIRD_SPROUTS,
    FLOWERPOT_STAGE_MATURE_PLANT,
    FLOWERPOT_STAGE_WILTED,
};

enum FLOWERPOT_ELEMENT_TYPE
{
    FLOWERPOT_ELEMENT_NONE,
    FLOWERPOT_ELEMENT_FIRE,
    FLOWERPOT_ELEMENT_ICE,
    FLOWERPOT_ELEMENT_WIND,
    FLOWERPOT_ELEMENT_EARTH,
    FLOWERPOT_ELEMENT_LIGHTNING,
    FLOWERPOT_ELEMENT_WATER,
    FLOWERPOT_ELEMENT_LIGHT,
    FLOWERPOT_ELEMENT_DARK,
};

class CItemFlowerpot : public CItemFurnishing
{
public:
    CItemFlowerpot(uint16 id);
    virtual ~CItemFlowerpot();

    void cleanPot();

    bool isPlanted();
    bool isTree();
    void setDried(bool dried);
    bool isDried();
    bool canGrow();

    void setPlant(FLOWERPOT_PLANT_TYPE plant);
    FLOWERPOT_PLANT_TYPE getPlant();
    static uint16 getSeedID(FLOWERPOT_PLANT_TYPE plantType);
    static FLOWERPOT_PLANT_TYPE getPlantFromSeed(uint16 seedID);

    void setStage(FLOWERPOT_STAGE_TYPE stage);
    FLOWERPOT_STAGE_TYPE getStage();

    void setFirstCrystalFeed(FLOWERPOT_ELEMENT_TYPE element);
    void setSecondCrystalFeed(FLOWERPOT_ELEMENT_TYPE element);
    FLOWERPOT_ELEMENT_TYPE getExtraCrystalFeed();
    FLOWERPOT_ELEMENT_TYPE getCommonCrystalFeed();
    static int16 getItemFromElement(FLOWERPOT_ELEMENT_TYPE element);
    static FLOWERPOT_ELEMENT_TYPE getElementFromItem(int16 itemID);

    void setPlantTimestamp(uint32 vanatime);
    uint32 getPlantTimestamp();
    void setStageTimestamp(uint32 vanatime);
    uint32 getStageTimestamp();

    void clearExamined();
    void markExamined();
    bool wasExamined();

    void setStrength(uint8 strength);
    uint8 getStrength();
};

#endif // _CITEMFLOWERPOT_H
