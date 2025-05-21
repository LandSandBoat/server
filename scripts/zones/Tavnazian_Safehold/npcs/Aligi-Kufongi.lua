-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Aligi-Kufongi
-- Title Change NPC
-- !pos -23 -21 15 26
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventId = 342
local titleInfo =
{
    {
        cost = 200,
        title =
        {
            xi.title.TAVNAZIAN_SQUIRE,
            xi.title.PUTRID_PURVEYOR_OF_PUNGENT_PETALS,
            xi.title.MONARCH_LINN_PATROL_GUARD,
            xi.title.SIN_HUNTER_HUNTER,
            xi.title.DISCIPLE_OF_JUSTICE,
            xi.title.DYNAMIS_TAVNAZIA_INTERLOPER,
            xi.title.CONFRONTER_OF_NIGHTMARES,
        },
    },
    {
        cost = 300,
        title =
        {
            xi.title.DEAD_BODY,
            xi.title.FROZEN_DEAD_BODY,
            xi.title.DREAMBREAKER,
            xi.title.MIST_MELTER,
            xi.title.DELTA_ENFORCER,
            xi.title.OMEGA_OSTRACIZER,
            xi.title.ULTIMA_UNDERTAKER,
            xi.title.ULMIAS_SOULMATE,
            xi.title.TENZENS_ALLY,
            xi.title.COMPANION_OF_LOUVERANCE,
            xi.title.TRUE_COMPANION_OF_LOUVERANCE,
            xi.title.PRISHES_BUDDY,
            xi.title.NAGMOLADAS_UNDERLING,
            xi.title.ESHANTARLS_COMRADE_IN_ARMS,
            xi.title.THE_CHEBUKKIS_WORST_NIGHTMARE,
            xi.title.UNQUENCHABLE_LIGHT,
            xi.title.WARRIOR_OF_THE_CRYSTAL,
        },
    },
    {
        cost = 400,
        title =
        {
            xi.title.ANCIENT_FLAME_FOLLOWER,
            xi.title.TAVNAZIAN_TRAVELER,
            xi.title.TRANSIENT_DREAMER,
            xi.title.THE_LOST_ONE,
            xi.title.TREADER_OF_AN_ICY_PAST,
            xi.title.BRANDED_BY_LIGHTNING,
            xi.title.SEEKER_OF_THE_LIGHT,
            xi.title.AVERTER_OF_THE_APOCALYPSE,
            xi.title.BANISHER_OF_EMPTINESS,
            xi.title.BREAKER_OF_THE_CHAINS,
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
