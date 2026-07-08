-----------------------------------
-- Area: Full Moon Fountain
-- Name: The Moonlit Path
-----------------------------------
local fullMoonFountainID = zones[xi.zone.FULL_MOON_FOUNTAIN]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.FULL_MOON_FOUNTAIN,
    battlefieldId    = xi.battlefield.id.MOONLIT_PATH,
    canLoseExp       = false,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 0,
    entryNpc         = 'MS_Entrance',
    exitNpc          = 'Moon_Spiral',
    requiredKeyItems = { xi.ki.MOON_BAUBLE, keep = true },

    questArea = xi.questLog.WINDURST,
    quest     = xi.quest.id.windurst.THE_MOONLIT_PATH,
})

function content:onEventFinishWin(player, csid, option, npc)
    player:delKeyItem(xi.ki.MOON_BAUBLE)
    npcUtil.giveKeyItem(player, xi.ki.WHISPER_OF_THE_MOON)
end

content.groups =
{
    {
        mobIds =
        {
            { fullMoonFountainID.mob.FENRIR_PRIME     },
            { fullMoonFountainID.mob.FENRIR_PRIME + 1 },
            { fullMoonFountainID.mob.FENRIR_PRIME + 2 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
