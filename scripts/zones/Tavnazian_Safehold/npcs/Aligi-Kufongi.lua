-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Aligi-Kufongi
-- Title Change NPC
-- !pos -23 -21 15 26
-----------------------------------
require("scripts/globals/titles")
-----------------------------------

local eventId = 342
local titleInfo =
{
    {
        cost = 200,
        title =
        {
            tpz.title.TAVNAZIAN_SQUIRE,
            tpz.title.PUTRID_PURVEYOR_OF_PUNGENT_PETALS,
            tpz.title.MONARCH_LINN_PATROL_GUARD,
            tpz.title.SIN_HUNTER_HUNTER,
            tpz.title.DISCIPLE_OF_JUSTICE,
            tpz.title.DYNAMIS_TAVNAZIA_INTERLOPER,
            tpz.title.CONFRONTER_OF_NIGHTMARES,
        },
    },
    {
        cost = 300,
        title =
        {
            tpz.title.DEAD_BODY,
            tpz.title.FROZEN_DEAD_BODY,
            tpz.title.DREAMBREAKER,
            tpz.title.MIST_MELTER,
            tpz.title.DELTA_ENFORCER,
            tpz.title.OMEGA_OSTRACIZER,
            tpz.title.ULTIMA_UNDERTAKER,
            tpz.title.ULMIAS_SOULMATE,
            tpz.title.TENZENS_ALLY,
            tpz.title.COMPANION_OF_LOUVERANCE,
            tpz.title.TRUE_COMPANION_OF_LOUVERANCE,
            tpz.title.PRISHES_BUDDY,
            tpz.title.NAGMOLADAS_UNDERLING,
            tpz.title.ESHANTARLS_COMRADE_IN_ARMS,
            tpz.title.THE_CHEBUKKIS_WORST_NIGHTMARE,
            tpz.title.UNQUENCHABLE_LIGHT,
            tpz.title.WARRIOR_OF_THE_CRYSTAL,
        },
    },
    {
        cost = 400,
        title =
        {
            tpz.title.ANCIENT_FLAME_FOLLOWER,
            tpz.title.TAVNAZIAN_TRAVELER,
            tpz.title.TRANSIENT_DREAMER,
            tpz.title.THE_LOST_ONE,
            tpz.title.TREADER_OF_AN_ICY_PAST,
            tpz.title.BRANDED_BY_LIGHTNING,
            tpz.title.SEEKER_OF_THE_LIGHT,
            tpz.title.AVERTER_OF_THE_APOCALYPSE,
            tpz.title.BANISHER_OF_EMPTINESS,
            tpz.title.BREAKER_OF_THE_CHAINS,
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
