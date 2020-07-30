-----------------------------------
-- Area: Windurst Walls
--  NPC: Burute-Sorute
-- Type: Title Change NPC
-- !pos 0.080 -10.765 5.394 239
-----------------------------------
require("scripts/globals/titles")
-----------------------------------

local eventId = 10004
local titleInfo =
{
    {
        cost = 200,
        title =
        {
            tpz.title.NEW_ADVENTURER,
            tpz.title.CAT_BURGLAR_GROUPIE,
            tpz.title.CRAWLER_CULLER,
            tpz.title.STAR_ONION_BRIGADE_MEMBER,
            tpz.title.SOB_SUPER_HERO,
            tpz.title.EDITORS_HATCHET_MAN,
            tpz.title.SUPER_MODEL,
            tpz.title.FAST_FOOD_DELIVERER,
            tpz.title.CARDIAN_TUTOR,
            tpz.title.KISSER_MAKEUPPER,
            tpz.title.LOWER_THAN_THE_LOWEST_TUNNEL_WORM,
            tpz.title.FRESH_NORTH_WINDS_RECRUIT,
            tpz.title.HEAVENS_TOWER_GATEHOUSE_RECRUIT,
            tpz.title.NEW_BEST_OF_THE_WEST_RECRUIT,
            tpz.title.NEW_BUUMAS_BOOMERS_RECRUIT,
            tpz.title.MOGS_MASTER,
            tpz.title.EMERALD_EXTERMINATOR,
            tpz.title.DISCERNING_INDIVIDUAL,
            tpz.title.VERY_DISCERNING_INDIVIDUAL,
            tpz.title.EXTREMELY_DISCERNING_INDIVIDUAL,
            tpz.title.BABBANS_TRAVELING_COMPANION
        },
    },
    {
        cost = 300,
        title =
        {
            tpz.title.SAVIOR_OF_KNOWLEDGE,
            tpz.title.STAR_ONION_BRIGADIER,
            tpz.title.QUICK_FIXER,
            tpz.title.FAKEMOUSTACHED_INVESTIGATOR,
            tpz.title.CUPIDS_FLORIST,
            tpz.title.TARUTARU_MURDER_SUSPECT,
            tpz.title.HEXER_VEXER,
            tpz.title.GREAT_GRAPPLER_SCORPIO,
            tpz.title.CERTIFIED_ADVENTURER,
            tpz.title.BOND_FIXER,
            tpz.title.FOSSILIZED_SEA_FARER,
            tpz.title.MOGS_KIND_MASTER,
        },
    },
    {
        cost = 400,
        title =
        {
            tpz.title.HAKKURURINKURUS_BENEFACTOR,
            tpz.title.SPOILSPORT,
            tpz.title.PILGRIM_TO_MEA,
            tpz.title.TOTAL_LOSER,
            tpz.title.DOCTOR_SHANTOTTOS_FLAVOR_OF_THE_MONTH,
            tpz.title.THE_FANGED_ONE,
            tpz.title.RAINBOW_WEAVER,
            tpz.title.FINE_TUNER,
            tpz.title.DOCTOR_SHANTOTTOS_GUINEA_PIG,
            tpz.title.GHOSTIE_BUSTER,
            tpz.title.NIGHT_SKY_NAVIGATOR,
            tpz.title.DELIVERER_OF_TEARFUL_NEWS,
            tpz.title.DOWN_PIPER_PIPEUPPERER,
            tpz.title.DOCTOR_YORANORAN_SUPPORTER,
            tpz.title.DOCTOR_SHANTOTTO_SUPPORTER,
            tpz.title.PROFESSOR_KORUMORU_SUPPORTER,
            tpz.title.STARORDAINED_WARRIOR,
            tpz.title.SHADOW_BANISHER,
            tpz.title.MOGS_EXCEPTIONALLY_KIND_MASTER,
            tpz.title.FRIEND_OF_THE_HELMED,
            tpz.title.DEED_VERIFIER,
        },
    },
    {
        cost = 500,
        title =
        {
            tpz.title.PARAGON_OF_THIEF_EXCELLENCE,
            tpz.title.PARAGON_OF_BLACK_MAGE_EXCELLENCE,
            tpz.title.PARAGON_OF_RANGER_EXCELLENCE,
            tpz.title.PARAGON_OF_SUMMONER_EXCELLENCE,
            tpz.title.CERTIFIED_RHINOSTERY_VENTURER,
            tpz.title.DREAM_DWELLER,
            tpz.title.HERO_ON_BEHALF_OF_WINDURST,
            tpz.title.VICTOR_OF_THE_BALGA_CONTEST,
            tpz.title.MOGS_LOVING_MASTER,
            tpz.title.HEIR_OF_THE_NEW_MOON,
            tpz.title.SEEKER_OF_TRUTH,
            tpz.title.FUGITIVE_MINISTER_BOUNTY_HUNTER,
            tpz.title.GUIDING_STAR,
            tpz.title.VESTAL_CHAMBERLAIN,
            tpz.title.DYNAMIS_WINDURST_INTERLOPER,
            tpz.title.HEIR_TO_THE_REALM_OF_DREAMS,
        },
    },
    {
        cost = 600,
        title =
        {
            tpz.title.FREESWORD,
            tpz.title.MERCENARY,
            tpz.title.MERCENARY_CAPTAIN,
            tpz.title.COMBAT_CASTER,
            tpz.title.TACTICIAN_MAGICIAN,
            tpz.title.WISE_WIZARD,
            tpz.title.PATRIARCH_PROTECTOR,
            tpz.title.CASTER_CAPTAIN,
            tpz.title.MASTER_CASTER,
            tpz.title.MERCENARY_MAJOR,
            tpz.title.KNITTING_KNOWITALL,
            tpz.title.LOOM_LUNATIC,
            tpz.title.ACCOMPLISHED_WEAVER,
            tpz.title.BOUTIQUE_OWNER,
            tpz.title.BONE_BEAUTIFIER,
            tpz.title.SHELL_SCRIMSHANDER,
            tpz.title.ACCOMPLISHED_BONEWORKER,
            tpz.title.CURIOSITY_SHOP_OWNER,
            tpz.title.FASTRIVER_FISHER,
            tpz.title.COASTLINE_CASTER,
            tpz.title.ACCOMPLISHED_ANGLER,
            tpz.title.FISHMONGER_OWNER,
            tpz.title.GOURMAND_GRATIFIER,
            tpz.title.BANQUET_BESTOWER,
            tpz.title.ACCOMPLISHED_CHEF,
            tpz.title.RESTAURANT_OWNER,
        },
    },
    {
        cost = 700,
        title =
        {
            tpz.title.MOG_HOUSE_HANDYPERSON,
            tpz.title.ARRESTER_OF_THE_ASCENSION,
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
