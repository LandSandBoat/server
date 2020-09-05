-----------------------------------
-- Area: Port Jeuno
--  NPC: ZuahLepahnyu
-- Title Change NPC
-- !pos 0 0 8 246
-----------------------------------
require("scripts/globals/titles")
-----------------------------------

local eventId = 330
local titleInfo =
{
    {
        cost = 200,
        title =
        {
            tpz.title.VISITOR_TO_ABYSSEA,
            tpz.title.FRIEND_OF_ABYSSEA,
            tpz.title.WARRIOR_OF_ABYSSEA,
            tpz.title.STORMER_OF_ABYSSEA,
            tpz.title.DEVASTATOR_OF_ABYSSEA,
            tpz.title.HERO_OF_ABYSSEA,
            tpz.title.CHAMPION_OF_ABYSSEA,
            tpz.title.CONQUEROR_OF_ABYSSEA,
            tpz.title.SAVIOR_OF_ABYSSEA,
        },
    },
    {
        cost = 300,
        title =
        {
            tpz.title.GOLDWING_SQUASHER,
            tpz.title.SILAGILITH_DETONATOR,
            tpz.title.SURTR_SMOTHERER,
            tpz.title.DREYRUK_PREDOMINATOR,
            tpz.title.SAMURSK_VITIATOR,
        },
    },
    {
        cost = 400,
        title =
        {
            tpz.title.YAANEI_CRASHER,
            tpz.title.KUTHAREI_UNHORSER,
            tpz.title.SIPPOY_CAPTURER,
            tpz.title.RANI_DECROWNER,
            tpz.title.ORTHRUS_DECAPITATOR,
            tpz.title.DRAGUA_SLAYER,
            tpz.title.BENNU_DEPLUMER,
            tpz.title.HEDJEDJET_DESTINGER,
            tpz.title.CUIJATENDER_DESICCATOR,
            tpz.title.BRULO_EXTINGUISHER,
            tpz.title.PANTOKRATOR_DISPROVER,
            tpz.title.APADEMAK_ANNIHILATOR,
            tpz.title.ISGEBIND_DEFROSTER,
            tpz.title.RESHEPH_ERADICATOR,
            tpz.title.EMPOUSA_EXPURGATOR,
            tpz.title.INDRIK_IMMOLATOR,
            tpz.title.OGOPOGO_OVERTURNER,
            tpz.title.RAJA_REGICIDE,
            tpz.title.ALFARD_DETOXIFIER,
            tpz.title.AZDAJA_ABOLISHER,
            tpz.title.AMPHITRITE_SHUCKER,
            tpz.title.FUATH_PURIFIER,
            tpz.title.KILLAKRIQ_EXCORIATOR,
            tpz.title.MAERE_BESTIRRER,
            tpz.title.WYRM_GOD_DEFIER,
        },
    },
    {
        cost = 500,
        title =
        {
            tpz.title.TITLACAUAN_DISMEMBERER,
            tpz.title.SMOK_DEFOGGER,
            tpz.title.AMHULUK_INUNDATER,
            tpz.title.PULVERIZER_DISMANTLER,
            tpz.title.DURINN_DECEIVER,
            tpz.title.KARKADANN_EXOCULATOR,
            tpz.title.TEMENOS_EMANCIPATOR,
            tpz.title.APOLLYON_RAZER,
            tpz.title.UMAGRHK_MANEMANGLER,
        },
    },
    {
        cost = 600,
        title =
        {
            tpz.title.KARKINOS_CLAWCRUSHER,
            tpz.title.CARABOSSE_QUASHER,
            tpz.title.OVNI_OBLITERATOR,
            tpz.title.RUMINATOR_CONFOUNDER,
            tpz.title.FISTULE_DRAINER,
            tpz.title.TURUL_GROUNDER,
            tpz.title.BLOODEYE_BANISHER,
            tpz.title.SATIATOR_DEPRIVER,
            tpz.title.CHLORIS_UPROOTER,
            tpz.title.MYRMECOLEON_TAMER,
            tpz.title.GLAVOID_STAMPEDER,
            tpz.title.USURPER_DEPOSER,
            tpz.title.ULHUADSHI_DESICCATOR,
            tpz.title.ITZPAPALOTL_DECLAWER,
            tpz.title.SOBEK_MUMMIFIER,
            tpz.title.CIREINCROIN_HARPOONER,
            tpz.title.BUKHIS_TETHERER,
            tpz.title.SEDNA_TUSKBREAKER,
            tpz.title.CLEAVER_DISMANTLER,
            tpz.title.EXECUTIONER_DISMANTLER,
            tpz.title.SEVERER_DISMANTLER,
        },
    },
    {
        cost = 700,
        title =
        {
            tpz.title.HADHAYOSH_HALTERER,
            tpz.title.BRIAREUS_FELLER,
            tpz.title.ECCENTRICITY_EXPUNGER,
            tpz.title.KUKULKAN_DEFANGER,
            tpz.title.IRATHAM_CAPTURER,
            tpz.title.LACOVIE_CAPSIZER,
            tpz.title.LUSCA_DEBUNKER,
            tpz.title.TRISTITIA_DELIVERER,
            tpz.title.KETEA_BEACHER,
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
