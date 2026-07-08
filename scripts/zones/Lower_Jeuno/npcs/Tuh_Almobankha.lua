-----------------------------------
-- Area: Lower Jeuno
--  NPC: Tuh Almobankha
-- Title Change NPC
-- !pos -14 0 -61 245
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventId = 10014
local titleInfo =
{
    {
        cost = 200,
        title =
        {
            xi.title.BROWN_MAGE_GUINEA_PIG,
            xi.title.BROWN_MAGIC_BY_PRODUCT,
            xi.title.RESEARCHER_OF_CLASSICS,
            xi.title.TORCHBEARER,
            xi.title.FORTUNE_TELLER_IN_TRAINING,
            xi.title.CHOCOBO_TRAINER,
            xi.title.CLOCK_TOWER_PRESERVATIONIST,
            xi.title.LIFE_SAVER,
            xi.title.CARD_COLLECTOR,
            xi.title.TWOS_COMPANY,
            xi.title.TRADER_OF_ANTIQUITIES,
            xi.title.GOBLINS_EXCLUSIVE_FASHION_MANNEQUIN,
            xi.title.TENSHODO_MEMBER,
        },
    },
    {
        cost = 300,
        title =
        {
            xi.title.ACTIVIST_FOR_KINDNESS,
            xi.title.ENVOY_TO_THE_NORTH,
            xi.title.EXORCIST_IN_TRAINING,
            xi.title.FOOLS_ERRAND_RUNNER,
            xi.title.STREET_SWEEPER,
            xi.title.MERCY_ERRAND_RUNNER,
            xi.title.BELIEVER_OF_ALTANA,
            xi.title.TRADER_OF_MYSTERIES,
            xi.title.WANDERING_MINSTREL,
            xi.title.ANIMAL_TRAINER,
            xi.title.HAVE_WINGS_WILL_FLY,
            xi.title.ROD_RETRIEVER,
            xi.title.DESTINED_FELLOW,
            xi.title.TROUPE_BRILIOTH_DANCER,
            xi.title.PROMISING_DANCER,
            xi.title.STARDUST_DANCER,
        },
    },
    {
        cost = 400,
        title =
        {
            xi.title.TIMEKEEPER,
            xi.title.BRINGER_OF_BLISS,
            xi.title.PROFESSIONAL_LOAFER,
            xi.title.TRADER_OF_RENOWN,
            xi.title.HORIZON_BREAKER,
            xi.title.SUMMIT_BREAKER,
            xi.title.BROWN_BELT,
            xi.title.DUCAL_DUPE,
            xi.title.CHOCOBO_LOVE_GURU,
            xi.title.PICK_UP_ARTIST,
            xi.title.WORTHY_OF_TRUST,
            xi.title.A_FRIEND_INDEED,
            xi.title.CHOCOROOKIE,
            xi.title.CRYSTAL_STAKES_CUPHOLDER,
            xi.title.WINNING_OWNER,
            xi.title.VICTORIOUS_OWNER,
            xi.title.TRIUMPHANT_OWNER,
            xi.title.HIGH_ROLLER,
            xi.title.FORTUNES_FAVORITE,
            xi.title.CHOCOCHAMPION,
        },
    },
    {
        cost = 500,
        title =
        {
            xi.title.PARAGON_OF_BEASTMASTER_EXCELLENCE,
            xi.title.PARAGON_OF_BARD_EXCELLENCE,
            xi.title.SKY_BREAKER,
            xi.title.BLACK_BELT,
            xi.title.GREEDALOX,
            xi.title.CLOUD_BREAKER,
            xi.title.STAR_BREAKER,
            xi.title.ULTIMATE_CHAMPION_OF_THE_WORLD,
            xi.title.DYNAMIS_JEUNO_INTERLOPER,
            xi.title.DYNAMIS_BEAUCEDINE_INTERLOPER,
            xi.title.DYNAMIS_XARCABARD_INTERLOPER,
            xi.title.DYNAMIS_QUFIM_INTERLOPER,
            xi.title.CONQUEROR_OF_FATE,
            xi.title.SUPERHERO,
            xi.title.SUPERHEROINE,
            xi.title.ELEGANT_DANCER,
            xi.title.DAZZLING_DANCE_DIVA,
            xi.title.GRIMOIRE_BEARER,
            xi.title.FELLOW_FORTIFIER,
            xi.title.BUSHIN_ASPIRANT,
            xi.title.BUSHIN_RYU_INHERITOR,
        },
    },
    {
        cost = 600,
        title =
        {
            xi.title.GRAND_GREEDALOX,
            xi.title.SILENCER_OF_THE_ECHO,
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
