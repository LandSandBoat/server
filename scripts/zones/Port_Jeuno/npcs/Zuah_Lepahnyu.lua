-----------------------------------
-- Area: Port Jeuno
--  NPC: ZuahLepahnyu
-- Title Change NPC
-- !pos 0 0 8 246
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventId = 330
local titleInfo =
{
    {
        cost = 200,
        title =
        {
            xi.title.VISITOR_TO_ABYSSEA,
            xi.title.FRIEND_OF_ABYSSEA,
            xi.title.WARRIOR_OF_ABYSSEA,
            xi.title.STORMER_OF_ABYSSEA,
            xi.title.DEVASTATOR_OF_ABYSSEA,
            xi.title.HERO_OF_ABYSSEA,
            xi.title.CHAMPION_OF_ABYSSEA,
            xi.title.CONQUEROR_OF_ABYSSEA,
            xi.title.SAVIOR_OF_ABYSSEA,
        },
    },
    {
        cost = 300,
        title =
        {
            xi.title.GOLDWING_SQUASHER,
            xi.title.SILAGILITH_DETONATOR,
            xi.title.SURTR_SMOTHERER,
            xi.title.DREYRUK_PREDOMINATOR,
            xi.title.SAMURSK_VITIATOR,
        },
    },
    {
        cost = 400,
        title =
        {
            xi.title.YAANEI_CRASHER,
            xi.title.KUTHAREI_UNHORSER,
            xi.title.SIPPOY_CAPTURER,
            xi.title.RANI_DECROWNER,
            xi.title.ORTHRUS_DECAPITATOR,
            xi.title.DRAGUA_SLAYER,
            xi.title.BENNU_DEPLUMER,
            xi.title.HEDJEDJET_DESTINGER,
            xi.title.CUIJATENDER_DESICCATOR,
            xi.title.BRULO_EXTINGUISHER,
            xi.title.PANTOKRATOR_DISPROVER,
            xi.title.APADEMAK_ANNIHILATOR,
            xi.title.ISGEBIND_DEFROSTER,
            xi.title.RESHEPH_ERADICATOR,
            xi.title.EMPOUSA_EXPURGATOR,
            xi.title.INDRIK_IMMOLATOR,
            xi.title.OGOPOGO_OVERTURNER,
            xi.title.RAJA_REGICIDE,
            xi.title.ALFARD_DETOXIFIER,
            xi.title.AZDAJA_ABOLISHER,
            xi.title.AMPHITRITE_SHUCKER,
            xi.title.FUATH_PURIFIER,
            xi.title.KILLAKRIQ_EXCORIATOR,
            xi.title.MAERE_BESTIRRER,
            xi.title.WYRM_GOD_DEFIER,
        },
    },
    {
        cost = 500,
        title =
        {
            xi.title.TITLACAUAN_DISMEMBERER,
            xi.title.SMOK_DEFOGGER,
            xi.title.AMHULUK_INUNDATER,
            xi.title.PULVERIZER_DISMANTLER,
            xi.title.DURINN_DECEIVER,
            xi.title.KARKADANN_EXOCULATOR,
            xi.title.TEMENOS_EMANCIPATOR,
            xi.title.APOLLYON_RAZER,
            xi.title.UMAGRHK_MANEMANGLER,
        },
    },
    {
        cost = 600,
        title =
        {
            xi.title.KARKINOS_CLAWCRUSHER,
            xi.title.CARABOSSE_QUASHER,
            xi.title.OVNI_OBLITERATOR,
            xi.title.RUMINATOR_CONFOUNDER,
            xi.title.FISTULE_DRAINER,
            xi.title.TURUL_GROUNDER,
            xi.title.BLOODEYE_BANISHER,
            xi.title.SATIATOR_DEPRIVER,
            xi.title.CHLORIS_UPROOTER,
            xi.title.MYRMECOLEON_TAMER,
            xi.title.GLAVOID_STAMPEDER,
            xi.title.USURPER_DEPOSER,
            xi.title.ULHUADSHI_DESICCATOR,
            xi.title.ITZPAPALOTL_DECLAWER,
            xi.title.SOBEK_MUMMIFIER,
            xi.title.CIREIN_CROIN_HARPOONER,
            xi.title.BUKHIS_TETHERER,
            xi.title.SEDNA_TUSKBREAKER,
            xi.title.CLEAVER_DISMANTLER,
            xi.title.EXECUTIONER_DISMANTLER,
            xi.title.SEVERER_DISMANTLER,
        },
    },
    {
        cost = 700,
        title =
        {
            xi.title.HADHAYOSH_HALTERER,
            xi.title.BRIAREUS_FELLER,
            xi.title.ECCENTRICITY_EXPUNGER,
            xi.title.KUKULKAN_DEFANGER,
            xi.title.IRATHAM_CAPTURER,
            xi.title.LACOVIE_CAPSIZER,
            xi.title.LUSCA_DEBUNKER,
            xi.title.TRISTITIA_DELIVERER,
            xi.title.KETEA_BEACHER,
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
