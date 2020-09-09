-----------------------------------
-- Area: Mhaura
--  NPC: Willah Maratahya
-- Title Change NPC
-- !pos 23 -8 63 249
-----------------------------------
require("scripts/globals/titles")
-----------------------------------

local eventId = 10001
local titleInfo =
{
    {
        cost = 200,
        title =
        {
            tpz.title.PURVEYOR_IN_TRAINING,
            tpz.title.ONESTAR_PURVEYOR,
            tpz.title.TWOSTAR_PURVEYOR,
            tpz.title.THREESTAR_PURVEYOR,
        },
    },
    {
        cost = 300,
        title =
        {
            tpz.title.FOURSTAR_PURVEYOR,
            tpz.title.FIVESTAR_PURVEYOR,
            tpz.title.HEIR_OF_THE_GREAT_LIGHTNING,
            tpz.title.ORCISH_SERJEANT,
            tpz.title.BRONZE_QUADAV,
            tpz.title.YAGUDO_INITIATE,
            tpz.title.MOBLIN_KINSMAN,
            tpz.title.DYNAMIS_BUBURIMU_INTERLOPER,
        },
    },
    {
        cost = 400,
        title =
        {
            tpz.title.FODDERCHIEF_FLAYER,
            tpz.title.WARCHIEF_WRECKER,
            tpz.title.DREAD_DRAGON_SLAYER,
            tpz.title.OVERLORD_EXECUTIONER,
            tpz.title.DARK_DRAGON_SLAYER,
            tpz.title.ADAMANTKING_KILLER,
            tpz.title.BLACK_DRAGON_SLAYER,
            tpz.title.MANIFEST_MAULER,
            tpz.title.BEHEMOTHS_BANE,
            tpz.title.ARCHMAGE_ASSASSIN,
            tpz.title.HELLSBANE,
            tpz.title.GIANT_KILLER,
            tpz.title.LICH_BANISHER,
            tpz.title.JELLYBANE,
            tpz.title.BOGEYDOWNER,
            tpz.title.BEAKBENDER,
            tpz.title.SKULLCRUSHER,
            tpz.title.MORBOLBANE,
            tpz.title.GOLIATH_KILLER,
            tpz.title.MARYS_GUIDE,
        },
    },
    {
        cost = 500,
        title =
        {
            tpz.title.SIMURGH_POACHER,
            tpz.title.ROC_STAR,
            tpz.title.SERKET_BREAKER,
            tpz.title.CASSIENOVA,
            tpz.title.THE_HORNSPLITTER,
            tpz.title.TORTOISE_TORTURER,
            tpz.title.MON_CHERRY,
            tpz.title.BEHEMOTH_DETHRONER,
            tpz.title.THE_VIVISECTOR,
            tpz.title.DRAGON_ASHER,
            tpz.title.EXPEDITIONARY_TROOPER,
        },
    },
    {
        cost = 600,
        title =
        {
            tpz.title.ADAMANTKING_USURPER,
            tpz.title.OVERLORD_OVERTHROWER,
            tpz.title.DEITY_DEBUNKER,
            tpz.title.FAFNIR_SLAYER,
            tpz.title.ASPIDOCHELONE_SINKER,
            tpz.title.NIDHOGG_SLAYER,
            tpz.title.MAAT_MASHER,
            tpz.title.KIRIN_CAPTIVATOR,
            tpz.title.CACTROT_DESACELERADOR,
            tpz.title.LIFTER_OF_SHADOWS,
            tpz.title.TIAMAT_TROUNCER,
            tpz.title.VRTRA_VANQUISHER,
            tpz.title.WORLD_SERPENT_SLAYER,
            tpz.title.XOLOTL_XTRAPOLATOR,
            tpz.title.BOROKA_BELEAGUERER,
            tpz.title.OURYU_OVERWHELMER,
            tpz.title.VINEGAR_EVAPORATOR,
            tpz.title.VIRTUOUS_SAINT,
            tpz.title.BYEBYE_TAISAI,
            tpz.title.TEMENOS_LIBERATOR,
            tpz.title.APOLLYON_RAVAGER,
            tpz.title.WYRM_ASTONISHER,
            tpz.title.NIGHTMARE_AWAKENER,
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
