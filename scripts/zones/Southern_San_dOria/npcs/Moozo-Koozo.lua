-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Moozo-Koozo
--  Title Change NPC
-- !pos 83 0 120 230
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventId = 675
local titleInfo =
{
    {
        cost = 200,
        title =
        {
            xi.title.NEW_ADVENTURER,
            xi.title.BEAN_CUISINE_SALTER,
            xi.title.DAYBREAK_GAMBLER,
            xi.title.ENTRANCE_DENIED,
            xi.title.RABBITER,
            xi.title.ROYAL_GRAVE_KEEPER,
            xi.title.COURIER_EXTRAORDINAIRE,
            xi.title.RONFAURIAN_RESCUER,
            xi.title.PICKPOCKET_PINCHER,
            xi.title.THE_PURE_ONE,
            xi.title.LOST_CHILD_OFFICER,
            xi.title.SILENCER_OF_THE_LAMBS,
            xi.title.LOST_FOUND_OFFICER,
            xi.title.GREEN_GROCER,
            xi.title.THE_BENEVOLENT_ONE,
            xi.title.KNIGHT_IN_TRAINING,
            xi.title.ADVERTISING_EXECUTIVE,
            xi.title.FAMILY_COUNSELOR,
            xi.title.MOGS_MASTER,
            xi.title.VERMILLION_VENTURER,
            xi.title.DISCERNING_INDIVIDUAL,
            xi.title.VERY_DISCERNING_INDIVIDUAL,
            xi.title.EXTREMELY_DISCERNING_INDIVIDUAL,
        },
    },
    {
        cost = 300,
        title =
        {
            xi.title.SHEEPS_MILK_DELIVERER,
            xi.title.THE_PIOUS_ONE,
            xi.title.APIARIST,
            xi.title.FAITH_LIKE_A_CANDLE,
            xi.title.LIZARD_SKINNER,
            xi.title.BUG_CATCHER,
            xi.title.SPELUNKER,
            xi.title.ARMS_TRADER,
            xi.title.THIRD_RATE_ORGANIZER,
            xi.title.ROYAL_WEDDING_PLANNER,
            xi.title.CONSORT_CANDIDATE,
            xi.title.CERTIFIED_ADVENTURER,
            xi.title.VAMPIRE_HUNTER_D_MINUS,
            xi.title.A_MOSS_KIND_PERSON,
            xi.title.FANG_FINDER,
            xi.title.TRAVELING_MEDICINE_MAN,
            xi.title.CAT_SKINNER,
            xi.title.CARP_DIEM,
            xi.title.SECOND_RATE_ORGANIZER,
            xi.title.MOGS_KIND_MASTER,
        },
    },
    {
        cost = 400,
        title =
        {
            xi.title.FIRST_RATE_ORGANIZER,
            xi.title.PILGRIM_TO_HOLLA,
            xi.title.TRIED_AND_TESTED_KNIGHT,
            xi.title.HEIR_TO_THE_HOLY_CREST,
            xi.title.OBSIDIAN_STORM,
            xi.title.TALKS_WITH_TONBERRIES,
            xi.title.SHADOW_BANISHER,
            xi.title.MOGS_EXCEPTIONALLY_KIND_MASTER,
        },
    },
    {
        cost = 500,
        title =
        {
            xi.title.SEARINGSTAR,
            xi.title.STRIKINGSTAR,
            xi.title.SOOTHINGSTAR,
            xi.title.SABLESTAR,
            xi.title.SCARLETSTAR,
            xi.title.SONICSTAR,
            xi.title.SAINTLYSTAR,
            xi.title.SHADOWYSTAR,
            xi.title.SAVAGESTAR,
            xi.title.SINGINGSTAR,
            xi.title.SNIPINGSTAR,
            xi.title.SLICINGSTAR,
            xi.title.SNEAKINGSTAR,
            xi.title.SPEARINGSTAR,
            xi.title.SUMMONINGSTAR,
            xi.title.SAPPHIRESTAR,
            xi.title.SURGINGSTAR,
            xi.title.SWAYINGSTAR,
            xi.title.SPRIGHTLYSTAR,
            xi.title.SAGACIOUSSTAR,
        },
    },
    {
        cost = 600,
        title =
        {
            xi.title.ROOK_BUSTER,
            xi.title.BANNERET,
            xi.title.GOLD_BALLISTAR,
            xi.title.MYTHRIL_BALLISTAR,
            xi.title.SILVER_BALLISTAR,
            xi.title.BRONZE_BALLISTAR,
            xi.title.BALLISTAGER,
            xi.title.FINAL_BALLISTAR,
            xi.title.BALLISTAR_ROYALE,
            xi.title.PARAGON_OF_RED_MAGE_EXCELLENCE,
            xi.title.PARAGON_OF_WHITE_MAGE_EXCELLENCE,
            xi.title.PARAGON_OF_PALADIN_EXCELLENCE,
            xi.title.PARAGON_OF_DRAGOON_EXCELLENCE,
            xi.title.HEIR_OF_THE_GREAT_ICE,
            xi.title.MOGS_LOVING_MASTER,
            xi.title.SAN_DORIAN_ROYAL_HEIR,
            xi.title.DYNAMIS_SAN_DORIA_INTERLOPER,
        },
    },
    {
        cost = 700,
        title =
        {
            xi.title.ROYAL_ARCHER,
            xi.title.ROYAL_SPEARMAN,
            xi.title.ROYAL_SQUIRE,
            xi.title.ROYAL_SWORDSMAN,
            xi.title.ROYAL_CAVALIER,
            xi.title.ROYAL_GUARD,
            xi.title.GRAND_KNIGHT_OF_THE_REALM,
            xi.title.GRAND_TEMPLE_KNIGHT,
            xi.title.RESERVE_KNIGHT_CAPTAIN,
            xi.title.ELITE_ROYAL_GUARD,
            xi.title.WOOD_WORSHIPER,
            xi.title.LUMBER_LATHER,
            xi.title.ACCOMPLISHED_CARPENTER,
            xi.title.ANVIL_ADVOCATE,
            xi.title.FORGE_FANATIC,
            xi.title.ACCOMPLISHED_BLACKSMITH,
            xi.title.ARMORY_OWNER,
            xi.title.HIDE_HANDLER,
            xi.title.LEATHER_LAUDER,
            xi.title.ACCOMPLISHED_TANNER,
            xi.title.SHOESHOP_OWNER,
            xi.title.MOG_HOUSE_HANDYPERSON,
        },
    },
}

entity.onTrigger = function(player, npc)
    xi.titleChanger.onTrigger(player, eventId, titleInfo)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.titleChanger.onEventFinish(player, csid, option, eventId, titleInfo)
end

return entity
