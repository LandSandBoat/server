-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Moozo-Koozo
--  Title Change NPC
-- !pos 83 0 120 230
-------------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

local eventId = 675
local titleInfo =
{
    {
        cost = 200,
        title =
        {
            tpz.title.NEW_ADVENTURER,
            tpz.title.BEAN_CUISINE_SALTER,
            tpz.title.DAYBREAK_GAMBLER,
            tpz.title.ENTRANCE_DENIED,
            tpz.title.RABBITER,
            tpz.title.ROYAL_GRAVE_KEEPER,
            tpz.title.COURIER_EXTRAORDINAIRE,
            tpz.title.RONFAURIAN_RESCUER,
            tpz.title.PICKPOCKET_PINCHER,
            tpz.title.THE_PURE_ONE,
            tpz.title.LOST_CHILD_OFFICER,
            tpz.title.SILENCER_OF_THE_LAMBS,
            tpz.title.LOST_AMP_FOUND_OFFICER,
            tpz.title.GREEN_GROCER,
            tpz.title.THE_BENEVOLENT_ONE,
            tpz.title.KNIGHT_IN_TRAINING,
            tpz.title.ADVERTISING_EXECUTIVE,
            tpz.title.FAMILY_COUNSELOR,
            tpz.title.MOGS_MASTER,
            tpz.title.VERMILLION_VENTURER,
            tpz.title.DISCERNING_INDIVIDUAL,
            tpz.title.VERY_DISCERNING_INDIVIDUAL,
            tpz.title.EXTREMELY_DISCERNING_INDIVIDUAL,
        },
    },
    {
        cost = 300,
        title =
        {
            tpz.title.SHEEPS_MILK_DELIVERER,
            tpz.title.THE_PIOUS_ONE,
            tpz.title.APIARIST,
            tpz.title.FAITH_LIKE_A_CANDLE,
            tpz.title.LIZARD_SKINNER,
            tpz.title.BUG_CATCHER,
            tpz.title.SPELUNKER,
            tpz.title.ARMS_TRADER,
            tpz.title.THIRDRATE_ORGANIZER,
            tpz.title.ROYAL_WEDDING_PLANNER,
            tpz.title.CONSORT_CANDIDATE,
            tpz.title.CERTIFIED_ADVENTURER,
            tpz.title.VAMPIRE_HUNTER_DMINUS,
            tpz.title.A_MOSS_KIND_PERSON,
            tpz.title.FANG_FINDER,
            tpz.title.TRAVELING_MEDICINE_MAN,
            tpz.title.CAT_SKINNER,
            tpz.title.CARP_DIEM,
            tpz.title.SECONDRATE_ORGANIZER,
            tpz.title.MOGS_KIND_MASTER,
        },
    },
    {
        cost = 400,
        title =
        {
            tpz.title.FIRSTRATE_ORGANIZER,
            tpz.title.PILGRIM_TO_HOLLA,
            tpz.title.TRIED_AND_TESTED_KNIGHT,
            tpz.title.HEIR_TO_THE_HOLY_CREST,
            tpz.title.OBSIDIAN_STORM,
            tpz.title.TALKS_WITH_TONBERRIES,
            tpz.title.SHADOW_BANISHER,
            tpz.title.MOGS_EXCEPTIONALLY_KIND_MASTER,
        },
    },
    {
        cost = 500,
        title =
        {
            tpz.title.SEARING_STAR,
            tpz.title.STRIKING_STAR,
            tpz.title.SOOTHING_STAR,
            tpz.title.SABLE_STAR,
            tpz.title.SCARLET_STAR,
            tpz.title.SONIC_STAR,
            tpz.title.SAINTLY_STAR,
            tpz.title.SHADOWY_STAR,
            tpz.title.SAVAGE_STAR,
            tpz.title.SINGING_STAR,
            tpz.title.SNIPING_STAR,
            tpz.title.SLICING_STAR,
            tpz.title.SNEAKING_STAR,
            tpz.title.SPEARING_STAR,
            tpz.title.SUMMONING_STAR,
            tpz.title.SAPPHIRE_STAR,
            tpz.title.SURGING_STAR,
            tpz.title.SWAYING_STAR,
            tpz.title.SPRIGHTLY_STAR,
            tpz.title.SAGACIOUS_STAR,
        },
    },
    {
        cost = 600,
        title =
        {
            tpz.title.ROOK_BUSTER,
            tpz.title.BANNERET,
            tpz.title.GOLD_BALLI_STAR,
            tpz.title.MYTHRIL_BALLI_STAR,
            tpz.title.SILVER_BALLI_STAR,
            tpz.title.BRONZE_BALLI_STAR,
            tpz.title.BALLISTAGER,
            tpz.title.FINAL_BALLI_STAR,
            tpz.title.BALLI_STAR_ROYALE,
            tpz.title.PARAGON_OF_RED_MAGE_EXCELLENCE,
            tpz.title.PARAGON_OF_WHITE_MAGE_EXCELLENCE,
            tpz.title.PARAGON_OF_PALADIN_EXCELLENCE,
            tpz.title.PARAGON_OF_DRAGOON_EXCELLENCE,
            tpz.title.HEIR_OF_THE_GREAT_ICE,
            tpz.title.MOGS_LOVING_MASTER,
            tpz.title.SAN_DORIAN_ROYAL_HEIR,
            tpz.title.DYNAMIS_SAN_DORIA_INTERLOPER,
        },
    },
    {
        cost = 700,
        title =
        {
            tpz.title.ROYAL_ARCHER,
            tpz.title.ROYAL_SPEARMAN,
            tpz.title.ROYAL_SQUIRE,
            tpz.title.ROYAL_SWORDSMAN,
            tpz.title.ROYAL_CAVALIER,
            tpz.title.ROYAL_GUARD,
            tpz.title.GRAND_KNIGHT_OF_THE_REALM,
            tpz.title.GRAND_TEMPLE_KNIGHT,
            tpz.title.RESERVE_KNIGHT_CAPTAIN,
            tpz.title.ELITE_ROYAL_GUARD,
            tpz.title.WOOD_WORSHIPER,
            tpz.title.LUMBER_LATHER,
            tpz.title.ACCOMPLISHED_CARPENTER,
            tpz.title.ANVIL_ADVOCATE,
            tpz.title.FORGE_FANATIC,
            tpz.title.ACCOMPLISHED_BLACKSMITH,
            tpz.title.ARMORY_OWNER,
            tpz.title.HIDE_HANDLER,
            tpz.title.LEATHER_LAUDER,
            tpz.title.ACCOMPLISHED_TANNER,
            tpz.title.SHOESHOP_OWNER,
            tpz.title.MOG_HOUSE_HANDYPERSON,
        },
    },
}

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.title.changerOnTrigger(player, eventId, titleInfo)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.title.changerOnEventFinish(player, csid, option, eventId, titleInfo)
end
