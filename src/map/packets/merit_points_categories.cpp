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

#include "common/socket.h"

#include <cstring>

#include "merit_points_categories.h"

#include "entities/charentity.h"

/*
Package containing information about the applied merites and the amount required for the next boost
There is a lot of information, sent in three packages. The beginning is standard for everyone:

0x8c 0x80 0x05 0x00 0x3D 0x00 0x00 0x00

Next comes the data in the form of structures

struct
{
  unsigned sort // Merit id
  unsigned char // Required number of merits for the next enhancement (0 - strengthening of this merit is impossible)
  unsigned char // Number of enhancements made by the character
};

The beginning of the category is a multiple of 0x40, then the id value is added. All ids are multiples of two

The number of required merits for the next enhancement is transferred to the character only when entering the moghouse
*/

/************************************************************************
 *                                                                       *
 *  Send the character information about all merits (5 packages)         *
 *                                                                       *
 ************************************************************************/

#define MAX_MERITS_IN_PACKET 61

CMeritPointsCategoriesPacket::CMeritPointsCategoriesPacket(CCharEntity* PChar)
{
    this->setType(0x8C);
    this->setSize(0x100);

    ref<uint8>(0x04) = MAX_MERITS_IN_PACKET;

    for (uint8 i = 0; i < 5; ++i)
    {
        MeritPointsCategoriesPacket(PChar, i * MAX_MERITS_IN_PACKET);

        PChar->pushPacket(this->copy());
    }
    MeritPointsCategoriesPacket(PChar, static_cast<uint8>(5 * MAX_MERITS_IN_PACKET));
}

/************************************************************************
 *                                                                       *
 *  Send the character information about one merit                       *
 *                                                                       *
 ************************************************************************/

CMeritPointsCategoriesPacket::CMeritPointsCategoriesPacket(CCharEntity* PChar, MERIT_TYPE merit)
{
    this->setType(0x8C);
    this->setSize(0x10);

    ref<uint8>(0x04)  = 1;
    ref<uint32>(0x08) = PChar->PMeritPoints->GetMerit(merit)->data;
}

void CMeritPointsCategoriesPacket::MeritPointsCategoriesPacket(CCharEntity* PChar, uint8 offset)
{
    for (uint8 i = 0; i < MAX_MERITS_IN_PACKET; ++i)
    {
        std::memcpy(buffer_.data() + 0x08 + sizeof(uint32) * i, &PChar->PMeritPoints->GetMeritByIndex(offset + i)->data, sizeof(uint32));
    }

    if (!PChar->m_moghouseID)
    {
        for (uint8 i = 0; i < MAX_MERITS_IN_PACKET; ++i)
        {
            (*(Merit_t*)(buffer_.data() + 0x08 + sizeof(uint32) * i)).next = 0; // Reset the next value for all merits
        }
    }
}

/*

0x00 0x40 - HP/MP
        Max HP (+10 per upgrade)
        Max MP (+10 per upgrade)
0x00 0x80 - Attributes
        STR (+1 per upgrade)
        DEX (+1 per upgrade)
        VIT (+1 per upgrade)
        AGI (+1 per upgrade)
        INT (+1 per upgrade)
        MND (+1 per upgrade)
        CHR (+1 per upgrade)
0x00 0xC0 - Combat Skills
        Hand-to-Hand Skill (+2 per upgrade)
        Dagger Skill (+2 per upgrade)
        Sword Skill (+2 per upgrade)
        Great Sword Skill (+2 per upgrade)
        Axe Skill (+2 per upgrade)
        Great Axe Skill (+2 per upgrade)
        Scythe Skill (+2 per upgrade)
        Polearm Skill (+2 per upgrade)
        Katana Skill (+2 per upgrade)
        Great Katana Skill (+2 per upgrade)
        Club Skill (+2 per upgrade)
        Staff Skill (+2 per upgrade)
        Archery Skill (+2 per upgrade)
        Marksmanship Skill (+2 per upgrade)
        Throwing Skill (+2 per upgrade)

        Guarding Skill (+2 per upgrade)
        Evasion Skill (+2 per upgrade)
        Shield Skill (+2 per upgrade)
        Parrying Skill (+2 per upgrade)
0x01 0x00 - Magic Skills
        Divine Magic Skill (+2 per upgrade)
        Healing Magic Skill (+2 per upgrade)
        Enhancing Magic Skill (+2 per upgrade)
        Enfeebling Magic Skill (+2 per upgrade)
        Elemental Magic Skill (+2 per upgrade)
        Dark Magic Skill (+2 per upgrade)
        Summoning Magic Skill (+2 per upgrade)
        Ninjutsu Skill (+2 per upgrade)
        Singing Skill (+2 per upgrade)
        String Instrument Skill (+2 per upgrade)
        Wind Instrument Skill (+2 per upgrade)
        Blue Magic Skill (+2 per upgrade)
        Geomancy Magic Skill (+2 per upgrade)
        Handbell Instrument Skill (+2 per upgrade)
0x01 0x40 - Others
        Enmity Increase (+1 per upgrade)
        Enmity Decrease (-1 per upgrade)
        Critical Hit Rate (+1% per upgrade)
        Enemy Critical Hit Rate (-1% per upgrade)
        Spell Interruption Rate (-2% per upgrade)
0x01 0x80 - WAR - Group 1
        Berserk Recast (-10 seconds per upgrade)
        Defender Recast (-6 seconds per upgrade)
        Warcry Recast (-10 seconds per upgrade)
        Aggressor Recast (-10 seconds per upgrade)
        Double Attack Rate (+1% per upgrade)
0x01 0xC0 - MNK - Group 1
        Focus Recast (-10 seconds per upgrade)
        Dodge Recast (-10 seconds per upgrade)
        Chakra Recast (-10 seconds per upgrade)
        Counter Rate (+1% per upgrade)
        Kick Attack Rate (+1% per upgrade)
0x02 0x00 - WHM - Group 1
        Divine Seal Recast (-20 seconds per upgrade)
        Cure Cast Time (-4% cast time of all Cure spells per upgrade)
        Bar Spell Effect (+2 potency of Bar spells, +2 Magic Defense Bonus per upgrade)
        Banish Effect (+2 damage, +2 seconds duration of Defense Down effect per upgrade)
        Regen Spell Effect (+1 HP/tick recovered per upgrade)
0x02 0x40 - BLM - Group 1
        Elemental Seal Recast (-20 seconds per upgrade)
        Fire Magic Potency (+2 potency per upgrade)
        Ice Magic Potency (+2 potency per upgrade)
        Wind Magic Potency (+2 potency per upgrade)
        Earth Magic Potency (+2 potency per upgrade)
        Lightning Magic Potency (+2 potency per upgrade)
        Water Magic Potency (+2 potency per upgrade)
0x02 0x80 - RDM - Group 1
        Convert Recast (-20 seconds per upgrade)
        Fire Magic Accuracy (+3 magic accuracy per upgrade)
        Ice Magic Accuracy (+3 magic accuracy per upgrade)
        Wind Magic Accuracy (+3 magic accuracy per upgrade)
        Earth Magic Accuracy (+3 magic accuracy per upgrade)
        Lightning Magic Accuracy (+3 magic accuracy per upgrade)
        Water Magic Accuracy (+3 magic accuracy per upgrade)
0x02 0xC0 - THF - Group 1
        Flee Recast (-10 seconds per upgrade)
        Hide Recast (-10 seconds per upgrade)
        Sneak Attack Recast (-2 seconds per upgrade)
        Trick Attack Recast (-2 seconds per upgrade)
        Triple Attack Rate (+1% per upgrade)
0x03 0x00 - PLD - Group 1
        Shield Bash Recast (-10 seconds per upgrade)
        Holy Circle Recast (-20 seconds per upgrade)
        Sentinel Recast (-10 seconds per upgrade)
        Cover Effect Length (+4 seconds per upgrade)
        Rampart Recast (-10 seconds per upgrade)
0x03 0x40 - DRK - Group 1
        Souleater Recast (-12 seconds per upgrade)
        Arcane Circle Recast (-20 seconds per upgrade)
        Last Resort Recast (-10 seconds per upgrade)
        Last Resort Effect (+2% Attack Bonus, 2% Defense Down per upgrade)
        Weapon Bash Recast (-10 seconds per upgrade)
0x03 0x80 - BST - Group 1
        Killer Effects (+1% intimidation rate on all killer effects per upgrade)
        Reward Recast (-3 seconds per upgrade)
        Call Beast Recast (-10 seconds per upgrade)
        Sic/Ready Recast (Sic -4 sec / Ready -2 sec per upgrade)
        Tame Recast (-20 seconds per upgrade)
0x03 0xC0 - BRD - Group 1
        Lullaby Recast (-1 second per upgrade)
        Finale Recast (-1 second per upgrade)
        Minne Effect (+1 per upgrade)
        Minuet Effect (+1 per upgrade)
        Madrigal Effect (+1 per upgrade)
0x04 0x00 - RNG - Group 1
        Scavenge (5% increase to recovered/spent ammo per upgrade)
        Camouflage Recast (-10 seconds per upgrade)
        Sharpshot Recast (-10 seconds per upgrade)
        Unlimited Shot Recast (-6 seconds per upgrade)
        Rapid Shot Rate (+1% per upgrade)
0x04 0x40 - SAM - Group 1
        Third Eye Recast (-2 seconds per upgrade)
        Warding Circle Recast (-20 seconds per upgrade)
        Store TP Effect (+2 per upgrade)
        Meditate Recast (-6 seconds per upgrade)
        Zanshin Attack Rate (+1% per upgrade)
0x04 0x80 - NIN - Group 1
        Subtle Blow Effect (+1 per upgrade)
        Katon Effect (+2 damage and +2 seconds resist down per upgrade)
        Hyoton Effect (+2 damage and +2 seconds resist down per upgrade)
        Huton Effect (+2 damage and +2 seconds resist down per upgrade)
        Doton Effect (+2 damage and +2 seconds resist down per upgrade)
        Raiton Effect (+2 damage and +2 seconds resist down per upgrade)
        Suiton Effect (+2 damage and +2 seconds resist down per upgrade)
0x04 0xC0 - DRG - Group 1
        Ancient Circle Recast (-20 seconds per upgrade)
        Jump Recast (-3 seconds per upgrade)
        High Jump Recast (-6 seconds per upgrade)
        Super Jump Recast (-6 seconds per upgrade)
        Spirit Link Recast (-6 seconds per upgrade)
0x05 0x00 - SMN - Group 1
        Avatar Physical Accuracy (+3 per upgrade)
        Avatar Physical Attack (+2 per upgrade)
        Avatar Magical Accuracy (+3 per upgrade)
        Avatar Magical Attack (+2 per upgrade)
        Elemental MP Cost (-1 elemental perpetuation cost per upgrade)
0x05 0x40 - BLU - Group 1
        Chain Affinity Recast (-4 seconds per upgrade)
        Burst Affinity Recast (-4 seconds per upgrade)
        Monster Correlation (Increase monster family related effects by 1 per upgrade)
        Physical Potency (+2 Magic Potency of physical Blue Magic spells per upgrade)
        Magical Accuracy (+2 Magic Accuracy of magical Blue Magic spells per upgrade)
0x05 0x80 - COR - Group 1
        Phantom Roll Recast (-2 seconds per upgrade)
        Quick Draw Recast (-2 seconds per upgrade)
        Quick Draw Accuracy (+2 per upgrade)
        Random Deal Recast (-40 seconds per upgrade)
        Bust Duration (-10 seconds per upgrade)
0x05 0xC0 - PUP - Group 1
        Automaton Melee Skill (+2 per upgrade)
        Automaton Ranged Skill (+2 per upgrade)
        Automaton Magic Skill (+2 per upgrade)
        Activate Recast (-40 seconds per upgrade)
        Repair Recast (-6 seconds per upgrade)
0x06 0x00 - DNC - Group 1
        Steps Accuracy (+3 per upgrade)
        Haste Samba Effect (+1 per upgrade)
        Reverse Flourish Effect (+3 TP per upgrade)
        Building Flourish Effect (+2 accuracy, +1% attack, and +1% critical hit rate (with 1 / 2 / 3 finishing moves) per upgrade)
0x06 0x40 - SCH - Group 1
        Grimoire Recast (-2 seconds Light Arts/Dark Arts recast per upgrade)
        Modus Veritas Duration (+10% per upgrade)
        Helix Magic Acc./Atk. (+3 magic accuracy and +2 magic attack bonus per upgrade)
        Max Sublimation (+10 MP available per upgrade)
0x06 0x80 -
0x06 0xC0 -
0x08 0x00 - WAR - Group 2
        Warrior's Charge (-2 minutes 30 seconds recast per upgrade)
        Tomahawk (+15 seconds duration per upgrade)
        Savagery (+10 Weapon Skill TP Bonus per upgrade)
        Aggressive Aim (+4 Ranged Accuracy bonus per upgrade)
0x08 0x40 - MNK - Group 2
        Mantra (+4% per upgrade)
        Formless Strikes (+5% effect per upgrade)
        Invigorate (+24 seconds duration per upgrade)
        Penance (+20 seconds duration per upgrade)
0x08 0x80 - WHM - Group 2
        Martyr (-2 minutes 30 seconds recast per upgrade)
        Devotion (-2 minutes 30 seconds recast per upgrade)
        Protectra V (+2 defense per upgrade)
        Shellra V (~-0.8% Magic Damage Taken per upgrade)
0x08 0xC0 - BLM - Group 2
        Flare II (+3 Magic Burst damage and +5 Magic Accuracy per upgrade)
        Freeze II (+3 Magic Burst damage and +5 Magic Accuracy per upgrade)
        Tornado II (+3 Magic Burst damage and +5 Magic Accuracy per upgrade)
        Quake II (+3 Magic Burst damage and +5 Magic Accuracy per upgrade)
        Burst II (+3 Magic Burst damage and +5 Magic Accuracy per upgrade)
        Flood II (+3 Magic Burst damage and +5 Magic Accuracy per upgrade)
0x09 0x00 - RDM - Group 2
        Dia III (+30 seconds duration per upgrade : 30/60/90/120/150 seconds)
        Slow II (+1 effect and +2 Magic Accuracy per upgrade)
        Paralyze II (+1 effect and +2 Magic Accuracy per upgrade)
        Phalanx II (+30 seconds duration and +3 damage reduction per upgrade)
        Bio III (+30 seconds duration per upgrade : 30/60/90/120/150 seconds)
        Blind II (+1 effect and +2 Magic Accuracy per upgrade)
0x09 0x40 - THF - Group 2
        Assassin's Charge (-2 minutes 30 seconds recast per upgrade)
        Feint (-2 minutes recast per upgrade)
        Aura Steal (+20% absorb rate per upgrade)
        Ambush (+3 Accuracy Bonus per upgrade)
0x09 0x80 - PLD - Group 2
        Fealty (-2 minutes 30 seconds recast per upgrade)
        Chivalry (-2 minutes 30 seconds recast per upgrade)
        Iron Will (+19% effect per upgrade)
        Guardian (+19% effect per upgrade)
0x09 0xC0 - DRK - Group 2
        Dark Seal (-2 minutes 30 seconds recast per upgrade)
        Diabolic Eye (-2 minutes 30 seconds recast per upgrade)
        Muted Soul (-10 Enmity per upgrade)
        Desperate Blows (-5% Delay per upgrade)
0x0A 0x00 - BST - Group 2
        Feral Howl (-2 minutes 30 seconds recast per upgrade)
        Killer Instinct (-2 minutes 30 seconds recast per upgrade)
        Beast Affinity (+2 pet level per upgrade)
        Beast Healer (+1 Regen amount per upgrade)
0x0A 0x40 - BRD - Group 2
        Nightingale (-2 minutes 30 seconds recast per upgrade)
        Troubadour (-2 minutes 30 seconds recast per upgrade)
        Foe Sirvente (+5% effect per upgrade)
        Adventurer's Dirge (-3 Enmity per upgrade)
0x0A 0x80 - RNG - Group 2
        Stealth Shot (-10 Enmity per upgrade)
        Flashy Shot (-2 minutes 30 seconds recast per upgrade)
        Snapshot (-2% Delay per upgrade)
        Recycle (+5% activation rate per upgrade)
0x0A 0xC0 - SAM - Group 2
        Shikikoyo (-2 minutes 30 seconds recast per upgrade)
        Blade Bash (-2 minutes 30 seconds recast per upgrade)
        Ikishoten (+3 TP gained per upgrade)
        Overwhelm (+5% damage bonus per upgrade for the first 3 upgrades. 2% increase each for the last 2 upgrades)
0x0B 0x00 - NIN - Group 2
        Sange (-2 minutes 30 seconds recast per upgrade)
        Ninja Tool Expertise (+5% activation rate per upgrade)
        Katon: San (+5 Magic Attack and +5 Magic Accuracy per upgrade)
        Hyoton: San (+5 Magic Attack and +5 Magic Accuracy per upgrade)
        Huton: San (+5 Magic Attack and +5 Magic Accuracy per upgrade)
        Doton: San (+5 Magic Attack and +5 Magic Accuracy per upgrade)
        Raiton: San (+5 Magic Attack and +5 Magic Accuracy per upgrade)
        Suiton: San (+5 Magic Attack and +5 Magic Accuracy per upgrade)
0x0B 0x40 - DRG - Group 2
        Deep Breathing (-2 minutes 30 seconds recast per upgrade)
        Angon (+15 seconds Defense Down duration per upgrade)
        Empathy (+1 copied effect per upgrade)
        Strafe (+5 Wyvern Breath Accuracy per upgrade)
0x0B 0x80 - SMN - Group 2
        Meteor Strike (+40 TP Bonus per upgrade)
        Heavenly Strike (+40 TP Bonus per upgrade)
        Wind Blade (+40 TP Bonus per upgrade)
        Geocrush (+40 TP Bonus per upgrade)
        Thunderstorm (+40 TP Bonus per upgrade)
        Grand Fall (+40 TP Bonus per upgrade)
0x0B 0xC0 - BLU - Group 2
        Convergence (+5 Magic Attack and +5 Magic Accuracy per upgrade)
        Diffusion (-2 minutes 30 seconds per upgrade)
        Enchainment (Grants a 10 TP Bonus to Chain Affinity per upgrade)
        Assimilation (Increases maximum Blue Magic points by 1 per upgrade)
0x0C 0x00 - COR - Group 2
        Snake Eye (-2 minutes 30 seconds per upgrade)
        Fold (-2 minutes 30 seconds per upgrade)
        Winning Streak (+20 seconds per upgrade)
        Loaded Deck (-10% failure rate per upgrade)
0x0C 0x40 - PUP - Group 2
        Role Reversal (-30 seconds per upgrade)
        Ventriloquy (-15 seconds per upgrade)
        Fine-Tuning (Increase accuracy by 5, ranged accuracy by 5, evasion by 5, and magic defense by 5 per upgrade)
        Optimization (Increase attack by 5%, defense by 5%, and magic attack by 5 per upgrade)
0x0C 0x80 - DNC - Group 2
        Saber Dance (-30 seconds per upgrade)
        Fan Dance (-30 seconds per upgrade)
        No Foot Rise (+1 Finishing Move per upgrade)
        Closed Position (+3 Accuracy and +3 Evasion per upgrade)
0x0C 0xC0 - SCH - Group 2
        Altruism (Light Arts Stratagem (requires two charges). Increases the accuracy of your next white magic spell.)
        Focalization (Dark Arts Stratagem (requires two charges). Increases the accuracy of your next black magic spell.)
        Tranquility (Light Arts Stratagem (requires two charges). Your next white magic spell will generate less enmity.)
        Equanimity (Dark Arts Stratagem (requires two charges). Your next black magic spell will generate less enmity.)
        Enlightenment (Optimizes both white and black magic capabilities and allows access to both addenda for your next spell. Recast: 10min.)
        Stormsurge (Storm-type spells grant a bonus to attributes associated with their element. Initial bonus value: +3.)
*/
