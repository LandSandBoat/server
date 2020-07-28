-----------------------------------
-- Area: Norg
--  NPC: Quntsu-Nointsu
-- Title Change NPC
-- !pos -67 -1 34 252
-----------------------------------
require("scripts/globals/titles")
-----------------------------------

local eventId = 1011
local titleInfo =
{
    {
        cost = 200,
        title =
        {
            tpz.title.HONORARY_DOCTORATE_MAJORING_IN_TONBERRIES,
            tpz.title.BUSHIDO_BLADE,
            tpz.title.BLACK_MARKETEER,
            tpz.title.CRACKER_OF_THE_SECRET_CODE,
            tpz.title.LOOKS_SUBLIME_IN_A_SUBLIGAR,
            tpz.title.LOOKS_GOOD_IN_LEGGINGS,
        },
    },
    {
        cost = 300,
        title =
        {
            tpz.title.APPRENTICE_SOMMELIER,
            tpz.title.TREASUREHOUSE_RANSACKER,
            tpz.title.HEIR_OF_THE_GREAT_WATER,
            tpz.title.PARAGON_OF_SAMURAI_EXCELLENCE,
            tpz.title.PARAGON_OF_NINJA_EXCELLENCE,
            tpz.title.GUIDER_OF_SOULS_TO_THE_SANCTUARY,
            tpz.title.BEARER_OF_BONDS_BEYOND_TIME,
            tpz.title.FRIEND_OF_THE_OPOOPOS,
            tpz.title.PENTACIDE_PERPETRATOR,
        },
    },
    {
        cost = 400,
        title =
        {
            tpz.title.BEARER_OF_THE_WISEWOMANS_HOPE,
            tpz.title.BEARER_OF_THE_EIGHT_PRAYERS,
            tpz.title.LIGHTWEAVER,
            tpz.title.DESTROYER_OF_ANTIQUITY,
            tpz.title.SEALER_OF_THE_PORTAL_OF_THE_GODS,
            tpz.title.BURIER_OF_THE_ILLUSION,
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
