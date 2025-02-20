-----------------------------------
-- Area: Port Bastok
--  NPC: Styi Palneh
-- Title Change NPC
-- !pos 28 4 -15 236
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventId = 200
local titleInfo =
{
    {
        cost = 200,
        title =
        {
            xi.title.NEW_ADVENTURER,
            xi.title.BASTOK_WELCOMING_COMMITTEE,
            xi.title.BUCKET_FISHER,
            xi.title.PURSUER_OF_THE_PAST,
            xi.title.MOMMYS_HELPER,
            xi.title.HOT_DOG,
            xi.title.STAMPEDER,
            xi.title.RINGBEARER,
            xi.title.ZERUHN_SWEEPER,
            xi.title.TEARJERKER,
            xi.title.CRAB_CRUSHER,
            xi.title.BRYGID_APPROVED,
            xi.title.GUSTABERG_TOURIST,
            xi.title.MOGS_MASTER,
            xi.title.CERULEAN_SOLDIER,
            xi.title.DISCERNING_INDIVIDUAL,
            xi.title.VERY_DISCERNING_INDIVIDUAL,
            xi.title.EXTREMELY_DISCERNING_INDIVIDUAL,
            xi.title.APOSTATE_FOR_HIRE,
        },
    },
    {
        cost = 300,
        title =
        {
            xi.title.SHELL_OUTER,
            xi.title.PURSUER_OF_THE_TRUTH,
            xi.title.QIJIS_FRIEND,
            xi.title.TREASURE_SCAVENGER,
            xi.title.SAND_BLASTER,
            xi.title.DRACHENFALL_ASCETIC,
            xi.title.ASSASSIN_REJECT,
            xi.title.CERTIFIED_ADVENTURER,
            xi.title.QIJIS_RIVAL,
            xi.title.CONTEST_RIGGER,
            xi.title.KULATZ_BRIDGE_COMPANION,
            xi.title.AVENGER,
            xi.title.AIRSHIP_DENOUNCER,
            xi.title.STAR_OF_IFRIT,
            xi.title.PURPLE_BELT,
            xi.title.MOGS_KIND_MASTER,
            xi.title.TRASH_COLLECTOR,
        },
    },
    {
        cost = 400,
        title =
        {
            xi.title.BEADEAUX_SURVEYOR,
            xi.title.PILGRIM_TO_DEM,
            xi.title.BLACK_DEATH,
            xi.title.DARK_SIDER,
            xi.title.SHADOW_WALKER,
            xi.title.SORROW_DROWNER,
            xi.title.STEAMING_SHEEP_REGULAR,
            xi.title.SHADOW_BANISHER,
            xi.title.MOGS_EXCEPTIONALLY_KIND_MASTER,
            xi.title.HYPER_ULTRA_SONIC_ADVENTURER,
            xi.title.GOBLIN_IN_DISGUISE,
            xi.title.BASTOKS_SECOND_BEST_DRESSED,
        },
    },
    {
        cost = 500,
        title =
        {
            xi.title.PARAGON_OF_WARRIOR_EXCELLENCE,
            xi.title.PARAGON_OF_MONK_EXCELLENCE,
            xi.title.PARAGON_OF_DARK_KNIGHT_EXCELLENCE,
            xi.title.HEIR_OF_THE_GREAT_EARTH,
            xi.title.MOGS_LOVING_MASTER,
            xi.title.HERO_AMONG_HEROES,
            xi.title.DYNAMIS_BASTOK_INTERLOPER,
            xi.title.MASTER_OF_MANIPULATION,
        },
    },
    {
        cost = 600,
        title =
        {
            xi.title.LEGIONNAIRE,
            xi.title.DECURION,
            xi.title.CENTURION,
            xi.title.JUNIOR_MUSKETEER,
            xi.title.SENIOR_MUSKETEER,
            xi.title.MUSKETEER_COMMANDER,
            xi.title.GOLD_MUSKETEER,
            xi.title.PRAEFECTUS,
            xi.title.SENIOR_GOLD_MUSKETEER,
            xi.title.PRAEFECTUS_CASTRORUM,
            xi.title.ANVIL_ADVOCATE,
            xi.title.FORGE_FANATIC,
            xi.title.ACCOMPLISHED_BLACKSMITH,
            xi.title.ARMORY_OWNER,
            xi.title.TRINKET_TURNER,
            xi.title.SILVER_SMELTER,
            xi.title.ACCOMPLISHED_GOLDSMITH,
            xi.title.JEWELRY_STORE_OWNER,
            xi.title.FORMULA_FIDDLER,
            xi.title.POTION_POTENTATE,
            xi.title.ACCOMPLISHED_ALCHEMIST,
            xi.title.APOTHECARY_OWNER,
        },
    },
    {
        cost = 700,
        title =
        {
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
