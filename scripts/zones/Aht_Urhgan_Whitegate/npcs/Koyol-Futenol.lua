-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Koyol-Futenol
-- Title Change NPC
-- !pos -129 2 -20 50
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventId = 644
local titleInfo =
{
    {
        cost = 200,
        title =
        {
            xi.title.DARK_RESISTANT,
            xi.title.BEARER_OF_THE_MARK_OF_ZAHAK,
            xi.title.SEAGULL_PHRATRIE_CREW_MEMBER,
            xi.title.PROUD_AUTOMATON_OWNER,
            xi.title.WILDCAT_PUBLICIST,
            xi.title.SCENIC_SNAPSHOTTER,
            xi.title.BRANDED_BY_THE_FIVE_SERPENTS,
            xi.title.IMMORTAL_LION,
            xi.title.PARAGON_OF_BLUE_MAGE_EXCELLENCE,
            xi.title.PARAGON_OF_CORSAIR_EXCELLENCE,
            xi.title.PARAGON_OF_PUPPETMASTER_EXCELLENCE,
            xi.title.MASTER_OF_AMBITION,
            xi.title.MASTER_OF_CHANCE,
            xi.title.SKYSERPENT_AGGRANDIZER,
            xi.title.GALESERPENT_GUARDIAN,
            xi.title.STONESERPENT_SHOCKTROOPER,
            xi.title.PHOTOPTICATOR_OPERATOR,
            xi.title.SPRINGSERPENT_SENTRY,
            xi.title.FLAMESERPENT_FACILITATOR,
        },
    },
    {
        cost = 300,
        title =
        {
            xi.title.PRIVATE_SECOND_CLASS,
            xi.title.PRIVATE_FIRST_CLASS,
            xi.title.SUPERIOR_PRIVATE,
            xi.title.LANCE_CORPORAL,
            xi.title.CORPORAL,
            xi.title.SERGEANT,
            xi.title.SERGEANT_MAJOR,
            xi.title.CHIEF_SERGEANT,
            xi.title.SECOND_LIEUTENANT,
            xi.title.FIRST_LIEUTENANT,
            xi.title.AGENT_OF_THE_ALLIED_FORCES,
            xi.title.OVJANGS_ERRAND_RUNNER,
            xi.title.KARABABAS_TOUR_GUIDE,
            xi.title.KARABABAS_BODYGUARD,
            xi.title.KARABABAS_SECRET_AGENT,
            xi.title.APHMAUS_MERCENARY,
            xi.title.NASHMEIRAS_MERCENARY,
            xi.title.SALAHEEMS_RISK_ASSESSOR,
            xi.title.TREASURE_TROVE_TENDER,
            xi.title.GESSHOS_MERCY,
            xi.title.EMISSARY_OF_THE_EMPRESS,
            xi.title.ENDYMION_PARATROOPER,
            xi.title.NAJAS_COMRADE_IN_ARMS,
            xi.title.NASHMEIRAS_LOYALIST,
            xi.title.PREVENTER_OF_RAGNAROK,
            xi.title.CHAMPION_OF_AHT_URHGAN,
            xi.title.ETERNAL_MERCENARY,
            xi.title.CAPTAIN
        },
    },
    {
        cost = 400,
        title =
        {
            xi.title.SUBDUER_OF_THE_MAMOOL_JA,
            xi.title.SUBDUER_OF_THE_TROLLS,
            xi.title.SUBDUER_OF_THE_UNDEAD_SWARM,
            xi.title.CERBERUS_MUZZLER,
            xi.title.HYDRA_HEADHUNTER,
            xi.title.SHINING_SCALE_RIFLER,
            xi.title.TROLL_SUBJUGATOR,
            xi.title.GORGONSTONE_SUNDERER,
            xi.title.KHIMAIRA_CARVER,
            xi.title.ELITE_EINHERJAR,
            xi.title.STAR_CHARIOTEER,
            xi.title.SUN_CHARIOTEER,
            xi.title.COMET_CHARIOTEER,
            xi.title.MOON_CHARIOTEER,
            xi.title.BLOODY_BERSERKER,
            xi.title.THE_SIXTH_SERPENT,
            xi.title.PANDEMONIUM_QUELLER,
            xi.title.OUPIRE_IMPALER,
            xi.title.HEIR_OF_THE_BLESSED_RADIANCE,
            xi.title.HEIR_OF_THE_BLIGHTED_GLOOM,
            xi.title.SWORN_TO_THE_DARK_DIVINITY,
        },
    },
    {
        cost = 500,
        title =
        {
            xi.title.SUPERNAL_SAVANT,
            xi.title.SOLAR_SAGE,
            xi.title.BOLIDE_BARON,
            xi.title.MOON_MAVEN,
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
