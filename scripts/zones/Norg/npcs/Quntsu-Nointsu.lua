-----------------------------------
-- Area: Norg
--  NPC: Quntsu-Nointsu
-- Title Change NPC
-- !pos -67 -1 34 252
-----------------------------------
---@type TNpcEntity
local entity = {}

local eventId = 1011
local titleInfo =
{
    {
        cost = 200,
        title =
        {
            xi.title.HONORARY_DOCTORATE_MAJORING_IN_TONBERRIES,
            xi.title.BUSHIDO_BLADE,
            xi.title.BLACK_MARKETEER,
            xi.title.CRACKER_OF_THE_SECRET_CODE,
            xi.title.LOOKS_SUBLIME_IN_A_SUBLIGAR,
            xi.title.LOOKS_GOOD_IN_LEGGINGS,
        },
    },
    {
        cost = 300,
        title =
        {
            xi.title.APPRENTICE_SOMMELIER,
            xi.title.TREASURE_HOUSE_RANSACKER,
            xi.title.HEIR_OF_THE_GREAT_WATER,
            xi.title.PARAGON_OF_SAMURAI_EXCELLENCE,
            xi.title.PARAGON_OF_NINJA_EXCELLENCE,
            xi.title.GUIDER_OF_SOULS_TO_THE_SANCTUARY,
            xi.title.BEARER_OF_BONDS_BEYOND_TIME,
            xi.title.FRIEND_OF_THE_OPO_OPOS,
            xi.title.PENTACIDE_PERPETRATOR,
        },
    },
    {
        cost = 400,
        title =
        {
            xi.title.BEARER_OF_THE_WISEWOMANS_HOPE,
            xi.title.BEARER_OF_THE_EIGHT_PRAYERS,
            xi.title.LIGHTWEAVER,
            xi.title.DESTROYER_OF_ANTIQUITY,
            xi.title.SEALER_OF_THE_PORTAL_OF_THE_GODS,
            xi.title.BURIER_OF_THE_ILLUSION,
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
