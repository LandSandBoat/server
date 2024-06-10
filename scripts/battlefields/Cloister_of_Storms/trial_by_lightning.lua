-----------------------------------
-- Area: Cloister of Storms
-- BCNM: Trial by Lightning
-----------------------------------
local cloisterOfStormsID = zones[xi.zone.CLOISTER_OF_STORMS]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_STORMS,
    battlefieldId    = xi.battlefield.id.TRIAL_BY_LIGHTNING,
    canLoseExp       = false,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 0,
    entryNpc         = 'LP_Entrance',
    exitNpc          = 'Lightning_Protocrystal',
    requiredKeyItems = { xi.ki.TUNING_FORK_OF_LIGHTNING },

    questArea = xi.questLog.OTHER_AREAS,
    quest     = xi.quest.id.otherAreas.TRIAL_BY_LIGHTNING,
})

function content:onEventFinishWin(player, csid, option, npc)
    player:addTitle(xi.title.HEIR_OF_THE_GREAT_LIGHTNING)
    npcUtil.giveKeyItem(player, xi.ki.WHISPER_OF_STORMS)
end

content.groups =
{
    {
        mobIds =
        {
            { cloisterOfStormsID.mob.RAMUH_PRIME     },
            { cloisterOfStormsID.mob.RAMUH_PRIME + 1 },
            { cloisterOfStormsID.mob.RAMUH_PRIME + 2 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
