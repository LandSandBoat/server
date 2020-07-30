-----------------------------------
-- Area: Port Bastok
--  NPC: Styi Palneh
-- Title Change NPC
-- !pos 28 4 -15 236
-----------------------------------
require("scripts/globals/titles")
-----------------------------------

local eventId = 200
local titleInfo =
{
    {
        cost = 200,
        title =
        {
            tpz.title.NEW_ADVENTURER,
            tpz.title.BASTOK_WELCOMING_COMMITTEE,
            tpz.title.BUCKET_FISHER,
            tpz.title.PURSUER_OF_THE_PAST,
            tpz.title.MOMMYS_HELPER,
            tpz.title.HOT_DOG,
            tpz.title.STAMPEDER,
            tpz.title.RINGBEARER,
            tpz.title.ZERUHN_SWEEPER,
            tpz.title.TEARJERKER,
            tpz.title.CRAB_CRUSHER,
            tpz.title.BRYGIDAPPROVED,
            tpz.title.GUSTABERG_TOURIST,
            tpz.title.MOGS_MASTER,
            tpz.title.CERULEAN_SOLDIER,
            tpz.title.DISCERNING_INDIVIDUAL,
            tpz.title.VERY_DISCERNING_INDIVIDUAL,
            tpz.title.EXTREMELY_DISCERNING_INDIVIDUAL,
            tpz.title.APOSTATE_FOR_HIRE,
        },
    },
    {
        cost = 300,
        title =
        {
            tpz.title.SHELL_OUTER,
            tpz.title.PURSUER_OF_THE_TRUTH,
            tpz.title.QIJIS_FRIEND,
            tpz.title.TREASURE_SCAVENGER,
            tpz.title.SAND_BLASTER,
            tpz.title.DRACHENFALL_ASCETIC,
            tpz.title.ASSASSIN_REJECT,
            tpz.title.CERTIFIED_ADVENTURER,
            tpz.title.QIJIS_RIVAL,
            tpz.title.CONTEST_RIGGER,
            tpz.title.KULATZ_BRIDGE_COMPANION,
            tpz.title.AVENGER,
            tpz.title.AIRSHIP_DENOUNCER,
            tpz.title.STAR_OF_IFRIT,
            tpz.title.PURPLE_BELT,
            tpz.title.MOGS_KIND_MASTER,
            tpz.title.TRASH_COLLECTOR,
        },
    },
    {
        cost = 400,
        title =
        {
            tpz.title.BEADEAUX_SURVEYOR,
            tpz.title.PILGRIM_TO_DEM,
            tpz.title.BLACK_DEATH,
            tpz.title.DARK_SIDER,
            tpz.title.SHADOW_WALKER,
            tpz.title.SORROW_DROWNER,
            tpz.title.STEAMING_SHEEP_REGULAR,
            tpz.title.SHADOW_BANISHER,
            tpz.title.MOGS_EXCEPTIONALLY_KIND_MASTER,
            tpz.title.HYPER_ULTRA_SONIC_ADVENTURER,
            tpz.title.GOBLIN_IN_DISGUISE,
            tpz.title.BASTOKS_SECOND_BEST_DRESSED,
        },
    },
    {
        cost = 500,
        title =
        {
            tpz.title.PARAGON_OF_WARRIOR_EXCELLENCE,
            tpz.title.PARAGON_OF_MONK_EXCELLENCE,
            tpz.title.PARAGON_OF_DARK_KNIGHT_EXCELLENCE,
            tpz.title.HEIR_OF_THE_GREAT_EARTH,
            tpz.title.MOGS_LOVING_MASTER,
            tpz.title.HERO_AMONG_HEROES,
            tpz.title.DYNAMIS_BASTOK_INTERLOPER,
            tpz.title.MASTER_OF_MANIPULATION,
        },
    },
    {
        cost = 600,
        title =
        {
            tpz.title.LEGIONNAIRE,
            tpz.title.DECURION,
            tpz.title.CENTURION,
            tpz.title.JUNIOR_MUSKETEER,
            tpz.title.SENIOR_MUSKETEER,
            tpz.title.MUSKETEER_COMMANDER,
            tpz.title.GOLD_MUSKETEER,
            tpz.title.PRAEFECTUS,
            tpz.title.SENIOR_GOLD_MUSKETEER,
            tpz.title.PRAEFECTUS_CASTRORUM,
            tpz.title.ANVIL_ADVOCATE,
            tpz.title.FORGE_FANATIC,
            tpz.title.ACCOMPLISHED_BLACKSMITH,
            tpz.title.ARMORY_OWNER,
            tpz.title.TRINKET_TURNER,
            tpz.title.SILVER_SMELTER,
            tpz.title.ACCOMPLISHED_GOLDSMITH,
            tpz.title.JEWELRY_STORE_OWNER,
            tpz.title.FORMULA_FIDDLER,
            tpz.title.POTION_POTENTATE,
            tpz.title.ACCOMPLISHED_ALCHEMIST,
            tpz.title.APOTHECARY_OWNER,
        },
    },
    {
        cost = 700,
        title =
        {
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
