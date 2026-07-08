-----------------------------------
-- Area: Mhaura
--  NPC: Willah Maratahya
-- Title Change NPC
-- !pos 23 -8 63 249
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventId = 10001
local titleInfo =
{
    {
        cost = 200,
        title =
        {
            xi.title.PURVEYOR_IN_TRAINING,
            xi.title.ONE_STAR_PURVEYOR,
            xi.title.TWO_STAR_PURVEYOR,
            xi.title.THREE_STAR_PURVEYOR,
        },
    },
    {
        cost = 300,
        title =
        {
            xi.title.FOUR_STAR_PURVEYOR,
            xi.title.FIVE_STAR_PURVEYOR,
            xi.title.HEIR_OF_THE_GREAT_LIGHTNING,
            xi.title.ORCISH_SERJEANT,
            xi.title.BRONZE_QUADAV,
            xi.title.YAGUDO_INITIATE,
            xi.title.MOBLIN_KINSMAN,
            xi.title.DYNAMIS_BUBURIMU_INTERLOPER,
        },
    },
    {
        cost = 400,
        title =
        {
            xi.title.FODDERCHIEF_FLAYER,
            xi.title.WARCHIEF_WRECKER,
            xi.title.DREAD_DRAGON_SLAYER,
            xi.title.OVERLORD_EXECUTIONER,
            xi.title.DARK_DRAGON_SLAYER,
            xi.title.ADAMANTKING_KILLER,
            xi.title.BLACK_DRAGON_SLAYER,
            xi.title.MANIFEST_MAULER,
            xi.title.BEHEMOTHS_BANE,
            xi.title.ARCHMAGE_ASSASSIN,
            xi.title.HELLSBANE,
            xi.title.GIANT_KILLER,
            xi.title.LICH_BANISHER,
            xi.title.JELLYBANE,
            xi.title.BOGEYDOWNER,
            xi.title.BEAKBENDER,
            xi.title.SKULLCRUSHER,
            xi.title.MORBOLBANE,
            xi.title.GOLIATH_KILLER,
            xi.title.MARYS_GUIDE,
        },
    },
    {
        cost = 500,
        title =
        {
            xi.title.SIMURGH_POACHER,
            xi.title.ROC_STAR,
            xi.title.SERKET_BREAKER,
            xi.title.CASSIENOVA,
            xi.title.THE_HORNSPLITTER,
            xi.title.TORTOISE_TORTURER,
            xi.title.MON_CHERRY,
            xi.title.BEHEMOTH_DETHRONER,
            xi.title.THE_VIVISECTOR,
            xi.title.DRAGON_ASHER,
            xi.title.EXPEDITIONARY_TROOPER,
        },
    },
    {
        cost = 600,
        title =
        {
            xi.title.ADAMANTKING_USURPER,
            xi.title.OVERLORD_OVERTHROWER,
            xi.title.DEITY_DEBUNKER,
            xi.title.FAFNIR_SLAYER,
            xi.title.ASPIDOCHELONE_SINKER,
            xi.title.NIDHOGG_SLAYER,
            xi.title.MAAT_MASHER,
            xi.title.KIRIN_CAPTIVATOR,
            xi.title.CACTROT_DESACELERADOR,
            xi.title.LIFTER_OF_SHADOWS,
            xi.title.TIAMAT_TROUNCER,
            xi.title.VRTRA_VANQUISHER,
            xi.title.WORLD_SERPENT_SLAYER,
            xi.title.XOLOTL_XTRAPOLATOR,
            xi.title.BOROKA_BELEAGUERER,
            xi.title.OURYU_OVERWHELMER,
            xi.title.VINEGAR_EVAPORATOR,
            xi.title.VIRTUOUS_SAINT,
            xi.title.BYE_BYE_TAISAI,
            xi.title.TEMENOS_LIBERATOR,
            xi.title.APOLLYON_RAVAGER,
            xi.title.WYRM_ASTONISHER,
            xi.title.NIGHTMARE_AWAKENER,
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
