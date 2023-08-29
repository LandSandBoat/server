-----------------------------------
-- Area: Selbina
--  NPC: Zaldon
-- Involved in Quests: Under the sea, A Boy's Dream
-- Starts and Finishes: Inside the Belly
-- !pos -13 -7 -5 248
-----------------------------------
local ID = require("scripts/zones/Selbina/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.fishRewards =
{
    ----- Quest 1 -----
    [     xi.items.DARK_BASS] = { gil =  10, items = { { chance =  4.9, itemId =                 xi.items.GREEN_ROCK } } },
    [ xi.items.VEYDAL_WRASSE] = { gil = 225, items = { { chance =    5, itemId =                 xi.items.NEBIMONITE }, { chance = 5, itemId = xi.items.SEASHELL } } },
    [      xi.items.OGRE_EEL] = { gil =  16, items = { { chance =  2.6, itemId =             xi.items.TURQUOISE_RING } }, title = xi.title.CORDON_BLEU_FISHER },
    [ xi.items.GIANT_CATFISH] = { gil =  50, items = { { chance =  7.2, itemId =                 xi.items.EARTH_WAND } }, title = xi.title.CORDON_BLEU_FISHER },
    ----- Quest 2 -----
    [  xi.items.ZAFMLUG_BASS] = { gil =  15, items = { { chance =  1.4, itemId =                  xi.items.BLUE_ROCK } } },
    [   xi.items.GIANT_DONKO] = { gil =  96, items = { { chance =  4.7, itemId = xi.items.BROKEN_HALCYON_FISHING_ROD } } },
    [     xi.items.BLADEFISH] = { gil = 200, items = { { chance = 11.7, itemId =                 xi.items.ROBBER_RIG } } },
    [xi.items.BHEFHEL_MARLIN] = { gil = 150, items = { { chance =  3.0, itemId =             xi.items.BRIGANDS_CHART }, { chance = 4.4, itemId = xi.items.PIRATES_CHART } } },
    [  xi.items.SILVER_SHARK] = { gil = 250, items = { { chance =  1.3, itemId =                    xi.items.TRIDENT } }, title = xi.title.ACE_ANGLER },
    ----- Quest 3 -----
    [xi.items.JUNGLE_CATFISH] = { gil = 300, items = { { chance =    3, itemId =    xi.items.BROKEN_HUME_FISHING_ROD } } },
    [   xi.items.GAVIAL_FISH] = { gil = 250, items = { { chance =    5, itemId =              xi.items.DRONE_EARRING } } },
    [  xi.items.EMPEROR_FISH] = { gil = 300, items = { { chance =    1, itemId =             xi.items.CUIR_HIGHBOOTS } } },
    [  xi.items.MORINABALIGI] = { gil = 300, items = { { chance =    5, itemId =                xi.items.CUIR_GLOVES } } },
    [      xi.items.PIRARUCU] = { gil = 516, items = { { chance =    5, itemId =                xi.items.WYVERN_SKIN }, { chance = 2.5, itemId =         xi.items.PEISTE_SKIN } } },
    [     xi.items.MEGALODON] = { gil = 532, items = { { chance =    3, itemId = xi.items.BROKEN_MITHRAN_FISHING_ROD }, { chance =   3, itemId = xi.items.MITHRAN_FISHING_ROD } } },
    ----- Quest 4 -----
    [    xi.items.PTERYGOTUS] = { gil = 390, items = { { chance =  6.6, itemId =               xi.items.LAPIS_LAZULI } } },
    [  xi.items.KALKANBALIGI] = { gil = 390, items = { { chance =  3.3, itemId =                xi.items.FLAT_SHIELD } } },
    [      xi.items.TAKITARO] = { gil = 350, items = { { chance =  2.1, itemId =         xi.items.PHILOSOPHERS_STONE } } },
    [    xi.items.SEA_ZOMBIE] = { gil = 350, items = { { chance = 23.4, itemId =             xi.items.DRILL_CALAMARY } } },
    [   xi.items.CAVE_CHERAX] = { gil = 800, items = { { chance = 23.2, itemId =                xi.items.DWARF_PUGIL } } },
    [       xi.items.TRICORN] = { gil = 810, items = { { chance =    4, itemId =     xi.items.CHUNK_OF_DARKSTEEL_ORE } } },
    [   xi.items.TURNABALIGI] = { gil = 340, items = { { chance =  0.8, itemId =          xi.items.CHUNK_OF_DARK_ORE }, { chance = 1.6, itemId = xi.items.CHUNK_OF_ICE_ORE }, { chance = 1.3, itemId = xi.items.CHUNK_OF_WATER_ORE } } },
    [    xi.items.TITANICTUS] = { gil = 350, items = { { chance =  1.4, itemId =              xi.items.ANCIENT_SWORD } }, title = xi.title.LU_SHANG_LIKE_FISHER_KING },
    ----- Unlisted -----
    [  xi.items.GIANT_CHIRAI] = { gil = 550, items = { { chance =  1.2, itemId =        xi.items.SPOOL_OF_TWINTHREAD } } },
    [   xi.items.GUGRUSAURUS] = { gil = 880, items = { { chance =  0.4, itemId =                xi.items.SABER_SHOOT } } },
    [           xi.items.LIK] = { gil = 880, items = { { chance =  0.5, itemId =         xi.items.SPOOL_OF_OPAL_SILK } } },
    [   xi.items.RYUGU_TITAN] = { gil = 800, items = { { chance =    1, itemId =            xi.items.MERCURIAL_SWORD } } },
    [   xi.items.GERROTHORAX] = { gil = 423, items = { { chance =  1.2, itemId =                xi.items.RISKY_PATCH } } },
    [    xi.items.MONKE_ONKE] = { gil = 150, items = { { chance =    2, itemId =       xi.items.PINCH_OF_POISON_DUST } } },
    [   xi.items.KILICBALIGI] = { gil = 150, items = { { chance =    2, itemId =           xi.items.RUSTY_GREATSWORD } } },
    [xi.items.ARMORED_PISCES] = { gil = 475, items = { { chance =  0.4, itemId =         xi.items.STOLID_BREASTPLATE } } },
    [     xi.items.MOLA_MOLA] = { gil = 478, items = { { chance =  1.8, itemId =            xi.items.MERCURIAL_SPEAR } } },
    [       xi.items.AHTAPOT] = { gil = 350, items = { { chance = 18.8, itemId =              xi.items.DECAYED_INGOT }, { chance = 10.6, itemId = xi.items.MILDEWY_INGOT } } },
    [       xi.items.LAKERDA] = { gil =  51, items = { { chance =    2, itemId =                      xi.items.PEARL }, { chance = 10.6, itemId =   xi.items.BLACK_PEARL } } },
}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc, trade)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
