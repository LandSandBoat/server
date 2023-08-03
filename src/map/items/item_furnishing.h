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

#ifndef _CITEMFURNISHING_H
#define _CITEMFURNISHING_H

#include "common/cbasetypes.h"

#include "item.h"

// List of Moghancements

enum MOGHANCEMENT_TYPE
{
    MOGHANCEMENT_FIRE      = 512, // Reduces the chances of losing materials when synthesis attempts utilizing a fire crystal have failed
    MOGHANCEMENT_ICE       = 513, // Reduces the chances of losing materials when synthesis attempts utilizing a ice crystal have failed
    MOGHANCEMENT_WIND      = 514, // Reduces the chances of losing materials when synthesis attempts utilizing a wind crystal have failed
    MOGHANCEMENT_EARTH     = 515, // Reduces the chances of losing materials when synthesis attempts utilizing an earth crystal have failed
    MOGHANCEMENT_LIGHTNING = 516, // Reduces the chances of losing materials when synthesis attempts utilizing a lightning crystal have failed
    MOGHANCEMENT_WATER     = 517, // Reduces the chances of losing materials when synthesis attempts utilizing a water crystal have failed
    MOGHANCEMENT_LIGHT     = 518, // Reduces the chances of losing materials when synthesis attempts utilizing a light crystal have failed
    MOGHANCEMENT_DARK      = 519, // Reduces the chances of losing materials when synthesis attempts utilizing a dark crystal have failed

    // Crafting Skills
    MOGHANCEMENT_FISHING      = 523, // Increases your fishing skill by 1
    MOGHANCEMENT_WOODWORKING  = 524, // Increases your woodworking skill by 1
    MOGHANCEMENT_SMITHING     = 525, // Increases your smithing skill by 1
    MOGHANCEMENT_GOLDSMITHING = 526, // Increases your goldsmithing skill by 1
    MOGHANCEMENT_CLOTHCRAFT   = 527, // Increases your clothcraft skill by 1
    MOGHANCEMENT_LEATHERCRAFT = 528, // Increases your leathercraft skill by 1
    MOGHANCEMENT_BONECRAFT    = 529, // Increases your bonecraft skill by 1
    MOGHANCEMENT_ALCHEMY      = 530, // Increases your alchemy skill by 1
    MOGHANCEMENT_COOKING      = 531, // Increases your cooking skill by 1

    // Crafting Skills & Material Salvage
    MOGLIFICATION_FISHING      = 544, // Increases your fishing skill, and makes it slightly easier to reel in your catch
    MOGLIFICATION_WOODWORKING  = 545, // Increases your woodworking skill, and reduces the chances of losing materials when synthesis attempts have failed
    MOGLIFICATION_SMITHING     = 546, // Increases your smithing skill, and reduces the chances of losing materials when synthesis attempts have failed
    MOGLIFICATION_GOLDSMITHING = 547, // Increases your goldsmithing skill, and reduces the chances of losing materials when synthesis attempts have failed
    MOGLIFICATION_CLOTHCRAFT   = 548, // Increases your clothcraft skill, and reduces the chances of losing materials when synthesis attempts have failed
    MOGLIFICATION_LEATHERCRAFT = 549, // Increases your leathercraft skill, and reduces the chances of losing materials when synthesis attempts have failed
    MOGLIFICATION_BONECRAFT    = 550, // Increases your bonecraft skill, and reduces the chances of losing materials when synthesis attempts have failed
    MOGLIFICATION_ALCHEMY      = 551, // Increases your alchemy skill, and reduces the chances of losing materials when synthesis attempts have failed
    MOGLIFICATION_COOKING      = 552, // Increases your cooking skill, and reduces the chances of losing materials when synthesis attempts have failed

    MEGA_MOGLIFICATION_FISHING      = 553, // Increases your fishing skill, and allows you to more quickly discern when you have a bite.
    MEGA_MOGLIFICATION_WOODWORKING  = 554, // Increases your woodworking skill immensely
    MEGA_MOGLIFICATION_SMITHING     = 555, // Increases your smithing skill immensely
    MEGA_MOGLIFICATION_GOLDSMITHING = 556, // Increases your goldsmithing skill immensely
    MEGA_MOGLIFICATION_CLOTHCRAFT   = 557, // Increases your clothcrafting skill immensely
    MEGA_MOGLIFICATION_LEATHERCRAFT = 558, // Increases your leathercrafting skill immensely.
    MEGA_MOGLIFICATION_BONECRAFT    = 559, // Increases your bonecrafting skill immensely
    MEGA_MOGLIFICATION_ALCHEMY      = 560, // Increases your alchemy skill immensely
    MEGA_MOGLIFICATION_COOKING      = 561, // Increases your cooking skill immensely

    // Other
    MOGHANCEMENT_EXPERIENCE        = 520, // Reduces the amount of experience lost by 5% when KO'd
    MOGHANCEMENT_GARDENING         = 521, // Reduces the chances of plants withering when gardening
    MOGHANCEMENT_DESYNTHESIS       = 522, // Increases the chances of success by 1 to 2% when attempting desynthesis
    MOGHANCEMENT_CONQUEST          = 532, // Increases the number of individual conquest points received
    MOGHANCEMENT_REGION            = 533, // Increases the number of region points awarded to your nation when participating in conquest
    MOGHANCEMENT_FISHING_ITEM      = 534, // Increases the chances of finding items when fishing
    MOGHANCEMENT_SANDORIA_CONQUEST = 535, // Increases the number of individual conquest points received for San d'Orian adventurers only
    MOGHANCEMENT_BASTOK_CONQUEST   = 536, // Increases the number of individual conquest points received for Bastokan adventurers only
    MOGHANCEMENT_WINDURST_CONQUEST = 537, // Increases the number of individual conquest points received for Windurstian adventurers only
    MOGHANCEMENT_MONEY             = 538, // Increases the amount of Gil dropped by monsters by 10%
    MOGHANCEMENT_CAMPAIGN          = 539, // Improves your evaluation for services rendered to the Allied Forces by 5%
    MOGHANCEMENT_MONEY_II          = 540, // Increases the amount of Gil received
    MOGHANCEMENT_SKILL_GAINS       = 541, // Increases the rate of gaining combat and magic skills
    MOGHANCEMENT_BOUNTY            = 542, // Increases the rate of gaining experience and capacity points by 10%

    MOGLIFICATION_EXPERIENCE_BOOST = 562, // Increases the rate of gaining experience by 15%
    MOGLIFICATION_CAPACITY_BOOST   = 563, // Increases the rate of gaining capacity points by 15%

    MOGLIFICATION_RESIST_DEATH         = 566,  // Slightly improves your resistance to death effects
    MOGLIFICATION_RESIST_SLEEP         = 2848, // Slightly improves your resistance to sleep effects
    MOGLIFICATION_RESIST_POISON        = 2849, // Slightly improves your resistance to poison effects
    MOGLIFICATION_RESIST_PARALYSIS     = 2850, // Slightly improves your resistance to paralysis effects
    MOGLIFICATION_RESIST_SILENCE       = 2852, // Slightly improves your resistance to silence effects
    MOGLIFICATION_RESIST_PETRIFICATION = 2853, // Slightly improves your resistance to petrification effects
    MOGLIFICATION_RESIST_VIRUS         = 2854, // Slightly improves your resistance to virus effects
    MOGLIFICATION_RESIST_CURSE         = 2855  // Slightly improves your resistance to curse effects
};

class CItemFurnishing : public CItem
{
public:
    CItemFurnishing(uint16);
    virtual ~CItemFurnishing();

    uint8  getStorage() const;
    uint16 getMoghancement() const;
    uint8  getElement() const;
    uint8  getAura() const;

    bool  isInstalled();
    uint8 getCol();
    uint8 getRow();
    uint8 getLevel();
    uint8 getRotation();
    uint8 getOrder(); // Gets Placement order with 0 being the most recently placed furniture

    void setInstalled(bool installed);
    void setStorage(uint8 storage);
    void setMoghancement(uint16 moghancement);
    void setElement(uint8 element);
    void setAura(uint8 aura);

    void setCol(uint8 col);
    void setRow(uint8 row);
    void setLevel(uint8 level);
    void setRotation(uint8 rotation);
    void setOrder(uint8 order);

    void  setMannequinRace(uint8 race);
    uint8 getMannequinRace();
    void  setMannequinPose(uint8 pose);
    uint8 getMannequinPose();

    void setOn2ndFloor(bool on2ndFloor);
    bool getOn2ndFloor();

    bool isGardeningPot();

private:
    uint8  m_storage;
    uint16 m_moghancement;
    uint8  m_element;
    uint8  m_aura;
};

#endif
