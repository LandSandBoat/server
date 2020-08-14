-----------------------------------
-- Area: Lower Jeuno
--  NPC: Tuh Almobankha
-- Title Change NPC
-- !pos -14 0 -61 245
-----------------------------------
require("scripts/globals/titles")
-----------------------------------

local eventId = 10014
local titleInfo =
{
    {
        cost = 200,
        title =
        {
            tpz.title.BROWN_MAGE_GUINEA_PIG,
            tpz.title.BROWN_MAGIC_BYPRODUCT,
            tpz.title.RESEARCHER_OF_CLASSICS,
            tpz.title.TORCHBEARER,
            tpz.title.FORTUNETELLER_IN_TRAINING,
            tpz.title.CHOCOBO_TRAINER,
            tpz.title.CLOCK_TOWER_PRESERVATIONIST,
            tpz.title.LIFE_SAVER,
            tpz.title.CARD_COLLECTOR,
            tpz.title.TWOS_COMPANY,
            tpz.title.TRADER_OF_ANTIQUITIES,
            tpz.title.GOBLINS_EXCLUSIVE_FASHION_MANNEQUIN,
            tpz.title.TENSHODO_MEMBER,
        },
    },
    {
        cost = 300,
        title =
        {
            tpz.title.ACTIVIST_FOR_KINDNESS,
            tpz.title.ENVOY_TO_THE_NORTH,
            tpz.title.EXORCIST_IN_TRAINING,
            tpz.title.FOOLS_ERRAND_RUNNER,
            tpz.title.STREET_SWEEPER,
            tpz.title.MERCY_ERRAND_RUNNER,
            tpz.title.BELIEVER_OF_ALTANA,
            tpz.title.TRADER_OF_MYSTERIES,
            tpz.title.WANDERING_MINSTREL,
            tpz.title.ANIMAL_TRAINER,
            tpz.title.HAVE_WINGS_WILL_FLY,
            tpz.title.ROD_RETRIEVER,
            tpz.title.DESTINED_FELLOW,
            tpz.title.TROUPE_BRILIOTH_DANCER,
            tpz.title.PROMISING_DANCER,
            tpz.title.STARDUST_DANCER,
        },
    },
    {
        cost = 400,
        title =
        {
            tpz.title.TIMEKEEPER,
            tpz.title.BRINGER_OF_BLISS,
            tpz.title.PROFESSIONAL_LOAFER,
            tpz.title.TRADER_OF_RENOWN,
            tpz.title.HORIZON_BREAKER,
            tpz.title.SUMMIT_BREAKER,
            tpz.title.BROWN_BELT,
            tpz.title.DUCAL_DUPE,
            tpz.title.CHOCOBO_LOVE_GURU,
            tpz.title.PICKUP_ARTIST,
            tpz.title.WORTHY_OF_TRUST,
            tpz.title.A_FRIEND_INDEED,
            tpz.title.CHOCOROOKIE,
            tpz.title.CRYSTAL_STAKES_CUPHOLDER,
            tpz.title.WINNING_OWNER,
            tpz.title.VICTORIOUS_OWNER,
            tpz.title.TRIUMPHANT_OWNER,
            tpz.title.HIGH_ROLLER,
            tpz.title.FORTUNES_FAVORITE,
            tpz.title.CHOCOCHAMPION,
        },
    },
    {
        cost = 500,
        title =
        {
            tpz.title.PARAGON_OF_BEASTMASTER_EXCELLENCE,
            tpz.title.PARAGON_OF_BARD_EXCELLENCE,
            tpz.title.SKY_BREAKER,
            tpz.title.BLACK_BELT,
            tpz.title.GREEDALOX,
            tpz.title.CLOUD_BREAKER,
            tpz.title.STAR_BREAKER,
            tpz.title.ULTIMATE_CHAMPION_OF_THE_WORLD,
            tpz.title.DYNAMIS_JEUNO_INTERLOPER,
            tpz.title.DYNAMIS_BEAUCEDINE_INTERLOPER,
            tpz.title.DYNAMIS_XARCABARD_INTERLOPER,
            tpz.title.DYNAMIS_QUFIM_INTERLOPER,
            tpz.title.CONQUEROR_OF_FATE,
            tpz.title.SUPERHERO,
            tpz.title.SUPERHEROINE,
            tpz.title.ELEGANT_DANCER,
            tpz.title.DAZZLING_DANCE_DIVA,
            tpz.title.GRIMOIRE_BEARER,
            tpz.title.FELLOW_FORTIFIER,
            tpz.title.BUSHIN_ASPIRANT,
            tpz.title.BUSHIN_RYU_INHERITOR,
        },
    },
    {
        cost = 600,
        title =
        {
            tpz.title.GRAND_GREEDALOX,
            tpz.title.SILENCER_OF_THE_ECHO,
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
