-----------------------------------
-- Area: Windurst Walls
--  NPC: Burute-Sorute
-- Type: Title Change NPC
-- !pos 0.080 -10.765 5.394 239
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventId = 10004
local titleInfo =
{
    {
        cost = 200,
        title =
        {
            xi.title.NEW_ADVENTURER,
            xi.title.CAT_BURGLAR_GROUPIE,
            xi.title.CRAWLER_CULLER,
            xi.title.STAR_ONION_BRIGADE_MEMBER,
            xi.title.SOB_SUPER_HERO,
            xi.title.EDITORS_HATCHET_MAN,
            xi.title.SUPER_MODEL,
            xi.title.FAST_FOOD_DELIVERER,
            xi.title.CARDIAN_TUTOR,
            xi.title.KISSER_MAKE_UPPER,
            xi.title.LOWER_THAN_THE_LOWEST_TUNNEL_WORM,
            xi.title.FRESH_NORTH_WINDS_RECRUIT,
            xi.title.HEAVENS_TOWER_GATEHOUSE_RECRUIT,
            xi.title.NEW_BEST_OF_THE_WEST_RECRUIT,
            xi.title.NEW_BUUMAS_BOOMERS_RECRUIT,
            xi.title.MOGS_MASTER,
            xi.title.EMERALD_EXTERMINATOR,
            xi.title.DISCERNING_INDIVIDUAL,
            xi.title.VERY_DISCERNING_INDIVIDUAL,
            xi.title.EXTREMELY_DISCERNING_INDIVIDUAL,
            xi.title.BABBANS_TRAVELING_COMPANION
        },
    },
    {
        cost = 300,
        title =
        {
            xi.title.SAVIOR_OF_KNOWLEDGE,
            xi.title.STAR_ONION_BRIGADIER,
            xi.title.QUICK_FIXER,
            xi.title.FAKE_MOUSTACHED_INVESTIGATOR,
            xi.title.CUPIDS_FLORIST,
            xi.title.TARUTARU_MURDER_SUSPECT,
            xi.title.HEXER_VEXER,
            xi.title.GREAT_GRAPPLER_SCORPIO,
            xi.title.CERTIFIED_ADVENTURER,
            xi.title.BOND_FIXER,
            xi.title.FOSSILIZED_SEA_FARER,
            xi.title.MOGS_KIND_MASTER,
        },
    },
    {
        cost = 400,
        title =
        {
            xi.title.HAKKURU_RINKURUS_BENEFACTOR,
            xi.title.SPOILSPORT,
            xi.title.PILGRIM_TO_MEA,
            xi.title.TOTAL_LOSER,
            xi.title.DOCTOR_SHANTOTTOS_FLAVOR_OF_THE_MONTH,
            xi.title.THE_FANGED_ONE,
            xi.title.RAINBOW_WEAVER,
            xi.title.FINE_TUNER,
            xi.title.DOCTOR_SHANTOTTOS_GUINEA_PIG,
            xi.title.GHOSTIE_BUSTER,
            xi.title.NIGHT_SKY_NAVIGATOR,
            xi.title.DELIVERER_OF_TEARFUL_NEWS,
            xi.title.DOWN_PIPER_PIPE_UPPERER,
            xi.title.DOCTOR_YORAN_ORAN_SUPPORTER,
            xi.title.DOCTOR_SHANTOTTO_SUPPORTER,
            xi.title.PROFESSOR_KORU_MORU_SUPPORTER,
            xi.title.STAR_ORDAINED_WARRIOR,
            xi.title.SHADOW_BANISHER,
            xi.title.MOGS_EXCEPTIONALLY_KIND_MASTER,
            xi.title.FRIEND_OF_THE_HELMED,
            xi.title.DEED_VERIFIER,
        },
    },
    {
        cost = 500,
        title =
        {
            xi.title.PARAGON_OF_THIEF_EXCELLENCE,
            xi.title.PARAGON_OF_BLACK_MAGE_EXCELLENCE,
            xi.title.PARAGON_OF_RANGER_EXCELLENCE,
            xi.title.PARAGON_OF_SUMMONER_EXCELLENCE,
            xi.title.CERTIFIED_RHINOSTERY_VENTURER,
            xi.title.DREAM_DWELLER,
            xi.title.HERO_ON_BEHALF_OF_WINDURST,
            xi.title.VICTOR_OF_THE_BALGA_CONTEST,
            xi.title.MOGS_LOVING_MASTER,
            xi.title.HEIR_OF_THE_NEW_MOON,
            xi.title.SEEKER_OF_TRUTH,
            xi.title.FUGITIVE_MINISTER_BOUNTY_HUNTER,
            xi.title.GUIDING_STAR,
            xi.title.VESTAL_CHAMBERLAIN,
            xi.title.DYNAMIS_WINDURST_INTERLOPER,
            xi.title.HEIR_TO_THE_REALM_OF_DREAMS,
        },
    },
    {
        cost = 600,
        title =
        {
            xi.title.FREESWORD,
            xi.title.MERCENARY,
            xi.title.MERCENARY_CAPTAIN,
            xi.title.COMBAT_CASTER,
            xi.title.TACTICIAN_MAGICIAN,
            xi.title.WISE_WIZARD,
            xi.title.PATRIARCH_PROTECTOR,
            xi.title.CASTER_CAPTAIN,
            xi.title.MASTER_CASTER,
            xi.title.MERCENARY_MAJOR,
            xi.title.KNITTING_KNOW_IT_ALL,
            xi.title.LOOM_LUNATIC,
            xi.title.ACCOMPLISHED_WEAVER,
            xi.title.BOUTIQUE_OWNER,
            xi.title.BONE_BEAUTIFIER,
            xi.title.SHELL_SCRIMSHANDER,
            xi.title.ACCOMPLISHED_BONEWORKER,
            xi.title.CURIOSITY_SHOP_OWNER,
            xi.title.FASTRIVER_FISHER,
            xi.title.COASTLINE_CASTER,
            xi.title.ACCOMPLISHED_ANGLER,
            xi.title.FISHMONGER_OWNER,
            xi.title.GOURMAND_GRATIFIER,
            xi.title.BANQUET_BESTOWER,
            xi.title.ACCOMPLISHED_CHEF,
            xi.title.RESTAURANT_OWNER,
        },
    },
    {
        cost = 700,
        title =
        {
            xi.title.MOG_HOUSE_HANDYPERSON,
            xi.title.ARRESTER_OF_THE_ASCENSION,
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
