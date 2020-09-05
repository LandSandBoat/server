-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Koyol-Futenol
-- Title Change NPC
-- !pos -129 2 -20 50
-----------------------------------
require("scripts/globals/titles")
-----------------------------------

local eventId = 644
local titleInfo =
{
    {
        cost = 200,
        title =
        {
            tpz.title.DARK_RESISTANT,
            tpz.title.BEARER_OF_THE_MARK_OF_ZAHAK,
            tpz.title.SEAGULL_PHRATRIE_CREW_MEMBER,
            tpz.title.PROUD_AUTOMATON_OWNER,
            tpz.title.WILDCAT_PUBLICIST,
            tpz.title.SCENIC_SNAPSHOTTER,
            tpz.title.BRANDED_BY_THE_FIVE_SERPENTS,
            tpz.title.IMMORTAL_LION,
            tpz.title.PARAGON_OF_BLUE_MAGE_EXCELLENCE,
            tpz.title.PARAGON_OF_CORSAIR_EXCELLENCE,
            tpz.title.PARAGON_OF_PUPPETMASTER_EXCELLENCE,
            tpz.title.MASTER_OF_AMBITION,
            tpz.title.MASTER_OF_CHANCE,
            tpz.title.SKYSERPENT_AGGRANDIZER,
            tpz.title.GALESERPENT_GUARDIAN,
            tpz.title.STONESERPENT_SHOCKTROOPER,
            tpz.title.PHOTOPTICATOR_OPERATOR,
            tpz.title.SPRINGSERPENT_SENTRY,
            tpz.title.FLAMESERPENT_FACILITATOR,
        },
    },
    {
        cost = 300,
        title =
        {
            tpz.title.PRIVATE_SECOND_CLASS,
            tpz.title.PRIVATE_FIRST_CLASS,
            tpz.title.SUPERIOR_PRIVATE,
            tpz.title.LANCE_CORPORAL,
            tpz.title.CORPORAL,
            tpz.title.SERGEANT,
            tpz.title.SERGEANT_MAJOR,
            tpz.title.CHIEF_SERGEANT,
            tpz.title.SECOND_LIEUTENANT,
            tpz.title.FIRST_LIEUTENANT,
            tpz.title.AGENT_OF_THE_ALLIED_FORCES,
            tpz.title.OVJANGS_ERRAND_RUNNER,
            tpz.title.KARABABAS_TOUR_GUIDE,
            tpz.title.KARABABAS_BODYGUARD,
            tpz.title.KARABABAS_SECRET_AGENT,
            tpz.title.APHMAUS_MERCENARY,
            tpz.title.NASHMEIRAS_MERCENARY,
            tpz.title.SALAHEEMS_RISK_ASSESSOR,
            tpz.title.TREASURE_TROVE_TENDER,
            tpz.title.GESSHOS_MERCY,
            tpz.title.EMISSARY_OF_THE_EMPRESS,
            tpz.title.ENDYMION_PARATROOPER,
            tpz.title.NAJAS_COMRADEINARMS,
            tpz.title.NASHMEIRAS_LOYALIST,
            tpz.title.PREVENTER_OF_RAGNAROK,
            tpz.title.CHAMPION_OF_AHT_URHGAN,
            tpz.title.ETERNAL_MERCENARY,
            tpz.title.CAPTAIN
        },
    },
    {
        cost = 400,
        title =
        {
            tpz.title.SUBDUER_OF_THE_MAMOOL_JA,
            tpz.title.SUBDUER_OF_THE_TROLLS,
            tpz.title.SUBDUER_OF_THE_UNDEAD_SWARM,
            tpz.title.CERBERUS_MUZZLER,
            tpz.title.HYDRA_HEADHUNTER,
            tpz.title.SHINING_SCALE_RIFLER,
            tpz.title.TROLL_SUBJUGATOR,
            tpz.title.GORGONSTONE_SUNDERER,
            tpz.title.KHIMAIRA_CARVER,
            tpz.title.ELITE_EINHERJAR,
            tpz.title.STAR_CHARIOTEER,
            tpz.title.SUN_CHARIOTEER,
            tpz.title.COMET_CHARIOTEER,
            tpz.title.MOON_CHARIOTEER,
            tpz.title.BLOODY_BERSERKER,
            tpz.title.THE_SIXTH_SERPENT,
            tpz.title.OUPIRE_IMPALER,
            tpz.title.HEIR_OF_THE_BLESSED_RADIANCE,
            tpz.title.HEIR_OF_THE_BLIGHTED_GLOOM,
            tpz.title.SWORN_TO_THE_DARK_DIVINITY,
        },
    },
    {
        cost = 500,
        title =
        {
            tpz.title.SUPERNAL_SAVANT,
            tpz.title.SOLAR_SAGE,
            tpz.title.BOLIDE_BARON,
            tpz.title.MOON_MAVEN,
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
